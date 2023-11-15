Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F4C07548
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 08:27:48 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.8767.1700036859375674948
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Nov 2023 00:27:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OfMMlJpy;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-32fbf271346so3994753f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Nov 2023 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700036858; x=1700641658; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdP2aWp1iwRDQotkQvHoQt4EXPR2D+l7OyorpdBH5oo=;
        b=OfMMlJpy+tXxyMMpnrTu+S1GmmdlumvlM1hHdQL65iAv/njCB7qT/HnE20eb/6BS4Z
         SBmEZBrzqpCWo1poXM/L23i7pPjdE9agVovQFXfd2ihrSKt371c+4PzV9Xh4a792nUK4
         Id+DxguQ9FgHNZ8SoUSwinlyCVbm4/ZoXUJ02Owisu78UtgsbPA5ch57wK5kprIpIIRg
         Tdrclt9/RY8GBl2f0Uye1g9aazYNGV6kJk42WiZyWvnflYebBaDBbqUCHQQq2TytXTG6
         VP7U+dYYbY4D9oxPQDfAX5YqjAkP+eNyJKkEITQbHUF/dShhPmYk645nm62qLZ/56ZtE
         rwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036858; x=1700641658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdP2aWp1iwRDQotkQvHoQt4EXPR2D+l7OyorpdBH5oo=;
        b=nSUkk1iZjozEbg4BvfyqNEyYdsVvLuSxXvI1Is8FsgjJb5z8a1r0lWQ0kj36cVcR+q
         Qa6vfMlaizo/VyTZI8JZHAYcr+ZKZe8HalvMS4WYEAdeip083IXC5wpycu436ufcZme0
         xyghaDEDMAyqQCPwNXR3Cx83F8FAmwHu3fLkej3cMa24wCNhrqMbfUFrbgCc6/pj/Agr
         MIIthgTO1sGJUMd5DIzDnL7tYj45ATAjcEsWruAx2ddA6k76P/YgZGQ7hZGWQJN6bVQZ
         Gk4WYqEg5nt7fVfkyf9DIsj71r/F+prvNgp2ZQm7G9g6FdeeivPPYt1qyMYQFlKiOIV7
         yY5Q==
X-Gm-Message-State: AOJu0YwEtWYgp1k/tjQN2Z5k8GctSVHE3LZJwWq4V3RQXnSRXwo4IjQT
	FLAI1x49Whr6Nq/qovcmeQQLN9v3Khmg4qcq62g=
X-Google-Smtp-Source: AGHT+IFGCqhYr9bq2/mf2O2el3eTM5SFigBqAUluOl8VPzQ5Fxi8VoGiOHMnt5hTc2oh5XMLBLtr8gzeHBwo5s76wy0=
X-Received: by 2002:a5d:6d89:0:b0:32d:92fd:9f73 with SMTP id
 l9-20020a5d6d89000000b0032d92fd9f73mr9166860wrs.10.1700036857550; Wed, 15 Nov
 2023 00:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20231110155009.941766-1-JPEWhacker@gmail.com>
In-Reply-To: <20231110155009.941766-1-JPEWhacker@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 15 Nov 2023 09:27:25 +0100
Message-ID: <CA+chaQfJOuinDq4mb27KWOk7wtdToaLSSoqwSO4KEm5tQ0xVQA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] asyncrpc: Add option to set log level when
 running as a process
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ffddcc060a2cace4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Nov 2023 08:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15530

--000000000000ffddcc060a2cace4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Tested-by: Martin Jansa <Martin.Jansa@gmail.com>

On Fri, Nov 10, 2023 at 4:50=E2=80=AFPM Joshua Watt <JPEWhacker@gmail.com> =
wrote:

> When running an asyncrpc server as a subprocess, it is often desired to
> run it with a lower logging level since the normal logging of clients
> connecting and disconnecting is not desired.
>
> As such, add an option to set the logging level of the server when
> running as a subprocess and set the level to WARNING when starting a
> local hashserver or PRserver
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  lib/bb/asyncrpc/serv.py | 5 ++++-
>  lib/bb/cooker.py        | 2 +-
>  lib/prserv/serv.py      | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
> index 5fed1730..f0be9a6c 100644
> --- a/lib/bb/asyncrpc/serv.py
> +++ b/lib/bb/asyncrpc/serv.py
> @@ -322,7 +322,7 @@ class AsyncServer(object):
>          self.loop =3D asyncio.new_event_loop()
>          asyncio.set_event_loop(self.loop)
>
> -    def serve_as_process(self, *, prefunc=3DNone, args=3D()):
> +    def serve_as_process(self, *, prefunc=3DNone, args=3D(), log_level=
=3DNone):
>          """
>          Serve requests in a child process
>          """
> @@ -351,6 +351,9 @@ class AsyncServer(object):
>              if prefunc is not None:
>                  prefunc(self, *args)
>
> +            if log_level is not None:
> +                self.logger.setLevel(log_level)
> +
>              self._serve_forever(tasks)
>
>              if sys.version_info >=3D (3, 6):
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 9a3e32ac..4bf1809b 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -345,7 +345,7 @@ class BBCooker:
>                      sync=3DFalse,
>                      upstream=3Dupstream,
>                  )
> -                self.hashserv.serve_as_process()
> +                self.hashserv.serve_as_process(log_level=3Dlogging.WARNI=
NG)
>              for mc in self.databuilder.mcdata:
>                  self.databuilder.mcorigdata[mc].setVar("BB_HASHSERVE",
> self.hashservaddr)
>                  self.databuilder.mcdata[mc].setVar("BB_HASHSERVE",
> self.hashservaddr)
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 6168eb18..62d3b5a0 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -130,7 +130,7 @@ class PRServSingleton(object):
>      def start(self):
>          self.prserv =3D PRServer(self.dbfile)
>          self.prserv.start_tcp_server(socket.gethostbyname(self.host),
> self.port)
> -        self.process =3D self.prserv.serve_as_process()
> +        self.process =3D
> self.prserv.serve_as_process(log_level=3Dlogging.WARNING)
>
>          if not self.prserv.address:
>              raise PRServiceConfigError
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15505):
> https://lists.openembedded.org/g/bitbake-devel/message/15505
> Mute This Topic: https://lists.openembedded.org/mt/102509062/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ffddcc060a2cace4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!<div><br></div><div>Tested-by:=C2=A0Martin Jansa &l=
t;<a href=3D"mailto:Martin.Jansa@gmail.com">Martin.Jansa@gmail.com</a>&gt;<=
br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Fri, Nov 10, 2023 at 4:50=E2=80=AFPM Joshua Watt &lt;<a href=3D=
"mailto:JPEWhacker@gmail.com">JPEWhacker@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">When running an asyncrpc =
server as a subprocess, it is often desired to<br>
run it with a lower logging level since the normal logging of clients<br>
connecting and disconnecting is not desired.<br>
<br>
As such, add an option to set the logging level of the server when<br>
running as a subprocess and set the level to WARNING when starting a<br>
local hashserver or PRserver<br>
<br>
Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" targ=
et=3D"_blank">JPEWhacker@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/asyncrpc/serv.py | 5 ++++-<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0lib/prserv/serv.py=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A03 files changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py<br>
index 5fed1730..f0be9a6c 100644<br>
--- a/lib/bb/asyncrpc/serv.py<br>
+++ b/lib/bb/asyncrpc/serv.py<br>
@@ -322,7 +322,7 @@ class AsyncServer(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.loop =3D asyncio.new_event_loop()<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asyncio.set_event_loop(self.loop)<br>
<br>
-=C2=A0 =C2=A0 def serve_as_process(self, *, prefunc=3DNone, args=3D()):<br=
>
+=C2=A0 =C2=A0 def serve_as_process(self, *, prefunc=3DNone, args=3D(), log=
_level=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Serve requests in a child process<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -351,6 +351,9 @@ class AsyncServer(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if prefunc is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefunc(self,=
 *args)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if log_level is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.setLev=
el(log_level)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._serve_forever(tasks)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if sys.version_info &gt;=3D=
 (3, 6):<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index 9a3e32ac..4bf1809b 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -345,7 +345,7 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sync=3DFalse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0upstream=3Dupstream,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.hashserv.serv=
e_as_process()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.hashserv.serv=
e_as_process(log_level=3Dlogging.WARNING)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for mc in self.databuilder.=
mcdata:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.databuil=
der.mcorigdata[mc].setVar(&quot;BB_HASHSERVE&quot;, self.hashservaddr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.databuil=
der.mcdata[mc].setVar(&quot;BB_HASHSERVE&quot;, self.hashservaddr)<br>
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py<br>
index 6168eb18..62d3b5a0 100644<br>
--- a/lib/prserv/serv.py<br>
+++ b/lib/prserv/serv.py<br>
@@ -130,7 +130,7 @@ class PRServSingleton(object):<br>
=C2=A0 =C2=A0 =C2=A0def start(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.prserv =3D PRServer(self.dbfile)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.prserv.start_tcp_server(socket.getho=
stbyname(self.host), self.port)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process =3D self.prserv.serve_as_process(=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process =3D self.prserv.serve_as_process(=
log_level=3Dlogging.WARNING)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.prserv.address:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise PRServiceConfigError<=
br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15505): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15505" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15505</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102509062/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102509062/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000ffddcc060a2cace4--

