Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBFC433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 15:20:54 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web10.11427.1644506452630579351
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 07:20:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NAvoSK+M;
 spf=pass (domain: gmail.com, ip: 209.85.222.49,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-ua1-f49.google.com with SMTP id u77so3171640uau.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTf2doyRH51wRBHYjTZwGssmUK9Xwu5Dv4m9Nv8bXKY=;
        b=NAvoSK+MrAk07rEslDDp+ampE1yZwNqUlc0WH6RdiqyhZ+/EGcGt3R9BSSredkKwmK
         o4Q3awYe1lAmkt9zaJMSqjyQz5b1Z5NwR3IW9UelK9tANCZgmqdgMKrLg99weJkKvp4C
         71JbEXVg6bKmAnkvh8fk7xERCGpjpGbHvnrtWe38rIFBzsLuP7foZ2bOKDICDNurkRg2
         fwt0uyRYwU+3kUwXhj37mJ3eWIMfqjm4pSIMgCy7jovLBS6s+LvLPu4s7/AN8e2RjHiu
         pZPa6YigJBwO7/hHloXf/yzjX7Lexr4YAqJ/q5xUcIsvKWnkgCWbaF683rtMdhqXdUZ5
         Aq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTf2doyRH51wRBHYjTZwGssmUK9Xwu5Dv4m9Nv8bXKY=;
        b=Z1UYOoNt9ECJ5IABzPm40gMQQuPVm6YjN+9tWcW6ZMFGQjqiMrDGp+70qyFBfgYDGg
         hjcQvyUhrd8Smd4MdkrHX494fB6AMFJ3bIsGzLahiA3lc/1KhndpStP4Xbz72egd2vWh
         zPT9ALyXL8/UNcJwlAbPdGZXBehQ9kMmVfjG89eK+rDvTNeEwkrlmEX9VEn/7BVHW+nr
         piYWXInNHit6tpsFYry4kb0Cf1DReZtHacMtvneaDVFEbzoy5ldfzS/WHF3vtmvlqN9v
         fy8U+xQJQaVgD1Ncwi6JXgZ+9AK5FcZJW8Is42x9m92SSuEfdUvL8jZWIUGzRo5KI2x6
         wVmQ==
X-Gm-Message-State: AOAM530HBms/ZBdNCAWanN0xRbTz5SHQnuUqiLFvtzwyxnmoz7vW/YJj
	W03XmHmMjrjoRNXzh80yEMDMxe7mKHWoE58N/Hs=
X-Google-Smtp-Source: 
 ABdhPJwnnsm6q8HVEflkv7FXbZrIKwnFK4UWfXJCCcXdoLH1blEl+DB91pA79dSllYoAY6lzBovFgkOwwWT6ncJlTcw=
X-Received: by 2002:ab0:63c7:: with SMTP id i7mr2507712uap.99.1644506451789;
 Thu, 10 Feb 2022 07:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
 <293951644501808@mail.yandex.ru>
 <CAJkqNs1m-Y=q9ss0E0W7eNGdSjZd-orBfreuZnTm=3S6uswQOA@mail.gmail.com>
 <6148401644503498@mail.yandex.ru>
 <16D27480B462D202.11771@lists.openembedded.org>
In-Reply-To: <16D27480B462D202.11771@lists.openembedded.org>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 10 Feb 2022 16:24:02 +0100
Message-ID: 
 <CAJkqNs3LTQZkDqpmObPG24aLdqVaOTU_9YGL7yFz-YOZrw+Ubg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git.py: Check if clonedir is
 correct after shallow tarball clone
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Pavel Zhukov <pavel@zhukoff.net>,
 Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e3cd0b05d7ab7ed8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 15:20:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13336

--000000000000e3cd0b05d7ab7ed8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 I just double checked and with the first patch bitbake-selftest is failing
with two errors that appear also without my changes, something about
missing hash on branch. Where did you take that logs so I could check it
and fix the patch?

Best regards,
Tomasz Dziendzielski

czw., 10 lut 2022 o 15:55 Tomasz Dziendzielski via lists.openembedded.org
<tomasz.dziendzielski=3Dgmail.com@lists.openembedded.org> napisa=C5=82(a):

> Is this bitbake-selftest output? I tried that but got network issues and
> missing branch tag only.
> Maybe I'll check it on different machine.
>
> Best regards,
> Tomasz Dziendzielski
>
> czw., 10 lut 2022 o 15:40 Pavel Zhukov <pavel@zhukoff.net> napisa=C5=82(a=
):
>
>> Not really.
>> it will either complain [1] if there's not git repository in the parent'=
s
>> dirs or replace git remote with the one from recipe_url and fail with [2=
]
>> if build directory is under some git managed directory.
>>
>> [1]
>> Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; git -c
>> core.fsyncobjectfiles=3D0 -c gc.autoDetach=3Dfalse remote failed with ex=
it code
>> 128, output:
>> fatal: not a git repository (or any parent up to mount point /)
>>
>> [2]
>> bb.fetch2.FetchError: Fetcher failure: Fetch command export
>> PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.autoDetach=
=3Dfalse
>> clone -n -s
>> /tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openembedded.org.bitbake/
>> /tmp/bitbake-fetch-hyrcqkrw/unpacked/git/ failed with exit code 128, out=
put:
>> fatal: repository
>> '/tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openembedded.org.bitbake/=
'
>> does not exist
>>
>>
>> --
>> Pavel
>>
>>
>>
>> 10.02.2022, 15:19, "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.co=
m
>> >:
>>
>> Then the first patch is safer, as it will not break build with tarballs
>> without vcs.
>>
>> Best regards,
>> Tomasz Dziendzielski
>>
>> czw., 10 lut 2022 o 15:08 Pavel Zhukov <pavel@zhukoff.net> napisa=C5=82(=
a):
>>
>> This is good question.
>> It is possible to provide bitbake with mailformed git repo mirror tarbal=
l
>> (manually created one for example with --exclude-vcs flag set or from wr=
ong
>> subdirectory) in that case tar will not return any return code but
>> git.download() will try to replace remote with origin from recipe_url. I=
n
>> worse case it will replace origin of "upper" git repo (poky?) with recip=
e's
>> one.
>>
>>
>> --
>> Pavel
>>
>>
>>
>> 10.02.2022, 14:31, "Alexander Kanavin" <alex.kanavin@gmail.com>:
>>
>> Wait, doesn't this mask the real issue? Is it ok that the tarball
>> unpacking failed 'for any reason'?
>>
>> Alex
>>
>> On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielski
>> <tomasz.dziendzielski@gmail.com> wrote:
>>
>>
>>  If shallow tarball clone is used and if tar unpacking fails for any
>>  reason it might end up with empty directory created. Since runfetchcmd
>>  does not check any return code we might not detect the issue and we wil=
l
>>  not clone from git. Then due to missing hash it will replace main
>>  repository's git remote with the remote of failing recipe.
>>
>>  To fix this behaviour we'll check if clonedir is not empty and if git
>>  dir is the same as clonedir.
>>
>>  Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
>>  Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
>>  ---
>>   lib/bb/fetch2/git.py | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>>  diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>>  index 30da8e95..ed6ecb64 100644
>>  --- a/lib/bb/fetch2/git.py
>>  +++ b/lib/bb/fetch2/git.py
>>  @@ -356,8 +356,15 @@ class Git(FetchMethod):
>>
>>           repourl =3D self._get_repo_url(ud)
>>
>>  - # If the repo still doesn't exist, fallback to cloning it
>>  - if not os.path.exists(ud.clonedir):
>>  + # Clean repo if git dir is different than ud.clonedir, which means ta=
r
>> unpacking failed
>>  + if os.path.exists(ud.clonedir):
>>  + if ud.clonedir !=3D runfetchcmd("%s -C %s rev-parse --git-dir" %
>> (ud.basecmd, ud.clonedir), d):
>>  + bb.utils.remove(ud.clonedir, recurse=3DTrue)
>>  + bb.utils.mkdirhier(ud.clonedir)
>>  + os.chdir(ud.clonedir)
>>  +
>>  + # If the repo still doesn't exist or is empty, fallback to cloning it
>>  + if not os.path.exists(ud.clonedir) or not os.listdir(ud.clonedir):
>>               # We do this since git will use a "-l" option automaticall=
y
>> for local urls where possible
>>               if repourl.startswith("file://"):
>>                   repourl =3D repourl[7:]
>>  --
>>  2.34.1
>>
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13335):
> https://lists.openembedded.org/g/bitbake-devel/message/13335
> Mute This Topic: https://lists.openembedded.org/mt/89045076/3619514
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> tomasz.dziendzielski@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000e3cd0b05d7ab7ed8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=C2=A0I just double checked and with the first patch =
bitbake-selftest is failing with two errors that appear also without my cha=
nges, something about missing hash on branch. Where did you take that logs =
so I could check it and fix the patch?<br></div><div><br></div><div>Best re=
gards,</div><div>Tomasz Dziendzielski<br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">czw., 10 lut 2022 o 15:55=C2=
=A0Tomasz Dziendzielski via <a href=3D"http://lists.openembedded.org">lists=
.openembedded.org</a> &lt;tomasz.dziendzielski=3D<a href=3D"mailto:gmail.co=
m@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; napisa=
=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div>Is this bitbake-selftest output? I tried that but got  net=
work issues and missing branch tag only.</div><div>Maybe I&#39;ll check it =
on different machine.</div><div><br></div><div>Best regards,</div><div>Toma=
sz Dziendzielski<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">czw., 10 lut 2022 o 15:40=C2=A0Pavel Zhukov &lt;<=
a href=3D"mailto:pavel@zhukoff.net" target=3D"_blank">pavel@zhukoff.net</a>=
&gt; napisa=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div>Not really.<br>it will either complain [1] if there&#39;s not gi=
t repository in the parent&#39;s dirs or replace git remote with the one fr=
om recipe_url and fail with [2] if build directory is under some git manage=
d directory.</div><div>=C2=A0</div><div>[1]<div>Fetcher failure: Fetch comm=
and export PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.auto=
Detach=3Dfalse remote failed with exit code 128, output:</div><div>fatal: n=
ot a git repository (or any parent up to mount point /)</div><div>=C2=A0</d=
iv><div>[2]<div><div>bb.fetch2.FetchError: Fetcher failure: Fetch command e=
xport PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 -c gc.autoDetac=
h=3Dfalse clone -n -s /tmp/bitbake-fetch-hyrcqkrw/download/git2/git.openemb=
edded.org.bitbake/ /tmp/bitbake-fetch-hyrcqkrw/unpacked/git/ failed with ex=
it code 128, output:</div><div>fatal: repository &#39;/tmp/bitbake-fetch-hy=
rcqkrw/download/git2/git.openembedded.org.bitbake/&#39; does not exist</div=
><div>=C2=A0</div></div></div></div><div>=C2=A0</div><div>--=C2=A0</div><di=
v>Pavel</div><div>=C2=A0</div><div>=C2=A0</div><div>=C2=A0</div><div>10.02.=
2022, 15:19, &quot;Tomasz Dziendzielski&quot; &lt;<a href=3D"mailto:tomasz.=
dziendzielski@gmail.com" target=3D"_blank">tomasz.dziendzielski@gmail.com</=
a>&gt;:</div><blockquote><div><div>Then the first patch is safer, as it wil=
l not break build with tarballs without vcs.</div><div>=C2=A0</div><div>Bes=
t regards,</div><div>Tomasz Dziendzielski</div></div>=C2=A0<div><div>czw., =
10 lut 2022 o 15:08=C2=A0Pavel Zhukov &lt;<a href=3D"mailto:pavel@zhukoff.n=
et" rel=3D"noopener noreferrer" target=3D"_blank">pavel@zhukoff.net</a>&gt;=
 napisa=C5=82(a):</div><blockquote style=3D"border-left:1px solid rgb(204,2=
04,204);margin:0px 0px 0px 0.8ex;padding-left:1ex"><div>This is good questi=
on.</div><div>It is possible to provide bitbake with mailformed git repo mi=
rror tarball (manually created one for example with --exclude-vcs flag set =
or from wrong subdirectory) in that case tar will not return any return cod=
e but git.download() will try to replace remote with origin from recipe_url=
. In worse case it will replace origin of &quot;upper&quot; git repo (poky?=
) with recipe&#39;s one.<div>=C2=A0</div></div><div>=C2=A0</div><div>--=C2=
=A0</div><div>Pavel</div><div>=C2=A0</div><div>=C2=A0</div><div>=C2=A0</div=
><div>10.02.2022, 14:31, &quot;Alexander Kanavin&quot; &lt;<a href=3D"mailt=
o:alex.kanavin@gmail.com" rel=3D"noopener noreferrer" target=3D"_blank">ale=
x.kanavin@gmail.com</a>&gt;:</div><blockquote><p>Wait, doesn&#39;t this mas=
k the real issue? Is it ok that the tarball<br>unpacking failed &#39;for an=
y reason&#39;?<br><br>Alex<br><br>On Thu, 10 Feb 2022 at 14:27, Tomasz Dzie=
ndzielski<br>&lt;<a href=3D"mailto:tomasz.dziendzielski@gmail.com" rel=3D"n=
oopener noreferrer" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt=
; wrote:</p><blockquote><br>=C2=A0If shallow tarball clone is used and if t=
ar unpacking fails for any<br>=C2=A0reason it might end up with empty direc=
tory created. Since runfetchcmd<br>=C2=A0does not check any return code we =
might not detect the issue and we will<br>=C2=A0not clone from git. Then du=
e to missing hash it will replace main<br>=C2=A0repository&#39;s git remote=
 with the remote of failing recipe.<br><br>=C2=A0To fix this behaviour we&#=
39;ll check if clonedir is not empty and if git<br>=C2=A0dir is the same as=
 clonedir.<br><br>=C2=A0Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"=
mailto:tomasz.dziendzielski@gmail.com" rel=3D"noopener noreferrer" target=
=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt;<br>=C2=A0Signed-off-by: =
Jan Brzezanski &lt;<a href=3D"mailto:jan.brzezanski@gmail.com" rel=3D"noope=
ner noreferrer" target=3D"_blank">jan.brzezanski@gmail.com</a>&gt;<br>=C2=
=A0---<br>=C2=A0=C2=A0lib/bb/fetch2/git.py | 11 +++++++++--<br>=C2=A0=C2=A0=
1 file changed, 9 insertions(+), 2 deletions(-)<br><br>=C2=A0diff --git a/l=
ib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>=C2=A0index 30da8e95..ed6ecb6=
4 100644<br>=C2=A0--- a/lib/bb/fetch2/git.py<br>=C2=A0+++ b/lib/bb/fetch2/g=
it.py<br>=C2=A0@@ -356,8 +356,15 @@ class Git(FetchMethod):<br><br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0repourl =3D self._get=
_repo_url(ud)<br><br>=C2=A0- # If the repo still doesn&#39;t exist, fallbac=
k to cloning it<br>=C2=A0- if not os.path.exists(ud.clonedir):<br>=C2=A0+ #=
 Clean repo if git dir is different than ud.clonedir, which means tar unpac=
king failed<br>=C2=A0+ if os.path.exists(ud.clonedir):<br>=C2=A0+ if ud.clo=
nedir !=3D runfetchcmd(&quot;%s -C %s rev-parse --git-dir&quot; % (ud.basec=
md, ud.clonedir), d):<br>=C2=A0+ bb.utils.remove(ud.clonedir, recurse=3DTru=
e)<br>=C2=A0+ bb.utils.mkdirhier(ud.clonedir)<br>=C2=A0+ os.chdir(ud.cloned=
ir)<br>=C2=A0+<br>=C2=A0+ # If the repo still doesn&#39;t exist or is empty=
, fallback to cloning it<br>=C2=A0+ if not os.path.exists(ud.clonedir) or n=
ot os.listdir(ud.clonedir):<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# We do this since git will use a=
 &quot;-l&quot; option automatically for local urls where possible<br>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if repourl.startswith(&quot;file://&quot;):<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0repourl =3D repourl[7:]<br>=C2=A0--<br>=C2=A02.34.1<br><br><br>=
=C2=A0<br>=C2=A0</blockquote></blockquote></blockquote></div></blockquote><=
/blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13335): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13335" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13335</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/89045076/3619=
514" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/89045076/3619514</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:tomasz.dziendzielski@gmail.com" ta=
rget=3D"_blank">tomasz.dziendzielski@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e3cd0b05d7ab7ed8--

