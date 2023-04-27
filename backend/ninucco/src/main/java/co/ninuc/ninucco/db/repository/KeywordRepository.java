package co.ninuc.ninucco.db.repository;

import co.ninuc.ninucco.db.entity.Keyword;
import co.ninuc.ninucco.db.entity.type.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface KeywordRepository extends JpaRepository<Keyword, Long> {
    List<Keyword> findAllByCategory(Category category);
}
