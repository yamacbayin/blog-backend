package com.yamacbayin.blogbackend.entity;


import com.yamacbayin.blogbackend.util.DateUtils;
import jakarta.persistence.*;

import java.time.OffsetDateTime;

@Entity
@Table(name = "posts")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "post_id")
    private int postId;
    @Column(name = "user_id")
    private int userId;
    @Column(name = "category_id")
    private int categoryId;
    @Column(length = 50)
    private String title;
    private String content;
    @Column(name = "view_count")
    private int viewCount;
    @Column(name = "creation_date")
    private OffsetDateTime creationDate;
    @Column(name = "is_published")
    private boolean isPublished;

    @PrePersist
    private void prePersist() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    @PreUpdate
    private void preUpdate() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    public Post() {
    }

    public Post(int postId, int userId, int categoryId, String title, String content,
                int viewCount, OffsetDateTime creationDate, boolean isPublished) {
        this.postId = postId;
        this.userId = userId;
        this.categoryId = categoryId;
        this.title = title;
        this.content = content;
        this.viewCount = viewCount;
        this.creationDate = creationDate;
        this.isPublished = isPublished;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public OffsetDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(OffsetDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public boolean getIsPublished() {
        return isPublished;
    }

    public void setIsPublished(boolean published) {
        isPublished = published;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", userId=" + userId +
                ", categoryId=" + categoryId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", viewCount=" + viewCount +
                ", creationDate=" + creationDate +
                ", isPublished=" + isPublished +
                '}';
    }
}

