
interface "Isolated Storage"
{
    procedure Set(var IsolatedKey: Guid; SecretText: SecretText; Scope: DataScope);
    procedure Get(IsolatedKey: Guid; Scope: DataScope): SecretText;
    procedure Delete(IsolatedKey: Guid; Scope: DataScope): Boolean;
}
