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
public class Provider {
   private int provider_id;
   private String provider_no;
   private String first_name;
   private String last_name;
   private int job_title_id;
    
    public void setProvider_id(int id){
        provider_id = id;
	}
    public void setProvider_no(String pn){
	provider_no = pn;
	}
    public void setFirst_name (String fn){
        first_name = fn;
        }	
    public void setLast_name (String ln){
        last_name = ln;
        }
    public void setJob_title_id(int id){
	job_title_id = id;
	}
    public int getProvider_id(){
        return provider_id;
        }
    public String getProvider_no(){
        return provider_no;
        }
    public String getFirst_name(){
        return first_name;
        }
    public String getLast_name(){
        return last_name;
        }
    public int getJob_title_id() {   
        return job_title_id;
        } 
}
