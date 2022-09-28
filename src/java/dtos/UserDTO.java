/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

/**
 *
 * @author Thien's
 */
public class UserDTO {
    private String email;
    private String name;
    private int roleId;
    private String phone;
    private String address;

    public UserDTO() {
    }

    public UserDTO(String email, String name, int roleId) {
        this.email = email;
        this.name = name;
        this.roleId = roleId;
    }

    public UserDTO(String email, String name, int roleId, String phone, String address) {
        this.email = email;
        this.name = name;
        this.roleId = roleId;
        this.phone = phone;
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
}
