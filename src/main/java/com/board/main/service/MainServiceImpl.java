package com.board.main.service;

import com.common.dao.Dao;
import com.common.dto.board.BoardDto;
import com.common.dto.main.MainDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainServiceImpl implements MainService {

    @Autowired
    private Dao dao;

    @Override
    public List<BoardDto> getMainLosts() {

        List<BoardDto> boardDto = dao.getMainLosts();

        return boardDto;
    }

    @Override
    public List<BoardDto> getMainReviews() {

        List<BoardDto> boardDto = dao.getMainReviews();

        return boardDto;
    }

}
