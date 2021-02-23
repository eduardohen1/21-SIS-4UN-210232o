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
    }
}
