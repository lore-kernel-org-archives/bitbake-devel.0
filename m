Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EDC02192
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 08:10:10 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.64792.1738915803870017250
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 00:10:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M50+xujO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dc8b5bb0bso258038f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738915802; x=1739520602; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbPxI7XtfkAWnZwA8T0Tw1Djr00e46sGV3aetP6efOA=;
        b=M50+xujO4CxFKyo9t4x9CXWezqcrIUVu9P4Zz1s1PgYx1Nmlrto7gfxYHqf6irCCoi
         XsHVQhNkox5Sbf5XT8u9fdhRWYfdPI3qJT4n/HkjD8LXksy6j4XlfRbQdl4F43pCRZvA
         xlVqGfeUkejwWORPKJYtsefBDm/hhMj+31JZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915802; x=1739520602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbPxI7XtfkAWnZwA8T0Tw1Djr00e46sGV3aetP6efOA=;
        b=kfoSml23MifkOcaGIW0tdXxacN1WiUq3NIrfyDy17m4O4ss4Ze0YoVq3pVdpX0ozyu
         0l4sFG55qjsQt79REEmh9dYaW+p1lCcMOvQJXSFdbO0/lgTBV2XREUacMMu4YddXT4i4
         LVW+4T0EyZxcTdBQYouTcgZ5Mb+ap4JvzdddL7u+4UPWpYSyZyBwJz9YftUnFUq/ErT9
         iPbFPwiL53fjBeHkNBbu5K9N1/ry9MZIwkay5YjxtGZ7SuDE4eEZHfglmiXNVUyrw6Jc
         OeIeSulEZaVE/s2AQs6wQHFpYXMbB6oKcl7AQU8RqCINV+oxogRMl+UV8c+kjpVKHOYP
         pPVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZDjfDQiK0kUQpM8IAQwep+3Fz7FoitHF+fkYhaZ1fdXcB6LCAY3yN7+ZK1REqNoi6G9ar6oC7nrAnG/HB@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx3rnhGbzbWIDKfNrwF/ourLjp8JQK/8I7mHvtuDkCGazMyU7bi
	jb9EZm0yzDrK/4jGNhlighCPw/8ftBMwXWLUfE3KaX/WxrKPG66UtTZsVekO2VQ=
X-Gm-Gg: ASbGncsLzWD2x0CMRiRhvfEHjVDaQ1ahf+U7zV9OdgCYtLY7QEu0EowFmc3TQ0pH5wr
	kU+57U/h6ZwNhZ57yyU0ElvfrOT5rDWtNZuEM2JaGB5hqv02TNswVJ1f53T4NTuWH6QcS4NJBiJ
	pChe6sySnOdVbdf+yk/sCSPhxSAFF+gqBWN8Fdd6k702wXNp/DJ2jrUFxipKhvSZjnoYcvyWxad
	T1AZIPig68+ElH6cd0lFSbXQsZVWjfknFMwkcI3hC/BoMZCwUYDlqhsiTXIM92KIjyfzVaPywkV
	eRiLorkFmdS9hxi7AAVxiRWJDjmp9GhDZ3kaijTi9HFNLSzq1TY3xst7FZeFHMqsfB01HSNInX4
	go4Qi
X-Google-Smtp-Source: AGHT+IECTOy18TNbQML7js6Pa40jLmeCgSKf7oc7LZN09zUZYyjBrSwYlmkzLfGcLD0mZe1cV8wflw==
X-Received: by 2002:a5d:47ca:0:b0:38d:c557:1146 with SMTP id ffacd0b85a97d-38dc912339amr1175620f8f.20.1738915801988;
        Fri, 07 Feb 2025 00:10:01 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:dcae:28d1:c97a:4196? ([2001:8b0:aba:5f3c:dcae:28d1:c97a:4196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb22f737sm964469f8f.24.2025.02.07.00.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:10:01 -0800 (PST)
Message-ID: <3b99c11f71e6f5761807bc707c215caae9643ff9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 08/15] fetch2: use localpath instead
 of localfile
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Fri, 07 Feb 2025 08:10:00 +0000
In-Reply-To: <e839c25a-e4d5-4a93-8c82-915336367400@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20250205071538.2681-9-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <7314b5c9248b9c1b73de6133dc34cf31bf41d43f.camel@linuxfoundation.org>
	 <1821AAFAC9C0AAD1.752@lists.openembedded.org>
	 <e839c25a-e4d5-4a93-8c82-915336367400@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 08:10:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17164

On Fri, 2025-02-07 at 09:05 +0100, Stefan Herbrechtsmeier wrote:
> =C2=A0
>=20
> =C2=A0
> =C2=A0
> Am 06.02.2025 um 17:21 schrieb Stefan Herbrechtsmeier via
> lists.openembedded.org:
> =C2=A0
> =C2=A0
> > Am 06.02.2025 um 16:26 schrieb Richard Purdie:=20
> > =C2=A0
> > > On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via
> > > lists.openembedded.org wrote:=20
> > > =C2=A0
> > > > From: Stefan Herbrechtsmeier
> > > > <stefan.herbrechtsmeier@weidmueller.com>=20
> > > > =C2=A0
> > > > =C2=A0Use localpath variable instead of localfile and DL_DIR
> > > > variable.=20
> > > > =C2=A0
> > > > =C2=A0Signed-off-by: Stefan Herbrechtsmeier
> > > > <stefan.herbrechtsmeier@weidmueller.com>=20
> > > > =C2=A0---=20
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0lib/bb/fetch2/az.py=C2=A0=C2=A0 | 3 +--=20
> > > > =C2=A0=C2=A0=C2=A0lib/bb/fetch2/repo.py | 2 +-=20
> > > > =C2=A0=C2=A0=C2=A0lib/bb/fetch2/sftp.py=C2=A0| 3 +--=20
> > > > =C2=A0=C2=A0=C2=A0lib/bb/fetch2/wget.py | 2 +-=20
> > > > =C2=A0=C2=A0=C2=A04 files changed, 4 insertions(+), 6 deletions(-)=
=20
> > > > =C2=A0
> > > > =C2=A0diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py=20
> > > > =C2=A0index 346124a8b..1f0f1337a 100644=20
> > > > =C2=A0--- a/lib/bb/fetch2/az.py=20
> > > > =C2=A0+++ b/lib/bb/fetch2/az.py=20
> > > > =C2=A0@@ -49,8 +49,7 @@ class Az(Wget):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchc=
md =3D self.basecmd + ' --retry-connrefused --
> > > > waitretry=3D5'=20
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 # We need to provide a localpath to avoid wget
> > > > using the SAS=20
> > > > =C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ud.localfile ei=
ther has the downloadfilename or
> > > > ud.path=20
> > > > =C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.=
path.join(d.getVar("DL_DIR"),
> > > > ud.localfile)=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.=
localpath=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.uti=
ls.mkdirhier(os.path.dirname(localpath))=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchc=
md +=3D " -O %s" % shlex.quote(localpath)=20
> > > > =C2=A0=C2=A0 diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/rep=
o.py=20
> > > > =C2=A0index fa4cb8149..5c0edf1f2 100644=20
> > > > =C2=A0--- a/lib/bb/fetch2/repo.py=20
> > > > =C2=A0+++ b/lib/bb/fetch2/repo.py=20
> > > > =C2=A0@@ -46,7 +46,7 @@ class Repo(FetchMethod):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def download(self, ud, d):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Fet=
ch url"""=20
> > > > =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.acce=
ss(os.path.join(d.getVar("DL_DIR"),
> > > > ud.localfile), os.R_OK):=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.access(ud.l=
ocalpath, os.R_OK):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 logger.debug("%s already exists (or was
> > > > stashed). Skipping repo init / sync.", ud.localpath)=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return=20
> > > > =C2=A0=C2=A0 diff --git a/lib/bb/fetch2/sftp.py=C2=A0b/lib/bb/fetch=
2/sftp.py=20
> > > > =C2=A0index 2a2a70a1b..b88dc5a28 100644=20
> > > > =C2=A0--- a/lib/bb/fetch2/sftp.py=20
> > > > =C2=A0+++ b/lib/bb/fetch2/sftp.py=20
> > > > =C2=A0@@ -82,8 +82,7 @@ class SFTP(FetchMethod):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 port =3D '-P %d' % urlo.port=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 urlo.port =3D None=20
> > > > =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D =
d.getVar('DL_DIR')=20
> > > > =C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D os.path=
.join(dldir, ud.localfile)=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpath =3D ud.loca=
lpath=20
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 user =3D ''=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if url=
o.userinfo:=20
> > > > =C2=A0diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py=
=20
> > > > =C2=A0index 161c66bea..1194f0e7a 100644=20
> > > > =C2=A0--- a/lib/bb/fetch2/wget.py=20
> > > > =C2=A0+++ b/lib/bb/fetch2/wget.py=20
> > > > =C2=A0@@ -95,7 +95,7 @@ class Wget(FetchMethod):=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchc=
md =3D self.basecmd=20
> > > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dldir =3D os.path.realpath(d.getVar("DL_DIR"))=20
> > > > =C2=A0-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.=
path.join(dldir, ud.localfile) +
> > > > ".tmp"=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D ud.=
localpath + ".tmp"=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.uti=
ls.mkdirhier(os.path.dirname(localpath))=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchc=
md +=3D " -O %s" % shlex.quote(localpath)=20
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0
> > > =C2=A0
> > > =C2=A0I put the first 8 patches of this series into a test branch and
> > > ran it=20
> > > =C2=A0against the autobuilder. It fails to parse, unable to find file=
s
> > > :(.=20
> > > =C2=A0
> > =C2=A0
> > =C2=A0Thanks for the test.=20
> > =C2=A0
> > =C2=A0
> > > https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/96=
0/steps/13/logs/stdio
> > > https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/96=
0/steps/13/logs/errors
> > > =C2=A0
> > > =C2=A0That suggests there is some breaking change in here
> > > unfortunately.=20
> > > =C2=A0
> > =C2=A0
> > =C2=A0I assume the @ in the filename is interpreter as username
> > separator . I will look into it and add a test to the selftest.
> =C2=A0
> We have two solutions to decode an URI with different behavior:
> =C2=A0class URI - urllib.parse.urlparse(uri)
> =C2=A0def decodeurl - re.compile(...).match(uri)


decodeurl is older and predates urllib existing. People have tried to
switch things over and use urllib where possible but as you say, the
behaviour is different. I don't remember what the differences are.

> =C2=A0=C2=A0Additionally the encode of an URI object and the encodeuri fu=
nction
> have different behavior. The class use the unquoted and the function
> the quoted path. Is this behavior intended or could we use one
> implementation?


I suspect we've been preserving the old behaviour so it was intended if
a bit strange. It is hard to comment on what we could do without an
idea of what it would break and what the differences are.

Cheers,

Richard








