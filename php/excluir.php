<?php
    // Inclui arquivo com configurações de conexão do banco de dados
    include("./config.php");
    
    // Estabelece conexão com o banco de dados usando as credenciais do config.php
    $con = mysqli_connect($host, $login, $senha, $bd);
    
    // Monta query para excluir personagem com base no ID recebido via GET
    $sql = "DELETE FROM Jogavel WHERE idPersonagem=".$_GET["idPersonagem"];
    
    // Executa a query no banco de dados
    mysqli_query($con, $sql);
    
    // Fecha a conexão com o banco de dados
    mysqli_close($con);
    
    // Redireciona de volta para a página principal
    // header() deve ser chamado antes de qualquer output HTML
    header("location: ./index.php");
    
    // Encerra a execução do script imediatamente após o redirecionamento
    exit;
?>
