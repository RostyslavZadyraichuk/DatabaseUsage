package com.zadyraichuk.entity;

import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@NoArgsConstructor
public class Customer {

    @EqualsAndHashCode.Include
    private Integer id;

    private String fullName;

    private String phone;

}
