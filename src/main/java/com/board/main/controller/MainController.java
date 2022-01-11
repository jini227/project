package com.board.main.controller;

import com.board.main.service.MainService;
import com.common.dto.board.BoardDto;
import com.common.dto.main.MainDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    public MainService mainService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(Model model) {

        List<BoardDto> losts = mainService.getMainLosts();
        model.addAttribute("losts", losts);

        List<BoardDto> reviews = mainService.getMainReviews();
        model.addAttribute("reviews", reviews);

        return "index";
    }
}
