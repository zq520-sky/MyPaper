package test;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "clazz", schema = "paper", catalog = "")
public class ClazzEntity {
    private int id;
    private Integer number;
    private String profess;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "number")
    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Basic
    @Column(name = "profess")
    public String getProfess() {
        return profess;
    }

    public void setProfess(String profess) {
        this.profess = profess;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClazzEntity that = (ClazzEntity) o;
        return id == that.id &&
                Objects.equals(number, that.number) &&
                Objects.equals(profess, that.profess);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, number, profess);
    }
}
