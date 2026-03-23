page 50400 "Secrets"
{
    ApplicationArea = All;
    Caption = 'Secrets';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Secret";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Data Scope"; Rec."Data Scope")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Data Scope field.';
                }
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("Set Secret")
            {
                ApplicationArea = all;
                Caption = 'Set Secret';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Allows to set a new secret.';
                trigger OnAction()
                begin
                    this.SetSecret();
                end;
            }

            action("Set Secret OnPrem")
            {
                ApplicationArea = all;
                Caption = 'Set Secret OnPrem';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Allows to set a new secret.';
                trigger OnAction()
                begin
                    this.SetSecretOnPrem();
                end;
            }
            action("Get Secret")
            {
                ApplicationArea = all;
                Caption = 'Get Secret';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Allows to get a secret.';
                trigger OnAction()
                var
                    SecretText: SecretText;
                begin
                    SecretText := this.IsolatedStorageImpl.Get(Rec."Secret ID", Rec.MapToDataScope(Rec."Data Scope"));
                    // Target = OnPrem only
                    //Message(SecretText.Unwrap());
                end;
            }
            action("Get Secret OnPrem")
            {
                ApplicationArea = all;
                Caption = 'Get Secret OnPrem';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Allows to get a secret.';
                trigger OnAction()
                var
                    SecretText: Text;
                begin

                    Message(SecretText);
                end;
            }
        }
    }

    local procedure SetSecret()
    var
        NewSecret: Record Secret;
        SecretDialog: Page "Set Secret Dialog";
        SecretText: SecretText;
    begin
        if SecretDialog.RunModal() = Action::OK then begin
            SecretDialog.SetSecret(NewSecret);
            SecretText := SecretDialog.GetSecret();

            this.IsolatedStorageImpl.Set(NewSecret."Secret ID", SecretText, NewSecret.MapToDataScope(NewSecret."Data Scope"));
            NewSecret.Modify(true);

            Commit();
        end;
    end;


    local procedure SetSecretOnPrem()
    var
        NewSecret: Record Secret;
        SecretDialog: Page "Set Secret Dialog";
        SecretText: Text;
    begin
        if SecretDialog.RunModal() = Action::OK then begin
            SecretDialog.SetSecret(NewSecret);
            SecretText := SecretDialog.GetSecret();

            this.IsolatedStorageOnPremOnly.Set(NewSecret, SecretText);
            NewSecret.Modify(true);

            Commit();
        end;
    end;

    var
        IsolatedStorageImpl: Codeunit "Isolated Storage Impl.";
        IsolatedStorageOnPremOnly: Codeunit "Isolated Storage - OnPremOnly";
}
