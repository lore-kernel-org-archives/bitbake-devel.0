Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A8DC433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 09:57:00 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web12.8456.1636624618459882573
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 01:56:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=glAWxogS;
 spf=pass (domain: gmail.com, ip: 209.85.167.54,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id k37so12898639lfv.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0l6hZkqFSxl8bYFfxQREX5aO6o3bmvDoIDzjhMM9SF8=;
        b=glAWxogSNqrq4ZwnUvCVqg0vLo/CWlSOBikuSI34lHqbYnUIA4ayXDG+fQZDaFK2gS
         B7wUKrchCShR0M+hML9xbAuEhKrZLb6nspHZqOJpxFvyZc/VwMBDJNTWf7KJ5SJjTyfY
         IX946xq3kN4xXy0bwYrp1wjDsAZuKzMVwOP1uATDb9xATwARsP/ch2Uj4QQFpWt45QNa
         2NvXu5ltybhxUYYsyiBmCOKrkiETi9Y+j6Lxk2jWGgnS1XIjZKnr5GTqTT1khNCMzI5O
         cuvDL0wmVBq2gUHSnpxMgiIzpG5kbKF+U2uxAfv7HcoXJnGA+ayvp87PI6765010o/2z
         NZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0l6hZkqFSxl8bYFfxQREX5aO6o3bmvDoIDzjhMM9SF8=;
        b=erFSc73dOWlfaqYI6oIINS1H8nOBn358hN1gII2+LNfp7D76K4u615UE0hY3Hx6Sdk
         CH8BaflzbrUPLtPonCjEzAsiVStmJU03VU8jM9F6EYRfJyGah9APdcO5kB0TZACUnggo
         QNgciYZb32ZV27rOvlaN/fgID44dvgs5DsoE9t3qrKN3VBvY6y9zrOuuxau8muDF3Zc6
         Cvpfgv9rtFr3rUYELs8g2QE1LBPCNFsiLeRaqgZ2VckKFUXiJ+Lu2YX3R0S9RyhqHJ39
         0j+WWpEc6drql3ahnVYtG3tQkDcSZma6EaxhFkssY8KK1aEWx8NcoojajLxc6djkz6Ue
         qa3Q==
X-Gm-Message-State: AOAM531L6HZw0upo0V5H6ZS8siBRl8NSrt8MUir2Pk2CRqrPHTEb+lF2
	oKqLXfyIGUDgkH4Tc5GUE0iLm21pQzk2JyEjiWGiBjSI
X-Google-Smtp-Source: 
 ABdhPJzNVLb/Yjw7IiaQpOLJDS9HL4iJJ4h/5dqZrnbpt2I36aUTtcunKn9JiTUTeJeLt+XrLLXGumrVzV49yckszbw=
X-Received: by 2002:a05:6512:3cf:: with SMTP id
 w15mr5510700lfp.555.1636624616290;
 Thu, 11 Nov 2021 01:56:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636591465.git.steve@sakoman.com>
 <c8c7678eccee16e6c2ac93ae6c5ba74a62e0a9e9.1636591465.git.steve@sakoman.com>
In-Reply-To: 
 <c8c7678eccee16e6c2ac93ae6c5ba74a62e0a9e9.1636591465.git.steve@sakoman.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 11 Nov 2021 09:56:45 +0000
Message-ID: 
 <CANPvuR=Hmz65ttyRxK3x6h_zTW8-QVnHZKst7g=3V+eqQdPh6A@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH] fetch/wget: Add
 timeout for checkstatus calls (30s)
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e27e0805d0805cc8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 09:57:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13001

--000000000000e27e0805d0805cc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steve Sakoman <steve@sakoman.com> escreveu no dia quinta, 11/11/2021 =C3=A0=
(s)
00:45:

> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> We had an issue where a webserver serving sstate had filesystem issues so
> would accept connections but effectively not do anything with them. This
> causes bitbake to hang whilst processing things like sstate objects insid=
e
> the checkstatus() calls. It can be replicated by setting up a server like=
:
>
> socat -u TCP4-LISTEN:NNN,fork OPEN:/dev/null
>
> and pointing SSTATE_MIRRORS in OE at that address.
>
> Adding a timeout to the checkstatus calls of 15s means that whilst the
>

-15
+30

but if we need the commit as in master we can drop this typo


> system will pause, it will then continue and not hang entirely. Since the=
re
> isn't a large transfer here, 30s should be a reasonable response time aft=
er
> which we should fall back to building things ourselves.
>
> [YOCTO #13716]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index f7d1de26..5676d3fd 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -319,7 +319,7 @@ class Wget(FetchMethod):
>              except (TypeError, ImportError, IOError,
> netrc.NetrcParseError):
>                  pass
>
> -            with opener.open(r) as response:
> +            with opener.open(r, timeout=3D30) as response:
>                  pass
>          except urllib.error.URLError as e:
>              if try_again:
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12997):
> https://lists.openembedded.org/g/bitbake-devel/message/12997
> Mute This Topic: https://lists.openembedded.org/mt/86971891/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000e27e0805d0805cc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Steve Sakoman &lt;<a href=3D"mailto:s=
teve@sakoman.com">steve@sakoman.com</a>&gt; escreveu no dia quinta, 11/11/2=
021 =C3=A0(s) 00:45:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">From: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundat=
ion.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<br>
<br>
We had an issue where a webserver serving sstate had filesystem issues so<b=
r>
would accept connections but effectively not do anything with them. This<br=
>
causes bitbake to hang whilst processing things like sstate objects inside<=
br>
the checkstatus() calls. It can be replicated by setting up a server like:<=
br>
<br>
socat -u TCP4-LISTEN:NNN,fork OPEN:/dev/null<br>
<br>
and pointing SSTATE_MIRRORS in OE at that address.<br>
<br>
Adding a timeout to the checkstatus calls of 15s means that whilst the<br><=
/blockquote><div><br></div><div>-15</div><div>+30</div><div><br></div><div>=
but if we need the commit as in master we can drop this typo</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
system will pause, it will then continue and not hang entirely. Since there=
<br>
isn&#39;t a large transfer here, 30s should be a reasonable response time a=
fter<br>
which we should fall back to building things ourselves.<br>
<br>
[YOCTO #13716]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/fetch2/wget.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index f7d1de26..5676d3fd 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -319,7 +319,7 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (TypeError, ImportEr=
ror, IOError, netrc.NetrcParseError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with opener.open(r) as response:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with opener.open(r, timeout=3D30=
) as response:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except urllib.error.URLError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if try_again:<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12997): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12997" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12997</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86971891/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86971891/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--000000000000e27e0805d0805cc8--

