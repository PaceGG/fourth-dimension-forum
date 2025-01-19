package ru.butorin.fourth_dimension_forum.services;

import java.security.Principal;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.models.enums.Role;
import ru.butorin.fourth_dimension_forum.repositories.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.ROLE_ADMIN);
        userRepository.save(user);
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(false);
        }
        userRepository.save(user);
    }

    public void unbanUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setActive(true);
        }
        userRepository.save(user);
    }

    public void setUserRole(User user, String role) {
        user.setRole(Role.valueOf(role));
        userRepository.save(user);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
}
