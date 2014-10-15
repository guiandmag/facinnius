package br.com.alvaro.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaQuery;

import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

public abstract class GenericDAO<T> {
	
	private final static String UNIT_NAME = "AOL";

	@PersistenceContext(unitName = UNIT_NAME)
	protected EntityManager em;

	private Class<T> entityClass;
	
	public GenericDAO(Class<T> entityClass) {
		this.entityClass = entityClass;
	}
	/*
	public void save(T entity) {
		em.persist(entity);
	}*/
	
	protected Session getSession() throws Exception {

	    if (em.getDelegate() instanceof org.hibernate.ejb.HibernateEntityManager) {
	    	return ((org.hibernate.ejb.HibernateEntityManager) em.getDelegate()).getSession();
	    }
	    else {
	       return (org.hibernate.Session) em.getDelegate();
	    }
	}
	
	public void save(T entity) throws Exception {
		getSession().saveOrUpdate(entity);
		getSession().flush();
	}
	
	
	public void delete(T entity) throws Exception {
		T entityToBeRemoved = em.merge(entity);
		
		em.remove(entityToBeRemoved);
	}

	public T update(T entity) throws Exception {
		getSession().merge(entity);
		getSession().flush();
		getSession().refresh(entity);
		return entity;
	}

	public T find(int entityID)  throws Exception {
		return em.find(entityClass, entityID);
	}
	
	public T find(long entityID) throws Exception {
		return em.find(entityClass, entityID);
	}
	
	public T find(String entityID) throws Exception {
		return em.find(entityClass, entityID);
	}

	// Using the unchecked because JPA does not have a
	// em.getCriteriaBuilder().createQuery()<T> method
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<T> findAll()  throws Exception {
		CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
		cq.select(cq.from(entityClass));
		return em.createQuery(cq).getResultList();
	}

	// Using the unchecked because JPA does not have a
	// ery.getSingleResult()<T> method
	@SuppressWarnings("unchecked")
	protected T findOneResult(String namedQuery, Map<String, Object> parameters)  throws Exception {
		T result = null;

		try {
			Query query = em.createNamedQuery(namedQuery);

			// Method that will populate parameters if they are passed not null and empty
			if (parameters != null && !parameters.isEmpty()) {
				populateQueryParameters(query, parameters);
			}

			result = (T) query.getSingleResult();
			
		} catch (NoResultException e) {
			System.out.println("Nenhum resultado encontrado. "+namedQuery);
		} catch (Exception e) {
			System.out.println("Error while running query: " + e.getMessage());
			e.printStackTrace();
		}

		return result;
	}
	
	@SuppressWarnings("unchecked")
	protected T findOneResultByQuery(String q, Map<String, Object> parameters)  throws Exception {
		T result = null;

		try {
			Query query = em.createQuery(q);

			// Method that will populate parameters if they are passed not null and empty
			if (parameters != null && !parameters.isEmpty()) {
				populateQueryParameters(query, parameters);
			}

			result = (T) query.getSingleResult();
			
			getSession().clear();
			
		} catch (NoResultException e) {
			System.out.println("Nenhum resultado encontrado.");
		} catch (Exception e) {
			System.out.println("Error while running query: " + e.getMessage());
			e.printStackTrace();
		}

		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	protected List<T> findListResultByQuery(String q, Map<String, Object> parameters)  throws Exception {
		List<T> result = null;

		try {
			Query query = em.createQuery(q);

			// Method that will populate parameters if they are passed not null and empty
			if (parameters != null && !parameters.isEmpty()) {
				populateQueryParameters(query, parameters);
			}

			result = query.getResultList();
			
			getSession().clear();
			
		} catch (NoResultException e) {
			System.out.println("Nenhum resultado encontrado.");
		} catch (Exception e) {
			System.out.println("Error while running query: " + e.getMessage());
			e.printStackTrace();
		}

		return result;
	}
	
	private void populateQueryParameters(Query query, Map<String, Object> parameters)  throws Exception {
		
		for (Entry<String, Object> entry : parameters.entrySet()) {
			query.setParameter(entry.getKey(), entry.getValue());
		}
	}
	


	@SuppressWarnings("unchecked")
	public T load(Long id)  throws Exception {
				
		return (T) getSession().load(entityClass, id);
		
	}
	
	protected Criterion createCriteriaUniqueDate(String propertyName, Date date)  throws Exception {
		
		Calendar calendarUltimo = new GregorianCalendar();
		
		calendarUltimo.setTime(date);
		
		calendarUltimo.set(Calendar.HOUR_OF_DAY, 23);
		calendarUltimo.set(Calendar.MINUTE, 59);
		calendarUltimo.set(Calendar.SECOND, 59);
		
		Calendar calendarInicio = new GregorianCalendar();
		
		calendarInicio.setTime(date);
		
		calendarInicio.set(Calendar.HOUR_OF_DAY, 00);
		calendarInicio.set(Calendar.MINUTE, 00);
		calendarInicio.set(Calendar.SECOND, 00);
		
		 return Restrictions.between(propertyName, calendarInicio.getTime(), calendarUltimo.getTime());
	}
	
	
}
