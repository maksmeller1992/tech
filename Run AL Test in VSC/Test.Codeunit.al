// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

codeunit 50100 Test
{
    Subtype = Test;

    [Test]
    // Scenario: Create a sales order and verify that the bill-to customer is the same as the sell-to customer by default.
    procedure CreateSalesOrder()
    var
        Customer: Record Customer;
        Customer2: Record Customer;
        SalesHeader: Record "Sales Header";
        LibrarySales: Codeunit "Library - Sales";
        SalesAdditionalFunctions: Codeunit "Sales Additional Functions";
        Assert: Codeunit Assert;
    begin
        // given
        LibrarySales.CreateCustomer(Customer);
        LibrarySales.CreateCustomer(Customer2);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, Customer."No.");

        // when
        SalesAdditionalFunctions.ChangeBillTo(SalesHeader, Customer2."No.");

        // then
        Assert.AreEqual(SalesHeader."Sell-to Customer No.", SalesHeader."Bill-to Customer No.", 'Bill-to is different than Sell-to');
    end;

    [Test]
    // Scenario: Create a sales invoice and verify that the bill-to customer is the same as the sell-to customer by default.
    procedure CreateSalesInvoice()
    var
        Customer: Record Customer;
        Customer2: Record Customer;
        SalesHeader: Record "Sales Header";
        LibrarySales: Codeunit "Library - Sales";
        SalesAdditionalFunctions: Codeunit "Sales Additional Functions";
        Assert: Codeunit Assert;
    begin
        // given
        LibrarySales.CreateCustomer(Customer);
        LibrarySales.CreateCustomer(Customer2);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Invoice, Customer."No.");

        // when
        SalesAdditionalFunctions.ChangeBillTo(SalesHeader, Customer."No.");

        // then
        Assert.AreEqual(SalesHeader."Sell-to Customer No.", SalesHeader."Bill-to Customer No.", 'Bill-to is different than Sell-to');
    end;
}