Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28A1C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 15:22:53 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.16200.1713367364073735607
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 08:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ksR+nM/I;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so3874720a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367363; x=1713972163; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSpXDnJ0sger/Ey3XuRqKjIBIaoXYAgQSPAOjpnuZZY=;
        b=ksR+nM/Imui49mT/Je53lXqNdqlVNJ1fuz1Rj2D+qwV1N7GzClE4Izl3pk9vUz8BF2
         QvCBOLOdiIJ5MxlMs3wM+xWPyS1y4TcSQpXOnSWskz3hYyDCO08iijZ2on56GZZzuc7P
         ZDrZd8y12lNoJsULtZg2Gqq/J5HQQ8U8WL1MYlCchoRwpb1l9XzJomrbMXw/47FBfW54
         UaqNpakwMLoZN4jLHX26SZmUk80xnXPHWCLPIlv+cbc5IHK1JxyfEqGFgz1rM6JAYYNn
         sVrdl4icd+pVRm4hNVdSxdUtJGLaR+JJYtcdFq6pU5ta22yio5Q6OCgTm15zkAnWcQAY
         FW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367363; x=1713972163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSpXDnJ0sger/Ey3XuRqKjIBIaoXYAgQSPAOjpnuZZY=;
        b=cVS5F6EQtVS1m3ezGwdKqUKlKA+NP1iuchiVeaodSsk5vVYDFA845eARZXRBm6Gj+M
         wPMoVO4NHd02W6+PK1RFCX6xWZNoAtWhE4v5DDsV6A9mW/cxVH+Mziwr+ops1WHcCKF9
         U3FVUrYv4+tjTC3OL7f9qauxNYEKteMHVwJEIw89/BTCCtGX2mNN976k7883TA/S09Dj
         rEhxUusYEU52c83eGxGyw5XHTHZ2LRc1JEsy8Qu4Qqz+/cVyJFP8JgUmYvqGWnmNEGWA
         G7JurebDQ3bNtqGue+LRmBSFtWjlii5hT+8SCr9XC48maLZR2gjTOAr052MKmqwNkSmO
         XPLg==
X-Gm-Message-State: AOJu0YzQ8gA4i05THZDtqr+XeMVKbeHRvh3hN5SpupatNE+qVPypKu8V
	TfkzxIvf6MJ8ZBSZyk/ig+WRiKbC2Fj8J+7HrfsecZCvJy+kgGWelbH7fTUPExfeKFQ644RKSkG
	b8oWiiMc3gnv2JtGanAXfF3pRM4TaiQ==
X-Google-Smtp-Source: AGHT+IHnLkdpE0LTsfN+2zkSHYmyZ/7I5YoQBVDGrpzA0LliiefANIBVhQEgUTYwqRD3i4pTJzR5+xjNI1efeI0xjrE=
X-Received: by 2002:a17:902:d549:b0:1e2:1df:449b with SMTP id
 z9-20020a170902d54900b001e201df449bmr16100353plf.69.1713367363296; Wed, 17
 Apr 2024 08:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
In-Reply-To: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 17 Apr 2024 11:22:32 -0400
Message-ID: <CADkTA4OGUQ3YMGmByutt6trmHN=3pFdABW3Jkh33RQgreCFeCg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 00/12] prserv: add support for an
 "upstream" server
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000f242506164c6d4f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 15:22:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16108

--0000000000000f242506164c6d4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org <michael.opdenacker=3D
bootlin.com@lists.openembedded.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This makes it possible to customize an "upstream" distribution
> by modifying local packages. If the "upstream" package bears
> revision "x", the local one will have revision "x.y", this
> having priority over the upstream one.
>
> Multiple levels of upstream servers are supported, so "x.y.z" revisions
> are possible too.
>
> Take advantage of this work to clean-up and update the prserv code too.
>
> Manual "sanity" tests have been run so far but automated tests
> (based on Python unittest, as for the hash server tests)
> are being prepared for the next iteration. They will also to
> test also supported scenarios.
>
> Code reviews are welcome, especially for more Pythonic
> ways of implementing some details.
>
>
I went through the code and commented on a few of the
larger patches.

I can't say that I'm an expert in the existing PR server and
I don't tend to write overly pythonic code .. but I did look
through things and can add:

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>




> ---
>
> Changes in V3:
>
> - Revert the commit removing the so far unused "hist" mode, which
>   we wish to keep for binary reproducibility sake.
>
> - Simplification of get_value() function to take
>   both "hist" and "nohist" modes with the same shared code.
>
> - Add "history" parameter to the "getPR" request,
>   so that the client can ask for the mode of its choice.
>   This will also make it possible to implement tests
>   for both modes.
>
>   Note that more requests ("export", "import"...)
>   will also need a "history" parameter, in a future version,
>   after the first tests are implemented.
>
> - Several fixes to bugs either present in V2 or introduced
>   by the V3 code changes.
>
> - Put all the new features at the tip of the branch,
>   to make the cleanup commits easier to merged.
>
> Changes in V2:
>
> - Add this new commit:
>   prserv: remove unused "hist" mode in the database backend
>
> - Squash commit "prserv: fix read_only test" into
>   commit "prserv: simplify the PRServerClient() interface"
>   (Reported by Richard Purdie)
>
> - Fix the code to support increasing "x.y.z" values, thus
>   supporting several levels of upstream servers.
>
> - db.py: remove duplicate definition of find_max_value() function in db.p=
y
>
> - prserv.py: remove tabs before comments (Python didn't complain)
>
> - db.py: now stores the revision ("value") as TEXT.
>   This way we can store "1.0" without having it transformed to "1"
>   when the default type was INTEGER.
>
> - This allows to fix a regression when the first packages were created
>   with 'r0.1' instead of 'r0.0' initially.
>
> - find_max_value: now returns None instead of '0' when no value is found
>   Before we couldn't tell the difference between a '0'
>   max value and the absence of such a value.
>
> Michael Opdenacker (12):
>   prserv: simplify the PRServerClient() interface
>   prserv: use double quotes by default
>   bitbake-prserv: replace deprecated optparse by argparse
>   prserv: use self.logger instead of logger directly
>   asyncrpc: include parse_address from hashserv
>   prserv: capitalization and spacing improvements
>   prserv: add extra requests
>   prserv: remove redundant exception handler
>   prserv: correct error message
>   prserv: remove unnecessary code
>   prserv: add "upstream" server support
>   prserv: add "history" argument to "get-pr" request
>
>  bin/bitbake-prserv        |  99 ++++++++++++-----
>  lib/bb/asyncrpc/client.py |  23 ++++
>  lib/hashserv/__init__.py  |  27 +----
>  lib/prserv/__init__.py    |  21 +++-
>  lib/prserv/client.py      |  44 ++++++--
>  lib/prserv/db.py          | 225 ++++++++++++++++++++++----------------
>  lib/prserv/serv.py        | 220 ++++++++++++++++++++++++++-----------
>  7 files changed, 436 insertions(+), 223 deletions(-)
>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16075):
> https://lists.openembedded.org/g/bitbake-devel/message/16075
> Mute This Topic: https://lists.openembedded.org/mt/105479088/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000000f242506164c6d4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opd=
enacker via <a href=3D"http://lists.openembedded.org">lists.openembedded.or=
g</a> &lt;michael.opdenacker=3D<a href=3D"mailto:bootlin.com@lists.openembe=
dded.org">bootlin.com@lists.openembedded.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: Michael Opdenacker &lt;<a=
 href=3D"mailto:michael.opdenacker@bootlin.com" target=3D"_blank">michael.o=
pdenacker@bootlin.com</a>&gt;<br>
<br>
This makes it possible to customize an &quot;upstream&quot; distribution<br=
>
by modifying local packages. If the &quot;upstream&quot; package bears<br>
revision &quot;x&quot;, the local one will have revision &quot;x.y&quot;, t=
his<br>
having priority over the upstream one.<br>
<br>
Multiple levels of upstream servers are supported, so &quot;x.y.z&quot; rev=
isions<br>
are possible too.<br>
<br>
Take advantage of this work to clean-up and update the prserv code too.<br>
<br>
Manual &quot;sanity&quot; tests have been run so far but automated tests<br=
>
(based on Python unittest, as for the hash server tests)<br>
are being prepared for the next iteration. They will also to<br>
test also supported scenarios.<br>
<br>
Code reviews are welcome, especially for more Pythonic<br>
ways of implementing some details.<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">I went through the code and commented on a few of the</div=
><div class=3D"gmail_default" style=3D"font-size:small">larger patches.</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">I can&#39;t say that I&#39;m=
 an expert in the existing PR server and</div><div class=3D"gmail_default" =
style=3D"font-size:small">I don&#39;t tend to write overly pythonic code ..=
 but I did look</div><div class=3D"gmail_default" style=3D"font-size:small"=
>through things and can add:</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Reviewed-by: Bruce Ashfield &lt;<a href=3D"mailto:bruce.ashfield@gmail.=
com">bruce.ashfield@gmail.com</a>&gt;</div><div class=3D"gmail_default" sty=
le=3D"font-size:small"><br></div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
---<br>
<br>
Changes in V3:<br>
<br>
- Revert the commit removing the so far unused &quot;hist&quot; mode, which=
<br>
=C2=A0 we wish to keep for binary reproducibility sake.<br>
<br>
- Simplification of get_value() function to take<br>
=C2=A0 both &quot;hist&quot; and &quot;nohist&quot; modes with the same sha=
red code.<br>
<br>
- Add &quot;history&quot; parameter to the &quot;getPR&quot; request,<br>
=C2=A0 so that the client can ask for the mode of its choice.<br>
=C2=A0 This will also make it possible to implement tests<br>
=C2=A0 for both modes.<br>
<br>
=C2=A0 Note that more requests (&quot;export&quot;, &quot;import&quot;...)<=
br>
=C2=A0 will also need a &quot;history&quot; parameter, in a future version,=
<br>
=C2=A0 after the first tests are implemented.<br>
<br>
- Several fixes to bugs either present in V2 or introduced<br>
=C2=A0 by the V3 code changes.<br>
<br>
- Put all the new features at the tip of the branch,<br>
=C2=A0 to make the cleanup commits easier to merged.<br>
<br>
Changes in V2:<br>
<br>
- Add this new commit:<br>
=C2=A0 prserv: remove unused &quot;hist&quot; mode in the database backend<=
br>
<br>
- Squash commit &quot;prserv: fix read_only test&quot; into<br>
=C2=A0 commit &quot;prserv: simplify the PRServerClient() interface&quot;<b=
r>
=C2=A0 (Reported by Richard Purdie)<br>
<br>
- Fix the code to support increasing &quot;x.y.z&quot; values, thus<br>
=C2=A0 supporting several levels of upstream servers.<br>
<br>
- db.py: remove duplicate definition of find_max_value() function in db.py<=
br>
<br>
- prserv.py: remove tabs before comments (Python didn&#39;t complain)<br>
<br>
- db.py: now stores the revision (&quot;value&quot;) as TEXT.<br>
=C2=A0 This way we can store &quot;1.0&quot; without having it transformed =
to &quot;1&quot;<br>
=C2=A0 when the default type was INTEGER.<br>
<br>
- This allows to fix a regression when the first packages were created<br>
=C2=A0 with &#39;r0.1&#39; instead of &#39;r0.0&#39; initially.<br>
<br>
- find_max_value: now returns None instead of &#39;0&#39; when no value is =
found<br>
=C2=A0 Before we couldn&#39;t tell the difference between a &#39;0&#39;<br>
=C2=A0 max value and the absence of such a value.<br>
<br>
Michael Opdenacker (12):<br>
=C2=A0 prserv: simplify the PRServerClient() interface<br>
=C2=A0 prserv: use double quotes by default<br>
=C2=A0 bitbake-prserv: replace deprecated optparse by argparse<br>
=C2=A0 prserv: use self.logger instead of logger directly<br>
=C2=A0 asyncrpc: include parse_address from hashserv<br>
=C2=A0 prserv: capitalization and spacing improvements<br>
=C2=A0 prserv: add extra requests<br>
=C2=A0 prserv: remove redundant exception handler<br>
=C2=A0 prserv: correct error message<br>
=C2=A0 prserv: remove unnecessary code<br>
=C2=A0 prserv: add &quot;upstream&quot; server support<br>
=C2=A0 prserv: add &quot;history&quot; argument to &quot;get-pr&quot; reque=
st<br>
<br>
=C2=A0bin/bitbake-prserv=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 99 ++++++++++++=
-----<br>
=C2=A0lib/bb/asyncrpc/client.py |=C2=A0 23 ++++<br>
=C2=A0lib/hashserv/__init__.py=C2=A0 |=C2=A0 27 +----<br>
=C2=A0lib/prserv/__init__.py=C2=A0 =C2=A0 |=C2=A0 21 +++-<br>
=C2=A0lib/prserv/client.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 44 ++++++--<br>
=C2=A0lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 225 ++++++++++++=
++++++++++----------------<br>
=C2=A0lib/prserv/serv.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 220 +++++++++++++++++=
+++++++++-----------<br>
=C2=A07 files changed, 436 insertions(+), 223 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16075): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16075" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16075</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105479088/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105479088/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">- =
Thou shalt not follow the NULL pointer, for chaos and madness await thee at=
 its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br><b=
r></div></div>

--0000000000000f242506164c6d4f--

