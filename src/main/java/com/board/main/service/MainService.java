package com.board.main.service;

import com.common.dto.board.BoardDto;
import com.common.dto.main.MainDto;

import java.util.List;

public interface MainService {

    // 메인 찾아주세요 글
    List<BoardDto> getMainLosts();

    // 메인 후기 글
    List<BoardDto> getMainReviews();
}
