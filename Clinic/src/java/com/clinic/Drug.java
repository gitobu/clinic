/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.clinic;

/**
 *
 * @author Gitobu
 */
public class Drug {
    private int drug_id;
   private String drug_no;
   private String drug_name;
   private int drug_form_id;
    
    public void setDrug_id(int id){
        drug_id = id;
	}
    public void setDrug_no(String dn){
	drug_no = dn;
	}
    public void setDrug_name (String dn){
        drug_name = dn;
        }	
    public void setDrug_form_id(int id){
		drug_form_id = id;
	}
    public int getDrug_id(){
        return drug_id;
        }
    public String getDrug_no(){
        return drug_no;
        }
    public String getDrug_name(){
        return drug_name;
        }
    public int getDrug_form_id() {   
        return drug_form_id;
        } 
}
