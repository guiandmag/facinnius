package com.facinnius.model.enumtype;

/**
 * @author Guilherme Magalhães - guiandmag@gmail.com
 *
 */
public enum VendaStatusEnum {

	INICIADA("Venda Iniciada"),
	EMANDAMENTO("Venda em Andamento"),
	ENCERRADA("Venda Encerrada");

	private String desc;
	
	VendaStatusEnum(String desc){
		this.desc = desc;
	}
	
	public String getDescricao(){
		return desc;
	}
	
}