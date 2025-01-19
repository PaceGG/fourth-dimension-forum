package ru.butorin.fourth_dimension_forum.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.models.Post;
import ru.butorin.fourth_dimension_forum.repositories.PostRepository;

@Service
public class PostService {

    @Autowired
    private PostRepository postRepository;

    public void savePost(Post post) {
        postRepository.save(post);
    }

    public void deletePost(Long id) {
        postRepository.deleteById(id);
    }

    public Post getPostById(Long id) {
        return postRepository.findById(id).orElse(null);
    }

    public List<Post> getPostsByUserId(Long id) {
        return postRepository.findByAuthorId(id);
    }
}
