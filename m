Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC4BC02198
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 15:27:05 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.44099.1738855617250147905
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Feb 2025 07:26:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bjFoAFyW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43621d27adeso7216455e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Feb 2025 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738855615; x=1739460415; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VRanaQd4u/EI/sdY31CWMfrtRycXL+UWnEvz5bTgOQ=;
        b=bjFoAFyWFlKlJRe3eL75cI2lMi8rKvU4b5wUTzguEaXT6khM1x5TsYrsKwJXf3mVQA
         I8DCh3Xrm35xrN+Bhy7k/AI84Nu1+aImHgIcaj5h1V2nqS0B+HSHipVAfZ4yRfKXOiFw
         zBGRttxzjdljqYUNrel0dOWKLZ4waWdJogfBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855615; x=1739460415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VRanaQd4u/EI/sdY31CWMfrtRycXL+UWnEvz5bTgOQ=;
        b=qZn8S6TUA0eJzQQ1nVbNk3rlK7OszBoVHRfRp77TgcMIyCy/GMVfruqb8mMXF4iUKh
         5bh6oe6SFCWxbnGDLCkAyEK38O/402ArLgQ1sRFDdgO59jm/FTUwJz/izCHiYLBQmJR+
         BgiaK3gBEXc2GCg46fFW9uS8ec+4py39UxTnOF2hxOJvRNOOH14vThSQrePXjHqaajIu
         smAAxYQLS1Wa9+P0Vs0ZpdlonyVzpFUAjUdX6+55qX20dRSBg/1ZScSYFhAChxTQMJon
         OiHerymzsdZ78TNJ9h4TeU95mo1whRlYc22bVtt0zDFJNDqgYiH8+jTMPhnSGxu2TdZe
         9sQg==
X-Forwarded-Encrypted: i=1; AJvYcCWJWxD4r+ua7NuTzdvXdxZuDZsD2Cq78gVKJFF6LF1KFRaApR87C4/YiUWo/bqRCua7p00OlkDnWeriJubS@lists.openembedded.org
X-Gm-Message-State: AOJu0YxGKDnubaT5r1eOI3sYgbCwwJ3QsHnV4AZa7t5E66xiIt+4LtHh
	RLwAOipSnxREKZB386xuzet+UZI4aN8VG+Yp8mW+j8/ODnR/wucu5srWh/twcgo=
X-Gm-Gg: ASbGncshEIZX1k/uANDCtxd83z6xWSW62ufI7o3HSjFPamYLTL4kIATJet8kP8QEOMp
	lqG4K/knQdDFqhdmDf7+M8T3vTGAn/d8zKY5S33R+dk+HhNxPe4H4bqVFRMPrWMUSke1GqzPlAr
	7nhiq/o3/k6wCj1O6Fwiu2ZwHeBJMDvLjl2A4M9xoWZYMKY39PJOl42iRu1gfeBgqcxLp3Yg7T1
	/g0+DEG6HUrkT92we4ePT+85wCQyYxdkDv43/OdeE5+gW8XNlC+Fjugji7Pi/tbNDHjmK4bt/pn
	55kzkYHUd54hFJDvQPRakQnucihP7zCRsrbk6DzKnEnZAKuJXmsDLjkkY4RL0N4diRQ3hXizHkZ
	oQpCw
X-Google-Smtp-Source: AGHT+IGQN/QQnYU/eNt9mGPSfdNZsP3IhncRn9OPF2+d5SJaTUAuPDTIEnok0KdtIQMzi2sPNfQ2fw==
X-Received: by 2002:a05:600c:310e:b0:434:f297:8e85 with SMTP id 5b1f17b1804b1-4390d43448amr62632005e9.10.1738855615444;
        Thu, 06 Feb 2025 07:26:55 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b5a2:dd41:ad93:d97c? ([2001:8b0:aba:5f3c:b5a2:dd41:ad93:d97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d96548bsm58244765e9.21.2025.02.06.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:26:54 -0800 (PST)
Message-ID: <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 08/15] fetch2: use localpath instead
 of localfile
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Thu, 06 Feb 2025 15:26:53 +0000
In-Reply-To: <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Feb 2025 15:27:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17161

On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Use localpath variable instead of localfile and DL_DIR variable.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
> =C2=A0lib/bb/fetch2/az.py=C2=A0=C2=A0 | 3 +--
> =C2=A0lib/bb/fetch2/repo.py | 2 +-
> =C2=A0lib/bb/fetch2/sftp.py=C2=A0| 3 +--
> =C2=A0lib/bb/fetch2/wget.py | 2 +-
> =C2=A04 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
> index 346124a8b..1f0f1337a 100644
> --- a/lib/bb/fetch2/az.py
> +++ b/lib/bb/fetch2/az.py
> @@ -49,8 +49,7 @@ class Az(Wget):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D self.basecm=
d + ' --retry-connrefused --waitretry=3D5'
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # We need to provide a l=
ocalpath to avoid wget using the SAS
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ud.localfile either has the=
 downloadfilename or ud.path
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.path.join(d.=
getVar("DL_DIR"), ud.localfile)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.localpath
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.pa=
th.dirname(localpath))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " -O %s" %=
 shlex.quote(localpath)
> =C2=A0
> diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
> index fa4cb8149..5c0edf1f2 100644
> --- a/lib/bb/fetch2/repo.py
> +++ b/lib/bb/fetch2/repo.py
> @@ -46,7 +46,7 @@ class Repo(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0 def download(self, ud, d):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Fetch url"""
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.access(os.path.join(d.g=
etVar("DL_DIR"), ud.localfile), os.R_OK):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.access(ud.localpath, os=
.R_OK):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
logger.debug("%s already exists (or was stashed). Skipping repo init / sync=
.", ud.localpath)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return
> =C2=A0
> diff --git a/lib/bb/fetch2/sftp.py=C2=A0b/lib/bb/fetch2/sftp.py
> index 2a2a70a1b..b88dc5a28 100644
> --- a/lib/bb/fetch2/sftp.py
> +++ b/lib/bb/fetch2/sftp.py
> @@ -82,8 +82,7 @@ class SFTP(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
port =3D '-P %d' % urlo.port
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
urlo.port =3D None
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D d.getVar('DL_DIR')
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D os.path.join(dldir,=
 ud.localfile)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D ud.localpath
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 user =3D ''
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if urlo.userinfo:
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 161c66bea..1194f0e7a 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -95,7 +95,7 @@ class Wget(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D self.basecm=
d
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D os.path.realpa=
th(d.getVar("DL_DIR"))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.path.join(dl=
dir, ud.localfile) + ".tmp"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.localpath + =
".tmp"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.pa=
th.dirname(localpath))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " -O %s" %=
 shlex.quote(localpath)
> =C2=A0
>=20


I put the first 8 patches of this series into a test branch and ran it
against the autobuilder. It fails to parse, unable to find files :(.

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/step=
s/13/logs/stdio
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/960/step=
s/13/logs/errors

That suggests there is some breaking change in here unfortunately.

Cheers,

Richard

