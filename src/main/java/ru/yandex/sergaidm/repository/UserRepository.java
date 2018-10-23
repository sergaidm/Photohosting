package ru.yandex.sergaidm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.yandex.sergaidm.model.CustomUser;

public interface UserRepository extends JpaRepository<CustomUser, Integer> {

	CustomUser findByUsername(String username);
	
	CustomUser findByActivationCode(String code);
	
	CustomUser findByEmail(String email);

	boolean existsByUsername(String username);
	
	boolean existsByEmail(String email);

	List<CustomUser> findAllByOrderByIdAsc();		

}