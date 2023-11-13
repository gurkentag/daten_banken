package com.example.dataloader.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.*;

@Getter
@Setter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Creators {
    @Id
    @GeneratedValue(generator = "INTEGER")
    @Column(name = "creatorid")
    private Integer id;

    @Column(name = "cname")
    private String cname;
}
