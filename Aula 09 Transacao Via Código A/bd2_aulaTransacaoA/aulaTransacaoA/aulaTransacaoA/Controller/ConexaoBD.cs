using aulaTransacaoA.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace aulaTransacaoA.Controller
{
    public class ConexaoBD
    {
        public MySqlConnection conexao = new MySqlConnection(); //variável de conexão com o BD
        DadosConexao dadosConexao = null; //variável de dados da conexão
        
        //Método construtor
        public ConexaoBD(DadosConexao dadosConexao)
        {
            this.dadosConexao = dadosConexao;
        }

        //Método Conectar no banco de dados
        //Método Desconectar do banco de dados


    }
}
