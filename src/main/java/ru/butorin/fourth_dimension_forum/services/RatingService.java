package ru.butorin.fourth_dimension_forum.services;

import java.util.List;

import org.springframework.stereotype.Service;

import ru.butorin.fourth_dimension_forum.models.Post;
import ru.butorin.fourth_dimension_forum.models.Rating;
import ru.butorin.fourth_dimension_forum.models.User;
import ru.butorin.fourth_dimension_forum.repositories.PostRepository;
import ru.butorin.fourth_dimension_forum.repositories.RatingRepository;
import ru.butorin.fourth_dimension_forum.repositories.UserRepository;

@Service
public class RatingService {
    private final RatingRepository ratingRepository;
    private final PostRepository postRepository;
    private final UserRepository userRepository;

    public RatingService(RatingRepository ratingRepository, PostRepository postRepository, UserRepository userRepository) {
        this.ratingRepository = ratingRepository;
        this.postRepository = postRepository;
        this.userRepository = userRepository;
    }

    public void saveRating(Rating rating) {
        ratingRepository.save(rating);
    }

    public long getTotalRating(Long postId) {
        List<Rating> ratings = ratingRepository.findByPostId(postId);
        return ratings.stream().mapToInt(Rating::getRate).sum();
    }

    public void setRating(Long userId, Long postId, int rate) {
        Rating existingRating = ratingRepository.findByUserIdAndPostId(userId, postId);
        
        if (existingRating != null) {
            existingRating.setRate(rate);
            ratingRepository.save(existingRating);
        } else {
            Rating newRating = new Rating();
            User user = userRepository.getById(userId);
            Post post = postRepository.getById(postId);
            newRating.setUser(user);
            newRating.setPost(post);
            newRating.setRate(rate);
            ratingRepository.save(newRating);
        }
    }

    public void removeRating(Long userId, Long postId) {
        Rating existingRating = ratingRepository.findByUserIdAndPostId(userId, postId);
        if (existingRating != null) {
            ratingRepository.delete(existingRating);
        }
    }

    public Rating getRatingByUserAndPost(Long userId, Long postId) {
        return ratingRepository.findByUserIdAndPostId(userId, postId);
    }
}
