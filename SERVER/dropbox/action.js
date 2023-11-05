const Dropbox = require('dropbox');

async function callActionDropbox(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_new_file") {
        checkFile(area.action_access_token);
    }
}

async function checkFileDropbox(access_token) {
    try {
        const dbx = new Dropbox({ accessToken: access_token });
        const response = await dbx.filesListFolder({ path: 'https://www.dropbox.com/home/Oe' });
        console.log("REPINSE " + response);
        console.log("YEP " +  response.result);
        return response.result.entries;
    } catch (error) {
        console.log("ERROR DROPBOX");
        console.log(error);
    }
}

async function checkFile(access_token) {
    const test = await checkFileDropbox(access_token);
}

module.exports = { callActionDropbox };