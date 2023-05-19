package co.ninuc.ninucco.api.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
@Setter
@Builder
public class Similarity {
    String keyword;
    Double value;
}
