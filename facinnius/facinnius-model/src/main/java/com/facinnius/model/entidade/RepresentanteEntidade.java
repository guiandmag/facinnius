package com.facinnius.model.entidade;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.facinnius.i.model.entidade.Credencial;
import com.facinnius.i.model.entidade.IEntity;

/**
 * @author guilherme
 */
@Entity
@Table(name = "TBL_REPRESENTANTE", indexes = { @Index(columnList = "representante_nome") })
@SequenceGenerator(name = RepresentanteEntidade.REPRESENTANTE_SEQUENCIA, sequenceName = RepresentanteEntidade.REPRESENTANTE_SEQUENCIA, initialValue = 1, allocationSize = 50)
@XmlRootElement(name = "representante")
@XmlAccessorType(XmlAccessType.FIELD)
public class RepresentanteEntidade extends Credencial 
		implements IEntity {
	
	private static final long serialVersionUID = 1L;
	
	@Transient
	public static final String REPRESENTANTE_SEQUENCIA = "REPRESENTANTE_SEQUENCIA";
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = REPRESENTANTE_SEQUENCIA)
	@Column(name = "representante_id", updatable = false, unique = true, nullable = false)
	@XmlAttribute
	private Long id;
	
	@Column(name="representante_nome", nullable = false, length = 255)
	@XmlElement
	private String nomeRepresentante;
	
	@ElementCollection
	@CollectionTable(name = "tbl_representante_emails")
	@XmlElementWrapper
	private Set<String> emails;
	
	@OneToMany(mappedBy = "representante", orphanRemoval = true)
	@XmlElementWrapper
	private List<TelefoneEntidade> telefone = new LinkedList<TelefoneEntidade>();

	public RepresentanteEntidade() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}
   
}
