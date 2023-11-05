const Dropbox = require('dropbox');

async function callActionDropbox(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_new_file") {
        console.log("CHECK NEW FILE ouais !!!");
        checkFile(area.action_access_token);
    }
}

async function checkFileDropbox(access_token) {
    try {
        console.log("CHECK FILE");
        const dbx = new Dropbox.Dropbox({ accessToken: access_token });
        const response = await dbx.filesListFolder({ path: 'home/Oe' });
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