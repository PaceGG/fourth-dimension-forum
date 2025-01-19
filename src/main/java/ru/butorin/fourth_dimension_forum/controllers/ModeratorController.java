package ru.butorin.fourth_dimension_forum.controllers;

import java.security.Principal;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import ru.butorin.fourth_dimension_forum.models.Forum;
import ru.butorin.fourth_dimension_forum.models.Post;
import ru.butorin.fourth_dimension_forum.services.MainService;
import ru.butorin.fourth_dimension_forum.services.PostService;


@Controller
@PreAuthorize("hasAuthority('ROLE_MODERATOR') or hasAuthority('ROLE_ADMIN')")
public class ModeratorController {
    private final MainService mainService;
    private final PostService postService;

    public ModeratorController(MainService mainService, PostService postService) {
        this.mainService = mainService;
        this.postService = postService;
    }

    @GetMapping("/moderator/edit-forum/{id}")
    public String editForum(@PathVariable("id") Long id, Model model, Principal principal) {
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        model.addAttribute("forum", mainService.getForumById(id));
        return "edit-forum";
    }

    @PostMapping("/moderator/edit-forum/{id}")
    public String updateForum(@PathVariable("id") Long id, String title) {
        Forum forum = mainService.getForumById(id);
        forum.setTitle(title);
        mainService.saveForum(forum);
        return "redirect:/";
    }

    @PostMapping("/moderator/create-forum")
    public String createForum(Forum forum) {
        mainService.saveForum(forum);
        return "redirect:/";
    }

    @PostMapping("/moderator/delete-forum/{id}")
    public String deleteForum(@PathVariable("id") Long id) {
        mainService.deleteForum(id);
        return "redirect:/";
    }

    @GetMapping("/moderator/edit-post/{id}")
    public String editPost(@PathVariable("id") Long id, Model model, Principal principal) {
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        model.addAttribute("post", postService.getPostById(id));
        model.addAttribute("forum", mainService.getForumById(postService.getPostById(id).getForum().getId()));
        return "edit-post";
    }

    @PostMapping("/moderator/edit-post/{id}")
    public String updatePost(@PathVariable("id") Long id, String title, String text) {
        Post updatedPost = postService.getPostById(id);
        updatedPost.setTitle(title);
        updatedPost.setText(text);
        postService.savePost(updatedPost);
        return "redirect:/forum/" + updatedPost.getForum().getId() + "/post/" + updatedPost.getId();
    }
}
