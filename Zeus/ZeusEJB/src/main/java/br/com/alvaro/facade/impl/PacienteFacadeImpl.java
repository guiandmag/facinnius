package br.com.alvaro.facade.impl;

import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;

import br.com.alvaro.dao.PacienteDAO;
import br.com.alvaro.entity.Paciente;
import br.com.alvaro.facade.PacienteFacade;

@Stateless
@Local(PacienteFacade.class)
public class PacienteFacadeImpl implements PacienteFacade {
	
	@EJB
	private PacienteDAO pacienteDao;

	@Override
	public Paciente find() {
		
		try {
			return pacienteDao.findOneResultByIdPaciente(new Long(100));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	
	
	
}
