<?php
    // Define cabeçalho com codificação UTF-8 para caracteres especiais
    header("Content-Type: text/html; charset=utf-8", true);
?>
<html>
<head>
    <title>Personagens Jogáveis</title>
</head>
<body>
  <center>
    <h3>Lista de Personagens Jogáveis</h3>
  </center>
  <!-- Formulário principal com botão de inclusão -->
  <form name="form1" method="POST" action="form_incluir.php">
    <table border="1" align="center" width="100%">
      <!-- Cabeçalho da tabela -->
      <tr bgcolor="grey">
        <td>Nome</td>
        <td>Idade</td>
        <td>Raça</td>
        <td>Local de Origem</td>
        <td>Saldo</td>
        <td>XP</td>
        <td>Resistência</td>
        <td>Furtividade</td>
        <td>Precisão</td>
        <td>Magia</td>
        <td>Dano</td>
        <td>Classe</td>
        <td>Ações</td>
      </tr>
      <?php
      // Conexão com banco de dados
      include("./config.php");
      $con = mysqli_connect($host, $login, $senha, $bd);
      
      // Query que combina dados do personagem com sua classe
      $sql = "SELECT Jogavel.*, Classe.tipoClasse FROM Jogavel 
              JOIN Classe ON Jogavel.idClasse = Classe.idClasse 
              ORDER BY nome";
              
      $tabela = mysqli_query($con, $sql);
      
      // Verifica se há registros retornados
      if (mysqli_num_rows($tabela) == 0) {
      ?>
        <!-- Mensagem para lista vazia -->
        <tr>
          <td colspan="13" align="center">Nenhum personagem cadastrado.</td>
        </tr>
      <?php
      } else {
        // Loop através de cada registro do banco
        while ($dados = mysqli_fetch_assoc($tabela)) {
      ?>
          <!-- Linha da tabela para cada personagem -->
          <tr>
            <!-- Exibição dos dados -->
            <td><?php echo $dados['nome']; ?></td>
            <td><?php echo $dados['idade']; ?></td>
            <td><?php echo $dados['raca']; ?></td>
            <td><?php echo $dados['localOrigem']; ?></td>
            <td><?php echo $dados['saldo']; ?></td>
            <td><?php echo $dados['xpJogador']; ?></td>
            <td><?php echo $dados['resistencia']; ?></td>
            <td><?php echo $dados['furtividade']; ?></td>
            <td><?php echo $dados['precisao']; ?></td>
            <td><?php echo $dados['magia']; ?></td>
            <td><?php echo $dados['dano']; ?></td>
            <td><?php echo $dados['tipoClasse']; ?></td>
            <td>
              <input type="button" value="Excluir" 
                onclick="location.href='excluir.php?idPersonagem=<?php echo $dados['idPersonagem']; ?>'">
              <input type="button" value="Editar" 
                onclick="location.href='form_incluir.php?idPersonagem=<?php echo $dados['idPersonagem']; ?>'">
            </td>
          </tr>
      <?php
        }
      }
      mysqli_close($con);
      ?>
      <!-- Botão para inclusão de novo personagem -->
      <tr>
        <td colspan="13" align="center">
          <input type="submit" value="Incluir Novo Personagem">
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
