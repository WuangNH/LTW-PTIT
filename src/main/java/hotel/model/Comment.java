package hotel.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "Comment" )
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String text;
}
