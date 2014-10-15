package br.com.alvaro.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="labor.pacientes")
public class Paciente {
	
	@Id
	@Column(name="PctSid")
	private Long id;
	
	@Column(name="PctNome")
	private String nome;
	
	@Column(name="pctCidade")
	private String cidade;
	
	@Column(name="pctEstado")
	private String estado;
	
	@Column(name="pctDtNasc",columnDefinition = "DATE")
	private Date dataNascimento;
	
	@Column(name="pctSexo")
	private String sexo;
	
	@Column(name="pctDtUltExame",columnDefinition = "DATETIME")
	private Date dataUltimoExame;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public Date getDataNascimento() {
		return dataNascimento;
	}

	public void setDataNascimento(Date dataNascimento) {
		this.dataNascimento = dataNascimento;
	}

	public Date getDataUltimoExame() {
		return dataUltimoExame;
	}

	public void setDataUltimoExame(Date dataUltimoExame) {
		this.dataUltimoExame = dataUltimoExame;
	}

	public Paciente() {
		super();
	}

}
