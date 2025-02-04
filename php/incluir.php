<?php
    // Inclui configurações de conexão com o banco de dados
    include("./config.php");
    
    // Estabelece conexão com o MySQL usando credenciais do config.php
    $con = mysqli_connect($host, $login, $senha, $bd);

    // Coleta dados do formulário POST
    $nome = $_POST["nome"];
    $idade = $_POST["idade"];
    $raca = $_POST["raca"];
    $localOrigem = $_POST["localOrigem"];
    $saldo = $_POST["saldo"];
    $xpJogador = $_POST["xpJogador"];
    $resistencia = $_POST["resistencia"];
    $furtividade = $_POST["furtividade"];
    $precisao = $_POST["precisao"];
    $magia = $_POST["magia"];
    $dano = $_POST["dano"];
    $idClasse = $_POST["idClasse"];

    // Verifica se é uma atualização de registro existente
    if (isset($_POST["idPersonagem"])) {
        $sql = "UPDATE Jogavel SET nome='$nome', idade=$idade, raca='$raca', localOrigem='$localOrigem', 
                saldo=$saldo, xpJogador=$xpJogador, resistencia=$resistencia, furtividade=$furtividade, 
                precisao=$precisao, magia=$magia, dano=$dano, idClasse=$idClasse 
                WHERE idPersonagem={$_POST["idPersonagem"]}";
    } else {
        // Verificação de nome duplicado para novos registros
        $check_sql = "SELECT COUNT(*) AS total FROM Jogavel WHERE nome='$nome'";
        $result = mysqli_query($con, $check_sql);
        $row = mysqli_fetch_assoc($result);
        
        // Se nome existir, exibe alerta e redireciona
        if ($row['total'] > 0) {
            echo "<script>alert('Erro: Nome já existe! Escolha outro nome.'); window.location.href='form_incluir.php';</script>";
            exit();
        }

        // Query de inserção
        $sql = "INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, 
                furtividade, precisao, magia, dano, idClasse) 
                VALUES ('$nome', $idade, '$raca', '$localOrigem', $saldo, $xpJogador, $resistencia, 
                $furtividade, $precisao, $magia, $dano, $idClasse)";
    }

    // Executa query principal
    mysqli_query($con, $sql);
    
    // Fecha conexão e redireciona
    mysqli_close($con);
    header("location: ./index.php");
    
    // Garante término da execução após redirecionamento
    exit;
?>
