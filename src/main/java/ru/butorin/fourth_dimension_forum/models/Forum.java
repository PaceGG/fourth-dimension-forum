package ru.butorin.fourth_dimension_forum.models;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "forums")
@Data
public class Forum {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private LocalDateTime dateOfCreated;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "forum" , cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Post> posts = new ArrayList<>();

    @PrePersist
    private void onCreate() { dateOfCreated = LocalDateTime.now(); }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Post> getPosts(){
        return posts;
    }

    

}
