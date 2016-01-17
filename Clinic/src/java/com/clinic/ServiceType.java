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
public class ServiceType {
    private int service_type_id;
    private String service_type_no;
    private String service_type_description;
    
   public void setService_type_id(int id){
	service_type_id = id;
	}
  public void setService_type_no(String stn){
	service_type_no = stn;
	}
  public void setService_type_description (String t){
      service_type_description = t;
        }	
 public int getService_type_id() {   
    return service_type_id;
    }
 public String getService_type_no(){
     return service_type_no;
 }
  public String getService_type_description(){
     return service_type_description;
 }
}
