package ru.yandex.sergaidm.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.NoArgsConstructor;
import ru.yandex.sergaidm.model.UserRole;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
public class CustomUser implements UserDetails, Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue
    private Integer id;
    @Column(nullable = false)
    private String username;
    @Column(nullable = false)
    private String password;
    @Transient
    private String repassword;
    @Column(nullable = false)
    private String email;
    private String activationCode;
    private String phone;
    private boolean active;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role;

    public CustomUser(String username, String password, UserRole role) {
        super();
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public CustomUser(String username, String password, String email, String phone, UserRole role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    public Set<UserRole> getRoles(UserRole role) {
        Set<UserRole> roles = new HashSet<>();
        roles.add(role);
        return roles;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles(role);
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

}