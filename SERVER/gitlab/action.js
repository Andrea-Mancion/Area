const axios = require('axios');

async function callActionGitlab(area) {
    const action_Name = area.action_Name;
    if (action_Name == "get_list_issues") {
        checkCommit(area.action_access_token, area.action_project_id);
    }
}

async function checkCommitGitlab(access_token, project_id) {
    try {
        const reponse = await axios.get(`https://gitlab.com/api/v4/projects/${project_id}/issues`, {
            headers: {
                'PRIVATE-TOKEN': access_token
            },
        });
        console.log("REPINSE " + reponse);
        console.log("YEP " +  reponse.data);

        return reponse.data;
    } catch (error) {
        console.log("ERROR GITLAB");
        console.log(error);
    }
}

async function checkCommit(access_token, project_id) {
    const test = await checkCommitGitlab(access_token, project_id);
}

module.exports = { callActionGitlab };