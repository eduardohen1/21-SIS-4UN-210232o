using aulaTransacaoA.Model;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

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
        public bool conectar()
        {
            //testar se o objeto dadosConexao é diferente de null
            if (dadosConexao != null)
            {
                try
                {
                    //testar se a variável conexão está ativa
                    if (conexao.State == System.Data.ConnectionState.Open) 
                        desconectar();

                    string sql = "Server=" + dadosConexao.host.Trim() + ";" +
                                 "Database=" + dadosConexao.dataBase.Trim() + ";" +
                                 "Uid=" + dadosConexao.user.Trim() + ";" +
                                 "Pwd=" + dadosConexao.password.Trim() + ";" +
                                 "Connection Timeout=900;" +
                                 "Port=" + dadosConexao.port.ToString();
                    conexao = new MySqlConnection(sql);
                    conexao.Open();
                    return true;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Erro ao conectar com o banco de dados: " + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                    return false;
                }
            }
            else
            {
                MessageBox.Show("Nenhum dados de conexão encontrado. Verifique!",
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                return false;
            }
        }

        //Método Desconectar do banco de dados


    }
}
