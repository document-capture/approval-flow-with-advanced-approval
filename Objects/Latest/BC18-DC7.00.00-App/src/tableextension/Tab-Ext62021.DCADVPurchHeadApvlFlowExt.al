tableextension 62021 "DCADV Purch.Head ApvlFlow Ext." extends "Purchase Header"
{
    fields
    {
        field(62021; "Approval flow assigned"; Boolean)
        {
            Caption = 'Approval flow assigned';
            FieldClass = FlowField;
            CalcFormula = exist("CDC Purchase Header Info." where(
                                                 "Document Type" = field("Document Type"),
                                                 "No." = field("No.")));

        }
    }
}
