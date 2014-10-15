package com.facinnius.model.enumtype;

/**
 * @author Guilherme Magalhães - guiandmag@gmail.com
 *
 */
public enum TipoPagamentoStatus {
	
	FICHA("Pagamento na Ficha"),
	CARTAO_DEBITO("Pagamento com cartao de debito"),
	CARTAO_CREDITO("Pagamento com cartao de credito"),
	CHEQUE("Pagamento com cheque");

	private String desc;
	
	TipoPagamentoStatus(String desc){
		this.desc = desc;
	}
	
	public String getDescricao(){
		return desc;
	}

}