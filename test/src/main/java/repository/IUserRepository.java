package repository;

import model.User;

import java.util.List;

public interface IUserRepository {
    List<User> findAll();
    boolean add(User user);
    boolean update(User user);
    boolean delete(int id);
    List<User> findByName(String name);
    User getById(int id);
}
