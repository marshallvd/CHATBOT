from typing import Final
from dotenv import load_dotenv
import os
import mysql.connector as mysql
import datetime as dt
import uuid
import re


# LOAD DOTENV FILE
load_dotenv()

# CONST
DB_HOST: Final = os.getenv('DB_HOST')
DB_USER: Final = os.getenv('DB_USER')
DB_PASSWORD: Final = os.getenv('DB_PASSWORD')
DB_NAME: Final = os.getenv('DB_NAME')

# CONNECT DATABASE
conn = mysql.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    database=DB_NAME
)

cur = conn.cursor(dictionary=True)

async def get_query(menu_id, query, data=None):
    conn.commit()

    if data:
        cur.execute(query, data)
    else:
        cur.execute(query)
    result = cur.fetchall()
    
    # if result and int(menu_id) == 2:
    #     total_sks = sum(row['SKS'] for row in result)
    #     result.append({"MATA KULIAH": "TOTAL SKS", "SKS": total_sks})  

    return result

async def get_list_menu():
    conn.commit()
    
    query: str = "SELECT * FROM tb_menu"
    cur.execute(query)
    result = cur.fetchall()

    return result

async def get_query_menu(menu_id):
    conn.commit()
    
    query: str = "SELECT * FROM tb_query_menu WHERE id_menu = %s"
    data = (menu_id,)
    cur.execute(query, data)
    
    res_query_menu = cur.fetchone()
    menu_query: str = res_query_menu["query"]

    query: str = "SELECT * FROM tb_query_menu_param WHERE id_query_menu = %s"
    data = (res_query_menu["id_query_menu"],)
    cur.execute(query, data)

    res_query_param = cur.fetchall()
    menu_params = []
    if res_query_param:
        for row in res_query_param:
            menu_params.append(row['param'])
            
    return menu_query, menu_params

async def insert_inbox(data):
    query: str = "INSERT INTO tb_inbox(id_inbox, user_id, message, type, create_date) VALUE(%s, %s, %s, %s, %s)"
    result = cur.execute(query, data)
    conn.commit()

    return result

async def insert_outbox(data):
    query: str = "INSERT INTO tb_outbox(id_outbox, id_inbox, user_id, message, type, create_date) VALUE(%s, %s, %s, %s, %s, %s)"
    result = cur.execute(query, data)
    conn.commit()

    return result