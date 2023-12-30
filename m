Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4169C46CD2
	for <webhook@archiver.kernel.org>; Sat, 30 Dec 2023 11:31:14 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.182778.1703935872446789752
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Dec 2023 03:31:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L7RObWYm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so42465615e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703935871; x=1704540671; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AraUNmLIQDNN9YZbwSgGnEmfPeKi0CJ7sowQomKeroM=;
        b=L7RObWYm6dYaWMwOo5iQ4qtqUAns3gTRffPinszaWgCC0yM+PaZxOeHF2AaBxU09F/
         bIj0ahSb+pxdmwxO5tyNrym2hgYo9STec+OsHufaV+zyUpeVc1lthg2KnT/uilFpB3B1
         xjHEDV28qbfX8s2NXNADgSNKH5CFi7ndfBtr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703935871; x=1704540671;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AraUNmLIQDNN9YZbwSgGnEmfPeKi0CJ7sowQomKeroM=;
        b=ZqCDO55McwJrgA5vtkfwEOsuUU/h3DLxcuh5uZ1gQOT909pSLTnBx0jvLJlnQ5lyQ6
         MokkY+ufa/DSHIHPh1mQVQjbp1xXzfEjXO3Cf4XbdWNQKZeP11b050KJA8IfKvB6anwD
         iU1dgipfYKx+7UyREGJRQLmhtzUWhSLZpBCOCzW/K0fJ5g4BMjAMJe1Wgjcka2r0/R15
         RT+Hw87M1sgRSdZqpG5gcuEwfjie+cdGGULA1Cgp8ja5vGs+KXw+SJ/gXB4tiRZgCZzd
         82A/1tXmh2qXvQpLleOK9XlV5+7Y90tWN1WI6ZDjQMj0axje5+8hH0N4noeht16AgXJ+
         0rvQ==
X-Gm-Message-State: AOJu0Yw3nl8lvz+6eWhSXZ43yNMcGdh79KIHBAIZ6r8/D/QKwM4MHHPJ
	fUxsVU2DL66jnALT2YdPm/dhVfTmQSszqw==
X-Google-Smtp-Source: AGHT+IETy4urfU+YIYrKDTAMLGBpBGt2/JZeG9XEMl5feF/96tGUOFdWJ6ja+ev1pKgtzot2m6vp6A==
X-Received: by 2002:a05:600c:3ba4:b0:40d:5ae2:2404 with SMTP id n36-20020a05600c3ba400b0040d5ae22404mr3624206wms.17.1703935870776;
        Sat, 30 Dec 2023 03:31:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a152:ea8e:7a3:4258? ([2001:8b0:aba:5f3c:a152:ea8e:7a3:4258])
        by smtp.gmail.com with ESMTPSA id h5-20020adff4c5000000b0033668b27f8fsm20069836wrp.4.2023.12.30.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:31:10 -0800 (PST)
Message-ID: <388ea27fd963ab72dd3506204848979ee0f80904.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] pthread_cancel bug on ubuntu2004/debian11
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, openembedded-core
 <openembedded-core@lists.openembedded.org>, Steve Sakoman
 <steve@sakoman.com>
Date: Sat, 30 Dec 2023 11:31:09 +0000
In-Reply-To: <CAJdd5GaP-v8rVuWNakWpkuGNgoaUA+N1tW2BESOmA96fAxabeA@mail.gmail.com>
References: 
	<5325820d4f9ca342498422d2427207e7d31270e0.camel@linuxfoundation.org>
	 <CAJdd5GaP-v8rVuWNakWpkuGNgoaUA+N1tW2BESOmA96fAxabeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 11:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15726

On Wed, 2023-12-27 at 11:30 -0700, Joshua Watt wrote:
> On Wed, Dec 27, 2023 at 4:28=E2=80=AFAM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >=20
> > I wanted to write down some thoughts on this which I have all the
> > pieces handy.
> >=20
> > We saw a nightly layer check fail for meta-openembedded:
> >=20
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/121/builds/1798=
/steps/21/logs/stdio
> >=20
> > INFO: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > INFO: ERROR: test_show_environment (common.CommonCheckLayer)
> > INFO: -----------------------------------------------------------------=
-----
> > INFO: Traceback (most recent call last):
> >   File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/=
lib/checklayer/cases/common.py", line 48, in test_show_environment
> >     check_command('Layer %s failed to show environment.' % self.tc.laye=
r['name'],
> >   File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/=
lib/checklayer/__init__.py", line 287, in check_command
> >     raise RuntimeError(msg)
> > RuntimeError: Layer meta-gnome failed to show environment.
> > Command: bitbake -e
> > Output:
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted (core dumped)
> >=20
> > which unsurprisingly is on ubuntn 20.04. We've also seen issues like
> > this on Debian 11.
> >=20
> > I noticed:
> >=20
> > https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-inst=
alled-for-pthread-cancel-to-work
> >=20
> > and:
> >=20
> > https://bugs.ams1.psf.io/issue42888
> >=20
> > which led me to try:
> > ubuntu2004-ty-1:~$ wget https://bugs.ams1.psf.io/file50112/pthread_canc=
el_bug.py
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
> >=20
> > (1 in 4 success)
> >=20
> > Then adding to the script:
> > import ctypes
> > libgcc_s =3D ctypes.CDLL('libgcc_s.so.1')
> >=20
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
> >=20
> > I also tried this on debian 11:
> >=20
> > debian11-ty-1:~$ python3 pthread_cancel_bug.py
> > libgcc_s.so.1 must be installed for pthread_cancel to work
> > Aborted
> >=20
> > debian11-ty-1:~$ python3 --version
> > Python 3.9.2
> >=20
> > where the above workaround using ctypes also seems to work.
> >=20
> > I'm therefore tempted for python 3.8/3.9 to preload libgcc_s as a
> > workaround for this...
>=20
> Seems reasonable to me, as long as we can restrict it to a specific
> version range of python and have a nice comment explaining why

Patch tested, sent and I've applied it to older bitbake branches too in
the hope that it helps some of Steve's autobuilder failures too.

Once we get to 3.10 as a minimum version we can drop it.

Cheers,

Richard

