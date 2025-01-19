package ru.butorin.fourth_dimension_forum.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ru.butorin.fourth_dimension_forum.models.Forum;
import ru.butorin.fourth_dimension_forum.models.Post;
import ru.butorin.fourth_dimension_forum.models.Rating;
import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.services.PostService;
import ru.butorin.fourth_dimension_forum.services.RatingService;
import ru.butorin.fourth_dimension_forum.services.UserService;


@Controller
public class RatingController {
    private final RatingService ratingService;
    private final UserService userService;
    private final PostService postService;

    public RatingController(RatingService ratingService, UserService userService, PostService postService) {
        this.ratingService = ratingService;
        this.userService = userService;
        this.postService = postService;
    }

    @PostMapping("/rating/{postId}")
    public String ratePost(@PathVariable Long postId, @RequestParam("rate") int rate, Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        Rating existingRating = ratingService.getRatingByUserAndPost(user.getId(), postId);
        Post post = postService.getPostById(postId);
        Forum forum = post.getForum();

        if (existingRating == null) {
            Rating rating = new Rating();
            rating.setUser(user);
            rating.setPost(post);
            rating.setRate(rate);
            ratingService.saveRating(rating);
            return "redirect:/forum/" + forum.getId() + "/post/" + post.getId();
        } else {
            if (existingRating.getRate() == rate) {
                ratingService.removeRating(user.getId(), postId);
                return "redirect:/forum/" + forum.getId() + "/post/" + post.getId();
            } else {
                existingRating.setRate(rate);
                ratingService.saveRating(existingRating);
                return "redirect:/forum/" + forum.getId() + "/post/" + post.getId();
            }
        }
    }



        // if (user != null) {
        //     if (rate == 1 || rate == -1) {
        //         Rating existingRating = ratingService.getRatingByUserAndPost(user, postId);
        //         if (existingRating != null && existingRating.getRate() == rate) {
        //             ratingService.removeRating(user, postId);
        //         } else {
        //             ratingService.setRating(user, postId, rate);
        //         }
        //     }
        // }
        // return "redirect:/forum/" + postId;
}
