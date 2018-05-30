unit uglobal;
{
     Este módulo contém flags que parametrizam a interface gráfica com o script main-pst.sh

}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


var
  flag_proxy : boolean = false;          //flag de ativaçao/desativacao do proxy
  flag_root : boolean = false;           //flag de super usuário on /off
  flag_auth_proxy: boolean = false;    //flag de proxy autenticado
  flag_set_host: boolean = false;      //flag que avisa que o campo de host(proxy) foi preenchido
  flag_set_porta: boolean = false;     // flag que avisa que o campo de porta(proxy) foi preenchido
  flag_set_user_proxy : boolean = false; // flag que avisa que o campo de  usuário(proxy autenticado) foi preenchido
  flag_set_psw_proxy : boolean = false; // flag que avisa que o campo de senha(proxy autenticado) foi preenchido
  PST_HOME : string ; // campo que contém o caminho dos módulos PST ( a ser implementado em futuro próximo)




implementation

end.

