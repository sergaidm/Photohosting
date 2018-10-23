package ru.yandex.sergaidm.model.dto;

import java.util.Set;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class CaptchaResponseDto {
	
	private boolean success;
	@JsonAlias("error-codes")
	private Set<String> errorCodes;

}