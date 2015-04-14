ruleset mtt {

  meta {
    name "Message Type Test"
  }

  rule songs1
  {
    select when echo message msg_type re#song#
      send_directive("sing") with
        song = event:param("msg_type");
    always
    {
      raise explicit event sung
        with song = event:param("msg_type");
    }
  }

  rule songs2
  {
    select when echo message msg_type re#song#
      send_directive("sing") with
        song = event:param("input");
    always
    {
      raise explicit event sung
        with song = event:param("input");
    }
  }
 
  rule catch is inactive {
    select when explicit sung
    send_directive("caught sung") with song = event:attr("song")
  }

}