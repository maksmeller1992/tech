page 50401 "Set Secret Dialog"
{
    ApplicationArea = All;
    Caption = 'Set Secret';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(Code; this.Code)
            {
                Caption = 'Code';
                ToolTip = 'Specifies the value of the Code field.';
            }
            field(Description; this.Description)
            {
                Caption = 'Description';
                ToolTip = 'Specifies the value of the Description field.';
            }
            field("Data Scope"; this.DataScope)
            {
                Caption = 'Data Scope';
                ToolTip = 'Specifies the value of the Data Scope field.';
            }
            field("Secret Text"; this.SecretText)
            {
                Caption = 'Secret Text';
                MaskType = Concealed;
                ToolTip = 'Specifies the value of the Secret Text field.';
            }
        }
    }

    procedure SetSecret(var Secret: Record Secret)
    begin
        Secret.Init();
        Secret.Code := this.Code;
        Secret.Description := this.Description;
        Secret."Data Scope" := this.DataScope;
        Secret.Insert(true);
    end;

    procedure GetSecret(): Text[250]
    begin
        exit(this.SecretText);
    end;

    var
        Code: Code[20];
        Description: Text[250];
        DataScope: Enum "Data Scope";

        [NonDebuggable]
        SecretText: Text[250];
}
