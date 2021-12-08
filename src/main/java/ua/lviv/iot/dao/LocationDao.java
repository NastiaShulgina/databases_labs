package ua.lviv.iot.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.lviv.iot.model.Location;

@Repository
public interface LocationDao extends JpaRepository<Location, Integer> {
}