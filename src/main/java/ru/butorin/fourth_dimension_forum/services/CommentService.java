package ru.butorin.fourth_dimension_forum.services;

import java.util.List;

import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.models.Comment;
import ru.butorin.fourth_dimension_forum.repositories.CommentRepository;
import ru.butorin.fourth_dimension_forum.repositories.PostRepository;

@Service
public class CommentService {

    private final CommentRepository commentRepository;
    private final PostRepository postRepository;

    public CommentService(CommentRepository commentRepository, PostRepository postRepository) {
        this.commentRepository = commentRepository;
        this.postRepository = postRepository;
    }

    public Comment getCommentById(Long id) {
        return commentRepository.findById(id).orElse(null);
    }

    public void saveComment(Comment comment) {
        commentRepository.save(comment);
    }

    public void deleteComment(Long id) {
        commentRepository.deleteById(id);
    }

    public List<Comment> getCommentsByPostId(Long postId) {
        return commentRepository.findByPostId(postId);
    }
}
