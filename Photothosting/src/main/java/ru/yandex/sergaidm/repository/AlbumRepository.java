package ru.yandex.sergaidm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.CustomUser;

public interface AlbumRepository extends JpaRepository<Album, Integer> {
	
	List<Album> findAllByAuthorOrderByIdAsc(CustomUser author);

}