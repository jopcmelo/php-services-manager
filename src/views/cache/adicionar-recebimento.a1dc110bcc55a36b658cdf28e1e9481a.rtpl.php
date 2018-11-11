<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-header card-header-primary">
              <h4 class="card-title">Adicionar Recebimento</h4>
              <p class="card-category">Cadastre um recebimento para <?php echo getenv('APP_NAME'); ?></p>
            </div>
            <div class="card-body">
              <form action="/admin/adicionar/recebimento" method="POST">
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label>Cliente</label>
                      <select type="text" class="form-control" id="cliente" name="cliente">
                        <option>Selecione um cliente (Obrigatório)</option>
                        <?php $counter1=-1;  if( isset($clientes) && ( is_array($clientes) || $clientes instanceof Traversable ) && sizeof($clientes) ) foreach( $clientes as $key1 => $value1 ){ $counter1++; ?>
                        <option value="<?php echo htmlspecialchars( $value1["id"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["nomeCliente"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label>Protocolo</label>
                      <select type="text" class="form-control" id="protocolo" name="protocolo">
                        <option>Nenhum cliente foi selecionado</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-12">
                      <div class="form-group">
                        <label>Forma de Pagamento</label>
                        <select type="text" class="form-control" id="r-type" name="formaPagamento">
                          <option value="Boleto">Boleto</option>
                          <option value="Depósito">Depósito</option>
                          <option value="Cheque">Cheque</option>
                          <option value="Dinheiro">Dinheiro</option>
                          <option value="Transferência Bancária">Transferência Bancária</option>
                        </select>
                      </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-5">
                    <div class="form-group">
                      <label>Data de Abertura</label>
                      <input type="date" class="form-control" name="dataRecebimento" required>
                    </div>
                  </div>
                  <div class="col-md-3">
                    <div class="form-group">
                      <label class="bmd-label-floating">Valor (R$)</label>
                      <input type="text" class="form-control" name="valorBoleto" data-mask="000.000.000,00" data-mask-reverse="true" required>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="form-group">
                      <label>Data de Vencimento</label>
                      <input type="date" class="form-control" name="dataVencimento" required>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6 ticket-dependent-change">
                    <div class="form-group">
                      <label>Data de Compensação</label>
                      <input type="date" class="form-control" name="dataCompensacao">
                    </div>
                  </div>
                  <div class="col-md-6 ticket-dependent">
                    <div class="form-group">
                      <label class="bmd-label-floating">Número do Boleto</label>
                      <input type="text" class="form-control" name="nBoleto" maxlength="15">
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="bmd-label-floating">Parcelas</label>
                      <input type="text" class="form-control" name="parcelas" max="56" value="1/1" data-mask="0/0" maxlength="3" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label class="bmd-label-floating">Referência</label>
                      <input type="text" class="form-control" name="referencia" maxlength="112">
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group">
                      <label>Forma de Envio</label>
                      <select type="text" class="form-control" name="formaEnvio">
                        <option value="E-mail">E-mail</option>
                        <option value="WhatsApp">WhatsApp</option>
                        <option value="Recebido no local">Recebido no local</option>
                      </select>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <label>Enviado Por</label>
                      <select type="text" class="form-control" name="enviadoPor">
                        <?php $counter1=-1;  if( isset($usuarios) && ( is_array($usuarios) || $usuarios instanceof Traversable ) && sizeof($usuarios) ) foreach( $usuarios as $key1 => $value1 ){ $counter1++; ?>
                        <option value="<?php echo htmlspecialchars( $value1["nome"], ENT_COMPAT, 'UTF-8', FALSE ); ?>"><?php echo htmlspecialchars( $value1["nome"], ENT_COMPAT, 'UTF-8', FALSE ); ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>
                <button type="submit" class="btn btn-primary pull-right">Adicionar</button>
                <div class="clearfix"></div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>