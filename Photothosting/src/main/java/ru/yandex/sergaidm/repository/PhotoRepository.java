package ru.yandex.sergaidm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ru.yandex.sergaidm.model.Album;
import ru.yandex.sergaidm.model.Photo;

public interface PhotoRepository extends JpaRepository<Photo, Integer> {
	
	List<Photo> findAllByAlbum(Album album);

}