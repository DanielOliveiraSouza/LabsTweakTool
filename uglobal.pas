unit uglobal;
{
     Este módulo contém flags que parametrizam a interface gráfica com o script main-pst.sh

}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


var
  flag_proxy : boolean = false;                //flag de ativaçao/desativacao do proxy
  flag_root : boolean = false;                  //flag de super usuário on /off
  flag_auth_proxy: boolean = false;
  //flag de proxy autenticado
 { flag_set_host: boolean = false;               //flag que avisa que o campo de host(proxy) foi preenchido
  flag_set_porta: boolean = false;              //flag que avisa que o campo de porta(proxy) foi preenchido
  flag_set_user_proxy : boolean = false;       // flag que avisa que o campo de  usuário(proxy autenticado) foi preenchido
  flag_set_psw_proxy : boolean = false;        // flag que avisa que o campo de senha(proxy autenticado) foi preenchido
  }
  PST_HOME : string = '/home/danny/scripts/pst/ver-2.0-rc10';                   // campo que contém o caminho dos módulos PST ( a ser implementado em futuro próximo)
//  uglobal.PST_HOME + '/main-pst.sh' : string  = '';
  BRIDGE_ROOT: string = '/home/danny/scripts/pst/ver-2.0-rc10/bridge-root.sh';
  VERSION : string ='PST 2.0-rc10-r05-01-2018' + sLineBreak + 'PST Tweak Tools by DanielTimelord'+ sLineBreak +  sLineBreak+'(c) 2014-2018' + sLineBreak + 'PST é um conjunto de ferramentas que  automatizam tarefas em laboratorios';
  flag_proxy_form_valid : boolean  = false;
  erro_proxy_form : integer = -1;
  { convenção erro_proxy_form
//  -2 Vários
  -1 VAZIO
  0  SEM ERROS
  1  HOST
  2  PORTA
  3  USUARIO
  4  SENHA
  }


  //erros do script
  ERROR_PPA_NOT_SUPPORTED : integer = 252;
  ERROR_DIST_NOT_SUPPORTED : integer = 253;
  PST_STR_INIT_LOG : string = 'Running PST main module, erros = 0';
  PST_LOG_FILE : string = '/tmp/pst.log';





implementation


end.

