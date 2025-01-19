package ru.butorin.fourth_dimension_forum.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.butorin.fourth_dimension_forum.models.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}
