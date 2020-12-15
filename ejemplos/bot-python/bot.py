import logging
from Crypto.Cipher import AES
import os
import random
import sys
from random import randint
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters




# Enabling logging
logging.basicConfig(level=logging.INFO,
                    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s")
logger = logging.getLogger()

# Getting mode, so we could define run function for local and Heroku setup
mode = os.getenv("MODE")
TOKEN = os.getenv("TOKEN")
MYKEY = os.getenv("MYKEY")
if mode == "dev":
    def run(updater):
        updater.start_polling()
elif mode == "prod":
    def run(updater):
        PORT = int(os.environ.get("PORT", "8443"))
        HEROKU_APP_NAME = os.environ.get("HEROKU_APP_NAME")
        # Code from https://github.com/python-telegram-bot/python-telegram-bot/wiki/Webhooks#heroku
        updater.start_webhook(listen="0.0.0.0",
                              port=PORT,
                              url_path=TOKEN)
        updater.bot.set_webhook("https://{}.herokuapp.com/{}".format(HEROKU_APP_NAME, TOKEN))
else:
    logger.error("No MODE specified!")
    sys.exit(1)

def start(update, context):
    logging.info("User started bot {}".format(update.message.from_user.first_name))
    context.bot.send_message(chat_id=update.message.chat_id, text="Hi there, {}".format(update.message.from_user.first_name))
    context.bot.send_message(chat_id=update.message.chat_id, text="What's up.")

def horario(update, context):
    logging.info("User started bot {}".format(update.message.from_user.first_name))
    context.bot.send_message(chat_id=update.message.chat_id, text="Monday to Friday - 09:00 am to 18:00 pm")

def echo(update, context):
    """Echo the user message."""
    update.message.reply_text(update.message.text)

def reply(update, context):
    themess = update.message.text
    choice = randint(0,1)

    if "stupid" in themess or "silly" in themess:
        dic = "aeou"
        for i in dic:
            themess = themess.replace(i,"i")
        context.bot.send_message(chat_id=update.message.chat_id, text=themess)
        context.bot.send_message(chat_id=update.message.chat_id, text="This is you. This is how you sound")
    else:
        if "encrypt" in themess:
            context.bot.send_message(chat_id=update.message.chat_id, text="Let's AES this shit. Wait a sec.")
            themess = themess.split(':',1)
            themess = themess[1]
            obj = AES.new(MYKEY, AES.MODE_CFB, 'This is an IV456')
            ciphered = obj.encrypt(themess)
            ciphered = str(ciphered)
            context.bot.send_message(chat_id=update.message.chat_id, text=ciphered)
                
if __name__ == '__main__':
    logger.info("Bot started")
   
    updater = Updater(token=TOKEN, use_context=True)

    # ADD dispatcher with command handler
    dispatcher = updater.dispatcher
    logger.info("working untill here")
    start_handler = CommandHandler('start', start)
    horario_handler = CommandHandler('horario', horario)
    dispatcher.add_handler(start_handler)
    dispatcher.add_handler(horario_handler)
    dispatcher.add_handler(MessageHandler(Filters.text, reply))
    logger.info(dispatcher.add_handler(start_handler))
    logger.info(dispatcher.add_handler(horario_handler))

run(updater)
