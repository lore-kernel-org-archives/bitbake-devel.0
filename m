Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B5EE49A8
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 07:29:09 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.5316.1692430141795464261
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Aug 2023 00:29:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=dpUtm3K7;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fee769fcc3so537745e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 19 Aug 2023 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692430140; x=1693034940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2L3XvPGPfPSURQ92u9cmVUW8GQTkol4xxBHL3+GIYA=;
        b=dpUtm3K7Vj+vMC69zlRzK3l70fciiuBF3gQ02R4te/5TMJAlzm6PcCFz29tvikPdvy
         EzDfxYls/llASRT08rLEp5zb3sw0Hl5DShbYnp2+tZDOjCZJUrJf/I4DZHX4Q2TEDa7p
         XJb6rsyvIETijkZ6C4kq3Ba2SoAOEV2HHSL9g5GsFuSf1VFLZbpF9HkgtQu8W70Q35h1
         JMppu0CuEpkKPp/At4qDoDpqz0ZM1SfJn+pa2ThYwAJhKhJcku7DwNDOMmpiOc56hXmw
         xVPoA593DW/v/gEmzgj1daS13mb94zqQZBnfzYNZUScGLVK/fqFqIU1z4ilz+3YW1PtK
         u8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692430140; x=1693034940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2L3XvPGPfPSURQ92u9cmVUW8GQTkol4xxBHL3+GIYA=;
        b=DErcB2PNdMd/xRmA0ZaayFKsEPIphQyyMTLXQfKIDX37vaKNRJ6FgQz0QRKqhB8slT
         zfneCvcOqU63XYpIzVvMnMDmX5HSmGjKf7PKMZhQ/VLv6lwG6ZvkbahSF7OO+rD/y0Um
         Q+E+fF10o6OpxYkW6aIubO8hqtwtO2HQrzSv+vcysfBBCKnbd7kHOWFkZSdtssbFRLFr
         Ybt7lCW18m/iicOr4Ao8mYcEnviZybnocgnd8ogE6yFNsfhCJIJQg0ubW4Mz7KgQCadc
         sAFw7+Gl4iuFxCLzmPSfryeWtgjKoZ1/SkPVinFDZy3huViPUmZgd5cGXjbFJ381Cimr
         p38Q==
X-Gm-Message-State: AOJu0YyIhbOEgSgYZPVocEAKCk0mBb1vlwZc3z+qB6IssBu+HxIsotdn
	sR7elloWiCGWsQyxDS//ahSKvGflxSMfwQXf8T8=
X-Google-Smtp-Source: AGHT+IEhXC31ecfo1CIy72jIgq6931Moc2YQTywFxY7GC+rXTbb3MaT27DSbN9I1bfuoFftrNz5kFJMhPE09F7i2PnY=
X-Received: by 2002:a5d:5242:0:b0:319:71be:9248 with SMTP id
 k2-20020a5d5242000000b0031971be9248mr1020535wrc.19.1692430139794; Sat, 19 Aug
 2023 00:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230819001011.3226247-1-rs@ti.com>
In-Reply-To: <20230819001011.3226247-1-rs@ti.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 19 Aug 2023 09:28:48 +0200
Message-ID: <CA+chaQfVYq93epWPuSrJHnU_gfgG_=Ria+XvPCNtPCD4jf6o-A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] gitsm: tolerate git-lfs in submodules
To: rs@ti.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004a2c3d06034199b2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Aug 2023 07:29:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14954

--0000000000004a2c3d06034199b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please add [YOCTO #14938] tag as this might help with that ticket.

On Sat, Aug 19, 2023 at 2:10=E2=80=AFAM Randolph Sapp via lists.openembedde=
d.org
<rs=3Dti.com@lists.openembedded.org> wrote:

> From: Randolph Sapp <rs@ti.com>
>
> Explicitly pass down the lfs parameter from the source repo URI to
> submodules. Add smudge skip to final checkout phase to make sure we
> don't access the network here. Everything should have been fetched and
> setup from the lfs logic in the git fetcher at this point.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  lib/bb/fetch2/gitsm.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 47225b97..a87361cc 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -123,6 +123,7 @@ class GitSM(Git):
>              url +=3D ";name=3D%s" % module
>              url +=3D ";subpath=3D%s" % module
>              url +=3D ";nobranch=3D1"
> +            url +=3D ";lfs=3D%s" % self._need_lfs(ud)
>              # Note that adding "user=3D" here to give credentials to the
>              # submodule is not supported. Since using SRC_URI to give
> git://
>              # URL a password is not supported, one have to use one of th=
e
> @@ -242,10 +243,12 @@ class GitSM(Git):
>          ret =3D self.process_submodules(ud, ud.destdir, unpack_submodule=
s,
> d)
>
>          if not ud.bareclone and ret:
> -            # All submodules should already be downloaded and configured
> in the tree.  This simply sets
> -            # up the configuration and checks out the files.  The main
> project config should remain
> -            # unmodified, and no download from the internet should occur=
.
> -            runfetchcmd("%s submodule update --recursive --no-fetch" %
> (ud.basecmd), d, quiet=3DTrue, workdir=3Dud.destdir)
> +            # All submodules should already be downloaded and configured
> in the tree.  This simply
> +            # sets up the configuration and checks out the files.  The
> main project config should
> +            # remain unmodified, and no download from the internet shoul=
d
> occur. As such, lfs smudge
> +            # should also be skipped as these files were already smudged
> in the fetch stage if lfs
> +            # was enabled.
> +            runfetchcmd("GIT_LFS_SKIP_SMUDGE=3D1 %s submodule update
> --recursive --no-fetch" % (ud.basecmd), d, quiet=3DTrue, workdir=3Dud.des=
tdir)
>
>      def implicit_urldata(self, ud, d):
>          import shutil, subprocess, tempfile
> --
> 2.41.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14953):
> https://lists.openembedded.org/g/bitbake-devel/message/14953
> Mute This Topic: https://lists.openembedded.org/mt/100831879/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000004a2c3d06034199b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please add [YOCTO #14938] tag as this might help with that=
 ticket.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Sat, Aug 19, 2023 at 2:10=E2=80=AFAM Randolph Sapp via <a href=
=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;rs=3D<a h=
ref=3D"mailto:ti.com@lists.openembedded.org">ti.com@lists.openembedded.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">F=
rom: Randolph Sapp &lt;<a href=3D"mailto:rs@ti.com" target=3D"_blank">rs@ti=
.com</a>&gt;<br>
<br>
Explicitly pass down the lfs parameter from the source repo URI to<br>
submodules. Add smudge skip to final checkout phase to make sure we<br>
don&#39;t access the network here. Everything should have been fetched and<=
br>
setup from the lfs logic in the git fetcher at this point.<br>
<br>
Signed-off-by: Randolph Sapp &lt;<a href=3D"mailto:rs@ti.com" target=3D"_bl=
ank">rs@ti.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 11 +++++++----<br>
=C2=A01 file changed, 7 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 47225b97..a87361cc 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -123,6 +123,7 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;name=3D%s&q=
uot; % module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;subpath=3D%=
s&quot; % module<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url +=3D &quot;;nobranch=3D=
1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 url +=3D &quot;;lfs=3D%s&quot; %=
 self._need_lfs(ud)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Note that adding &quot;us=
er=3D&quot; here to give credentials to the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# submodule is not supporte=
d. Since using SRC_URI to give git://<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# URL a password is not sup=
ported, one have to use one of the<br>
@@ -242,10 +243,12 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D self.process_submodules(ud, ud.de=
stdir, unpack_submodules, d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.bareclone and ret:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # All submodules should already =
be downloaded and configured in the tree.=C2=A0 This simply sets<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # up the configuration and check=
s out the files.=C2=A0 The main project config should remain<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # unmodified, and no download fr=
om the internet should occur.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%s submodule u=
pdate --recursive --no-fetch&quot; % (ud.basecmd), d, quiet=3DTrue, workdir=
=3Dud.destdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # All submodules should already =
be downloaded and configured in the tree.=C2=A0 This simply<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # sets up the configuration and =
checks out the files.=C2=A0 The main project config should<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # remain unmodified, and no down=
load from the internet should occur. As such, lfs smudge<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # should also be skipped as thes=
e files were already smudged in the fetch stage if lfs<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # was enabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;GIT_LFS_SKIP_S=
MUDGE=3D1 %s submodule update --recursive --no-fetch&quot; % (ud.basecmd), =
d, quiet=3DTrue, workdir=3Dud.destdir)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def implicit_urldata(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import shutil, subprocess, tempfile<br>
-- <br>
2.41.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14953): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14953" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14953</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100831879/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100831879/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000004a2c3d06034199b2--

