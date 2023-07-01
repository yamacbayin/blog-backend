package com.yamacbayin.blogbackend.entity;

import com.yamacbayin.blogbackend.util.DateUtils;
import jakarta.persistence.*;

import java.time.OffsetDateTime;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private int userId;
    @Column(unique = true)
    private String username;
    @Column(unique = true)
    private String email;
    @Column(name = "creation_date")
    private OffsetDateTime creationDate;
    @Column(name = "is_active")
    private boolean isActive;

    @PrePersist
    private void prePersist() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    @PreUpdate
    private void preUpdate() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    public User() {
    }

    public User(int userId, String username, String email, OffsetDateTime creationDate, boolean isActive) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.creationDate = creationDate;
        this.isActive = isActive;
    }

    public User(String username, String email, OffsetDateTime creationDate, boolean isActive) {
        this.username = username;
        this.email = email;
        this.isActive = isActive;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public OffsetDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(OffsetDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", creationDate=" + creationDate +
                ", isActive=" + isActive +
                '}';
    }
}
