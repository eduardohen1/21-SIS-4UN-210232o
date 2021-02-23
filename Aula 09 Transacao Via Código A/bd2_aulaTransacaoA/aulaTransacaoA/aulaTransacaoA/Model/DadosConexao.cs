using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace aulaTransacaoA.Model
{
    public class DadosConexao
    {
        public string host { get; set; }
        public string user { get; set; }
        public string password { get; set; }
        public string dataBase { get; set; }
        public int port { get; set; }

        //método construtor:
        public DadosConexao(string host, string user, string password, string dataBase, int port)
        {
            this.host = host;
            this.user = user;
            this.password = password;
            this.dataBase = dataBase;
            this.port = port;
        }

    }
}
