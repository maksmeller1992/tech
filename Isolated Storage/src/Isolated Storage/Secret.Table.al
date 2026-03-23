table 50400 Secret
{
    Caption = 'Secret';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Data Scope"; Enum "Data Scope")
        {
            Caption = 'Data Scope';
        }
        field(4; "Secret ID"; Guid)
        {
            Caption = 'Secret ID';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }


    trigger OnDelete()
    var
        IsolatedStorageImpl: Codeunit "Isolated Storage Impl.";
    begin
        IsolatedStorageImpl.Delete(Rec."Secret ID", Rec.MapToDataScope(Rec."Data Scope"));
    end;

    procedure MapToDataScope(SecretDataScope: Enum "Data Scope"): DataScope
    begin
        case SecretDataScope of
            SecretDataScope::Company:
                exit(DataScope::Company);
            SecretDataScope::"CompanyAndUser":
                exit(DataScope::CompanyAndUser);
            SecretDataScope::Module:
                exit(DataScope::Module);
            SecretDataScope::User:
                exit(DataScope::User);
        end;
    end;
}