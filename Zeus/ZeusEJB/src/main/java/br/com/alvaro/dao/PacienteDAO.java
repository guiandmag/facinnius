package br.com.alvaro.dao;

import javax.ejb.Stateless;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

import br.com.alvaro.entity.Paciente;

@Stateless
public class PacienteDAO  extends GenericDAO<Paciente> {

	public PacienteDAO() {
		super(Paciente.class);
	}
	
	public Paciente findOneResultByIdPaciente(Long idPaciente) throws Exception {
		
		Criteria criteria = getSession().createCriteria(Paciente.class);
		
		criteria.add(Restrictions.eq("id", idPaciente));
		
		return (Paciente) criteria.uniqueResult();
	}
	
	public Paciente findOneResultByNome(String nome) throws Exception {
		
		Criteria criteria = getSession().createCriteria(Paciente.class);
		
		criteria.add(Restrictions.ilike("nome", nome));
		
		return (Paciente) criteria.uniqueResult();
	}

}
