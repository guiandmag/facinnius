package com.facinnius.model.entidade;

import javax.persistence.*;
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
@Table(name = "TBL_ENDERECO", indexes = {@Index(columnList = "endereco_nome")})
@SequenceGenerator(name = EnderecoEntidade.ENDERECO_SEQUENCIA, sequenceName = EnderecoEntidade.ENDERECO_SEQUENCIA, initialValue = 1, allocationSize = 50)
@XmlRootElement(name = "endereco")
@XmlAccessorType(XmlAccessType.FIELD)
public class EnderecoEntidade implements IEntity {

	private static final long serialVersionUID = 1L;
	
	@Transient
	public static final String ENDERECO_SEQUENCIA = "ENDERECO_SEQUENCIA";
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = ENDERECO_SEQUENCIA)
	@Column(name = "endereco_id", updatable = false, unique = true, nullable = false)
	@XmlAttribute
	private Long id;
	
	@Column(name = "endereco_nome", nullable = false, length = 50)
	@XmlElement
	private String nomeEstabelecimento;
	
	@Column(name = "endereco_rua", nullable = false, length = 100)
	@XmlElement
	private String nomeRua;
	
	@Column(name = "endereco_bairro", nullable = false, length = 100)
	@XmlElement
	private String nomeBairro;
	
	@Column(name = "endereco_cidade", nullable = false, length = 100)
	@XmlElement
	private String nomeCidade;
	
	@Column(name = "endereco_cep", nullable = false, length = 12)
	@XmlElement
	private String cep;
	
	@Column(name = "endereco_numero", nullable = false, length = 6) 
	@XmlElement
	private int numero;
	
	@OneToOne(mappedBy = "endereco", orphanRemoval = true)
	private FichaEntidade ficha;

	public EnderecoEntidade() {
		super();
	}

	@Override
	public Number getId() {
		return id;
	}
   
}
