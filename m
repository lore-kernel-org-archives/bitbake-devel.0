Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563CC46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 11:28:40 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.99941.1703676513819463198
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 03:28:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YaMsL9vL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso11661515e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703676512; x=1704281312; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa4zZewjUa3VavVuhnocjU9ymX711ejaDLyVUXGClqg=;
        b=YaMsL9vLi9NssrJpxg29CQM9jyYsebwj1ZeVKLMos6Hx3Nl5AEOmrpGHPgCr69gMRa
         2TGANaAf5QOtfCNbHTP8BpMkrnco4mZxB9tL8h56sgNaeQj6iyKakjo2NEfdqQW4qwSa
         Xp9pgIznKW/ZcKKXn2BveiQDkDTKVvwk55VPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703676512; x=1704281312;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa4zZewjUa3VavVuhnocjU9ymX711ejaDLyVUXGClqg=;
        b=aNz5G62mKBXD6PKKcLDmjVHFyqXGYNXhV5cXiKXJylctpr2N7nBzRtBbSCSisOgpZZ
         ct5HkQKi2RuxoLkq8FCI2GmAAlFXU40s1KmAkqwRx/50n+QKi6ytWxWjybUfTsISdzwh
         tIEd7PLpUrAF2dNE56OKhdx3XZzAiMW+lYWjY3rKmy5dYWnWNAG8M+Lkxpnwbhz3/ipr
         unuNwaJ1eSpF/L1RWvLVF78TiKVdlTasvkWN2+gThW1BABuHWhHeYjDlPrZZPh9bkjX9
         X8V/Gj8JsXIOuukmmraf+DrGATv9KAbtYE89pPkIQCG57DjFrEzDMPOh7U7HS93K08gT
         w8wA==
X-Gm-Message-State: AOJu0YzF4g7kGcy+2li4oJOKh/73eKYhNird0LXbrbs2Dp1Sktt16ONS
	JOIHWeLAtrIsF4Lkd+264q7poNuyPg2Ow0nhlwFIP2cMZ2s=
X-Google-Smtp-Source: AGHT+IFL/5XcbVpK9gmXc75PehUEZMXBxHcMWLE2ezbyC4sRIDfBEfzzVJ+fx+5HHvcM+Iol7ixeLQ==
X-Received: by 2002:a05:600c:ac3:b0:40d:5c89:e256 with SMTP id c3-20020a05600c0ac300b0040d5c89e256mr744118wmr.186.1703676511793;
        Wed, 27 Dec 2023 03:28:31 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ed04:d745:dee2:d264? ([2001:8b0:aba:5f3c:ed04:d745:dee2:d264])
        by smtp.gmail.com with ESMTPSA id cg10-20020a5d5cca000000b00336c120855dsm7108195wrb.84.2023.12.27.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 03:28:31 -0800 (PST)
Message-ID: <5325820d4f9ca342498422d2427207e7d31270e0.camel@linuxfoundation.org>
Subject: pthread_cancel bug on ubuntu2004/debian11
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Date: Wed, 27 Dec 2023 11:28:30 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Dec 2023 11:28:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15704

I wanted to write down some thoughts on this which I have all the
pieces handy.

We saw a nightly layer check fail for meta-openembedded:

https://autobuilder.yoctoproject.org/typhoon/#/builders/121/builds/1798/ste=
ps/21/logs/stdio

INFO: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
INFO: ERROR: test_show_environment (common.CommonCheckLayer)
INFO: ---------------------------------------------------------------------=
-
INFO: Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/lib/=
checklayer/cases/common.py", line 48, in test_show_environment
    check_command('Layer %s failed to show environment.' % self.tc.layer['n=
ame'],
  File "/home/pokybuild/yocto-worker/check-layer-nightly/build/scripts/lib/=
checklayer/__init__.py", line 287, in check_command
    raise RuntimeError(msg)
RuntimeError: Layer meta-gnome failed to show environment.
Command: bitbake -e
Output:
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)

which unsurprisingly is on ubuntn 20.04. We've also seen issues like
this on Debian 11.

I noticed:

https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-installe=
d-for-pthread-cancel-to-work

and:

https://bugs.ams1.psf.io/issue42888

which led me to try:
ubuntu2004-ty-1:~$ wget https://bugs.ams1.psf.io/file50112/pthread_cancel_b=
ug.py
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ echo $?
0
rpurdie@ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)

(1 in 4 success)

Then adding to the script:
import ctypes
libgcc_s =3D ctypes.CDLL('libgcc_s.so.1')

ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 pthread_cancel_bug.py=20
ubuntu2004-ty-1:~$ python3 --version
Python 3.8.10

I also tried this on debian 11:

debian11-ty-1:~$ python3 pthread_cancel_bug.py=20
libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted

debian11-ty-1:~$ python3 --version
Python 3.9.2

where the above workaround using ctypes also seems to work.

I'm therefore tempted for python 3.8/3.9 to preload libgcc_s as a
workaround for this...

Cheers,

Richard



