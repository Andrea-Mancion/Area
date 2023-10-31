const express = require('express');
const session = require('express-session');
const octokit = require('octokit');
const { get } = require('..');
require('dotenv').config();

var counter = 0;
var recup_Total;

async function callActionGithub(area) {
    const action_Name = area.action_Name;
    if (action_Name == "get_issues") {
        getIssues(area.action_Param);
    }
}

async function getIssue(access_token) {
    try {
      const octokit1 = new octokit.Octokit({
        auth: access_token,
      });

      const reponse = await octokit1.request('GET /repos/{owner}/{repo}/issues', {
        owner: 'Andrea-Mancion',
        repo: 'ChatBotDiscord',
        headers: {
          'X-GitHub-Api-Version': '2022-11-28'
        }
      });

      counter = counter + 1;
      return reponse.data;
    } catch (error) {
      console.log("ERROR WITH THE ISSUE");
      console.error(error);
    }
}

async function getIssues(areaContent) {
    const test = await getIssue(areaContent.access_token);
    if (counter === 1)
      recup_Total = Object.keys(test).length;
    else {
      if (recup_Total < Object.keys(test).length) {
        console.log("NEW ISSUE");
        recup_Total = Object.keys(test).length;
      } else if (recup_Total > Object.keys(test).length) {
        console.log("DELETE ISSUE");
        recup_Total = Object.keys(test).length;
      } else
        console.log("NO CHANGE");
    }
}

module.exports = { callActionGithub };