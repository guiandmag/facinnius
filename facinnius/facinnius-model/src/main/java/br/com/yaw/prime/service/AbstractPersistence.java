package br.com.yaw.prime.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaQuery;

import br.com.yaw.prime.model.AbstractEntity;

public abstract class AbstractPersistence<T extends AbstractEntity, PK extends Number> {

	private Class<T> entityClass;

    public AbstractPersistence(Class<T> entityClass) {
    	this.entityClass = entityClass;
    }

    protected abstract EntityManager getEntityManager();

    public T save(T e) {
		if (e.getId() != null)
			return getEntityManager().merge(e);
		else {
			getEntityManager().persist(e);
			return e;
		}
	}

    public void remove(T entity) {
        getEntityManager().remove(getEntityManager().merge(entity));
    }

    public T find(PK id) {
        return getEntityManager().find(entityClass, id);
    }

    @SuppressWarnings("unchecked")
	public List<T> findAll() {
        @SuppressWarnings("rawtypes")
		CriteriaQuery cq = getEntityManager().getCriteriaBuilder().createQuery();
        cq.select(cq.from(entityClass));
        return getEntityManager().createQuery(cq).getResultList();
    }
}