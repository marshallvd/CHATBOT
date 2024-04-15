from typing import Final
from telegram import InlineKeyboardButton, InlineKeyboardMarkup, Update
from telegram.constants import ParseMode
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes, ConversationHandler, CallbackQueryHandler
from models import get_list_menu, get_query, get_query_menu, insert_inbox, insert_outbox
from dotenv import load_dotenv
import os
import datetime as dt
import uuid
import re
import prettytable as pt
import mysql.connector



# LOAD DOTENV FILE
load_dotenv()

# CONST
TOKEN: Final = os.getenv("TOKEN")
BOT_USERNAME: Final = os.getenv("BOT_USERNAME")
SELECT_MENU, ASKING_PARAMS = range(2)

# COMMANDS
async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Bot on start_command()")
    id_inbox = await _insert_inbox(update.message)
    list_menu = await get_list_menu()


    # SET SESSION DATA
    context.user_data['user_id'] = update.message.chat.id                   # GET user id
    context.user_data['message_type'] = update.message.chat.type            # CHECK IF chat type (Group / Personal Chat)

    response: str = f"Hai. Saya Bot Banago, sahabat masalah kuliah Anda\nKirim /cancel untuk menghentikan perintah.\n\nAda yang bisa saya bantu ?\n"

    # MAKE INLINE KEYBOARD
    input_keyboard = []
    index = 1
    arr_input = []
    for menu in list_menu:
        if index % 2 != 0:
            arr_input = [InlineKeyboardButton(menu['label'], callback_data=menu['id_menu'])]
            if index == len(list_menu):
                input_keyboard.append(arr_input)
        else:
            arr_input.append(InlineKeyboardButton(menu['label'], callback_data=menu['id_menu']))
            input_keyboard.append(arr_input)
        index += 1
            
    # REPLY MESSAGE
    await update.message.reply_text(
        response, 
        reply_markup=InlineKeyboardMarkup(input_keyboard)
    )

    await _insert_outbox(update.message, id_inbox, response + " " + str(input_keyboard))

    # RETURN STATE
    return SELECT_MENU

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Bot on help_command()")
    id_inbox = await _insert_inbox(update.message)

    response = (
        "Selamat datang!\n\n"
        "Berikut adalah perintah yang tersedia:\n"
        "/start - Memulai interaksi dengan bot.\n"
        "/cancel - Membatalkan operasi saat ini.\n"
        "/help - Menampilkan perintah yang tersedia beserta deskripsinya.\n"
        "\n"
        "Catatan: Anda juga dapat berinteraksi dengan bot dengan mengeklik tombol yang disediakan."
    )

    await _insert_outbox(update.message, id_inbox, response)
    await update.message.reply_text(response)


# RESPONSE
async def asking_params(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Bot on asking_params()")
    query = update.callback_query
    menu_id = query.data
    id_inbox = await _insert_inbox_inline(menu_id, context.user_data['user_id'], context.user_data['message_type'])

    # GET QUERY MENU
    menu_query, menu_params = await get_query_menu(menu_id)
    # CHECK IF THERE IS PARAMS OR NOT
    if len(menu_params) > 0:
        # ITERATE MULTIPLE PARAMS
        response = "Silakan masukkan "
        for i in range(len(menu_params)):
            response += menu_params[i]
            if i == 1-len(menu_params):
                response += " anda : "
            else:
                response += " | "
        flag_params = 1
    else:
        response = "Yang sabar ya . . ."
        flag_params = 0

    # SET SESSION DATA
    context.user_data['menu_id'] = menu_id
    context.user_data['menu_query'] = menu_query


    # REPLY THE MESSAGE
    print('Bot: ', response)
    await _insert_outbox_inline(menu_id, context.user_data['user_id'], context.user_data['message_type'], id_inbox, response)
    await query.answer()
    await query.edit_message_text(text=response)
    
    # CHECK IF THERE IS PARAM OR NOT
    #   Y = RETURN STATE
    #   N = RETURN QUERY RESULT
    if flag_params:    
        return ASKING_PARAMS 
    else:
        res_query = await get_query(menu_id, menu_query)
        response = await _generate_table(res_query)

        print('Bot: \n', response)
        await _insert_outbox_inline(menu_id, context.user_data['user_id'], context.user_data['message_type'], id_inbox, response.get_string())
        await query.message.reply_text(f'```{response}```', parse_mode=ParseMode.MARKDOWN_V2)
        

        response = "Anda dapat memulai dari awal dengan mengetik /start."
        
        print('Bot: \n', response)
        await _insert_outbox_inline(menu_id, context.user_data['user_id'], context.user_data['message_type'], id_inbox, response)
        await query.message.reply_text(response)
        
        return ConversationHandler.END

async def query_result(update: Update, context: ContextTypes.DEFAULT_TYPE):    
    print("Bot on query_result()")
    id_inbox = await _insert_inbox(update.message)

    # GET SESSION DATA
    menu_query = context.user_data['menu_query']
    menu_id = context.user_data['menu_id']

    message_type: str = update.message.chat.type        # CHECK IF chat type (Group / Personal Chat)
    text: str = update.message.text                     # GET message

    if message_type == 'group':
        if BOT_USERNAME in text:
            text = text.replace(BOT_USERNAME, '').strip()
        else:
            return
        
    # GET PARAMS
    params = tuple(text.split(" | "))
    # Jika hanya NIM atau nama yang dimasukkan, sesuaikan parameter yang digunakan
    if len(params) == 1:
        # Jika hanya NIM yang dimasukkan
        if re.match(r'^\d+$', params[0]):
            # Gunakan NIM sebagai parameter dan tambahkan parameter nama
            params = (params[0], params[0])
        # Jika hanya nama yang dimasukkan
        else:
            # Gunakan nama sebagai parameter dan tambahkan parameter NIM
            params = (params[0], params[0])

    res_query = await get_query(menu_id, menu_query, params)
    print('\tQuery: ', menu_query, '\n\tParams: ', params, '\n\tMenu ID: ', menu_id)

    # CHECK RESULT_QUERY
    #   Y = RESPONSE WITH RESULT
    #   N = ERROR MESSAGE
    if res_query:
        response = await _generate_table(res_query)
        await _insert_outbox(update.message, id_inbox, response.get_string())
        await update.message.reply_text(f'```{response}```', parse_mode=ParseMode.MARKDOWN_V2)
    else:
        response = "Data tidak ditemukan! Silakan coba masukkan input / format yang benar."
        await _insert_outbox(update.message, id_inbox, response)
        await update.message.reply_text(response)

    # REPLY TO USER
    print('Bot: \n', response)

    response = "Anda dapat memulai dari awal dengan mengetik /start."
    print('Bot: \n', response)
    await _insert_outbox(update.message, id_inbox, response)
    await update.message.reply_text(response)

    return ConversationHandler.END


# DEFAULT FUNCTION
async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):  
    print("Bot on handle_message()")
    id_inbox = await _insert_inbox(update.message)

    if id_inbox: 
        response: str = 'Pesan berhasil disimpan ke database!'
    else:
        response: str = 'Gagal menyimpan pesan ke database!'

    # REPLY TO USER
    print('Bot: ', response)
    await _insert_outbox(update.message, id_inbox, response)
    await update.message.reply_text(response)

# CANCEL FUNCTION
async def cancel_conv(update: Update, context: ContextTypes.DEFAULT_TYPE): 
    print("Bot on cancel_conv()")
    id_inbox = await _insert_inbox(update.message)
    response = 'Input salah, percakapan dibatalkan. Kirim /start untuk memulai kembali.'

    await update.message.reply_text(response)
    await _insert_outbox(update.message, id_inbox, response)
    return ConversationHandler.END

async def cancel(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Bot on cancel()")
    id_inbox = await _insert_inbox(update.message)
    response = 'Oke, percakapan dibatalkan. Kirim /start untuk memulai lagi.'

    await update.message.reply_text(response)
    await _insert_outbox(update.message, id_inbox, response)
    return ConversationHandler.END

# ERROR
async def error(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print(f'Update {update} caused error {context.error}')

# INNER FUNCTION
async def _generate_table(data):
    headers = list(data[0].keys())
    table = pt.PrettyTable(headers)

    for header in headers: 
        table.align[header] = 'l'
        
    
    for row in data:
        temp_row = []
        for i in range(len(headers)):
            temp_row.append(row[headers[i]])
        table.add_row(temp_row)
    
    return table

async def _insert_outbox(update, id_inbox, response):
    user_id: str = update.chat.id               # GET user id
    message_type: str = update.chat.type        # CHECK IF chat type (Group / Personal Chat)
    text: str = update.text                     # GET message
    current_date_time: str = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    if message_type == 'group':
        if BOT_USERNAME in text:
            text = text.replace(BOT_USERNAME, '').strip()
        else:
            return

    # SAVED BOT MESSAGE TO OUTBOX
    outbox_id = str(uuid.uuid4())
    data = (outbox_id, id_inbox, user_id, response, message_type, current_date_time)
    result = await insert_outbox(data)

    print("Respon disimpan ke outbox")
    
    return result

async def _insert_outbox_inline(key_id, user_id, message_type, id_inbox, response):
    text = "Memilih menu nomor " + key_id
    current_date_time: str = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # SAVED BOT MESSAGE TO OUTBOX
    outbox_id = str(uuid.uuid4())
    data = (outbox_id, id_inbox, user_id, response, message_type, current_date_time)
    result = await insert_outbox(data)

    print("Respon disimpan ke outbox")

    return id_inbox

async def _insert_inbox(update):
    user_id: str = update.chat.id               # GET user id
    message_type: str = update.chat.type        # CHECK IF chat type (Group / Personal Chat)
    text: str = update.text                     # GET message
    current_date_time: str = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    if message_type == 'group':
        if BOT_USERNAME in text:
            text = text.replace(BOT_USERNAME, '').strip()
        else:
            return

    # SAVED USER MESSAGE TO INBOX
    id_inbox = str(uuid.uuid4())
    data = (id_inbox, user_id, text, message_type, current_date_time)
    result = await insert_inbox(data)

    print("Respon disimpan ke inbox")

    return id_inbox

async def _insert_inbox_inline(key_id, user_id, message_type):
    text = "Memilih menu nomor." + key_id
    current_date_time: str = dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # SAVED USER MESSAGE TO INBOX
    id_inbox = str(uuid.uuid4())
    data = (id_inbox, user_id, text, message_type, current_date_time)
    result = await insert_inbox(data)

    print("Respon disimpan ke inbox")

    return id_inbox

# MAIN PY
if __name__ == '__main__':
    print("Starting bot...")
    app = Application.builder().token(TOKEN).build()

    # CONV HANDLER : HANDLE STATE
    conv_handler = ConversationHandler(
        entry_points=[CommandHandler('start', start_command)],
        states={
            SELECT_MENU: [CallbackQueryHandler(asking_params), MessageHandler(~filters.COMMAND, cancel_conv), MessageHandler(filters.Regex(r'(^/cancel)'), cancel)],
            ASKING_PARAMS: [MessageHandler(filters.TEXT, query_result)]
        },
        fallbacks=[]
    )
    app.add_handler(conv_handler)

    # COMMAND
    app.add_handler(CommandHandler("help", help_command))

    # MESSAGE
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))

    # ERROR
    app.add_error_handler(error)

    print("Polling...")
    app.run_polling(poll_interval=3)