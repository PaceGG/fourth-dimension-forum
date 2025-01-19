package ru.butorin.fourth_dimension_forum.services;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.models.Forum;
import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.repositories.ForumRepository;
import ru.butorin.fourth_dimension_forum.repositories.UserRepository;


@Service
public class MainService {
    private final ForumRepository forumRepository;
    private final UserRepository userRepository;

    public MainService(ForumRepository forumRepository, UserRepository userRepository) {
        this.forumRepository = forumRepository;
        this.userRepository = userRepository;
    }

    public List<Forum> listForums() {
        return forumRepository.findAll();
    }

    public void saveForum(Forum forum) {
        forumRepository.save(forum);
    }

    public void deleteForum(Long id) {
        forumRepository.deleteById(id);
    }

    public Forum getForumById(Long id) {
        return forumRepository.findById(id).orElse(null);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }
}
