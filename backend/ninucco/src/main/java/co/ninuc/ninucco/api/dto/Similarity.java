package co.ninuc.ninucco.api.dto;

import lombok.*;

@Getter
@NoArgsConstructor //deserialize
@AllArgsConstructor
@Setter
@Builder
public class Similarity {
    String keyword;
    Double value;
}
