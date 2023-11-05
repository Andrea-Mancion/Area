const nodemailer = require('nodemailer');
require('dotenv').config();

async function callReactionTwitch(area) {
    if (area.reaction_Name == "send_mail") {
        send_mail(area.reaction_Param);
    }
}

module.exports = { callReactionTwitch };

const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    tls: {
        rejectUnauthorized: false
    },
    auth: {
        user: process.env.GMAIL_USER,
        pass: process.env.GMAIL_PASSWORD
    },
});

function send_mail(messageContent) {
    console.log("send_mail to bite");
    console.log(messageContent.message);
    const mailOptions = {
        from: 'ferius.mancion@gmail.com',
        to: 'ferius.mancion@gmail.com',
        subject: 'New follow on Twitch',
        text: messageContent.message,
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error)
            console.log(error);
        else
            console.log('Email sent: ' + info.response);
    });
}