package br.com.officecleantech.view;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import br.com.officecleantech.controller.FornecedorController;
import br.com.officecleantech.model.entidade.Endereco;
import br.com.officecleantech.model.entidade.Fornecedor;

/**
 * Servlet implementation class InicioAlterarFornecedor
 */

@SuppressWarnings("unused")
public class InicioAlterarFornecedor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InicioAlterarFornecedor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Endereco end = new Endereco();
		
		String id = request.getParameter("id");
		
		long Id = 0;
				
				try {
					Id = Long.parseLong(request.getParameter(id));
				} catch (Exception e) {
					System.out.println("Erro ao alterar Servlet");
					e.printStackTrace();
				}
				
				FornecedorController controller = new FornecedorController();
				Fornecedor f = controller.buscar(Id);
				
				request.setAttribute("Fornecedor", f);
				request.setAttribute("Endereco", end);
				RequestDispatcher rd = request.getRequestDispatcher("alterar_fornecedores.jsp");
				rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
