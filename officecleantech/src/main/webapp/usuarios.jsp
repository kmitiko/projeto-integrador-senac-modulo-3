<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="br.com.officecleantech.controller.UsuarioController"%>
<%@ page import="br.com.officecleantech.model.entidade.Usuario"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,300;0,400;0,500;0,600;0,700;1,600&display=swap"
	rel="stylesheet">
<title>Dashboard - OCT</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- CSS only -->
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<link rel="stylesheet" href="./css/style.css">
<!-- Scrollbar Custom CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
</head>
<meta charset="UTF-8">
<body>

	<!-- tratamento login -->
	<%
	if (session.getAttribute("usuarioLogado") == null) {
		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);
	}
	Usuario u = (Usuario) session.getAttribute("usuarioLogado");
	%>
	<!-- fim tratamento login-->

	<!-- tratamento busca -->
	<%
	String nomeBusca = request.getParameter("busca");

	if (nomeBusca == null) {
		nomeBusca = "";
	}
	/* System.out.println(nomeBusca); */
	%>
	<!-- fim tratamento busca -->

	<div class="wrapper">
		<!-- Sidebar  -->
		<nav id="sidebar">
			<div class="sidebar-header">
				<a href="#"> <img src="./img/oct.png"
					alt="Logo Office Clean Tech" style="height: 60px;">
				</a>
			</div>

			<ul class="list-unstyled components">
				<li class="active">
					<div class="icons-menu">
						<i class="fa-solid fa-house"></i> <a href="#homeSubmenu"
							data-toggle="collapse" aria-expanded="false">Dashboard</a>
					</div>

				</li>
				<li>
					<div class="icons-menu">
						<i class="fa-solid fa-box-archive"></i> <a href="produtos.jsp">Produtos</a>
					</div>
				</li>
				<li><a href="#pageSubmenu" data-toggle="collapse"
					aria-expanded="false" class="dropdown-toggle ">Relatórios</a>

					<ul class="collapse list-unstyled" id="pageSubmenu">
						<li>
							<div class="icons-menu">
								<i class="fa-solid fa-arrow-up"></i> <a href="#">Entrada</a>

							</div>
						</li>
						<li>
							<div class="icons-menu">
								<i class="fa-solid fa-arrow-down"></i> <a href="#">Saída</a>

							</div>
						</li>
					</ul></li>
				<li>
					<div class="icons-menu">

						<i class="fa-solid fa-users"></i> <a href="#">Fornecedores</a>
					</div>
				</li>
				<li>
					<div class="icons-menu">
						<i class="fa-solid fa-user-plus"></i> <a href="usuarios.jsp">Usuários</a>
					</div>
				</li>
				<li id="li-logoff">
					<div class="icons-menu logoff">
						<i class="fa-solid fa-power-off"></i> <a href="LogoffServlet">Sair</a>
					</div>
				</li>
			</ul>

		</nav>
		<!-- Fim Sidebar  -->
		<main id="content">
			<!-- Menu -->
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">

					<button type="button" id="sidebarCollapse" class="btn text-white"
						style="background-color: #77B800;">
						<i class="fas fa-align-left"></i> <span>Menu</span>
					</button>

				</div>
			</nav>
			<!-- Fim Menu -->

			<!-- Large modal -->
			<header
				class="d-flex align-items-center gap-4 justify-content-between"
				id="header__btn">
				<button type="button" class="btn text-white" data-toggle="modal"
					data-target="#exampleModal" data-whatever="@mdo"
					style="background-color: #2678D1;" id="btnProduto">Cadastrar
					Usuários</button>
				<div class="search-container">
					<form action="usuarios.jsp" method="post">
						<input type="text" placeholder="Buscar Usuários" name="busca"
							<%=nomeBusca%>>
						<button type="submit">
							<i class="fa fa-search"></i>
						</button>
					</form>
				</div>
			</header>
			<!-- Modal de Cadastro -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-md"
					role="document">
					<div class="modal-content">
						<div class="modal-header" style="border: 0;">
							<h5 class="modal-title" id="exampleModalLabel"></h5>
							<button type="button" class="close text-white"
								data-dismiss="modal" aria-label="Close"
								style="background-color: red; border: none; border-radius: 8px; padding: 5px 10px;">
								<span aria-hidden="true" class="">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form class="" method="post" action="CadastrarUsuarioServlet">
								<div
									class="form-group d-flex gap-3 mb-2 flex-column  columnInput">
									<input type="text" class="form-control shadow-none"
										id="recipient-name" placeholder="Nome do Usuário" name="name"
										required> <input type="email"
										class="form-control shadow-none" id="recipient-name"
										placeholder="email@dominio.com" name="login" required>
								</div>

								<div
									class="form-group d-flex gap-3 mb-2 flex-column  columnInput">
									<input type="password" class="form-control shadow-none"
										id="recipient-name" placeholder="senha" name="password"
										required> <input type="text"
										class="form-control shadow-none" id="recipient-name"
										placeholder="Nível de Acesso" name="accessLevel">
								</div>

								<div class="modal-footer">
									<button type="submit" class="btn text-white w-100"
										style="background-color: #2678D1; letter-spacing: 7px; padding: 12px 0; font-weight: 600;">CADASTRAR</button>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>
			<!-- Fim Modal de Cadastro -->

			<div
				class="table-responsive table-wrapper-scroll-y my-custom-scrollbar"
				style="margin-top: 40px; border-radius: 8px; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);">
				<table class="table">
					<thead
						style="box-shadow: 0px 4px 4px rgb(0 0 0/ 5%); border-radius: 8px;">
						<tr>
							<th scope="Id">Id</th>
							<th scope="Nome">Nome</th>
							<th scope="Telefone">Login</th>
							<th scope="Email">Senha</th>
							<th scope="Estado">Nível de Acesso</th>
							<th scope="Estado">Ações</th>

						</tr>
					</thead>
					<tbody>

						<%
						UsuarioController controller = new UsuarioController();

						ArrayList<Usuario> usuarios = controller.listarUsuario(nomeBusca);

						for (Usuario user : usuarios) {
						%>

						<tr>
							<!-- <th scope="row">Lorem</th> -->

							<td><%=user.getId()%></td>
							<td><%=user.getNome()%></td>
							<td><%=user.getLogin()%></td>
							<td><%=user.getSenha()%></td>
							<td><%=user.getNivelAcesso()%></td>


							<td>
								<!-- Botão de Update -->
								<div class="d-flex gap-2">
									<div class="text-primary" data-toggle="modal"
										data-target="#exampleModal2">
										<a
											href="InicioAlterarUsuarioServlet?redirecionador=<%=user.getId()%>">
											<i class="fa-solid fa-pen-to-square"></i>
										</a>

									</div>
									<div class="text-danger">

										<a href="ExcluirUsuarioServlet?get=<%=user.getId()%>"
											onclick="if(!confirm('Deseja excluir esse registro?')) {return false}"><i
											class="fa-solid fa-xmark"></i></a>
									</div>
								</div>
							</td>

						</tr>

						<%
						}
						%>
					</tbody>
				</table>
			</div>

		</main>

		<!-- jQuery CDN - Slim version (=without AJAX) -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
			crossorigin="anonymous"></script>
		<!-- Popper.JS -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
			integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
			crossorigin="anonymous"></script>
		<!-- Bootstrap JS -->
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
			integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
			crossorigin="anonymous"></script>
		<!-- jQuery Custom Scroller CDN -->
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>

		<script type="text/javascript">
			$(document).ready(function() {
				$("#sidebar").mCustomScrollbar({
					theme : "minimal"
				});

				$('#sidebarCollapse').on('click', function() {
					$('#sidebar, #content').toggleClass('active');
					$('.collapse.in').toggleClass('in');
					$('a[aria-expanded=true]').attr('aria-expanded', 'false');
				});
			});
		</script>
</body>

</html>