table 50401 "Masked Secret"
{
    Caption = 'Masked Secret';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Table ExtendedDatatype Secret"; Text[250])
        {
            Caption = 'Table ExtendedDatatype Secret';
            MaskType = Concealed;
        }
        field(3; "Page ExtendedDatatype Secret"; Text[250])
        {
            Caption = 'Page ExtendedDatatype Secret';
        }
        field(4; "Table MaskType Secret"; Text[250])
        {
            Caption = 'Table MaskType Secret';
            MaskType = Concealed;
        }
        field(5; "Page MaskType Secret"; Text[250])
        {
            Caption = 'Page MaskType Secret';
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
