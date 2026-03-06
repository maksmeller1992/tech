page 50403 "Masked Secret"
{
    ApplicationArea = All;
    Caption = 'Masked Secrets';
    UsageCategory = Administration;
    SourceTable = "Masked Secret";

    layout
    {
        area(Content)
        {
            group("ExtendedDatatype Secrets")
            {
                field("Table ExtendedDatatype Secret"; Rec."Table ExtendedDatatype Secret")
                {
                    ToolTip = 'Specifies the value of the Table ExtendedDatatype Secret field.';
                }
                field("Page ExtendedDatatype Secret"; Rec."Page ExtendedDatatype Secret")
                {
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Page ExtendedDatatype Secret field.';
                }
            }
            group("MaskType Secrets")
            {
                field("Table MaskType Secret"; Rec."Table MaskType Secret")
                {
                    ToolTip = 'Specifies the value of the Table MaskType Secret field.';
                }
                field("Page MaskType Secret"; Rec."Page MaskType Secret")
                {
                    MaskType = Concealed;
                    ToolTip = 'Specifies the value of the Page MaskType Secret field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Secret")
            {
                ApplicationArea = all;
                Caption = 'Get Secret';
                ToolTip = 'Executes the Get Secret action.';
                trigger OnAction()
                var
                    MaskedSecretTester: Codeunit "Masked Secret Tester";
                begin
                    MaskedSecretTester.GetSecret();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

}