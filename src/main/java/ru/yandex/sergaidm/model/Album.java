package ru.yandex.sergaidm.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "albums")
@Data
@NoArgsConstructor
public class Album implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer id;
	@Column(nullable = false)
	private String albumName;
	@Column
	private Integer cover;
	@Column
	private String description;
	@Column(nullable = false)
	private String creationDate;
	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "album_id")
	private List<Photo> photos;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private CustomUser author;

	public Album(String albumName, String description, String creationDate, CustomUser author) {
		super();
		this.albumName = albumName;
		this.description = description;
		this.creationDate = creationDate;
		this.author = author;
	}

}