sf demoutil org create scratch -f config/project-scratch-def.json -d 5 -s -p loan -e approval.demo
sf project deploy start
sf demoutil user password set -p salesforce1 -g User -l User
#assign permset to user
sf org assign permset -n LoanAdmin
#Load Opportunity and Recommendation data
sf data bulk upsert -s Loan__c -f data/loans.csv -i Loan_Id__c -w 30
sf apex run -f data/recommendations.cls
#Install EPB Model Accuracy Package
#sfdx force:package:install -p 04t4J000002ASSJ
#Open org
sf org open -p /lightning/setup/SetupOneHome/home
