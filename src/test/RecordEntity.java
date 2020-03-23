package test;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "record", schema = "paper", catalog = "")
public class RecordEntity {
    private int id;
    private Timestamp 日期;
    private String 记录;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "日期")
    public Timestamp get日期() {
        return 日期;
    }

    public void set日期(Timestamp 日期) {
        this.日期 = 日期;
    }

    @Basic
    @Column(name = "记录")
    public String get记录() {
        return 记录;
    }

    public void set记录(String 记录) {
        this.记录 = 记录;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RecordEntity that = (RecordEntity) o;
        return id == that.id &&
                Objects.equals(日期, that.日期) &&
                Objects.equals(记录, that.记录);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, 日期, 记录);
    }
}
