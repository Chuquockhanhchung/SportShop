package model;

import java.sql.Date;

public class UserAdmin {

    private int userId;
    private String userName;
    private String userFullName;
    private String email;
    private String password;
    private String phoneNumber;
    private String gender;
    private Date dateOfBirth;
    private String role;
    private String address;
    private String userAvatar;

    public UserAdmin() {
    }

    public UserAdmin(int userId, String userName, String email, String role) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.role = role;
    }

    public UserAdmin(int userId, String userName, String userFullName, String email, String password,
            String phoneNumber, String gender, Date dateOfBirth, String role, String address, String userAvatar) {
        this.userId = userId;
        this.userName = userName;
        this.userFullName = userFullName;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.role = role;
        this.address = address;
        this.userAvatar = userAvatar;
    }
    
    public UserAdmin(String userName, String userFullname, String email, String password, String phonenumber, String gender, Date dateOfBirth, String address) {
        this.userName = userName;
        this.userFullName = userFullname;
        this.email = email;
        this.password = password;
        this.phoneNumber = phonenumber;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", userName=" + userName + ", userFullName=" + userFullName + ", email=" + email + ", password=" + password + ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", dateOfBirth=" + dateOfBirth + ", role=" + role + ", address=" + address + ", userAvatar=" + userAvatar + '}';
    }

}
