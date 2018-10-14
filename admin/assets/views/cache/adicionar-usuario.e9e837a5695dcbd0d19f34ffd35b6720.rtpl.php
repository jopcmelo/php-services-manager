<?php if(!class_exists('Rain\Tpl')){exit;}?><div class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header card-header-primary">
            <h4 class="card-title">Adicionar Usuário</h4>
            <p class="card-category">Cadastre um usuário para a CVA Climatização</p>
          </div>
          <div class="card-body">
            <form action="/adicionar/usuario" method="POST">
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="bmd-label-floating">Nome do Usuário</label>
                    <input type="text" class="form-control" name="nome" maxlength="56" required>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="bmd-label-floating">Login do Usuário</label>
                    <input type="text" class="form-control" name="login" maxlength="56" required>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                    <label class="bmd-label-floating">Senha do Usuário</label>
                    <input type="password" class="form-control" name="senha" maxlength="32" required>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="form-check form-check-radio">
                    <label class="form-check-label">
                      <input class="form-check-input" type="radio" name="acesso" id="exampleRadios1" value="1">
                      Administrador
                      <span class="circle">
                        <span class="check"></span>
                      </span>
                    </label>
                  </div>
                  <div class="form-check form-check-radio">
                    <label class="form-check-label">
                      <input class="form-check-input" type="radio" name="acesso" id="exampleRadios2" value="0">
                      Somente leitura
                      <span class="circle">
                        <span class="check"></span>
                      </span>
                    </label>
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