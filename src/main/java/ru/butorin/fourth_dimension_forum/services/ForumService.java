package ru.butorin.fourth_dimension_forum.services;

import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.repositories.UserRepository;
import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.models.Forum;
import ru.butorin.fourth_dimension_forum.models.Post;

import java.security.Principal;

import lombok.extern.slf4j.Slf4j;

import java.util.List;

import ru.butorin.fourth_dimension_forum.repositories.ForumRepository;
import ru.butorin.fourth_dimension_forum.repositories.PostRepository;


@Service
@Slf4j
public class ForumService {
    private final ForumRepository forumRepository;
    private final UserRepository userRepository;
    private final PostRepository postRepository;

    public ForumService(ForumRepository forumRepository, UserRepository userRepository, PostRepository postRepository) {
        this.forumRepository = forumRepository;
        this.userRepository = userRepository;
        this.postRepository = postRepository;
    }

    public List<Post> getPostsByForumId(Long forumId) {
        return postRepository.findByForumId(forumId);
    }

    public void savePost(Forum forum) {
        forumRepository.save(forum);
    }

    public void deletePost(Long id) {
        forumRepository.deleteById(id);
    }

    public Forum getPostById(Long id) {
        return forumRepository.findById(id).orElse(null);
    }
}
