{
Delphi7直接连接MySQL示例
===
开源软件，您可以任意使用此代码，无任何限制
===
- 此代码引用了UniDac for Delphi
- 此代码使用Delphi7在Win7 32/64及WinXP 32编译通过

Author:Sunway China
Date:2014-03-10
QQ:10426013  
}

unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Uni, UniProvider, MySQLUniProvider,
  StdCtrls, Buttons;

type
  TfrmMain = class(TForm)
    MySQLUniProvider1: TMySQLUniProvider;
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    txtAddress: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtPort: TEdit;
    Label3: TLabel;
    txtDatabaseName: TEdit;
    Label4: TLabel;
    txtUsername: TEdit;
    Label5: TLabel;
    txtPassword: TEdit;
    Label6: TLabel;
    btnConnect: TBitBtn;
    Label7: TLabel;
    txtSQL: TEdit;
    procedure btnConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  //
  self.UniConnection1.ProviderName:='MySQL';
  self.UniConnection1.SpecificOptions.Clear;
  self.UniConnection1.SpecificOptions.Values['Direct']:='True';
  self.UniConnection1.Server:=self.txtAddress.Text;
  self.UniConnection1.Port:=strtoint(self.txtPort.Text);
  self.UniConnection1.Username:=self.txtUsername.Text;
  self.UniConnection1.Password:=self.txtPassword.Text;
  self.UniConnection1.Database:=self.txtDatabaseName.Text;
  
  try
    self.UniConnection1.Connect;
  except
    on e:exception do
    begin
      showmessage(format('连接失败: %s',[e.Message]));
      exit;
    end;
  end;

  self.UniQuery1.Connection:=self.UniConnection1;
  self.UniQuery1.SQL.Clear;
  self.UniQuery1.SQL.Text:=self.txtSQL.Text;

  try
    self.UniQuery1.Open;
  except
    on e:exception do
    begin
      self.UniConnection1.Disconnect;
      showmessage(format('执行SQL语句失败: %s',[e.Message]));
      exit;
    end;
  end;

  if not self.UniQuery1.Eof then
  begin
    showmessage(format('连接成功,返回的部分结果: %s %s',[#13#10#13#10,self.UniQuery1.Fields[0].AsString]));
  end;


  self.UniQuery1.Close;
  self.UniConnection1.Disconnect;
  
end;

end.
