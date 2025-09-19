const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');
const TelegramBot = require('node-telegram-bot-api'); // Import the Telegram library

const app = express();
const port = 3000;

const botToken = "7728570474:AAFa2KV2mHpi-8vMPm_g1Eioe4CaTpN3txs";
const chatId = "1901603603"; 

const bot = new TelegramBot(botToken, { polling: false });

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const logFilePath = path.join(__dirname, 'sms.txt');

app.post('/', (req, res) => {
  const message = req.body.message;

  if (!message) {
    return res.status(400).send('Error: The "message" parameter is missing.');
  }

  const logEntry = `${message}\n`;

  fs.appendFile(logFilePath, logEntry, (err) => {
    if (err) {
      console.error('Failed to write to file:', err);
    } else {
      console.log(`Successfully wrote message to ${logFilePath}`);
    }

    bot.sendMessage(chatId, message)
      .then(() => {
        console.log('Successfully sent message to Telegram.');
        res.status(200).send('Success!');
      })
      .catch((telegramErr) => {
        console.error('Failed to send message to Telegram:', telegramErr);
        res.status(500).send('Internal Server Error: Failed to send Telegram message.');
      });
  });
});

app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
