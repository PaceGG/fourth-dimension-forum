package ru.butorin.fourth_dimension_forum.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.butorin.fourth_dimension_forum.models.Post;

public interface PostRepository extends JpaRepository<Post, Long> {
    List<Post> findByForumId(Long id);
    List<Post> findByAuthorId(Long id);
}
