package com.common.mapper.main;

import com.common.dto.board.BoardDto;
import com.common.dto.main.MainDto;

import java.util.List;

public interface MainMapper {

    List<BoardDto> getMainLosts();

    List<BoardDto> getMainReviews();
}
