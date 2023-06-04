package co.ninuc.ninucco.db.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name= "item")
@Getter
@NoArgsConstructor
public class Item extends BaseEntity {
    @Column(name="name", length = 20)
    String name;

    @Column(name="url", length = 1024)
    String url;

    @Column(name="description", length = 200)
    String description;

    @Builder
    public Item(String name, String url, String description){
        this.name=name;
        this.url=url;
        this.description=description;
    }
}
