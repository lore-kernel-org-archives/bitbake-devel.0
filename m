Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6BC3DA59
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 10:18:44 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.15838.1721384313742572580
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jul 2024 03:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HsB3+DID;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so27764071fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jul 2024 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721384312; x=1721989112; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUTWTsh6u5fJYbN6MnTw5r4772IbqSyLXEUTBtSZPoE=;
        b=HsB3+DID4oxAYP+HK2LUCW/uQFimFRpKQ4wLgA+ByRg1WwY68gC/whSSm69en9OSnz
         1z8tEGAQyGTgySnv4jghn0CaC5Ackl9SGjZghYkAnj1N/wu5DxJQKSLK0siSDefwAvit
         8HETERX1gqLVHy6Av9jizgh8d6Z2FpRX4XQOAkMZaozWuezK4d8x3Z+U9pF1Uw7tFa/Y
         mlB7mUxTqAE7KlUj0xw7eLqw51HWvkdIIQT8nF6bc5c1McXBlJpUgY14SKIMyOlVdfAX
         PYPN+yBsYFQz9BvmsVCH/ikL0ae5tkvIo+LlPwNQX1xlPibXoSywFadN63ORFQAXQ4J5
         k6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721384312; x=1721989112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUTWTsh6u5fJYbN6MnTw5r4772IbqSyLXEUTBtSZPoE=;
        b=J0B77XaMAquZbwAsbQRIQ2HOoHX9giYO4OIiPHuLL9aawyt5IeUqaL6abYxSgq2/fo
         ZpeZ8Ug9QKk3rfOiV/MCLs3Q3+9CoeozLYCQ4sBwRM+kHta0k3g/3jsM+6AaZzCLGoOZ
         YfIyA7O7VBqJ15AOydiF0PZzYM6lRlOXEmCdNMI3K5BYRcPJB8ihDkEk5vjK8TMeKO+b
         8KCQMeANvnV+2iJvYnCLkK+pQYqMXvRAtcAbaQPmdBLZAzf1KgGu+263xJD4JPt6Sn0N
         2qIYvHLdivZTep3cp4C7crHwdXtKRtzJ8u0x7f7XDDyzyh8NXMQ1/g4dii1C9rvfghCi
         4QCg==
X-Gm-Message-State: AOJu0YxuD8vsrLaEPd7nsePf8rKIXlocRvJq7JD9CVD57cwct5H/63/+
	PU1/B81faSgouq+RCG8JeZjv9gerpXJJgMQhL3MOd1L3KipnDj8vjzVFuslLcaiILgd82ql/XLx
	BEO9foXOlMX76wySG0cjIe2pK+t0=
X-Google-Smtp-Source: AGHT+IGB05TywDDbHG1Cc2mKzj8GJe2wffbn2LqNm2Vh57kvi0cNQF6wENzWq+kzQ4RXlPOqxA3nuFSIXD5QAg8/Fos=
X-Received: by 2002:a2e:be89:0:b0:2ec:2d75:509c with SMTP id
 38308e7fff4ca-2ef05d7f600mr42402921fa.46.1721384311168; Fri, 19 Jul 2024
 03:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <9TpF.1721383981109709443.Rgoj@lists.openembedded.org>
In-Reply-To: <9TpF.1721383981109709443.Rgoj@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 19 Jul 2024 12:18:19 +0200
Message-ID: <CANNYZj9rgXQ-FgK_BiCip=_yA-m3AG8aMQDLZMNuM0=nMt5Bag@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake does not perform to unpack tarball after
 second and other downloads for PREMIRRORs and MIRRORS
To: andrii.sosiuk@seco.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jul 2024 10:18:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16431

We can perhaps handle the issue here if you describe steps to
reproduce it locally in a more specific way (e.g. how to make the
tarballs, what local.conf settings are needed etc.)

Note that there are PREMIRRORS tests in bitbake/lib/bb/tests/fetch.py
, so the most awesome thing to do would be to add a test there that
would fail in a way that exposes the issue.

Alex

On Fri, 19 Jul 2024 at 12:13, andrii.sosiuk via lists.openembedded.org
<andrii.sosiuk=3Dseco.com@lists.openembedded.org> wrote:
>
> Hi All.
>
> I've encountered a bug, but I'm unable to report it directly as only regi=
stered users can create bug reports on Yocto Project's Bugzilla.
> Therefore, I'm raising the issue here to see if anyone else has experienc=
ed this problem.
>
> The bug pertains to the use of MREMIRROR in a project setup where multipl=
e source code tarballs are linked for a recipe.
> Bitbake is designed to download and untar the tarball from the first prov=
ided link.
> If there's an issue with this tarball=E2=80=94for instance, if the requir=
ed revision is missing=E2=80=94Bitbake then attempts to download the tarbal=
l from the next link.
> However, it fails to untar this second tarball, leading to subsequent che=
cks being incorrectly performed on outdated data from the first tarball sin=
ce the untar step is skipped.
> As a result, even if the second tarball has the correct revision, the che=
cks fail.
>
> This problem can be observed in the fetch log file, where the fetcher use=
s wget followed by a tar command for the first link.
> In contrast, for the second link, after wget, it bypasses the tar step an=
d proceeds directly to performing git checks.
>
> Is anyone else facing this issue, or does anyone have insights on a possi=
ble workaround or an instruction how to create a bug report?
>
> Thanks, in advance.
>
>
>
>
> DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t=
 2 -T 30 --passive-ftp --no-check-certificate -O /usr/src/packages/git2_cod=
e.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://=
support.garz-fricke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar=
.gz'
>
> DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRES=
S=3D"unix:path=3D/run/user/58604/bus";  /usr/bin/env wget -t 2 -T 30 --pass=
ive-ftp --no-check-certificate -O /usr/src/packages/git2_code.qt.io.qt.qtvi=
rtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://support.garz-fr=
icke.com/mirror/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz' --progress=
=3Ddot -v
>
> --2024-07-19 08:45:38--  https://support.garz-fricke.com/mirror/git2_code=
.qt.io.qt.qtvirtualkeyboard.git.tar.gz
>
> Resolving support.garz-fricke.com (support.garz-fricke.com)... 212.53.188=
.8, 2a00:1f78:cd:6::19e
>
> Connecting to support.garz-fricke.com (support.garz-fricke.com)|212.53.18=
8.8|:443... connected.
>
> HTTP request sent, awaiting response... 200 OK
>
> Length: 19921396 (19M) [application/x-gzip]
>
> Saving to: =E2=80=98/usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboar=
d.git.tar.gz.tmp=E2=80=99
>
>
>
> 2024-07-19 08:45:39 (27.0 MB/s) - =E2=80=98/usr/src/packages/git2_code.qt=
.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99 saved [19921396/19921396]
>
>
>
> DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRE=
SS=3D"unix:path=3D/run/user/58604/bus"; tar -xzf /usr/src/packages/git2_cod=
e.qt.io.qt.qtvirtualkeyboard.git.tar.gz' in /usr/src/packages//git2/code.qt=
.io.qt.qtvirtualkeyboard.git
>
> DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRE=
SS=3D"unix:path=3D/run/user/58604/bus"; git -c core.fsyncobjectfiles=3D0 br=
anch --contains 7b90415c58dd02c682a9ba317f273d7b3398ff88 --list 5.15.2 2> /=
dev/null | wc -l' in /usr/src/packages//git2/code.qt.io.qt.qtvirtualkeyboar=
d.git
>
> =E2=80=A6=E2=80=A6
>
> DEBUG: Mirror fetch failure for url https://support.garz-fricke.com/mirro=
r/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz (original url: git://code=
.qt.io/qt/qtvirtualkeyboard.git;name=3Dqtvirtualkeyboard;branch=3D5.15.2;pr=
otocol=3Dgit)
>
> DEBUG: Fetcher failure: Unable to find revision 7b90415c58dd02c682a9ba317=
f273d7b3398ff88 in branch 5.15.2 even from upstream
>
> =E2=80=A6..
>
> DEBUG: Fetcher accessed the network with the command /usr/bin/env wget -t=
 2 -T 30 --passive-ftp --no-check-certificate -O /usr/src/packages/git2_cod=
e.qt.io.qt.qtvirtualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://=
support.garz-fricke.com/mirror/archive1/git2_code.qt.io.qt.qtvirtualkeyboar=
d.git.tar.gz'
>
> DEBUG: Running export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRES=
S=3D"unix:path=3D/run/user/58604/bus"; /usr/bin/env wget -t 2 -T 30 --passi=
ve-ftp --no-check-certificate -O /usr/src/packages/git2_code.qt.io.qt.qtvir=
tualkeyboard.git.tar.gz.tmp -P /usr/src/packages/ 'https://support.garz-fri=
cke.com/mirror/archive1/git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz' --=
progress=3Ddot -v
>
> --2024-07-19 08:45:40--  https://support.garz-fricke.com/mirror/archive1/=
git2_code.qt.io.qt.qtvirtualkeyboard.git.tar.gz
>
> Resolving support.garz-fricke.com (support.garz-fricke.com)... 212.53.188=
.8, 2a00:1f78:cd:6::19e
>
> Connecting to support.garz-fricke.com (support.garz-fricke.com)|212.53.18=
8.8|:443... connected.
>
> HTTP request sent, awaiting response... 200 OK
>
> Length: 20875043 (20M) [application/x-gzip]
>
> Saving to: =E2=80=98/usr/src/packages/git2_code.qt.io.qt.qtvirtualkeyboar=
d.git.tar.gz.tmp=E2=80=99
>
>
>
> 2024-07-19 08:45:41 (28.2 MB/s) - =E2=80=98/usr/src/packages/git2_code.qt=
.io.qt.qtvirtualkeyboard.git.tar.gz.tmp=E2=80=99 saved [20875043/20875043]
>
>
>
> DEBUG: Running 'export PSEUDO_DISABLED=3D1; export DBUS_SESSION_BUS_ADDRE=
SS=3D"unix:path=3D/run/user/58604/bus"; git -c core.fsyncobjectfiles=3D0 br=
anch --contains 7b90415c58dd02c682a9ba317f273d7b3398ff88 --list 5.15.2 2> /=
dev/null | wc -l' in /usr/src/packages//git2/code.qt.io.qt.qtvirtualkeyboar=
d.git
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16430): https://lists.openembedded.org/g/bitbake-deve=
l/message/16430
> Mute This Topic: https://lists.openembedded.org/mt/107432587/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

