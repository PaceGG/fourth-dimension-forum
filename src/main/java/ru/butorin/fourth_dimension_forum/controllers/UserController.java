package ru.butorin.fourth_dimension_forum.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.services.CommentService;
import ru.butorin.fourth_dimension_forum.services.PostService;
import ru.butorin.fourth_dimension_forum.services.UserService;


@Controller
public class UserController {
    private final UserService userService;
    private final PostService postService;
    private final CommentService commentService;

    public UserController(UserService userService, PostService postService, CommentService commentService) {
        this.userService = userService;
        this.postService = postService;
        this.commentService = commentService;
    }

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "login";
    }

    @GetMapping("/profile")
    public String profile(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);

        model.addAttribute("user", user);
        model.addAttribute("posts", postService.getPostsByUserId(user.getId()));
        return "profile";
    }

    @GetMapping("/registration")
    public String registration(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(User user, Model model) {
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{userId}")
    public String userInfo(@PathVariable Long userId, Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("otherUser", userService.getUserById(userId));
        if (userId.equals( userService.getUserByPrincipal(principal).getId())) {
            return "redirect:/profile";
        }
        model.addAttribute("posts", postService.getPostsByUserId(userId));
        return "user-info";
    }
}
