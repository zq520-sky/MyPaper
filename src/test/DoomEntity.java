package test;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "doom", schema = "paper", catalog = "")
public class DoomEntity {
    private int id;
    private Integer 宿舍名;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "宿舍名")
    public Integer get宿舍名() {
        return 宿舍名;
    }

    public void set宿舍名(Integer 宿舍名) {
        this.宿舍名 = 宿舍名;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DoomEntity that = (DoomEntity) o;
        return id == that.id &&
                Objects.equals(宿舍名, that.宿舍名);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, 宿舍名);
    }
}
