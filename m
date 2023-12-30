Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9594C47073
	for <webhook@archiver.kernel.org>; Sat, 30 Dec 2023 17:35:26 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.188731.1703957723188936859
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Dec 2023 09:35:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fjtWfqyv;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: raj.khem@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-594cad5f69fso1327053eaf.1;
        Sat, 30 Dec 2023 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703957722; x=1704562522; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gz8Qo5x2KqjceOJYrMTeebwv2x6psk4+gEiTqQdjTUg=;
        b=fjtWfqyvGXR/aphN0Cp3kEiqJKlpIuWahnjX0D4vsbA2u0kVM1A9hcm0GbxcO+yboH
         gOifdb+rZPrJIIQC8YRKfzZzaAK6Qk10xwuixCkdhJx2MBDX/SgltYjK+/HL4rj/6ihK
         jGKAD4nNu60eNL/B7eqBaNFZz8Cs9uqJc6+YbUQWAShTIOM53ERxvRh0DZ5CemQ56CGt
         VTZP90tKG641UMF0/XehKixjsEVanki7coSt9dJfUncXaIxsD8Cr6XkGjtjmyfrldX1/
         QOD29ycUnkdqeFQ4vxQMNV1f/k3XDCRNiiL24VHQIgoU3DvspScmcw+cqp23a52+k4sR
         lpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703957722; x=1704562522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz8Qo5x2KqjceOJYrMTeebwv2x6psk4+gEiTqQdjTUg=;
        b=O0CNE27u9oYEFpjzk+PZt2nBDEsXyo3JMUH7+NHsigDEg6vNuGKAngvagHept9yDJi
         GvpKbdPoDX9H/1+Jp6s67CGd8we9K/fVSGHckKqvC1oEC8bdnqRXRJu0l9dxTEdy0iAX
         ol3UJaVq98ypyp+viDCYhElsgTfTiAeluDh3Zeog+zsmP82lLL2xIhp8dxcEsxCU+6qc
         DoyUClGp1nVn3AU6x8km1Lykk0yB4S2MZYwww3CM6eNg4PAZbXgpHCo7gBFz8QFy1adm
         pMVPgiWgWa0FfJAoJVNNBrnG0QZVsqAtHl5BB+JKvx/ERMP3s2GgWJxwvTbhKmRboI54
         wJlw==
X-Gm-Message-State: AOJu0YwSm58uSMcNLHjJ9Hxze+DEN7mYaDBBjFlugxP0zu1KdTEHWtuv
	r6DsvDYQkRcEl5L460SdovrurCQHrI9SmLOZq6o=
X-Google-Smtp-Source: AGHT+IHbFXPniiwlR+SNWcS2Z8FuLL45qoqW/D811pWaNESVRkGoadnmF1tIJn3svkY92WoGr/QXCK2rAInj6/bPafg=
X-Received: by 2002:a05:6871:2b0b:b0:203:e8e8:3cf9 with SMTP id
 dr11-20020a0568712b0b00b00203e8e83cf9mr5074302oac.55.1703957722235; Sat, 30
 Dec 2023 09:35:22 -0800 (PST)
MIME-Version: 1.0
References: <5325820d4f9ca342498422d2427207e7d31270e0.camel@linuxfoundation.org>
 <CAJdd5GaP-v8rVuWNakWpkuGNgoaUA+N1tW2BESOmA96fAxabeA@mail.gmail.com>
In-Reply-To: <CAJdd5GaP-v8rVuWNakWpkuGNgoaUA+N1tW2BESOmA96fAxabeA@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 30 Dec 2023 09:35:11 -0800
Message-ID: <CAMKF1spEVkSvFHfQi_ghKfKOUWT9S_XWUdTgSJ9y=E7WR2QC_w@mail.gmail.com>
Subject: Re: [bitbake-devel] pthread_cancel bug on ubuntu2004/debian11
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-core <openembedded-core@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000bf077e060dbd9280"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 17:35:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15728

--000000000000bf077e060dbd9280
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It=E2=80=99s preloading the library so I think it
Won=E2=80=99t have unintended side effects therefore can be applied regardl=
ess I
would imagine


On Wed, Dec 27, 2023 at 10:30=E2=80=AFAM Joshua Watt <JPEWhacker@gmail.com>=
 wrote:

> On Wed, Dec 27, 2023 at 4:28=E2=80=AFAM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > I wanted to write down some thoughts on this which I have all the
> > pieces handy.
> >
> > We saw a nightly layer check fail for meta-openembedded:
> >
> >
> https://autobuilder.yoctoproject.org/typhoon/#/builders/121/builds/1798/s=
teps/21/logs/stdio
> >
> > INFO:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > INFO: ERROR: test_show_environment (common.CommonCheckLayer)
> > INFO:
> ----------------------------------------------------------------------
> > INFO: Traceback (most recent call last):
> >   File
> "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/lib/check=
layer/cases/common.py",
> line 48, in test_show_environment
> >     check_command('Layer %s failed to show environment.' %
> self.tc.layer['name'],
> >   File
> "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/lib/check=
layer/__init__.py",
> line 287, in check_command
> >     raise RuntimeError(msg)
> > RuntimeError: Layer meta-gnome failed to show environment.
> > Command: bitbake -e
> > Output:
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted (core dumped)
> >
> > which unsurprisingly is on ubuntn 20.04. We've also seen issues like
> > this on Debian 11.
> >
> > I noticed:
> >
> >
> https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-instal=
led-for-pthread-cancel-to-work
> >
> > and:
> >
> > https://bugs.ams1.psf.io/issue42888
> >
> > which led me to try:
> > ubuntu2004-ty-1:~$ wget
> https://bugs.ams1.psf.io/file50112/pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ echo $?
> > 0
> > rpurdie@ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted (core dumped)
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted (core dumped)
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted (core dumped)
> >
> > (1 in 4 success)
> >
> > Then adding to the script:
> > import ctypes
> > libgcc_s =3D ctypes.CDLL('libgcc_s.so.1')
> >
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> > ubuntu2004-ty-1:~$ python3 --version
> > Python 3.8.10
> >
> > I also tried this on debian 11:
> >
> > debian11-ty-1:~$ python3 pthread_cancel_bug.py
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted
> >
> > debian11-ty-1:~$ python3 --version
> > Python 3.9.2
> >
> > where the above workaround using ctypes also seems to work.
> >
> > I'm therefore tempted for python 3.8/3.9 to preload libgcc_s as a
> > workaround for this...
>
> Seems reasonable to me, as long as we can restrict it to a specific
> version range of python and have a nice comment explaining why
>
> >
> > Cheers,
> >
> > Richard
> >
> >
> >
> >
> >
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15709):
> https://lists.openembedded.org/g/bitbake-devel/message/15709
> Mute This Topic: https://lists.openembedded.org/mt/103383244/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000bf077e060dbd9280
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It=E2=80=99s preloading the library so I think it</div><d=
iv dir=3D"auto">Won=E2=80=99t have unintended side effects therefore can be=
 applied regardless I would imagine</div><div dir=3D"auto"><br></div><div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Dec 27, 2023 at 10:30=E2=80=AFAM Joshua Watt &lt;<a href=3D"mailto:JPEWhac=
ker@gmail.com">JPEWhacker@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On Wed, Dec 27, 2023 at 4:28=E2=80=AFAM Richard Purdie<br>
&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank"=
>richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt;<br>
&gt; I wanted to write down some thoughts on this which I have all the<br>
&gt; pieces handy.<br>
&gt;<br>
&gt; We saw a nightly layer check fail for meta-openembedded:<br>
&gt;<br>
&gt; <a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/121=
/builds/1798/steps/21/logs/stdio" rel=3D"noreferrer" target=3D"_blank">http=
s://autobuilder.yoctoproject.org/typhoon/#/builders/121/builds/1798/steps/2=
1/logs/stdio</a><br>
&gt;<br>
&gt; INFO: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>
&gt; INFO: ERROR: test_show_environment (common.CommonCheckLayer)<br>
&gt; INFO: ----------------------------------------------------------------=
------<br>
&gt; INFO: Traceback (most recent call last):<br>
&gt;=C2=A0 =C2=A0File &quot;/home/pokybuild/yocto-worker/check-layer-nightl=
y/build/scripts/lib/checklayer/cases/common.py&quot;, line 48, in test_show=
_environment<br>
&gt;=C2=A0 =C2=A0 =C2=A0check_command(&#39;Layer %s failed to show environm=
ent.&#39; % self.tc.layer[&#39;name&#39;],<br>
&gt;=C2=A0 =C2=A0File &quot;/home/pokybuild/yocto-worker/check-layer-nightl=
y/build/scripts/lib/checklayer/__init__.py&quot;, line 287, in check_comman=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0raise RuntimeError(msg)<br>
&gt; RuntimeError: Layer meta-gnome failed to show environment.<br>
&gt; Command: bitbake -e<br>
&gt; Output:<br>
&gt; libgcc_s.so.1 must be installed for pthread_cancel to work<br>
&gt; Aborted (core dumped)<br>
&gt;<br>
&gt; which unsurprisingly is on ubuntn 20.04. We&#39;ve also seen issues li=
ke<br>
&gt; this on Debian 11.<br>
&gt;<br>
&gt; I noticed:<br>
&gt;<br>
&gt; <a href=3D"https://stackoverflow.com/questions/64797838/libgcc-s-so-1-=
must-be-installed-for-pthread-cancel-to-work" rel=3D"noreferrer" target=3D"=
_blank">https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-=
installed-for-pthread-cancel-to-work</a><br>
&gt;<br>
&gt; and:<br>
&gt;<br>
&gt; <a href=3D"https://bugs.ams1.psf.io/issue42888" rel=3D"noreferrer" tar=
get=3D"_blank">https://bugs.ams1.psf.io/issue42888</a><br>
&gt;<br>
&gt; which led me to try:<br>
&gt; ubuntu2004-ty-1:~$ wget <a href=3D"https://bugs.ams1.psf.io/file50112/=
pthread_cancel_bug.py" rel=3D"noreferrer" target=3D"_blank">https://bugs.am=
s1.psf.io/file50112/pthread_cancel_bug.py</a><br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ echo $?<br>
&gt; 0<br>
&gt; rpurdie@ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; libgcc_s.so.1 must be installed for pthread_cancel to work<br>
&gt; Aborted (core dumped)<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; libgcc_s.so.1 must be installed for pthread_cancel to work<br>
&gt; Aborted (core dumped)<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; libgcc_s.so.1 must be installed for pthread_cancel to work<br>
&gt; Aborted (core dumped)<br>
&gt;<br>
&gt; (1 in 4 success)<br>
&gt;<br>
&gt; Then adding to the script:<br>
&gt; import ctypes<br>
&gt; libgcc_s =3D ctypes.CDLL(&#39;libgcc_s.so.1&#39;)<br>
&gt;<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; ubuntu2004-ty-1:~$ python3 --version<br>
&gt; Python 3.8.10<br>
&gt;<br>
&gt; I also tried this on debian 11:<br>
&gt;<br>
&gt; debian11-ty-1:~$ python3 pthread_cancel_bug.py<br>
&gt; libgcc_s.so.1 must be installed for pthread_cancel to work<br>
&gt; Aborted<br>
&gt;<br>
&gt; debian11-ty-1:~$ python3 --version<br>
&gt; Python 3.9.2<br>
&gt;<br>
&gt; where the above workaround using ctypes also seems to work.<br>
&gt;<br>
&gt; I&#39;m therefore tempted for python 3.8/3.9 to preload libgcc_s as a<=
br>
&gt; workaround for this...<br>
<br>
Seems reasonable to me, as long as we can restrict it to a specific<br>
version range of python and have a nice comment explaining why<br>
<br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Richard<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; <br>
&gt;<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15709): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15709" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15709</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/103383244/199=
7914" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/103383244/1997914</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_bla=
nk">raj.khem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000bf077e060dbd9280--

