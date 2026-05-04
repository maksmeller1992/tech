codeunit 50101 "Sales Additional Functions"
{
    procedure ChangeBillTo(var SalesHeader: Record "Sales Header"; BillToCustomerNo: Code[20])
    begin
        SalesHeader.Validate("Bill-to Customer No.", BillToCustomerNo);
        SalesHeader.Modify();
    end;

}
