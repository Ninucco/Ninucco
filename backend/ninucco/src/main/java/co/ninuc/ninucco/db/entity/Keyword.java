package co.ninuc.ninucco.db.entity;

import co.ninuc.ninucco.db.entity.type.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name= "keyword")
@Getter
@NoArgsConstructor
public class Keyword extends BaseEntity{
    Category category;
    String name;
    @Builder
    public Keyword(Category category, String name){
        this.category=category;
        this.name=name;
    }
}
