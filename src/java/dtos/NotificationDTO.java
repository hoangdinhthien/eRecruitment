/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.sql.Date;

/**
 *
 * @author ACER
 */
public class NotificationDTO {
    private int nId;
    private String email;
    private String title;
    private String content;
    private String link;
    private Date date;

    public NotificationDTO() {
    }

    public NotificationDTO(int nId, String email, String title, String content, String link, Date date) {
        this.nId = nId;
        this.email = email;
        this.title = title;
        this.content = content;
        this.link = link;
        this.date = date;
    }

    public int getnId() {
        return nId;
    }

    public void setnId(int nId) {
        this.nId = nId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    
    
}
