sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s --wait 60 --userprefix loan -o approval.workshop
sfdx force:source:push
sfdx shane:user:password:set -g User -l User -p salesforce1
#assign permset to user
sfdx force:user:permset:assign --permsetname LoanAdmin
#Load Opportunity and Recommendation data
sfdx force:data:bulk:upsert -s Loan__c -f data/loans.csv -i Loan_Id__c -w 3
sfdx force:apex:execute -f data/recommendations.cls
#Install EPB Model Accuracy Package
#sfdx force:package:install -p 04t4J000002ASSJ
#Open org
sfdx force:org:open -p /lightning/setup/SetupOneHome/home
