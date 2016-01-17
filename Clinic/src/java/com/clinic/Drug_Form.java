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
public class Drug_Form {
    private int drug_form_id;
    private String drug_form_no;
    private String drug_form;
    
   public void setDrug_form_id(int id){
	drug_form_id = id;
	}
  public void setDrug_form_no(String dfn){
	drug_form_no = dfn;
	}
  public void setDrug_form (String f){
      drug_form = f;
        }	
 public int getDrug_form_id() {   
    return drug_form_id;
    }
 public String getDrug_form_no(){
     return drug_form_no;
 }
  public String getDrug_form(){
     return drug_form;
 }
}
