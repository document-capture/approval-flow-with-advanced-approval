codeunit 62021 "DCADV Approval Flow Management"
{
    [EventSubscriber(ObjectType::table, 6085767, 'OnBeforeUpdateApprvlFlowCode', '', true, true)]
    local procedure PurchHeaderInfo_OnBeforeUpdateApprvlFlowCode(PurchHeader: Record "Purchase Header"; NewCode: Code[10]; var Handled: Boolean)
    var
        ApprovalFlow: Record "CDC Approval Flow";
        PurchHeaderDCInfo: Record "CDC Purchase Header Info.";
        CDCModuleLicense: Codeunit "CDC Module License";
        DCApprovalsBridge: Codeunit "CDC Approvals Bridge";
    begin
        IF Handled THEN
            EXIT;

        Handled := true;
        PurchHeader.TESTFIELD(Status, PurchHeader.Status::Open);

        IF NewCode = '' THEN BEGIN
            IF PurchHeaderDCInfo.GET(PurchHeader."Document Type", PurchHeader."No.") THEN
                PurchHeaderDCInfo.DELETE;
            EXIT;
        END;

        // Verify that Approcal Flow Code and Advanced approval is not being used at the same time
        //CASE PurchHeader."Document Type" OF
        //    PurchHeader."Document Type"::Invoice:
        //        IF DCApprovalsBridge.IsAdvPurchInvApprEnabled THEN
        //            ERROR(AppFlowAndAdvAppErr);
        //    PurchHeader."Document Type"::"Credit Memo":
        //        IF DCApprovalsBridge.IsAdvPurchCrMemoApprEnabled THEN
        //            ERROR(AppFlowAndAdvAppErr);
        //END;

        ApprovalFlow.GET(NewCode);
        IF NOT PurchHeaderDCInfo.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
            PurchHeaderDCInfo."Document Type" := PurchHeader."Document Type";
            PurchHeaderDCInfo."No." := PurchHeader."No.";
            PurchHeaderDCInfo.INSERT;
        END;

        PurchHeaderDCInfo."Approval Flow Code" := NewCode;
        PurchHeaderDCInfo.MODIFY;

    end;

    [EventSubscriber(ObjectType::Table, 6085767, 'OnBeforeIsApprovalFlowVisible', '', true, true)]
    local procedure PurchHeaderInfo_OnBeforeIsApprovalFlowVisible(var Handled: Boolean)
    var
        ApprovalFlow: Record "CDC Approval Flow";
        ModuleLicense: Codeunit "CDC Module License";
        DCApprovalsBridge: Codeunit "CDC Approvals Bridge";
    begin
        if Handled then
            exit;

        if (IsAdvPurchInvApprEnabled and IsDCPurchInvApprEnabled) OR
           (IsAdvPurchCrMemoApprEnabled and IsDCPurchCrMemoApprEnabled) then
            Handled := true;
    end;

    local procedure IsDCPurchInvApprEnabled(): Boolean
    var
        Workflow: Record Workflow;
    begin
        Workflow.SETFILTER(Code, 'DC-PIW*');
        Workflow.SETRANGE(Enabled, TRUE);
        EXIT(NOT Workflow.ISEMPTY);
    end;

    local procedure IsDCPurchCrMemoApprEnabled(): Boolean
    var
        Workflow: Record Workflow;
    begin
        Workflow.SETFILTER(Code, 'DC-PCMW*');
        Workflow.SETRANGE(Enabled, TRUE);
        EXIT(NOT Workflow.ISEMPTY);
    end;

    local procedure IsAdvPurchInvApprEnabled(): Boolean
    var
        Workflow: Record Workflow;
    begin
        Workflow.SETFILTER(Code, 'DC-PIAW*');
        Workflow.SETRANGE(Enabled, TRUE);
        EXIT(NOT Workflow.ISEMPTY);
    end;

    local procedure IsAdvPurchCrMemoApprEnabled(): Boolean
    var
        Workflow: Record Workflow;
    begin
        Workflow.SETFILTER(Code, 'DC-PCMAW*');
        Workflow.SETRANGE(Enabled, TRUE);
        EXIT(NOT Workflow.ISEMPTY);
    end;
}
