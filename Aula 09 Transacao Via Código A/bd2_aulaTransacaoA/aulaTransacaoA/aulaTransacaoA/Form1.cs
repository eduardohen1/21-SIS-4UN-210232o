using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using aulaTransacaoA.Model;
using aulaTransacaoA.Controller;
using MySql.Data.MySqlClient;

namespace aulaTransacaoA
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DadosConexao dadosConexao = new DadosConexao("localhost",
                "root",
                "123456",
                "escola",
                3306
                );
            ConexaoBD conexaoBD = new ConexaoBD(dadosConexao);
            try
            {
                if (conexaoBD.conectar())
                {
                    MessageBox.Show("Conectou!!!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    conexaoBD.desconectar();
                }
                else
                {
                    MessageBox.Show("Não conectou!!!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro na conexão com o banco de dados: " + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            DadosConexao dadosConexao = new DadosConexao("localhost","root", "123456", "escola", 3306 );
            ConexaoBD conexaoBD = new ConexaoBD(dadosConexao);
            comboBox1.Items.Clear();
            try
            {
                if (conexaoBD.conectar())
                {
                    string sql = "SELECT * FROM pessoa ORDER BY nome LIMIT 100";
                    MySqlCommand comando = new MySqlCommand(sql, conexaoBD.conexao);
                    MySqlDataReader dr = comando.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            //comboBox1.Items.Add(dr["nome"].ToString().ToUpper() + "                                                         " + 
                            //                    int.Parse(dr["id_pessoa"].ToString()).ToString("D6"));
                            ComboboxItem item = new ComboboxItem();
                            item.Text = dr["nome"].ToString().ToUpper();
                            item.Value = dr["id_pessoa"].ToString();
                            comboBox1.Items.Add(item);
                        }
                        MessageBox.Show("Pesquisa concluída!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    }
                    dr.Dispose();
                    dr.Close();
                    conexaoBD.desconectar();
                }
                else
                {
                    MessageBox.Show("Não conectou!!!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao buscar pessoas no banco de dados: " + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex >= 0)
            {
                ComboboxItem item = (comboBox1.SelectedItem as ComboboxItem);
                //MessageBox.Show("Id_pessoa: " + item.Value.ToString(),"Aplicação",MessageBoxButtons.OK, MessageBoxIcon.Information);
                try
                {
                    DadosConexao dadosConexao = new DadosConexao("localhost", "root", "123456", "escola", 3306);
                    ConexaoBD conexaoBD = new ConexaoBD(dadosConexao);
                    if (conexaoBD.conectar())
                    {
                        string sql = "select *, func_idade(dt_nascimento) idade from pessoa where id_pessoa = " + item.Value.ToString();
                        MySqlCommand comando = new MySqlCommand(sql, conexaoBD.conexao);
                        MySqlDataReader dr = comando.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                string resposta = "A pessoa " + item.Text + " tem " + dr["idade"].ToString() + " anos de idade.";
                                MessageBox.Show(resposta, "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Hand);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Erro ao buscar idade de pessoas no banco de dados: " + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                }
            }
            else
            {
                MessageBox.Show("Nenhum registro selecionado.", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            MySqlTransaction transacao = null;
            bool iniTransacao = false;
            DadosConexao dadosConexao = new DadosConexao("localhost", "root", "123456", "escola", 3306);
            ConexaoBD conexaoBD = new ConexaoBD(dadosConexao);
            if (comboBox1.SelectedIndex >= 0)
            {
                try
                {
                    ComboboxItem item = (comboBox1.SelectedItem as ComboboxItem);
                    if (conexaoBD.conectar())
                    {
                        transacao = conexaoBD.conexao.BeginTransaction(IsolationLevel.RepeatableRead);
                        iniTransacao = true;
                        //testar se a pessoa já é aluno
                        string sql = "SELECT COUNT(*) qte FROM aluno WHERE id_pessoa = " + item.Value.ToString();
                        MySqlCommand comando = new MySqlCommand(sql, conexaoBD.conexao);
                        MySqlDataReader dr = comando.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                int qte = int.Parse(dr["qte"].ToString());
                                if (qte > 0)
                                {
                                    MessageBox.Show("Esta pessoa já é aluno. Verifique!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                                    iniTransacao = false;
                                }
                            }
                        }
                        dr.Dispose();
                        dr.Close();

                        //criar mensagem para testar transação:
                        sql = "INSERT INTO mensagens(id_aluno, dt_mensagem, mensagem) VALUES(1, now(), 'OI!');";
                        comando = new MySqlCommand(sql, conexaoBD.conexao);
                        comando.ExecuteNonQuery();

                        //caso não for, inserir:
                        if (iniTransacao)
                        {
                            sql = "INSERT INTO aluno(dt_cadastro, id_pessoa) VALUES(now(), " + item.Value.ToString() + ")";
                            comando = new MySqlCommand(sql, conexaoBD.conexao);
                            comando.ExecuteNonQuery();
                            transacao.Commit();
                            MessageBox.Show("Pessoa " + item.Text.ToString() + " inserida como aluno.", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                        else
                        {
                            transacao.Rollback();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Erro ao inserir novo aluno!\n" + ex.ToString(),
                                    "Aplicação",
                                    MessageBoxButtons.OK,
                                    MessageBoxIcon.Error);
                    if (iniTransacao)
                    {
                        transacao.Rollback();
                    }
                }
                finally
                {
                    conexaoBD.desconectar();
                }
            }
            else
            {
                MessageBox.Show("Nenhum registro selecionado.", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
    }

    //criar objeto comboboxItem
    public class ComboboxItem
    {
        public string Text { get; set; }
        public object Value { get; set; }
        public override string ToString()
        {
            return Text;
        }

    }

}
