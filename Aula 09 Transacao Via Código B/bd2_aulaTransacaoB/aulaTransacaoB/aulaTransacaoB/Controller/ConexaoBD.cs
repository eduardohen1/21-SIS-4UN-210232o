using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using aulaTransacaoB.Model;
using System.Windows.Forms;

namespace aulaTransacaoB.Controller
{
    public class ConexaoBD
    {
        MySqlConnection conexao = new MySqlConnection(); //variável de conexão com o BD
        DadosConexao dadosConexao = null; //variável de dados da conexão

        //Método construtor:
        public ConexaoBD(DadosConexao dadosConexao)
        {
            this.dadosConexao = dadosConexao;
        }

        //Método Conectar - no banco de dados
        public bool conectar()
        {
            //testar se o objeto dadosConexao é diferente de null
            if (dadosConexao != null)
            {
                //tratamento de erro
                try
                {
                    //testar se a variável de conexão está aberta:
                    if (conexao.State == System.Data.ConnectionState.Open) 
                        desconectar();

                    //montar a minha string de conexão
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
                    MessageBox.Show("Erro ao conectar com o banco de dados:\n" + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                    return false;
                }
            }
            else
            {
                MessageBox.Show("Nenhum dado de conexão foi encontrado. Verifique!",
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                return false;
            }
        }
        //Método Desconectar - do banco de dados
        public bool desconectar()
        {
            try
            {
                //testar se a variável conexão está aberta:
                if (conexao.State == System.Data.ConnectionState.Open)
                    conexao.Close();
                return true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao desconectar com o banco de dados:\n" + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                return false;
            }
        }
    }
}
