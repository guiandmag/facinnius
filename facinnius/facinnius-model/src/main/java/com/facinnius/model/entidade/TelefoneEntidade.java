package com.facinnius.model.entidade;

import javax.persistence.*;
import javax.validation.Valid;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.facinnius.i.model.entidade.IEntity;

/**
 * @author guilherme
 */
@Entity
@Table(name = "TBL_TELEFONE", indexes = { @Index(columnList = "telefone_numero") })
@SequenceGenerator(name = TelefoneEntidade.TELEFONE_SUQUENCIA, sequenceName = TelefoneEntidade.TELEFONE_SUQUENCIA, initialValue = 1, allocationSize = 50)
@XmlRootElement(name = "telefone")
@XmlAccessorType(XmlAccessType.FIELD)
public class TelefoneEntidade implements IEntity {

	private static final long serialVersionUID = 1L;
	
	@Transient
	public static final String TELEFONE_SUQUENCIA = "TELEFONE_SUQUENCIA";
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = TELEFONE_SUQUENCIA)
	@Column(name = "telefone_id", updatable = false, unique = true, nullable = false)
	@XmlAttribute
	private Long id;
	
	@Column(name="telefone_tipo", nullable = false, length = 25)
	@XmlElement
	private String tipoTelefone;
	
	@Column(name="telefone_numero", nullable = false, length = 25)
	@XmlElement
	private String numeroTelefone;
	
	@Column(name="telefone_operadora", nullable = false, length = 25)
	@XmlElement
	private String operadoraTelefone;
	
	@ManyToOne(fetch = FetchType.EAGER, optional = false)
	@JoinColumn(name = "representante_id", nullable = false)
	@Valid
	private RepresentanteEntidade representante;

	public TelefoneEntidade() {
		super();
	}

	@Override
	public Long getId() {
		return id;
	}
   
}