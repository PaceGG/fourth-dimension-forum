package ru.butorin.fourth_dimension_forum.models;

import lombok.Data;

import javax.persistence.*;

@Table (name = "rating", uniqueConstraints=@UniqueConstraint(columnNames = {"user_id", "post_id"}))
@Entity
@Data
public class Rating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int rate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    private Post post;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }   

    public int getRate() {
        return rate;
    }
    public void setRate(int rate) {
        this.rate = rate;
    }
    
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public Post getPost() {
        return post;
    }
    public void setPost(Post post) {
        this.post = post;
    }
}
