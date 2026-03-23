
codeunit 50400 "Isolated Storage Impl." implements "Isolated Storage"
{
    [NonDebuggable]
    procedure Set(var IsolatedKey: Guid; SecretText: SecretText; Scope: DataScope)
    begin
        if IsNullGuid(IsolatedKey) then
            IsolatedKey := CreateGuid();

        if EncryptionEnabled() then
            IsolatedStorage.SetEncrypted(IsolatedKey, SecretText, Scope)
        else
            IsolatedStorage.Set(IsolatedKey, SecretText, Scope);
    end;

    [NonDebuggable]
    procedure Get(IsolatedKey: Guid; Scope: DataScope) SecretText: SecretText
    begin
        if IsolatedStorage.Contains(IsolatedKey, Scope) and not IsNullGuid(IsolatedKey) then
            IsolatedStorage.Get(IsolatedKey, Scope, SecretText);
    end;

    [NonDebuggable]
    procedure Delete(IsolatedKey: Guid; Scope: DataScope): Boolean
    begin
        if not IsolatedStorage.Contains(IsolatedKey, Scope) then
            exit;

        IsolatedStorage.Delete(IsolatedKey, Scope);
    end;
}
