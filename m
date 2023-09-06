Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06ECEE14B1
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 16:41:21 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.web11.3732.1694018472954079859
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Sep 2023 09:41:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=nFt/7dXb;
 spf=pass (domain: gmail.com, ip: 209.85.222.51, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-78a5384a5daso1108028241.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Sep 2023 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694018472; x=1694623272; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWQQuASBC8GuClBH5UmxpXeu96vFf/cRpsvV/ZWI1Hw=;
        b=nFt/7dXbRVxLIwNDlrTFRnMRA7OFwqZ/x4tCag7QSo2lceh0vvmiIMCJatw24SamAF
         UqeUu1YOVTipU4sU3gD0nfBOm6EStn0Mikd+TFLFrXJOn/4hKNodI/dwNL1PxhgB77zW
         ySrnhtODYWYShlKQx6w9KrGNN8kcJ+faLPZFxf2afbu1F0dTa4LKCnd90h6Oqt2DF5+I
         8VT85lyc34fTEeRj7cRk8/U4r6QIpHC99p0nxGN8mYiAgZ5qDJXLSNgqMqpaUt6HISES
         S22Lx6OZnmNbiqk/Gf2BRwApjW9T5A2/pJoQVJ3AmJNT1H/NzHYb6z1uO/1IklqfLZ3a
         HlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018472; x=1694623272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWQQuASBC8GuClBH5UmxpXeu96vFf/cRpsvV/ZWI1Hw=;
        b=SQTQ7h/sL4gOpROx+VDg6a+4rdc3pqn0JJxoiWuByZY5L1pb1ucqhxGmsFJrUqQwVf
         di+A6UaTE7+egTDNYZBKNrdY2YYU9NGYGaZIiQOF6XoO50C1R7q4/TUSwjcPBbde/Spo
         YusiJpQFBd2YUWROP26QEIeQmGARU4wWWW2h8B6o1EPRDyeEa3dkT1jya629mvrR/1Fm
         yvPfbB3cDuMrWHC7t/Q0VAMmUjEuHkoABmPllwLdirLeM7ZOb2KLJTVqowXM9WXqJwVM
         aWyQ/AnzuxgqrhG9MhV1MrPoho7i3bsLwzdVGRzFUbGGXhnLWRT+yCd0+DW5PNbJo368
         TGXg==
X-Gm-Message-State: AOJu0YzV9tx0YJVe3OWmsQxD8YjpMROaChfOT6DGDAU4eV42Kv7bZzY8
	6XyricCd/pAaIrE/JYhnReJJ/G4MYhsiqNnyP84=
X-Google-Smtp-Source: AGHT+IFn+w419heDOpkvRvbt85wTtTerilDb3klqqyJnjS5jSHoNpgSvpbIpoWdARz1l7s2HmUXzNtsFXrWQ7bbZE2A=
X-Received: by 2002:a05:6102:4a6:b0:44d:5104:ff2c with SMTP id
 r6-20020a05610204a600b0044d5104ff2cmr3103758vsa.26.1694018471940; Wed, 06 Sep
 2023 09:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230824083109.1821425-1-Markus.Niebel@ew.tq-group.com>
In-Reply-To: <20230824083109.1821425-1-Markus.Niebel@ew.tq-group.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 6 Sep 2023 17:41:01 +0100
Message-ID: <CANPvuR=8-BicdWNHsgmyBAZDHg7Phj9b2vhnzbo_xEaEb09b+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] bitbake-getvar: Add a
 quiet command line argument
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: bitbake-devel@lists.openembedded.org, oss@ew.tq-group.com, 
	Paulo Neves <ptsneves@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: multipart/alternative; boundary="0000000000004357610604b369a2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Sep 2023 16:41:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15014

--0000000000004357610604b369a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Jose

Markus Niebel <Markus.Niebel@ew.tq-group.com> escreveu no dia quinta,
24/08/2023 =C3=A0(s) 09:59:

> From: Paulo Neves <ptsneves@gmail.com>
>
> bitbake-getvar does not have a way to silence bitbake
> server's logger and that makes the tool hard to use for
> text processing. This is especially true when one wants to
> get a bitbake value to be piped to some other utility and
> instead we get uncontrolled logging messages or warnings
> together with bitbake's variable value.
>
> Example without quiet:
> bitbake-getvar --value MACHINE
> NOTE: Starting bitbake server...
> qemux86-64
>
> With quiet:
> bitbake-getvar --value MACHINE --quiet
> qemux86-64
>
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> (cherry picked from commit af354e975d0b4c26d0e91e3c82946b093bc11b45)
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> ---
>  bin/bitbake-getvar | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
> index 5435a8d7..4a9eb4f3 100755
> --- a/bin/bitbake-getvar
> +++ b/bin/bitbake-getvar
> @@ -25,6 +25,7 @@ if __name__ =3D=3D "__main__":
>      parser.add_argument('-u', '--unexpand', help=3D'Do not expand the va=
lue
> (with --value)', action=3D"store_true")
>      parser.add_argument('-f', '--flag', help=3D'Specify a variable flag =
to
> query (with --value)', default=3DNone)
>      parser.add_argument('--value', help=3D'Only report the value, no
> history and no variable name', action=3D"store_true")
> +    parser.add_argument('-q', '--quiet', help=3D'Silence bitbake server
> logging', action=3D"store_true")
>      args =3D parser.parse_args()
>
>      if args.unexpand and not args.value:
> @@ -35,7 +36,7 @@ if __name__ =3D=3D "__main__":
>          print("--flag only makes sense with --value")
>          sys.exit(1)
>
> -    with bb.tinfoil.Tinfoil(tracking=3DTrue) as tinfoil:
> +    with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot args.qu=
iet)
> as tinfoil:
>          if args.recipe:
>              tinfoil.prepare(quiet=3D2)
>              d =3D tinfoil.parse_recipe(args.recipe)
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14972):
> https://lists.openembedded.org/g/bitbake-devel/message/14972
> Mute This Topic: https://lists.openembedded.org/mt/100931867/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000004357610604b369a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(0,0,0)">Gentle ping.</span><br st=
yle=3D"color:rgb(0,0,0)"><br style=3D"color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(0,0,0)">Jose</span><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Markus Niebel &lt;<a href=3D"mailto:Markus.Ni=
ebel@ew.tq-group.com">Markus.Niebel@ew.tq-group.com</a>&gt; escreveu no dia=
 quinta, 24/08/2023 =C3=A0(s) 09:59:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">From: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail=
.com" target=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
<br>
bitbake-getvar does not have a way to silence bitbake<br>
server&#39;s logger and that makes the tool hard to use for<br>
text processing. This is especially true when one wants to<br>
get a bitbake value to be piped to some other utility and<br>
instead we get uncontrolled logging messages or warnings<br>
together with bitbake&#39;s variable value.<br>
<br>
Example without quiet:<br>
bitbake-getvar --value MACHINE<br>
NOTE: Starting bitbake server...<br>
qemux86-64<br>
<br>
With quiet:<br>
bitbake-getvar --value MACHINE --quiet<br>
qemux86-64<br>
<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" target=
=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
Signed-off-by: Alexandre Belloni &lt;<a href=3D"mailto:alexandre.belloni@bo=
otlin.com" target=3D"_blank">alexandre.belloni@bootlin.com</a>&gt;<br>
(cherry picked from commit af354e975d0b4c26d0e91e3c82946b093bc11b45)<br>
Signed-off-by: Markus Niebel &lt;<a href=3D"mailto:Markus.Niebel@ew.tq-grou=
p.com" target=3D"_blank">Markus.Niebel@ew.tq-group.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-getvar | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar<br>
index 5435a8d7..4a9eb4f3 100755<br>
--- a/bin/bitbake-getvar<br>
+++ b/bin/bitbake-getvar<br>
@@ -25,6 +25,7 @@ if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;-u&#39;, &#39;--unexpand&#39;,=
 help=3D&#39;Do not expand the value (with --value)&#39;, action=3D&quot;st=
ore_true&quot;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;-f&#39;, &#39;--flag&#39;, hel=
p=3D&#39;Specify a variable flag to query (with --value)&#39;, default=3DNo=
ne)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--value&#39;, help=3D&#39;Only=
 report the value, no history and no variable name&#39;, action=3D&quot;sto=
re_true&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-q&#39;, &#39;--quiet&#39;, help=3D=
&#39;Silence bitbake server logging&#39;, action=3D&quot;store_true&quot;)<=
br>
=C2=A0 =C2=A0 =C2=A0args =3D parser.parse_args()<br>
<br>
=C2=A0 =C2=A0 =C2=A0if args.unexpand and not args.value:<br>
@@ -35,7 +36,7 @@ if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;--flag only makes sense with =
--value&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
<br>
-=C2=A0 =C2=A0 with bb.tinfoil.Tinfoil(tracking=3DTrue) as tinfoil:<br>
+=C2=A0 =C2=A0 with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot=
 args.quiet) as tinfoil:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.recipe:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tinfoil.prepare(quiet=3D2)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D tinfoil.parse_recipe(=
args.recipe)<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14972): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14972" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14972</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100931867/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100931867/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div>

--0000000000004357610604b369a2--

