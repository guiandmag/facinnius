package br.com.alvaro.servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.alvaro.facade.PacienteFacade;


@WebServlet("/TesteServlet")
public class TesteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private PacienteFacade pacienteFacade;

	public TesteServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().println("Paciente Teste"+pacienteFacade.find().getNome());

	}

}
