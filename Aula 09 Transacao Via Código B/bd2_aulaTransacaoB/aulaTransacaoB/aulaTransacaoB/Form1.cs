using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using aulaTransacaoB.Model;
using aulaTransacaoB.Controller;
using MySql.Data.MySqlClient;

namespace aulaTransacaoB
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
                    //exibir msm que conectou!
                    MessageBox.Show("Conectou!!!","Aplicação",MessageBoxButtons.OK,MessageBoxIcon.Information);
                    conexaoBD.desconectar();
                }
                else
                {
                    //exibir msm que não conectou!!
                    MessageBox.Show("Não conectou!!!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro no teste de conexão com o Banco de Dados:\n" + ex.ToString(), 
                    "Aplicação", 
                    MessageBoxButtons.OK, 
                    MessageBoxIcon.Information);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DadosConexao dadosConexao = new DadosConexao("localhost", "root", "123456", "escola", 3306);
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
                            //comboBox1.Items.Add(dr["nome"].ToString().ToUpper() + "                                                                                       " +
                            //                    int.Parse(dr["id_pessoa"].ToString()).ToString("D6")
                            //    );
                            ComboboxItem item = new ComboboxItem();
                            item.Text = dr["nome"].ToString().ToUpper();
                            item.Value = dr["id_pessoa"].ToString();
                            comboBox1.Items.Add(item);
                        }
                    }
                    dr.Dispose();
                    dr.Close();
                    conexaoBD.desconectar();
                }
                else
                {
                    //exibir msm que não conectou!!
                    MessageBox.Show("Não conectou!!!", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao buscar pessoas no Banco de Dados:\n" + ex.ToString(),
                    "Aplicação",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex >= 0)
            {
                ComboboxItem item = (comboBox1.SelectedItem as ComboboxItem);
                //MessageBox.Show("Id_pessoa: " + item.Value.ToString(), "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                try
                {
                    //conectar no banco
                    DadosConexao dadosConexao = new DadosConexao("localhost", "root", "123456", "escola", 3306);
                    ConexaoBD conexaoBD = new ConexaoBD(dadosConexao);
                    if (conexaoBD.conectar())
                    {
                        //fazer a seleção dos dados 
                        string sql = "SELECT *, func_idade(dt_nascimento) idade FROM pessoa WHERE id_pessoa = " + 
                            item.Value.ToString();
                        MySqlCommand comando = new MySqlCommand(sql, conexaoBD.conexao);
                        MySqlDataReader dr = comando.ExecuteReader();
                        if (dr.HasRows)
                        {
                            //retornar msm para o usuário
                            while (dr.Read())
                            {
                                string resposta = "A pessoa " + item.Text + " tem " + 
                                    dr["idade"].ToString() + " de idade.";
                                MessageBox.Show(resposta, "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            }
                        }
                        dr.Dispose();
                        dr.Close();
                        conexaoBD.desconectar();
                    }                    
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Erro ao buscar idade de pessoa no Banco de Dados:\n" + ex.ToString(),
                    "Aplicação",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Information);
                }
            }
            else
            {
                MessageBox.Show("Nenhum registro selecionado.", "Aplicação", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
    }

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
