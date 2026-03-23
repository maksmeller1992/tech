codeunit 50403 "Isolated Storage - OnPremOnly"
{

    procedure Set(Secret: Record Secret; Value: Text)
    var
        IsolatedStorageRecord: Record "Isolated Storage";
        ModuleInfo: ModuleInfo;
        OutStreamValue: OutStream;
    begin
        NavApp.GetCurrentModuleInfo(ModuleInfo);
        IsolatedStorageRecord.Init();
        IsolatedStorageRecord."App Id" := ModuleInfo.Id;
        IsolatedStorageRecord.Scope := DataScopeToOption(Secret."Data Scope");
        IsolatedStorageRecord."Company Name" := CopyStr(CompanyName(), 1, 30);
        IsolatedStorageRecord."User Id" := UserSecurityId();
        IsolatedStorageRecord."Key" := Secret."Secret ID";
        IsolatedStorageRecord.Value.CreateOutStream(OutStreamValue);
        OutStreamValue.WriteText(Value);
        IsolatedStorageRecord.Insert(true);
    end;

    procedure Get(SecretID: Guid; Scope: DataScope) ValueText: Text
    var
        IsolatedStorageRecord: Record "Isolated Storage";
        ModuleInfo: ModuleInfo;
        ValueInStream: InStream;
    begin
        NavApp.GetCurrentModuleInfo(ModuleInfo);
        if IsolatedStorageRecord.Get(ModuleInfo.Id,
                                            Scope,
                                            CompanyName(),
                                            UserSecurityId(),
                                            SecretID) then begin
            IsolatedStorageRecord."Target Value Type" := IsolatedStorageRecord."Target Value Type"::SecretText;
            IsolatedStorageRecord.CalcFields(Value);
            IsolatedStorageRecord.Value.CreateInStream(ValueInStream);
            ValueInStream.ReadText(ValueText);
        end;
    end;

    procedure DataScopeToOption(DataScope: Enum "Data Scope"): Integer
    var
        IsolatedStorage: Record "Isolated Storage";
    begin
        case DataScope of
            DataScope::Company:
                exit(IsolatedStorage.Scope::Company);
            DataScope::"CompanyAndUser":
                exit(IsolatedStorage.Scope::CompanyAndUser);
            DataScope::Module:
                exit(IsolatedStorage.Scope::Module);
            DataScope::User:
                exit(IsolatedStorage.Scope::User);
        end;
    end;
}
