package service;

import model.User;
import repository.UserRepository;

import java.util.List;

public class UserService implements IUserService {
    private UserRepository userRepository = new UserRepository();
    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public boolean add(User user) {
        return userRepository.add(user);
    }

    @Override
    public boolean update(User user) {
       return userRepository.update(user);
    }

    @Override
    public boolean delete(int id) {
        return userRepository.delete(id);
    }

    @Override
    public List<User> findByName(String name) {
        return userRepository.findByName(name);
    }

    @Override
    public User getById(int id) {
        return userRepository.getById(id);
    }
}
