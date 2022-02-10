Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1081C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 14:55:10 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by mx.groups.io with SMTP id smtpd.web10.11091.1644504909649983353
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 06:55:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SCwum4D7;
 spf=pass (domain: gmail.com, ip: 209.85.217.43,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-vs1-f43.google.com with SMTP id r20so6766013vsn.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cjt/2zfT+NOS3fMAOJ7GVVTrXugkMBr7DeDtCIWijp8=;
        b=SCwum4D7K6WHGnorQg0LRqLz1T1rA503vSFsG4itrXuS+1X0mlu1NC70d0QVyPPalG
         rx+Mu3WG85gbxTZg0ov9nYU25FxL3YhKA1tuKsT7PY9YI9Y2BTFldxdJWyn0BFwARZTk
         mJRYuJaDWwxn0H3U4zE29z7dzb0x53zqRJW33o5eAJZH5KG2sHnNnDLysiMp56O3FgqV
         HYJ9NHr5N1Vu2VrIsBz7vSBkciu1BB02VC/5+zWonWTeLFi231EpSmTSvtP3nW0ANWnM
         +rflydXhtNEiIwwO5b/s/vdzDkBNNzrge9U8CiepZiV6XLj3fmaRk1mNh/38D1MyKoun
         l4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjt/2zfT+NOS3fMAOJ7GVVTrXugkMBr7DeDtCIWijp8=;
        b=iZLki5jJL0Hf3biDIDy0jTy9EgcVQB5owBmeVxQrqVni4HC4Np8VWU4lcdY7rUL4L7
         YYasFhc3czPSHD4BnINbRgHX7k2+eoVz+BJYjexBilW9fgg8jiZNLtJdMA6mLLb+vMfb
         p1HYW71jb4vICwuNOS93oRx2UP1442Qp8E6Itp22u4rjBuPsDWeQDpI+p5XHf76Nav2C
         0ZD0xSZLFUe+4bkMboAIVU+jfil5Ylq6LgQWQKVrhkrg0WXy1h6ZGCTYkF+ojNAtDsNy
         2zCsH3uAGx3dURGch5qs4nLBpetPr1s3AzGRG+OaOdArsXDyal5uGRzf7V2mpoevfI7f
         DmBA==
X-Gm-Message-State: AOAM532KHpc9EkcCEXc+Au8AAhSt1Qcl7sYxzA14WCFL1bs4ux2N/1Yq
	8W6IufOP3jKKP9f2hd2p+gdfveioWNHEvqsU7cE=
X-Google-Smtp-Source: 
 ABdhPJzq6Om38BVtVAlU6TONwRxWZdIRepv56ZuXwGCDXcwGoj+PmdUSADNNFb8bH5Ly87oZRGmFuLevSmWgpAqeDaY=
X-Received: by 2002:a05:6102:32cc:: with SMTP id
 o12mr2598176vss.39.1644504908798;
 Thu, 10 Feb 2022 06:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
 <293951644501808@mail.yandex.ru>
 <CAJkqNs1m-Y=q9ss0E0W7eNGdSjZd-orBfreuZnTm=3S6uswQOA@mail.gmail.com>
 <6148401644503498@mail.yandex.ru>
In-Reply-To: <6148401644503498@mail.yandex.ru>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 10 Feb 2022 15:58:19 +0100
Message-ID: 
 <CAJkqNs2i4gdxQT=hO0duZtqbmf6iDbafU=iHQn4=4hXkuaapig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git.py: Check if clonedir is
 correct after shallow tarball clone
To: Pavel Zhukov <pavel@zhukoff.net>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000eb9e5605d7ab22b7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 14:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13335

--000000000000eb9e5605d7ab22b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is this bitbake-selftest output? I tried that but got network issues and
missing branch tag only.
Maybe I'll check it on different machine.

Best regards,
Tomasz Dziendzielski

czw., 10 lut 2022 o 15:40 Pavel Zhukov <pavel@zhukoff.net> napisa=C5=82(a):

> Not really.
> it will either complain [1] if there's not git repository in the parent's
> dirs or replace git remote with the one from recipe_url and fail with [2]
> if build directory is under some git managed directory.
>
> [1]
> Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; git -c
> core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfalse remote failed with exi=
t code
> 128, output:
> fatal: not a git repository (or any parent up to mount point /)
>
> [2]
> bb.fetch2.FetchError: Fetcher failure: Fetch command export
> PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=3D=
false
> clone -n -s
> /tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openembedded.org.bitbake/
> /tmp/bitbake-fetch-hyrcqkrw/unpacked/git/ failed with exit code 128, outp=
ut:
> fatal: repository
> '/tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openembedded.org.bitbake/'
> does not exist
>
>
> --
> Pavel
>
>
>
> 10.02.2022, 15:19, "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com
> >:
>
> Then the first patch is safer, as it will not break build with tarballs
> without vcs.
>
> Best regards,
> Tomasz Dziendzielski
>
> czw., 10 lut 2022 o 15:08 Pavel Zhukov <pavel@zhukoff.net> napisa=C5=82(a=
):
>
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

--000000000000eb9e5605d7ab22b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Is this bitbake-selftest output? I tried that but got=
  network issues and missing branch tag only.</div><div>Maybe I&#39;ll chec=
k it on different machine.</div><div><br></div><div>Best regards,</div><div=
>Tomasz Dziendzielski<br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">czw., 10 lut 2022 o 15:40=C2=A0Pavel Zhukov =
&lt;<a href=3D"mailto:pavel@zhukoff.net">pavel@zhukoff.net</a>&gt; napisa=
=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>=
Not really.<br>it will either complain [1] if there&#39;s not git repositor=
y in the parent&#39;s dirs or replace git remote with the one from recipe_u=
rl and fail with [2] if build directory is under some git managed directory=
.</div><div>=C2=A0</div><div>[1]<div>Fetcher failure: Fetch command export =
PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfa=
lse remote failed with exit code 128, output:</div><div>fatal: not a git re=
pository (or any parent up to mount point /)</div><div>=C2=A0</div><div>[2]=
<div><div>bb.fetch2.FetchError: Fetcher failure: Fetch command export PSEUD=
O_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfalse c=
lone -n -s /tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openembedded.org.b=
itbake/ /tmp/bitbake-fetch-hyrcqkrw/unpacked/git/ failed with exit code 128=
, output:</div><div>fatal: repository &#39;/tmp/bitbake-fetch-hyrcqkrw/down=
load/git2/git.openembedded.org.bitbake/&#39; does not exist</div><div>=C2=
=A0</div></div></div></div><div>=C2=A0</div><div>--=C2=A0</div><div>Pavel</=
div><div>=C2=A0</div><div>=C2=A0</div><div>=C2=A0</div><div>10.02.2022, 15:=
19, &quot;Tomasz Dziendzielski&quot; &lt;<a href=3D"mailto:tomasz.dziendzie=
lski@gmail.com" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt;:</=
div><blockquote><div><div>Then the first patch is safer, as it will not bre=
ak build with tarballs without vcs.</div><div>=C2=A0</div><div>Best regards=
,</div><div>Tomasz Dziendzielski</div></div>=C2=A0<div><div>czw., 10 lut 20=
22 o 15:08=C2=A0Pavel Zhukov &lt;<a href=3D"mailto:pavel@zhukoff.net" rel=
=3D"noopener noreferrer" target=3D"_blank">pavel@zhukoff.net</a>&gt; napisa=
=C5=82(a):</div><blockquote style=3D"border-left:1px solid rgb(204,204,204)=
;margin:0px 0px 0px 0.8ex;padding-left:1ex"><div>This is good question.</di=
v><div>It is possible to provide bitbake with mailformed git repo mirror ta=
rball (manually created one for example with --exclude-vcs flag set or from=
 wrong subdirectory) in that case tar will not return any return code but g=
it.download() will try to replace remote with origin from recipe_url. In wo=
rse case it will replace origin of &quot;upper&quot; git repo (poky?) with =
recipe&#39;s one.<div>=C2=A0</div></div><div>=C2=A0</div><div>--=C2=A0</div=
><div>Pavel</div><div>=C2=A0</div><div>=C2=A0</div><div>=C2=A0</div><div>10=
.02.2022, 14:31, &quot;Alexander Kanavin&quot; &lt;<a href=3D"mailto:alex.k=
anavin@gmail.com" rel=3D"noopener noreferrer" target=3D"_blank">alex.kanavi=
n@gmail.com</a>&gt;:</div><blockquote><p>Wait, doesn&#39;t this mask the re=
al issue? Is it ok that the tarball<br>unpacking failed &#39;for any reason=
&#39;?<br><br>Alex<br><br>On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielsk=
i<br>&lt;<a href=3D"mailto:tomasz.dziendzielski@gmail.com" rel=3D"noopener =
noreferrer" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt; wrote:=
</p><blockquote><br>=C2=A0If shallow tarball clone is used and if tar unpac=
king fails for any<br>=C2=A0reason it might end up with empty directory cre=
ated. Since runfetchcmd<br>=C2=A0does not check any return code we might no=
t detect the issue and we will<br>=C2=A0not clone from git. Then due to mis=
sing hash it will replace main<br>=C2=A0repository&#39;s git remote with th=
e remote of failing recipe.<br><br>=C2=A0To fix this behaviour we&#39;ll ch=
eck if clonedir is not empty and if git<br>=C2=A0dir is the same as clonedi=
r.<br><br>=C2=A0Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"mailto:t=
omasz.dziendzielski@gmail.com" rel=3D"noopener noreferrer" target=3D"_blank=
">tomasz.dziendzielski@gmail.com</a>&gt;<br>=C2=A0Signed-off-by: Jan Brzeza=
nski &lt;<a href=3D"mailto:jan.brzezanski@gmail.com" rel=3D"noopener norefe=
rrer" target=3D"_blank">jan.brzezanski@gmail.com</a>&gt;<br>=C2=A0---<br>=
=C2=A0=C2=A0lib/bb/fetch2/git.py | 11 +++++++++--<br>=C2=A0=C2=A01 file cha=
nged, 9 insertions(+), 2 deletions(-)<br><br>=C2=A0diff --git a/lib/bb/fetc=
h2/git.py b/lib/bb/fetch2/git.py<br>=C2=A0index 30da8e95..ed6ecb64 100644<b=
r>=C2=A0--- a/lib/bb/fetch2/git.py<br>=C2=A0+++ b/lib/bb/fetch2/git.py<br>=
=C2=A0@@ -356,8 +356,15 @@ class Git(FetchMethod):<br><br>=C2=A0=C2=A0=C2=
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
=3D-=3D-<br>=C2=A0</blockquote></blockquote></blockquote></div></blockquote=
></blockquote></div>

--000000000000eb9e5605d7ab22b7--

