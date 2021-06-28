# approval-flow-with-advanced-approval
This is an example of an extension that enables you to use with Document Capture approval flow codes parallel with advanced approval.

## Concept of this solution ## 
This solution consists of these changes
1. add a flow field to table 38 which holds the information if an Document Capture approval flow code has been added to the selected purchase invoice/cr. memo.
2. an event subscriber that enables Document Capture to show the approval flow code field even though the adv. approval workflow is enabled
3. an event subscriber that enables Document Capture to modify the approval flow code on purchase invoice/cr. memo even though the adv. approval workflow is enabled

## How-to use this solution ##
Depending on your Business Central/Dynamics NAV solution you have to install the app (BC al-only) or merge the objects (BC14 and older "fob-based") from the "Object" directory of this repository.

In the next step you have to setup the Document Capture approval workflows to run only if the value of the new flow field is correct.

Setup example of advanced approval workflow for purchase invoices:
![](https://github.com/document-capture/approval-flow-with-advanced-approval/blob/main/Documentation/Edit_-_Workflow_-_DC-PIAW-01_%E2%88%99_Advanced_approval.png)

Filter example of purchase invoice approval setup:
![](https://github.com/document-capture/approval-flow-with-advanced-approval/blob/main/Documentation/Edit_-_Workflow_-_DC-PIW-01_%E2%88%99_Approval_workflow.png)


## Remark ##
You can use this code as it is, without any warranty or support by the github owner or [Continia Software A/S](https://www.continia.com "Continia Software"). 

You can use the app on your own risk. 

**If you find issues in the code, please report these in the issues list here on Github.**
