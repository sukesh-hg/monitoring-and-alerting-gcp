# Monitoring and Alerting on GCP
IAM and Service Accounts greatly simplify the management of GCP projects however they come with many a risk. To name a few- Engineers going rogue and spinning up resources against organization policies, stale policies that nobody keeps an eye on, leaked Service Account JSON keys which potentially compromise the entire project. It is very challenging to manually keep tabs on the project infrastructure, the complexity increases with the size of the organization.

Google Cloud Platform provides all the tools and services needed to ease the monitoring and alerting process. You can setup a simple pipeline to get instant notification on your preferred channel anytime there's a resource spun up in your project. 

![alt text](https://i.imgur.com/xleYzvb.jpg)

How to use this Repo:

There is a simple bash script which will take care of all the setup and create an end-to-end pipeline that sends out notifications on your Google Chat Room whenever a new Compute resource is created. You get information on 'WHO' created 'WHAT' in 'WHICH' project.

You can choose to tweak the configurations in the script or even set up this pipeline manually depending on your needs.
