<?php
    include("./config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);
    $sql = "DELETE FROM Jogavel WHERE idPersonagem=".$_GET["idPersonagem"];
    mysqli_query($con, $sql);
    mysqli_close($con);
    header("location: ./index.php");
?>