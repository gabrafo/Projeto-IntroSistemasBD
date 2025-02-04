    <title>Incluir/Editar Personagem</title>
</head>
<body>
    <!-- Formulário para cadastro/edição com envio POST para incluir.php -->
    <form name="form1" method="POST" action="incluir.php">
        <?php
        // Verifica se é uma edição (quando há ID na URL)
        if (isset($_GET["idPersonagem"])) {
            // Conexão e consulta para carregar dados existentes
            include("./config.php");
            $con = mysqli_connect($host, $login, $senha, $bd);
            
            // ATENÇÃO: Vulnerável a SQL Injection - usar prepared statements
            $sql = "SELECT * FROM Jogavel WHERE idPersonagem=" . $_GET['idPersonagem'];
            $result = mysqli_query($con, $sql);
            $vetor = mysqli_fetch_assoc($result); // Armazena dados do personagem
            mysqli_close($con);
        ?>
            <!-- Campo oculto para manter o ID durante a edição -->
            <input type="hidden" name="idPersonagem" value="<?php echo $_GET['idPersonagem']; ?>">
        <?php
        }
        ?>
        <table border="0" align="center" width="50%">
            <!-- Campos do formulário com valores pré-preenchidos (se for edição) -->
            <!-- @ suprime erros de variável não definida -->
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

           <!-- Seletor de Classe com opções carregadas do banco -->
            <tr>
                <td>Classe:</td>
                <td>
                    <select name="idClasse" required>
                        <?php
                        // Consulta todas as classes disponíveis
                        include("./config.php");
                        $con = mysqli_connect($host, $login, $senha, $bd);
                        $query = "SELECT idClasse, tipoClasse FROM Classe";
                        $result = mysqli_query($con, $query);
                        
                        // Preenche dinamicamente as opções do dropdown
                        while ($row = mysqli_fetch_assoc($result)) {
                            echo "<option value='" . $row['idClasse'] . "'>" 
                                . htmlspecialchars($row['tipoClasse']) // Prevenção XSS básica
                                . "</option>";
                        }
                        mysqli_close($con);
                        ?>
                    </select>
                </td>
            </tr>
            <!-- Botões de ação -->
            <tr>
                <td colspan="2" align="center">
                    <!-- Botão Cancelar volta para lista principal -->
                    <input type="button" value="Cancelar" onclick="location.href='index.php'">
                    <input type="submit" value="Gravar">
                </td>
            </tr>
        </table>
    </form>
</body>

</html>
