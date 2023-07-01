package com.yamacbayin.blogbackend.entity;


import com.yamacbayin.blogbackend.util.DateUtils;
import jakarta.persistence.*;

import java.time.OffsetDateTime;

@Entity
@Table(name = "categories")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private int categoryId;
    private String name;
    @Column(name = "creation_date")
    private OffsetDateTime creationDate;

    @PrePersist
    private void prePersist() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    @PreUpdate
    private void preUpdate() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    public Category() {
    }

    public Category(int categoryId, String name, OffsetDateTime creationDate) {
        this.categoryId = categoryId;
        this.name = name;
        this.creationDate = creationDate;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public OffsetDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(OffsetDateTime creationDate) {
        this.creationDate = creationDate;
    }

    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", name='" + name + '\'' +
                ", creationDate=" + creationDate +
                '}';
    }
}
