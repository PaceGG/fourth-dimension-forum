package ru.butorin.fourth_dimension_forum.controllers;

import java.security.Principal;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.services.UserService;

@Controller
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserService userService;

    public AdminController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String admin(Model model, Principal principal) {
        System.out.println(principal.getName());
        model.addAttribute("users", userService.list().reversed());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/admin/user/unban/{id}")
    public String userUnban(@PathVariable("id") Long id) {
        userService.unbanUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam("role") String role) {
        userService.setUserRole(user, role);
        return "redirect:/admin";
    }
}
