package ru.butorin.fourth_dimension_forum.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.butorin.fourth_dimension_forum.models.Rating;

public interface RatingRepository extends JpaRepository<Rating, Long> {
    List<Rating> findByPostId(Long id);
    Rating findByUserIdAndPostId(Long userId, Long postId);
}
