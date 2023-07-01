package com.yamacbayin.blogbackend.entity;


import com.yamacbayin.blogbackend.util.DateUtils;
import jakarta.persistence.*;

import java.time.OffsetDateTime;

@Entity
@Table(name = "comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private int commentId;
    @Column(name = "post_id")
    private int postId;
    @Column(name = "user_id")
    private int userId;
    private String comment;
    @Column(name = "creation_date")
    private OffsetDateTime creationDate;
    @Column(name = "is_confirmed")
    private boolean isConfirmed;

    @PrePersist
    private void prePersist() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    @PreUpdate
    private void preUpdate() {
        creationDate = DateUtils.formatCreationDate(creationDate);
    }

    public Comment() {
    }

    public Comment(int commentId, int postId, int userId, String comment,
                   OffsetDateTime creationDate, boolean isConfirmed) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.comment = comment;
        this.creationDate = creationDate;
        this.isConfirmed = isConfirmed;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public OffsetDateTime getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(OffsetDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public boolean getIsConfirmed() {
        return isConfirmed;
    }

    public void setIsConfirmed(boolean confirmed) {
        isConfirmed = confirmed;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", postId=" + postId +
                ", userId=" + userId +
                ", comment='" + comment + '\'' +
                ", creationDate=" + creationDate +
                ", isConfirmed=" + isConfirmed +
                '}';
    }
}
