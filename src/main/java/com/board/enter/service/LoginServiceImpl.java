package com.board.enter.service;

import com.common.dao.Dao;
import com.common.dto.enter.MemberDto;
import com.common.dto.enter.SignUpDto;
import com.common.utils.AES256Util;
import com.common.utils.SHA256Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private Dao dao;

    @Transactional
    @Override
    public void registMember(SignUpDto signUpDto) {
        // 암호화를 위한 salt 생성
        signUpDto.setSalt(SHA256Util.getSalt());

        try {
            // 비밀번호 SHA-256
            signUpDto.setPassword(SHA256Util.SHA256Encrypt(signUpDto.getPassword(), signUpDto.getSalt()));

            // 연락처, 이메일 AES-256
            AES256Util aes256util = new AES256Util("1234123412341234");
            signUpDto.setEmail(aes256util.encrypt(signUpDto.getEmail()));
            signUpDto.setPhone(aes256util.encrypt(signUpDto.getPhone()));

            dao.registMember(signUpDto);

        } catch (Exception e) {
            System.out.println("[ERROR] " + e.getMessage());
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
    }

    @Override
    public int idChk(String id) {
        int result = dao.idChk(id);

        return result;
    }

    @Override
    public MemberDto getMemberInfo(String id) {
        MemberDto memberInfo = dao.getMemberInfo(id);

        return memberInfo;
    }


}
