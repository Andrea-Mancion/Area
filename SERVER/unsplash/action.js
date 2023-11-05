const axios = require('axios');

async function callActionUnsplash(area) {
    const action_Name = area.action_Name;
    if (action_Name == "check_liked_photo") {
        check_like_photo(area.action_access_token, area.action_Param.photo_id);
    }
}

async function liked_photo(access_token, photo_id) {
    try {
        const config = {
            headers: { Authorization: `Bearer ${access_token}` }
        };

        const response = await axios.post(`https://api.unsplash.com/photos/${photo_id}/like`, config);

        console.log("REPINSE " + response);
        console.log("YEP " +  response.data);

        return response.data;
    } catch (error) {
        console.log("ERROR UNSPLASH");
        console.log(error);
    }
}

async function check_like_photo(access_token, photo_id) {
    const test = await liked_photo(access_token, photo_id);
    console.log("RESULT " + test);
}

module.exports = { callActionUnsplash };