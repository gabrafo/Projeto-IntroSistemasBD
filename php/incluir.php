<?php
include("./config.php");
$con = mysqli_connect($host, $login, $senha, $bd);

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

if(isset($_POST["idPersonagem"])) {
    $sql = "UPDATE Jogavel SET nome='$nome', idade=$idade, raca='$raca', localOrigem='$localOrigem', saldo=$saldo, xpJogador=$xpJogador, resistencia=$resistencia, furtividade=$furtividade, precisao=$precisao, magia=$magia, dano=$dano, idClasse=$idClasse WHERE idPersonagem={$_POST["idPersonagem"]}";
} else {
    // Verifica se o nome já existe
    $check_sql = "SELECT COUNT(*) AS total FROM Jogavel WHERE nome='$nome'";
    $result = mysqli_query($con, $check_sql);
    $row = mysqli_fetch_assoc($result);
    if ($row['total'] > 0) {
        echo "<script>alert('Erro: Nome já existe! Escolha outro nome.'); window.location.href='form_incluir.php';</script>";
        exit();
    }
    
    $sql = "INSERT INTO Jogavel (nome, idade, raca, localOrigem, saldo, xpJogador, resistencia, furtividade, precisao, magia, dano, idClasse) VALUES ('$nome', $idade, '$raca', '$localOrigem', $saldo, $xpJogador, $resistencia, $furtividade, $precisao, $magia, $dano, $idClasse)";
}

mysqli_query($con, $sql);
mysqli_close($con);
header("location: ./index.php");
?>