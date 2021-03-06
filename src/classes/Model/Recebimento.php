<?php

namespace Sourcess\Model;

use \Sourcess\DB\Sql;
use \Sourcess\Model\Model;
use \DateTime;

class Recebimento extends Model {

    public static function listAll($mes, $ano)
    {
        $sql = new Sql();
        $query = "SELECT c.nomeCliente AS cliente, c.id AS idcliente, p.numero AS codigo, p.id AS idprotocolo, s.titulo AS servico, r.* FROM tb_recebimentos AS r LEFT JOIN tb_protocolos AS p ON r.idprotocolo = p.id LEFT JOIN tb_clientes AS c ON p.idcliente = c.id LEFT JOIN tb_servicos AS s ON p.idservico = s.id WHERE r.mes = :mesAtual AND r.ano = :anoAtual ORDER BY r.dataRecebimento DESC";
        return $sql->select($query, array(
            ":mesAtual" => $mes,
            ":anoAtual" => $ano
        ));
    }

    public function save()
    {
        $sql = new Sql();
            $sql = new Sql();
            $qtdParcelas = explode('/', $this->getparcelas())[1];
            $mediaValor = $this->getvalorBoleto() / $qtdParcelas;
            $vencimento = new DateTime($this->getdataVencimento());
            for ($i = 0; $i < $qtdParcelas; $i++) {
                if ($i > 0)
                {
                    $vencimento->modify("+1 month");
                    $dataVencimento = $vencimento->format('Y-m-d');
                } else {
                    $dataVencimento = $vencimento->format('Y-m-d');
                }
                $results = $sql->select("CALL sp_recebimentos_save(:dataRecebimento, :idprotocolo, :valorBoleto, :dataVencimento, :dataCompensacao, :nBoleto, :formaPagamento, :parcelas, :referencia, :formaEnvio, :enviadoPor, :mes, :ano, :alteradoPor, :alteradoEm)", array(
                    ":dataRecebimento" => $this->getdataRecebimento(),
                    ":idprotocolo" => $this->getprotocolo(),
                    ":valorBoleto" => $mediaValor,
                    ":dataVencimento" => $dataVencimento,
                    ":dataCompensacao" => $this->getdataCompensacao(),
                    ":nBoleto" => $this->getnBoleto(),
                    ":formaPagamento" => $this->getformaPagamento(),
                    ":parcelas" => $i + 1 . '/' . $qtdParcelas,
                    ":referencia" => $this->getreferencia(),
                    ":formaEnvio" => $this->getformaEnvio(),
                    ":enviadoPor" => $this->getenviadoPor(),
                    ":mes" => $vencimento->format('m'),
                    ":ano" => $vencimento->format('Y'),
                    ":alteradoPor" => $_SESSION["User"]["nome"],
                    ":alteradoEm" => date('Y-m-d H:i')
                ));
                $this->setData($results[0]);
            }
            $query = "SELECT p.numero AS codigo, c.nomeCliente AS cliente, c.email AS email, s.titulo AS servico FROM tb_recebimentos AS r JOIN tb_protocolos AS p ON r.idprotocolo = p.id JOIN tb_servicos AS s ON p.idservico = s.id JOIN tb_clientes AS c ON p.idcliente = c.id WHERE p.id = :id";
            $results = $sql->select($query, array(
                ":id" => $this->getprotocolo()
            ));
            if ($results != '' && $results != null && $results[0]['email'] != '') {
                $data = array(
                    "name" => $results[0]['cliente'],
                    "protocol" => $results[0]['codigo'],
                    "service" => $results[0]['servico'],
                    "to" => $results[0]['email']
                );
            $mail = new Mail(500, $data);
        }
    }

    public function get($id)
    {
        $sql = new Sql();
        $query = "SELECT r.*, p.numero AS codigo, c.nomeCliente AS cliente, c.email AS email, c.id AS idcliente, p.id AS idprotocolo, p.numero AS codigo, s.titulo AS servico FROM tb_recebimentos AS r LEFT JOIN tb_protocolos AS p ON r.idprotocolo = p.id LEFT JOIN tb_servicos AS s ON p.idservico = s.id LEFT JOIN tb_clientes AS c ON p.idcliente = c.id WHERE r.id = :id";
        $results = $sql->select($query,
        array(
            ":id" => $id
        ));
        $this->setData($results[0]);
    }

    public function getByClient($id)
    {
        $sql = new Sql();
        $query = "SELECT r.*, p.numero AS codigo, p.id AS idprotocolo, s.titulo AS servico FROM tb_recebimentos AS r JOIN tb_protocolos AS p ON r.idprotocolo = p.id JOIN tb_clientes AS c ON p.idcliente = c.id JOIN tb_servicos AS s ON p.idservico = s.id WHERE c.id = :id ORDER BY r.dataRecebimento DESC";
        return $sql->select($query, array(
            ":id" => $id
        ));
    }

    public function update()
    {
        $sql = new Sql();
        $results = $sql->select("CALL sp_recebimentos_update(:id, :dataCompensacao)", array(
            ":id" => $this->getid(),
            ":dataCompensacao" => $this->getdataCompensacao()
        ));
    }

    public function delete($pnum)
    {
        $sql = new Sql();
        $sql->select("CALL sp_recebimentos_delete(:pnum)", array(
            ":pnum" => $pnum
        ));
    }

}

?>