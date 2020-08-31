#!/bin/bash
echo "Script to automate notifications on gcp resource creation"

#setup the pub/sub topic
echo "Step 1: Setting up pub/sub topic to be configured as log sink"
read -p 'Please enter the name for the topic: ' topic
echo "Creating the topic ..."
gcloud pubsub topics create $topic

#setup the log sink
echo "Step 2: Setting up the log sink"
read -p 'Please enter the name for the log sink: ' logsink
echo "Setting up th Sink ..."
gcloud logging sinks create $logsink pubsub.googleapis.com/projects/$GOOGLE_CLOUD_PROJECT/topics/$topic --log-filter 'resource.type="gce_instance" AND protoPayload.methodName="beta.compute.instances.insert" AND operation.last=true'

#Grant permissions on the topic
echo "Step 3: Granting access for SA on the topic"
gcloud logging sinks describe automation --format='value(writerIdentity)' | sed -E  's/(.*):(.*)/\2/'
gcloud pubsub topics add-iam-policy-binding $topic --member=$(gcloud logging sinks describe $logsink --format='value(writerIdentity)') --role='roles/pubsub.publisher'

#setup cloud-function
echo "Step 3: Setting up the Cloud Function with Google Chat integration"
read -p 'Enter the name of cloud function: ' cloudfunction
read -p 'Enter the Google Chat webhook URL: ' webhookURL
echo "Creating the Cloud Function ..."
gcloud functions deploy $cloudfunction --entry-point=pubsubEvent --runtime=nodejs10 --set-env-vars=webhookURL=$webhookURL --trigger-topic=$topic

echo "Setup Completed!"

