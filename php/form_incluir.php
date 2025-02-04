<?php
    header("Content-Type: text/html; charset=utf-8", true);
?>
<html>

<head>
    <title>Incluir/Editar Personagem</title>
</head>

<body>
    <form name="form1" method="POST" action="incluir.php">
        <?php
        if (isset($_GET["idPersonagem"])) {
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
            $sql = "SELECT * FROM Jogavel WHERE idPersonagem=" . $_GET['idPersonagem'];
            $result = mysqli_query($con, $sql);
            $vetor = mysqli_fetch_assoc($result);
            mysqli_close($con);
        ?>
            <input type="hidden" name="idPersonagem" value="<?php echo $_GET['idPersonagem']; ?>">
        <?php
        }
        ?>
        <table border="0" align="center" width="50%">
            <tr>
                <td>Nome:</td>
                <td><input type="text" name="nome" value="<?php echo @$vetor['nome']; ?>" required></td>
            </tr>
            <tr>
                <td>Idade:</td>
                <td><input type="number" name="idade" value="<?php echo @$vetor['idade']; ?>" required></td>
            </tr>
            <tr>
                <td>Raça:</td>
                <td><input type="text" name="raca" value="<?php echo @$vetor['raca']; ?>" required></td>
            </tr>
            <tr>
                <td>Local de Origem:</td>
                <td><input type="text" name="localOrigem" value="<?php echo @$vetor['localOrigem']; ?>" required></td>
            </tr>
            <tr>
                <td>Saldo:</td>
                <td><input type="number" step="0.01" name="saldo" value="<?php echo @$vetor['saldo']; ?>" required></td>
            </tr>
            <tr>
                <td>XP:</td>
                <td><input type="number" name="xpJogador" value="<?php echo @$vetor['xpJogador']; ?>" required></td>
            </tr>
            <tr>
                <td>Resistência:</td>
                <td><input type="number" name="resistencia" value="<?php echo @$vetor['resistencia']; ?>" required></td>
            </tr>
            <tr>
                <td>Furtividade:</td>
                <td><input type="number" name="furtividade" value="<?php echo @$vetor['furtividade']; ?>" required></td>
            </tr>
            <tr>
                <td>Precisão:</td>
                <td><input type="number" name="precisao" value="<?php echo @$vetor['precisao']; ?>" required></td>
            </tr>
            <tr>
                <td>Magia:</td>
                <td><input type="number" name="magia" value="<?php echo @$vetor['magia']; ?>" required></td>
            </tr>
            <tr>
                <td>Dano:</td>
                <td><input type="number" name="dano" value="<?php echo @$vetor['dano']; ?>" required></td>
            </tr>
            <tr>
                <td>Classe:</td>
                <td><select name="idClasse" required>
                        <?php
                        include("./config.php");
                        $con = mysqli_connect($host, $login, $senha, $bd);
                        $query = "SELECT idClasse, tipoClasse FROM Classe";
                        $result = mysqli_query($con, $query);
                        while ($row = mysqli_fetch_assoc($result)) {
                            echo "<option value='" . $row['idClasse'] . "'>" . $row['tipoClasse'] . "</option>";
                        }
                        mysqli_close($con);
                        ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="Cancelar" onclick="location.href='index.php'">
                    <input type="submit" value="Gravar">
                </td>
        </table>
    </form>
</body>

</html>