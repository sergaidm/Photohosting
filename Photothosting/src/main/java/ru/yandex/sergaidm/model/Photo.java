package ru.yandex.sergaidm.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "photos")
@Data
@NoArgsConstructor
public class Photo implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Integer id;
	@Column(nullable = false)
	private byte[] data;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "album_id")
	private Album album;

	public Photo(byte[] data, Album album) {
		super();
		this.data = data;
		this.album = album;
	}

}