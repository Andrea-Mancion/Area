const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    tls: {
        rejectUnauthorized: false
    },
    auth: {
      user: process.env.GMAIL_USER,
      pass: process.env.GMAIL_PASSWORD,
    },
});

function sendMail(MessageContent) {
    const mailOptions = {
        from: 'ferius.mancion@gmail.com',
        to: 'ferius.mancion@gmail.com',
        subject: 'New Message on Discord',
        text: 'There is a new message on the Discord server: ' + MessageContent,
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.log("Error with the send Email: " + error);
        }
        console.log('Email sent: ' + info.response);
    });
}

module.exports = { sendMail };