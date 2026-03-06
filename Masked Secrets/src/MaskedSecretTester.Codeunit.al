
codeunit 50401 "Masked Secret Tester"
{
    procedure GetSecret()
    var
        MaskedSecret: Record "Masked Secret";
    begin
        MaskedSecret.Get();
        Message(MaskedSecret."Table ExtendedDatatype Secret");
    end;
}
