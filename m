Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C00C46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 18:30:42 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.107592.1703701838923541768
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 10:30:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kRnC+h3W;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so2135032e87.0;
        Wed, 27 Dec 2023 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703701837; x=1704306637; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5VewD6oSKHvi6wRRHXcJm1VmscJw7MZhVdb9qi8/n4=;
        b=kRnC+h3WauZzgMbNp71C114hiUCg7yQ+lA9vq4JMdGYfSTUmgMGfZqD/X+bTd2Vs/o
         X3xqDRtdG2aGeaZpu+Hv5LrzGpD3jVU6ZK+VcdgjvKJTk4l7B4OzWwg7sWhLzTFXz+Em
         /o5QZMHU75czEU9SLRY65dWjLG6kcdnPxZQ/y5oTbyFHEDqpwV+lAiS9VRAzZYWza9sm
         AXGFFYzcE+5igWQKd9b3GSM3meuw58We3e1Zudpm2lzYsvCX+klNsFz4P4nVap4yWg1C
         5IGRs4z35Jtdd6sEPA4VBZzav43Um4r6D7rZVez/MtGD0Ztr/FI1E6BmOxlGAUDbhz96
         lD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703701837; x=1704306637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5VewD6oSKHvi6wRRHXcJm1VmscJw7MZhVdb9qi8/n4=;
        b=kUAcCqC0jkwcCIMYUO9zgKhc3cbRCTuvequ42UELT/jKe/iJ7nl+nusGl3+5aApZW1
         lwOm75foK6IKWemzDk+ThHtlSHDtj/+RdYC0YK97M2nyKajvzXUjRFwvstZQx6c7mKJr
         LmKkhdbFhshK570EX3zxbKT+odcvxBbLU1nJRGDBANr0xRbEcSKO7eVn2eymA9VIo05B
         K83Qk8Cdme82B4wGQnOCpKk7L1EdzJk+k/aU94eSzc6sFmewXOmH/eM+gHTZsmMxBfXK
         dhMOH0/iqkowdNooUzHrIt0lJmLU93DYHiPYn9wwyXh5ZYhsl/+98h+fry2fVcsN5stJ
         sjlA==
X-Gm-Message-State: AOJu0YxcY3qJgl3LdQmZljWA7UW507NCpJfP9ecgmgi/vQq88YiKnDbC
	0b1p4h+/fpVcgDEazv5BjU+G7gXPhZdqy+buf/0=
X-Google-Smtp-Source: AGHT+IGOpmU7FGZ1GaCUoapwYljxXcfUCQ5WnGiPMAZ4ZDtWBDBDMnDrt7sH2WhncEy4FHo+UHMT5F6dFfRHnuT/JY0=
X-Received: by 2002:a05:6512:1055:b0:50e:7e93:4d34 with SMTP id
 c21-20020a056512105500b0050e7e934d34mr1980553lfb.128.1703701836404; Wed, 27
 Dec 2023 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <5325820d4f9ca342498422d2427207e7d31270e0.camel@linuxfoundation.org>
In-Reply-To: <5325820d4f9ca342498422d2427207e7d31270e0.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 27 Dec 2023 11:30:23 -0700
Message-ID: <CAJdd5GaP-v8rVuWNakWpkuGNgoaUA+N1tW2BESOmA96fAxabeA@mail.gmail.com>
Subject: Re: [bitbake-devel] pthread_cancel bug on ubuntu2004/debian11
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	openembedded-core <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 18:30:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15709

On Wed, Dec 27, 2023 at 4:28=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> I wanted to write down some thoughts on this which I have all the
> pieces handy.
>
> We saw a nightly layer check fail for meta-openembedded:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/121/builds/1798/s=
teps/21/logs/stdio
>
> INFO: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> INFO: ERROR: test_show_environment (common.CommonCheckLayer)
> INFO: -------------------------------------------------------------------=
---
> INFO: Traceback (most recent call last):
>   File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/li=
b/checklayer/cases/common.py", line 48, in test_show_environment
>     check_command('Layer %s failed to show environment.' % self.tc.layer[=
'name'],
>   File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/li=
b/checklayer/__init__.py", line 287, in check_command
>     raise RuntimeError(msg)
> RuntimeError: Layer meta-gnome failed to show environment.
> Command: bitbake -e
> Output:
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted (core dumped)
>
> which unsurprisingly is on ubuntn 20.04. We've also seen issues like
> this on Debian 11.
>
> I noticed:
>
> https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-instal=
led-for-pthread-cancel-to-work
>
> and:
>
> https://bugs.ams1.psf.io/issue42888
>
> which led me to try:
> ubuntu2004-ty-1:~$ wget https://bugs.ams1.psf.io/file50112/pthread_cancel=
_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ echo $?
> 0
> rpurdie@ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted (core dumped)
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted (core dumped)
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted (core dumped)
>
> (1 in 4 success)
>
> Then adding to the script:
> import ctypes
> libgcc_s =3D ctypes.CDLL('libgcc_s.so.1')
>
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py
> ubuntu2004-ty-1:~$ python3 --version
> Python 3.8.10
>
> I also tried this on debian 11:
>
> debian11-ty-1:~$ python3 pthread_cancel_bug.py
> libgcc_s.so.1 must be installed for pthread_cancel to work
> Aborted
>
> debian11-ty-1:~$ python3 --version
> Python 3.9.2
>
> where the above workaround using ctypes also seems to work.
>
> I'm therefore tempted for python 3.8/3.9 to preload libgcc_s as a
> workaround for this...

Seems reasonable to me, as long as we can restrict it to a specific
version range of python and have a nice comment explaining why

>
> Cheers,
>
> Richard
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15704): https://lists.openembedded.org/g/bitbake-deve=
l/message/15704
> Mute This Topic: https://lists.openembedded.org/mt/103383244/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/8021544=
/3616693/382565666/xyzzy [JPEWhacker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

