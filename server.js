const fs = require('fs');
const https = require('https');
const express = require('express');

const app = express();
app.use(express.static('web'));
app.get('/', function (req, res) {
    return res.sendFile('web/index.html');
});

const options = {
    key: fs.readFileSync('ssl/techqila.key', 'utf8'),
    cert: fs.readFileSync('ssl/techqila.crt', 'utf8'),
    passphrase: process.env.HTTPS_PASSPHRASE || ''
};
const server = https.createServer(options, app);

server.listen(process.env.SERVER_PORT || 8443);