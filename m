Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA05C4332F
	for <webhook@archiver.kernel.org>; Mon, 17 Oct 2022 16:07:34 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.43041.1666022844916362144
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Oct 2022 09:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Yo03Cg9P;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so13039239wme.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Oct 2022 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KD0mZhm4CtpO1dz5kP6+0T2qGo6XgezWOy5sQHt5y0g=;
        b=Yo03Cg9POdzxX90A0n8yYFNDsbCI2N/4LTvQwZVCD2q81wxR2EiJQJ9lrDqQ4D8L5P
         gaIZ5XqNxtl8esnTJobeQIell9rbPvwEtTPgobXB7pVtaG7wRF8tPNilSKdkkg5zTjGW
         Yc93bM83RLDueWHbdEjTX5j+pDNfWOgLrVFeTaG3Vo1iVTcdf0+t70YRk6Ux6I1kj5Zg
         JKjbn8TTmIwz7L58brUICyH//EHXJAIr912jb5dgiHGQdGGjtOnXXDPl412tm8pE/h6O
         r0BJOjRCK+EcdOfAwxHNmNPLQOdTeD83Bojx+rxh7c8l53H2SCtZPetVbvAZ43n4VjKK
         Rs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KD0mZhm4CtpO1dz5kP6+0T2qGo6XgezWOy5sQHt5y0g=;
        b=OXIXDxKOmah/QVSckGWxl8lVGvjQqbtRNEH/8XOmYiUZiOqQWMLNtGKAe+OYkpZPc5
         JOjek9IDe47HQfKCCjF8XU47GhfGg0x3XAIr6XKsVwwfNU57mKKN2eyKM5TiKJJEo1LB
         zX+bX+7Ud7iLxuufvTU9uX1phv5dTM4WTkkYd1KqY/pC57z9p/bzHS2zVYARPgNyBfP6
         e6PTe35r4lVQjmDB5PdDAzmBRPkUyYPpd6rNVxmUZjbcBM48zf229pY2nZH1EJ5N6qEG
         HTbrSH0ktz5XSOfnkvjhLQ7zL1X/UK4eAUtsCAfxBBYkiZYXFL8gTU3owmVgy0gKgvdt
         QZsw==
X-Gm-Message-State: ACrzQf0hItg1N5AwOUjlI2KsElSHwNjcV+Y858YqQMQMKCGum+e70o/d
	xp4qRfJOR3Stc6J/ICXgFA/uJvFyPmrY2hgKtMo=
X-Google-Smtp-Source: AMsMyM5zBPDbOsotu6iYO8D7XLxF48Td0SHXHt6t/BLXnXWc1moEToT8e0lEOISMQb1g4pbOnusUmbwLtLe9zbRpo3w=
X-Received: by 2002:a7b:cd15:0:b0:3c5:1b4c:7632 with SMTP id
 f21-20020a7bcd15000000b003c51b4c7632mr20253343wmj.2.1666022843184; Mon, 17
 Oct 2022 09:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <171EDDD869A66677.2422@lists.openembedded.org>
In-Reply-To: <171EDDD869A66677.2422@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 17 Oct 2022 18:07:09 +0200
Message-ID: <CA+chaQfhSrOJB-4u23XsryLwvm+XXE3uMCp+DYpZLW4pP8uhkw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] gitsm: pass lfs parameter from main repo
 to all its submodules
To: Martin.Jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c1797a05eb3d2b47"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Oct 2022 16:07:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14038

--000000000000c1797a05eb3d2b47
Content-Type: text/plain; charset="UTF-8"

This might need a bit more work, it seemed to work, but then I still got
the same failure on different host

First I was assuming it was just stale tarball in PREMIRROR, but even after
cleaning that I didn't get it to work.

Luckily for vulkan-samples we can get away with just explicitly disabling
LFS, so this change isn't needed.

On the other hand vulkan-samples with lfs=0 changed to lfs=1 is good
oe-core reproducer for this smudge issue in submodule.

On Mon, Oct 17, 2022 at 3:20 PM Martin Jansa via lists.openembedded.org
<Martin.Jansa=gmail.com@lists.openembedded.org> wrote:

> * it might not be ideal in some cases where we might require LFS objects
>   only in some of the submodules, but still better than no way to set
>   lfs for submodules which causes git smudge issues in e.g. vulkan-samples
>   when LFS is enabled in gitconfig
>
> [YOCTO #14938]
>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 25d5db0e..36f0464c 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -122,6 +122,7 @@ class GitSM(Git):
>              url += ';protocol=%s' % proto
>              url += ";name=%s" % module
>              url += ";subpath=%s" % module
> +            url += ";lfs=%s" % ud.parm.get("lfs", "1")
>
>              ld = d.createCopy()
>              # Not necessary to set SRC_URI, since we're passing the URI to
> --
> 2.38.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14037):
> https://lists.openembedded.org/g/bitbake-devel/message/14037
> Mute This Topic: https://lists.openembedded.org/mt/94383851/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000c1797a05eb3d2b47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This might need a bit more work, it seemed to work, but th=
en I still got the same failure on different host<div><br></div><div>First =
I was assuming it was just stale tarball in PREMIRROR, but even after clean=
ing that I didn&#39;t get it to work.</div><div><br></div><div>Luckily for =
vulkan-samples we can get away with just explicitly disabling LFS, so this =
change isn&#39;t needed.</div><div><br></div><div>On the other hand vulkan-=
samples with lfs=3D0 changed to lfs=3D1 is good oe-core reproducer for this=
 smudge issue in submodule.</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 17, 2022 at 3:20 PM Martin Jan=
sa via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a>=
 &lt;Martin.Jansa=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gma=
il.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">* it might not be ideal in some cases where we=
 might require LFS objects<br>
=C2=A0 only in some of the submodules, but still better than no way to set<=
br>
=C2=A0 lfs for submodules which causes git smudge issues in e.g. vulkan-sam=
ples<br>
=C2=A0 when LFS is enabled in gitconfig<br>
<br>
[YOCTO #14938]<br>
<br>
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com" t=
arget=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 25d5db0e..36f0464c 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -122,6 +122,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &#39;;protocol=3D%=
s&#39; % proto<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;name=3D%s&q=
uot; % module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;subpath=3D%=
s&quot; % module<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &quot;;lfs=3D%s&quot; %=
 ud.parm.get(&quot;lfs&quot;, &quot;1&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ld =3D d.createCopy()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Not necessary to set SRC_=
URI, since we&#39;re passing the URI to<br>
-- <br>
2.38.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14037): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14037" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14037</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/94383851/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/94383851/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000c1797a05eb3d2b47--

