FROM python:3.7

RUN pip install python-telegram-bot

RUN mkdir /app
ADD . /app
WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD python /app/bot.py
