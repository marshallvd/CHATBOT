import mysql.connector
import asyncio
from mysql.connector import Error
from typing import Final
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes
from telegram import InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import CallbackQueryHandler

TOKEN: Final = '6700492977:AAFWzFALx6HubjVg3-OolA2ENKzj_efrLXM'
BOT_USERNAME: Final = '@banagobot'

# Informasi koneksi MySQL
DB_HOST = 'localhost'
DB_USER = 'root'
DB_PASSWORD = ''
DB_NAME = 'banagobot'

# Dictionary untuk melacak menu yang sudah ditampilkan
menu_displayed = {}

# Fungsi untuk membuat koneksi ke database
def create_connection():
    connection = None
    try:
        connection = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        print("Connection to MySQL DB successful")
    except Error as e:
        print(f"The error '{e}' occurred")

    return connection


# Fungsi untuk mengambil menu dari database
async def get_menu_from_database():
    connection = create_connection()
    menu = []
    if connection is not None:
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM tb_menu")  # Perbarui tabel menu di sini
        menu = cursor.fetchall()
        connection.close()
    return menu

# Fungsi handle_message yang telah dimodifikasi untuk menyimpan pesan dan respon bot
async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    message_type = update.message.chat.type
    text = update.message.text

    print(f'User ({update.message.chat.id}) in {message_type}: "{text}"')

    # Membuat koneksi ke database
    connection = create_connection()

    # Memasukkan pesan pengguna ke dalam database
    if connection is not None:
        # Simpan pesan dari pengguna ke tb_inbox
        insert_message(connection, text, update.message.chat.id, message_type)

        # Dapatkan ID pesan terakhir yang dimasukkan ke dalam tabel tb_inbox
        cursor = connection.cursor()
        cursor.execute("SELECT MAX(id_inbox) FROM tb_inbox")
        last_inbox_id = cursor.fetchone()[0]

        # Cek apakah entities tidak kosong sebelum mengaksesnya
        if update.message.entities:
            entity_length = update.message.entities[0].length
            # Lakukan sesuatu dengan entities jika diperlukan

        menu_message = None
        keyboard = []  # Define keyboard here
        # Jika pengguna memasukkan NIM (angka), maka simpan NIM tersebut
        if text.isdigit():
            nim = text
            # Menyiapkan tombol menu dengan query yang mengandung NIM
            menu_text = "Lihat Data Mahasiswa dengan NIM Ini"
            query_data = f"menu_3_{nim}"  # Format: menu_{menu_id}_{nim}
            menu_id = 3  # ID menu yang akan dikaitkan dengan query
        else:
            nim = None

            # Menampilkan menu sebagai respons default
            menu = await get_menu_from_database()
            for item in menu:
                keyboard.append([InlineKeyboardButton(item['label'], callback_data=f"menu_{item['id_menu']}")])
                # Menandai menu yang sudah ditampilkan kepada pengguna
                menu_displayed[update.message.chat.id] = True
            
        reply_markup = InlineKeyboardMarkup(keyboard)
        menu_message = "Silakan pilih salah satu opsi:"
        
        await update.message.reply_text(menu_message, reply_markup=reply_markup)

        # Memasukkan respon bot (menu) ke dalam database
        insert_bot_response(connection, menu_message, update.message.chat.id, last_inbox_id)

        connection.close()
        print("Connection closed")


async def button_callback(update: Update, context: ContextTypes.DEFAULT_TYPE):
    try:
        query = update.callback_query
        await query.answer()
        
        # Mendapatkan ID menu yang dipilih dari data callback
        menu_id = int(query.data.split('_')[1])
        
        # Membuat koneksi ke database
        connection = create_connection()
        
        # Menjalankan query yang tersimpan dalam tabel tb_menu_query
        if connection is not None:
            cursor = connection.cursor(dictionary=True)
            cursor.execute(f"SELECT query FROM tb_menu_query WHERE id_menu = {menu_id}")
            query_result = cursor.fetchone()
            
            if query_result:
                # Periksa apakah tombol sudah ditampilkan sebelumnya
                if menu_displayed.get(query.message.chat.id):
                    # Menu sudah ditampilkan, tandai sebagai sudah digunakan
                    menu_displayed[query.message.chat.id] = False
                    # Lanjutkan dengan menampilkan menu atau melakukan operasi lainnya

                    if menu_id == 3:
                        # Kirim pesan untuk meminta input NIM
                        await query.message.reply_text("Silakan masukkan NIM mahasiswa yang ingin Anda cari:")
                    else:
                        # Eksekusi query
                        cursor.execute(query_result['query'])
                        query_data = cursor.fetchall()
                    
                        # Buat pesan respons dari hasil query
                        response_message = ""
                        if menu_id == 1:  # Jika ID menu adalah 1 (Daftar Mata Kuliah)
                            for index, row in enumerate(query_data, start=1):
                                response_message += f"{index}. {row['nama_matakuliah']}\n"
                        elif menu_id == 2:  # Jika ID menu adalah 2 (Daftar Mahasiswa)
                            for index, row in enumerate(query_data, start=1):
                                response_message += f"{index}. {row['nama_mahasiswa']}\n"
                        elif menu_id == 4:  # Jika ID menu adalah 4 (Daftar Dosen)
                            for index, row in enumerate(query_data, start=1):
                                response_message += f"{index}. {row['nama_dosen']}\n"
                        else:
                            response_message = "Menu tidak valid."
                    
                        # Dapatkan message_type dari query.message
                        message_type = query.message.chat.type
                    
                        # Memasukkan informasi tombol yang diklik oleh pengguna ke dalam database
                        insert_message(connection, f"Button {menu_id} clicked", query.message.chat.id, message_type)
                    
                        # Kirim hasil query sebagai respons kepada pengguna
                        await query.message.reply_text(response_message)
                    
                        # Dapatkan ID pesan terakhir yang dimasukkan ke dalam tabel tb_inbox
                        cursor.execute("SELECT MAX(id_inbox) FROM tb_inbox")
                        last_inbox_id = cursor.fetchone()[0]
                    
                        # Memasukkan respon bot (hasil query) ke dalam database
                        insert_bot_response(connection, response_message, query.message.chat.id, last_inbox_id)
                    
                else:
                    # Menu belum ditampilkan, beri respons sesuai
                    await query.message.reply_text("Anda sudah memilih menu sebelumnya.")
            
            connection.close()
            print("Connection closed")
    except Exception as e:
        print(f"Error in button_callback: {e}")


# Fungsi untuk memasukkan pesan dari pengguna ke dalam tabel database
def insert_message(connection, message, chat_id, message_type):
    cursor = connection.cursor()
    try:
        cursor.execute("INSERT INTO tb_inbox (message_content, chat_id, message_type) VALUES (%s, %s, %s)",
        (message, chat_id, message_type))
        connection.commit()
        print("Message inserted successfully")
    except Error as e:
        print(f"The error '{e}' occurred")

# Fungsi untuk memasukkan respon bot ke dalam tabel database
def insert_bot_response(connection, response_content, chat_id, message_id):
    cursor = connection.cursor()
    try:
        cursor.execute("INSERT INTO tb_outbox (response_content, chat_id, id_inbox) VALUES (%s, %s, %s)",
        (response_content, chat_id, message_id))
        connection.commit()
        print("Bot response inserted successfully")
    except Error as e:
        print(f"The error '{e}' occurred")

# Command Default
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Ambil menu dari database
    menu = await get_menu_from_database()
    
    # Buat tombol-tombol untuk menu pilihan
    keyboard = []
    for item in menu:
        keyboard.append([InlineKeyboardButton(item['label'], callback_data=f"menu_{item['id_menu']}")])  
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    # Kirim pesan dengan inline keyboard
    await update.message.reply_text("Silakan pilih salah satu opsi:", reply_markup=reply_markup)

async def error(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print(f'Update {update} caused error {context.error}')

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Saya Banago! Tulis sesuatu biar kuserpon!')

async def custom_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Ini adalah custom command!')



if __name__ == '__main__':
    app = Application.builder().token(TOKEN).build()


    # Commands
    app.add_handler(CommandHandler('start', start_command))
    app.add_handler(CommandHandler('help', help_command))
    app.add_handler(CommandHandler('custom', custom_command))

    # Messages
    app.add_handler(MessageHandler(filters.TEXT, handle_message))
    app.add_handler(CallbackQueryHandler(button_callback))


    # Error
    app.add_error_handler(error)

    # Polls the bot
    print('Polling...')
    app.run_polling(poll_interval=3)
