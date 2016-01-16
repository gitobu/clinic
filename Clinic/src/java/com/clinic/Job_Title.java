/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
job_title_id int not null auto_increment,
job_title_number varchar(25),
job_title varchar(50),
 */

package com.clinic;

/**
 *
 * @author Gitobu
 */
public class Job_Title {
    private int job_title_id;
    private String job_title_number;
    private String job_title;
    
   public void setJob_title_id(int id){
	job_title_id = id;
	}
  public void setJob_title_no(String jtn){
	job_title_number = jtn;
	}
  public void setJob_title (String t){
      job_title = t;
        }	
 public int getJob_title_id() {   
    return job_title_id;
    }
 public String getJob_title_no(){
     return job_title_number;
 }
  public String getJob_title(){
     return job_title;
 }
}