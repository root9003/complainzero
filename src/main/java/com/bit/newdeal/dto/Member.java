package com.bit.newdeal.dto;

public class Member {
  private String id;
  private String pw;
  private String nickname;
  private int enabled;
  private String file;
  private String authCode;
  
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPw() {
    return pw;
  }
  public void setPw(String pw) {
    this.pw = pw;
  }
  public String getNickname() {
    return nickname;
  }
  public void setNickname(String nickname) {
    this.nickname = nickname;
  }
  public int getEnabled() {
    return enabled;
  }
  public void setEnabled(int enabled) {
    this.enabled = enabled;
  }
  public String getFile() {
    return file;
  }
  public void setFile(String file) {
    this.file = file;
  }
  public String getAuthCode() {
    return authCode;
  }
  public void setAuthCode(String authCode) {
    this.authCode = authCode;
  }
}
