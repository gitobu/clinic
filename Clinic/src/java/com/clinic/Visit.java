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
public class Visit {
    private int visit_id;
    private String visit_no;
    private int patient_id;
    private String primary_complaint;
    private int provider_id;
    
    
   public void setVisit_id(int id){
	visit_id = id;
	}
  public void setVisit_no(String vn){
	visit_no = vn;
	}
  public void setPatient_id (int pi){
      patient_id = pi;
        }
 
 public int getVisit_id() {   
    return visit_id;
        }
 public String getVisit_no(){
     return visit_no;
 }
  public int getPatient_id(){
     return patient_id;
 }
  
  public String getPrimary_complaint(){
      return primary_complaint;
  }
  public int getProvider_id(){
      return provider_id;
  }
}
