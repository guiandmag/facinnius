package com.facinnius.model.entidade;

import java.io.Serializable;

import javax.persistence.*;
import javax.validation.Valid;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entity implementation class for Entity: FichaEntidade
 *
 */
@Entity
@Table(name = "TBL_FICHA", indexes = { @Index(columnList = "ficha_numero_ficha") })
@SequenceGenerator(name = FichaEntidade.FICHA_SEQUENCIA, sequenceName = FichaEntidade.FICHA_SEQUENCIA, initialValue = 1, allocationSize = 50)
@XmlRootElement(name = "ficha")
@XmlAccessorType(XmlAccessType.FIELD)
public class FichaEntidade implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Transient
	public static final String FICHA_SEQUENCIA = "FICHA_SEQUENCIA";
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = FICHA_SEQUENCIA)
	@Column(name = "ficha_id", updatable = false, unique = true, nullable = false)
	@XmlAttribute
	private Long id;
	
	@Column(name = "ficha_numero_ficha", nullable = false, length = 12)
	@XmlElement
	private Long numeroFicha;
	
	@OneToOne
	@JoinColumn(name = "endereco_id", updatable = true, nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.NO_CONSTRAINT, name = "fk_ficha_endereco"))
	@Valid
	private EnderecoEntidade endereco;

	public FichaEntidade() {
		super();
	}
   
}
