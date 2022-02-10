Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF57C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 14:19:03 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web12.10799.1644502742480753922
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 06:19:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=el4JHg+1;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id d22so3095215uaw.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 06:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eO1XKf7buUMrWGsIKl+w5lbndCs7QhcO6eBrBN9vaGg=;
        b=el4JHg+17lsZkKceLqpf/4h85suIOurwh+xmOUOXg1i+jbWhjO1ejfj+MqMMA5RHYg
         4Z/K4mxgP4sQNcTL8M/xBFMGVf7l8LWoMrDhKNB9mCXY++joPxDAIGYmAeQWRGz31qTs
         drl45ACs5dcnf0ADk/lBbsmqkvw/vVaUwEKIt34sS5DdwD9rcUBoj/dVvYFSDI9trgxc
         Jb+ZEfm7O2iJH2EJkAwyOwquzUjCLxLAKdxZrTlaIbxc/XCjScFhi9glfxtPQe11qf/I
         PKLYaY9v1Le/MhHMcqSnua2uxVLvoRdugBehs+ZJvd14ffZ+kVMBQ+RhmnuzqtcVkUPP
         TyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO1XKf7buUMrWGsIKl+w5lbndCs7QhcO6eBrBN9vaGg=;
        b=Jd51PWK95KRquQWcIigLYdzInFgQmEP0vhTLE7jm1AXENdcsIYU4AfgPaTU3fTbr90
         RaurNYImlyDbdvmbdn6HoGOEACgYbm7KwJ5t35fL89VCvCssKAL9zIz5c4uBrIdKj1/O
         gqmK4EvoM6MZ1127PJYwmHC3P0W+eiPtDBNax1z9jT5wuI54RQr/CQbpOzXZjQhm6UsZ
         dNT+5ZO6PRUqir8bgijGLHNZfZGLD7XYKegtTc0b8S22EONpRLuzzzOTXP4BpWi4xKSY
         p/djhXr+5oNiktfqQDHIuy3IUlmPUCJD362X1/Yl47N/9rMa3HzmyvcqpNIywdMMqq30
         eYMQ==
X-Gm-Message-State: AOAM532S4nI3Wqpjmd/Z16hSw8r8fHracQk4IIVUtTMaQOrFqrUMDelJ
	OhLpzMDtDy7A7Nicvh8aDvs/yhdOO3InDLV7ngk=
X-Google-Smtp-Source: 
 ABdhPJzMsR26O95LN6xOhN4rv9FHz5uy6W4Rxzm21B3K8rSrxGEZcp40y/eKJUV1lpOd5fQJbgy+kbwLMW2uU1mhVqI=
X-Received: by 2002:ab0:63c7:: with SMTP id i7mr2406803uap.99.1644502741436;
 Thu, 10 Feb 2022 06:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
 <293951644501808@mail.yandex.ru>
In-Reply-To: <293951644501808@mail.yandex.ru>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 10 Feb 2022 15:22:11 +0100
Message-ID: 
 <CAJkqNs1m-Y=q9ss0E0W7eNGdSjZd-orBfreuZnTm=3S6uswQOA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git.py: Check if clonedir is
 correct after shallow tarball clone
To: Pavel Zhukov <pavel@zhukoff.net>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bc4d3d05d7aaa1d7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 14:19:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13333

--000000000000bc4d3d05d7aaa1d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Then the first patch is safer, as it will not break build with tarballs
without vcs.

Best regards,
Tomasz Dziendzielski

czw., 10 lut 2022 o 15:08 Pavel Zhukov <pavel@zhukoff.net> napisa=C5=82(a):

> This is good question.
> It is possible to provide bitbake with mailformed git repo mirror tarball
> (manually created one for example with --exclude-vcs flag set or from wro=
ng
> subdirectory) in that case tar will not return any return code but
> git.download() will try to replace remote with origin from recipe_url. In
> worse case it will replace origin of "upper" git repo (poky?) with recipe=
's
> one.
>
>
> --
> Pavel
>
>
>
> 10.02.2022, 14:31, "Alexander Kanavin" <alex.kanavin@gmail.com>:
>
> Wait, doesn't this mask the real issue? Is it ok that the tarball
> unpacking failed 'for any reason'?
>
> Alex
>
> On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielski
> <tomasz.dziendzielski@gmail.com> wrote:
>
>
>  If shallow tarball clone is used and if tar unpacking fails for any
>  reason it might end up with empty directory created. Since runfetchcmd
>  does not check any return code we might not detect the issue and we will
>  not clone from git. Then due to missing hash it will replace main
>  repository's git remote with the remote of failing recipe.
>
>  To fix this behaviour we'll check if clonedir is not empty and if git
>  dir is the same as clonedir.
>
>  Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
>  Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
>  ---
>   lib/bb/fetch2/git.py | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
>  diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>  index 30da8e95..ed6ecb64 100644
>  --- a/lib/bb/fetch2/git.py
>  +++ b/lib/bb/fetch2/git.py
>  @@ -356,8 +356,15 @@ class Git(FetchMethod):
>
>           repourl =3D self._get_repo_url(ud)
>
>  - # If the repo still doesn't exist, fallback to cloning it
>  - if not os.path.exists(ud.clonedir):
>  + # Clean repo if git dir is different than ud.clonedir, which means tar
> unpacking failed
>  + if os.path.exists(ud.clonedir):
>  + if ud.clonedir !=3D runfetchcmd("%s -C %s rev-parse --git-dir" %
> (ud.basecmd, ud.clonedir), d):
>  + bb.utils.remove(ud.clonedir, recurse=3DTrue)
>  + bb.utils.mkdirhier(ud.clonedir)
>  + os.chdir(ud.clonedir)
>  +
>  + # If the repo still doesn't exist or is empty, fallback to cloning it
>  + if not os.path.exists(ud.clonedir) or not os.listdir(ud.clonedir):
>               # We do this since git will use a "-l" option automatically
> for local urls where possible
>               if repourl.startswith("file://"):
>                   repourl =3D repourl[7:]
>  --
>  2.34.1
>
>
>  -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>  Links: You receive all messages sent to this group.
>  View/Reply Online (#13328):
> https://lists.openembedded.org/g/bitbake-devel/message/13328
>  Mute This Topic: https://lists.openembedded.org/mt/89045076/1686489
>  Group Owner: bitbake-devel+owner@lists.openembedded.org
>  Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
>  -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000bc4d3d05d7aaa1d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Then the first patch is safer, as it will not break b=
uild with tarballs without vcs.</div><div><br></div><div>Best regards,<br><=
/div><div>Tomasz Dziendzielski<br></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">czw., 10 lut 2022 o 15:08=C2=A0Pave=
l Zhukov &lt;<a href=3D"mailto:pavel@zhukoff.net">pavel@zhukoff.net</a>&gt;=
 napisa=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div>This is good question.</div><div>It is possible to provide bitbake w=
ith mailformed git repo mirror tarball (manually created one for example wi=
th --exclude-vcs flag set or from wrong subdirectory) in that case tar will=
 not return any return code but git.download() will try to replace remote w=
ith origin from recipe_url. In worse case it will replace origin of &quot;u=
pper&quot; git repo (poky?) with recipe&#39;s one.<div>=C2=A0</div></div><d=
iv>=C2=A0</div><div>--=C2=A0</div><div>Pavel</div><div>=C2=A0</div><div>=C2=
=A0</div><div>=C2=A0</div><div>10.02.2022, 14:31, &quot;Alexander Kanavin&q=
uot; &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.k=
anavin@gmail.com</a>&gt;:</div><blockquote><p>Wait, doesn&#39;t this mask t=
he real issue? Is it ok that the tarball<br>unpacking failed &#39;for any r=
eason&#39;?<br><br>Alex<br><br>On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendz=
ielski<br>&lt;<a href=3D"mailto:tomasz.dziendzielski@gmail.com" rel=3D"noop=
ener noreferrer" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt; w=
rote:</p><blockquote><br>=C2=A0If shallow tarball clone is used and if tar =
unpacking fails for any<br>=C2=A0reason it might end up with empty director=
y created. Since runfetchcmd<br>=C2=A0does not check any return code we mig=
ht not detect the issue and we will<br>=C2=A0not clone from git. Then due t=
o missing hash it will replace main<br>=C2=A0repository&#39;s git remote wi=
th the remote of failing recipe.<br><br>=C2=A0To fix this behaviour we&#39;=
ll check if clonedir is not empty and if git<br>=C2=A0dir is the same as cl=
onedir.<br><br>=C2=A0Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"mai=
lto:tomasz.dziendzielski@gmail.com" rel=3D"noopener noreferrer" target=3D"_=
blank">tomasz.dziendzielski@gmail.com</a>&gt;<br>=C2=A0Signed-off-by: Jan B=
rzezanski &lt;<a href=3D"mailto:jan.brzezanski@gmail.com" rel=3D"noopener n=
oreferrer" target=3D"_blank">jan.brzezanski@gmail.com</a>&gt;<br>=C2=A0---<=
br>=C2=A0=C2=A0lib/bb/fetch2/git.py | 11 +++++++++--<br>=C2=A0=C2=A01 file =
changed, 9 insertions(+), 2 deletions(-)<br><br>=C2=A0diff --git a/lib/bb/f=
etch2/git.py b/lib/bb/fetch2/git.py<br>=C2=A0index 30da8e95..ed6ecb64 10064=
4<br>=C2=A0--- a/lib/bb/fetch2/git.py<br>=C2=A0+++ b/lib/bb/fetch2/git.py<b=
r>=C2=A0@@ -356,8 +356,15 @@ class Git(FetchMethod):<br><br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0repourl =3D self._get_repo_url=
(ud)<br><br>=C2=A0- # If the repo still doesn&#39;t exist, fallback to clon=
ing it<br>=C2=A0- if not os.path.exists(ud.clonedir):<br>=C2=A0+ # Clean re=
po if git dir is different than ud.clonedir, which means tar unpacking fail=
ed<br>=C2=A0+ if os.path.exists(ud.clonedir):<br>=C2=A0+ if ud.clonedir !=
=3D runfetchcmd(&quot;%s -C %s rev-parse --git-dir&quot; % (ud.basecmd, ud.=
clonedir), d):<br>=C2=A0+ bb.utils.remove(ud.clonedir, recurse=3DTrue)<br>=
=C2=A0+ bb.utils.mkdirhier(ud.clonedir)<br>=C2=A0+ os.chdir(ud.clonedir)<br=
>=C2=A0+<br>=C2=A0+ # If the repo still doesn&#39;t exist or is empty, fall=
back to cloning it<br>=C2=A0+ if not os.path.exists(ud.clonedir) or not os.=
listdir(ud.clonedir):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# We do this since git will use a &quot=
;-l&quot; option automatically for local urls where possible<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if repourl.startswith(&quot;file://&quot;):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0repourl =3D repourl[7:]<br>=C2=A0--<br>=C2=A02.34.1<br><br><br>=C2=A0=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>=C2=A0Links: You receive a=
ll messages sent to this group.<br>=C2=A0View/Reply Online (#13328): <a hre=
f=3D"https://lists.openembedded.org/g/bitbake-devel/message/13328" rel=3D"n=
oopener noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bitb=
ake-devel/message/13328</a><br>=C2=A0Mute This Topic: <a href=3D"https://li=
sts.openembedded.org/mt/89045076/1686489" rel=3D"noopener noreferrer" targe=
t=3D"_blank">https://lists.openembedded.org/mt/89045076/1686489</a><br>=C2=
=A0Group Owner: <a href=3D"mailto:bitbake-devel+owner@lists.openembedded.or=
g" rel=3D"noopener noreferrer" target=3D"_blank">bitbake-devel+owner@lists.=
openembedded.org</a><br>=C2=A0Unsubscribe: <a href=3D"https://lists.openemb=
edded.org/g/bitbake-devel/unsub" rel=3D"noopener noreferrer" target=3D"_bla=
nk">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"ma=
ilto:alex.kanavin@gmail.com" rel=3D"noopener noreferrer" target=3D"_blank">=
alex.kanavin@gmail.com</a>]<br>=C2=A0-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-<br>=C2=A0</blockquote></blockquote></blockquote></div>

--000000000000bc4d3d05d7aaa1d7--

