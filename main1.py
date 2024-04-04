import mysql.connector
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


# Command
# Fungsi untuk mengambil menu dari database
def get_menu_from_database():
    connection = create_connection()
    menu = []
    if connection is not None:
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM tb_menu")  # Perbarui tabel menu di sini
        menu = cursor.fetchall()
        connection.close()
    return menu

# Command /start
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Ambil menu dari database
    menu = get_menu_from_database()
    
    # Buat tombol-tombol untuk menu pilihan
    keyboard = []
    for item in menu:
        keyboard.append([InlineKeyboardButton(item['label'], callback_data=f"menu_{item['id_menu']}")])  
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    # Kirim pesan dengan inline keyboard
    await update.message.reply_text("Silakan pilih salah satu opsi:", reply_markup=reply_markup)


# Jika tombol menu tidak ditekan, fungsi default akan menampilkan menu
async def default_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await start_command(update, context)

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Saya Banago! Tulis sesuatu biar kuserpon!')


async def custom_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Ini adalah custom command!')


# # Handler Responses
# def handle_responses(text: str) -> str:
#     processed: str = text.lower()

#     if 'halo' in processed:
#         return 'Halo Guys!'
#     if 'apa kabar' in processed:
#         return "Kabar baik!"
#     if 'aku sayang kamu' in processed:
#         return 'Ternyata aku tidak sayang orang :)'
#     if 'ada yang menarik hari ini' in processed:
#         return 'Hmm, sepertinya hari ini cukup menarik. Ada yang ingin kamu bicarakan?'
#     if 'kenapa' in processed:
#         return 'Cuaca memang tidak bisa diprediksi, tetapi mari kita cari tahu bagaimana kita bisa tetap bahagia di hari yang mendung ini.'
#     if 'siapa kamu' in processed:
#         return 'Saya adalah teman virtualmu di sini untuk membantu dan menghiburmu. Ada yang bisa saya bantu?'
#     if 'hari ini' in processed:
#         return 'Saya berencana untuk menghabiskan hari saya dengan mengobrol dengan teman-teman seperti Anda! Bagaimana dengan Anda?'
#     if 'suka makanan apa' in processed:
#         return 'Saya tidak bisa makan, tetapi saya suka mendengarkan tentang makanan favorit Anda! Ceritakan padaku makanan favoritmu!'
#     if 'ada yang seru hari ini' in processed:
#         return 'Wah, sepertinya ada yang menarik! Ceritakan padaku apa yang terjadi!'
#     if 'mengapa' in processed:
#         return 'Banyak hal yang bisa membuat kita bertanya-tanya. Apa yang kamu cari tahu?'
#     if 'siapa anda' in processed:
#         return 'Saya adalah asisten virtual yang bisa membantu dengan berbagai pertanyaanmu. Apa yang bisa saya bantu?'
#     if 'rencana hari ini' in processed:
#         return 'Hari ini saya ingin menjelajahi dunia digital dan membantu pengguna seperti Anda. Apa yang ingin Anda lakukan hari ini?'
#     if 'makanan favorit' in processed:
#         return 'Meskipun saya tidak bisa makan, saya ingin tahu makanan favoritmu. Ceritakan padaku!'

#     return 'Maaf, sepertinya saya belum bisa memahami pesanmu sepenuhnya. Bisakah kamu sampaikan dengan cara yang berbeda?'



# Fungsi untuk memasukkan pesan dari pengguna ke dalam tabel database
def insert_message(connection, message, chat_id, message_type):
    cursor = connection.cursor()
    try:
        cursor.execute("INSERT INTO chat_messages (message_content, chat_id, message_type) VALUES (%s, %s, %s)",
        (message, chat_id, message_type))
        connection.commit()
        print("Message inserted successfully")
    except Error as e:
        print(f"The error '{e}' occurred")

# Fungsi untuk memasukkan respon bot ke dalam tabel database
def insert_bot_response(connection, response_content, chat_id, message_id):
    cursor = connection.cursor()
    try:
        cursor.execute("INSERT INTO bot_responses (response_content, chat_id, message_id) VALUES (%s, %s, %s)",
        (response_content, chat_id, message_id))
        connection.commit()
        print("Bot response inserted successfully")
    except Error as e:
        print(f"The error '{e}' occurred")


# Fungsi handle_message yang telah dimodifikasi untuk menyimpan pesan dan respon bot ke
async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    message_type = update.message.chat.type
    text = update.message.text

    print(f'User ({update.message.chat.id}) in {message_type}: "{text}"')

    # Membuat koneksi ke database
    connection = create_connection()

    # Menampilkan menu sebagai respons default
    menu = get_menu_from_database()
    keyboard = []
    for item in menu:
        keyboard.append([InlineKeyboardButton(item['label'], callback_data=f"menu_{item['id_menu']}")])
    reply_markup = InlineKeyboardMarkup(keyboard)
    menu_message = "Silakan pilih salah satu opsi:"
    
    await update.message.reply_text(menu_message, reply_markup=reply_markup)

    # Memasukkan pesan pengguna ke dalam database
    if connection is not None:
        insert_message(connection, text, update.message.chat.id, message_type)

        # Mendapatkan ID pesan terakhir yang dimasukkan ke dalam tabel chat_messages
        cursor = connection.cursor()
        cursor.execute("SELECT LAST_INSERT_ID()")
        last_message_id = cursor.fetchone()[0]

        # Memasukkan respon bot (menu) ke dalam database
        insert_bot_response(connection, menu_message, update.message.chat.id, last_message_id)

        connection.close()
        print("Connection closed")

async def button_callback(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    query.answer()
    
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
            # Eksekusi query
            cursor.execute(query_result['query'])
            query_data = cursor.fetchall()
            
            # Buat pesan respons dari hasil query
            response_message = "Pilihan:\n"
            for index, row in enumerate(query_data, start=1):
                response_message += f"{index}. {row['nama_makanan']}\n"
            
            # Kirim hasil query sebagai respons kepada pengguna
            await query.message.reply_text(response_message)
            
            # Memasukkan respon bot (hasil query) ke dalam database
            insert_bot_response(connection, response_message, query.message.chat.id, query.message.message_id)
        
        connection.close()
        print("Connection closed")

async def error(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print(f'Update {update} caused error {context.error}')

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
