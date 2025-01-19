package ru.butorin.fourth_dimension_forum.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import ru.butorin.fourth_dimension_forum.models.Comment;
import ru.butorin.fourth_dimension_forum.models.Forum;
import ru.butorin.fourth_dimension_forum.models.Post;
import ru.butorin.fourth_dimension_forum.models.Rating;
import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.services.CommentService;
import ru.butorin.fourth_dimension_forum.services.ForumService;
import ru.butorin.fourth_dimension_forum.services.MainService;
import ru.butorin.fourth_dimension_forum.services.PostService;
import ru.butorin.fourth_dimension_forum.services.RatingService;


@Controller
public class ForumController {
    private final MainService mainService;
    private final ForumService forumService;
    private final PostService postService;
    private final CommentService commentService;
    private final RatingService ratingService;

    public ForumController(MainService mainService, ForumService forumService, PostService postService, CommentService commentService, RatingService ratingService) {
        this.mainService = mainService;
        this.forumService = forumService;
        this.postService = postService;
        this.commentService = commentService;
        this.ratingService = ratingService;
    }

    @GetMapping("/")
    public String products(Principal principal, Model model) {
        model.addAttribute("forums", mainService.listForums());
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        return "main";
    }
    
    @GetMapping("/forum/{forumId}")
    public String forumInfo(@PathVariable Long forumId, Model model, Principal principal) {
        model.addAttribute("forum", mainService.getForumById(forumId));
        model.addAttribute("posts", forumService.getPostsByForumId(forumId));
        model.addAttribute("user", mainService.getUserByPrincipal(principal));

        return "forum";
    }

    @GetMapping("/create/{forumId}")
    public String createPostForm(@PathVariable Long forumId, Model model, Principal principal) {
        model.addAttribute("forum", mainService.getForumById(forumId));
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        return "create-post";
    }

    @PostMapping("/create/{forumId}")
    public String createPost(Post post, @PathVariable Long forumId, Principal principal) {
        System.out.println(post.getText());
        Forum forum = mainService.getForumById(forumId);
        post.setForum(forum);

        User user = mainService.getUserByPrincipal(principal);
        post.setAuthor(user);

        postService.savePost(post);
        return "redirect:/forum/" + forumId + "/post/" + post.getId();
    }

    @PostMapping("/delete/{postId}")
    public String postMethodName(@PathVariable Long postId, Principal principal) {
        User user = mainService.getUserByPrincipal(principal);
        Post post = postService.getPostById(postId);
        if (user.getId().equals(post.getAuthor().getId()) || user.isAdmin() || user.isModerator()) {
            postService.deletePost(postId);
        }
        return "redirect:/forum/" + post.getForum().getId();
    }
    

    @GetMapping("/forum/{forumId}/post/{postId}")
    public String postInfo(@PathVariable Long forumId, @PathVariable Long postId, Model model, Principal principal) {
        model.addAttribute("forum", mainService.getForumById(forumId));
        model.addAttribute("post", postService.getPostById(postId));
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        model.addAttribute("comments", commentService.getCommentsByPostId(postId));
        Rating userRating = ratingService.getRatingByUserAndPost(mainService.getUserByPrincipal(principal).getId(), postId);
        if (userRating == null) {
            model.addAttribute("userRating", 0);
        } else {
            model.addAttribute("userRating", userRating.getRate());
        }
        model.addAttribute("rating", ratingService.getTotalRating(postId));
        return "post";
    }

    @PostMapping("comment/{postId}")
    public String createComment(Comment comment, @PathVariable Long postId, Principal principal) {
        Post post = postService.getPostById(postId);
        comment.setPost(post);

        User user = mainService.getUserByPrincipal(principal);
        comment.setAuthor(user);

        commentService.saveComment(comment);
        return "redirect:/forum/" + post.getForum().getId() + "/post/" + post.getId();
    }

    @GetMapping("/edit-comment/{commentId}")
    public String editCommentForm(@PathVariable Long commentId, Model model, Principal principal) {
        User user = mainService.getUserByPrincipal(principal);
        Comment comment = commentService.getCommentById(commentId);
        if (!user.isAdmin() && !user.isModerator() && !user.getId().equals(commentService.getCommentById(commentId).getAuthor().getId())) {
            return "redirect:/forum/" + comment.getPost().getForum().getId() + "/post/" + comment.getPost().getId();
        }
        model.addAttribute("comment", commentService.getCommentById(commentId));
        model.addAttribute("user", mainService.getUserByPrincipal(principal));
        model.addAttribute("forum", mainService.getForumById(comment.getPost().getForum().getId()));
        model.addAttribute("post", comment.getPost());
        return "edit-comment";
    }

    @PostMapping("/edit-comment/{commentId}")
    public String updateComment(@PathVariable Long commentId, String text, Principal principal) {
        User user = mainService.getUserByPrincipal(principal);
        Comment comment = commentService.getCommentById(commentId);
        if (!user.isAdmin() && !user.isModerator() && !user.getId().equals(commentService.getCommentById(commentId).getAuthor().getId())) {
            return "redirect:/forum/" + comment.getPost().getForum().getId() + "/post/" + comment.getPost().getId();
        }
        comment.setText(text);
        commentService.saveComment(comment);
        return "redirect:/forum/" + comment.getPost().getForum().getId() + "/post/" + comment.getPost().getId();
    }

    @PostMapping("/delete-comment/{commentId}")
    public String deleteComment(@PathVariable Long commentId, Principal principal) {
        User user = mainService.getUserByPrincipal(principal);
        Comment comment = commentService.getCommentById(commentId);
        if (user.getId().equals(comment.getAuthor().getId()) || user.isAdmin() || user.isModerator()) {
            commentService.deleteComment(commentId);
        }
        return "redirect:/forum/" + comment.getPost().getForum().getId() + "/post/" + comment.getPost().getId();
    }
}
