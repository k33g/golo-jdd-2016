package acme;

import java.lang.String;
import java.lang.System;

public class Toon {

  public String name;
  private String nickName;

  public String getNickName() {
    return nickName;
  }
  public void setNickName(String value) {
    nickName = value;
  }

  public Toon(String name) {
    this.name = name;
  }
  
  public Toon() {
    this.name = "John Doe";
  }

  public void hi() {
    System.out.println("Hi, I'm " + this.name);
  }

  public static Toon getInstance(String name) {
    return new Toon(name);
  }

  public void hug(Toon toon) {
    System.out.println("I 💙 " + toon.name);
  }
}
