/**
 * Triggered from a log sink export message on a Cloud Pub/Sub topic.
 *
 * @param {!Object} event Event payload.
 * @param {!Object} context Metadata for the event.
 */
const fetch = require('node-fetch');

exports.pubsubEvent = (event, context) => {
  //decode and parse the event payload to json	
  const data = JSON.parse(Buffer.from(event.data, 'base64').toString());
  const user = data.protoPayload.authenticationInfo.principalEmail;
  const project = data.resource.labels.project_id;
  var notification = user+" created a compute resource in project "+project;
  //google chat notification
  fetch(process.env.webhookURL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({
    'text': notification,
     })
  }).then((response) => {
    console.log(response);
  });
};
