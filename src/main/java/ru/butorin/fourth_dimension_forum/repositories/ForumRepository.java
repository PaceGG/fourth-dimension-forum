package ru.butorin.fourth_dimension_forum.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.butorin.fourth_dimension_forum.models.Forum;

public interface ForumRepository extends JpaRepository<Forum, Long> {
}
