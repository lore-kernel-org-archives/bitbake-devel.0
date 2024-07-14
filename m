Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F0EC3DA42
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 11:17:28 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.14341.1720955845683519405
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 04:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ey1zk6k3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4267300145eso26326515e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720955844; x=1721560644; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2KJsOwIs7u1f5m0G5P/y/XqN+LKCtqeCJmcRuITH4E=;
        b=ey1zk6k3yVavDVYQQ080c88uq97RpU9gb8cdrwBfCKl/803Hnertpr4RfIAyQkAi3R
         iGBA+E+bM5axe4aQ30a3iguVhPKKd+VRbf7r0UtjcpuHJVrVP0xJvDNb3MRskYCL2Tof
         ADrP/sWgISllV9vUhWCbY9+2x4FvE2dPDvbzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720955844; x=1721560644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2KJsOwIs7u1f5m0G5P/y/XqN+LKCtqeCJmcRuITH4E=;
        b=cvasqhvH7PS37PwbJcjCCpM/VIBvV0tfa3fI4xphxkwv5cIWc+OKxoGRyKIshrYMbT
         4fra9MH5/V2NKwcaewtMBZrabpi8ebyS+hAOeKvdOu9y0ESOtQXTCt3+Kj4e4TFXR4ZD
         1Px3MWf0xVDBKMc5jk+n68MCjZ6wLaBXbuilPDiS4sCO1E+FE6Kt0tHBCXDOJW2QpOU7
         hOtHDv28XJQcpltcjsJtZjMQnHAt8Ebje5keiwMYBs9/xwmm8RupXnDirvVGe/seCBuc
         vZl3ZBrth4aMQTfBo7b/0Nqz5DOVEX3ztBm0wOB9ryNV6wNYqqQxTAwv3+n94FRMTKKc
         NPUw==
X-Forwarded-Encrypted: i=1; AJvYcCWcAEnPKW6dDvfnmDFbJ7sbwhiEkp45YWoyUv+tALqKakoOhpQ4Uh03OjhdOqnS/9c5Gn6m/9Aq0ik3ZIg47DjSohhSvjnq1Ylmf6ARwX3L5eSntaI=
X-Gm-Message-State: AOJu0YzRgX47b7e8ulVeqpWuJPxBzVY8FDOvl9Jrm6WBWSQTReLcLGBR
	7udc8wunksII+DIHHLi6yBGazBSTSmw7hlKnCZ3iRyQoyfq8TECPK3UGIyqmx0o=
X-Google-Smtp-Source: AGHT+IH+cVRGqj+RoPBIRcU+pYb55mTZB68dCiQ85eWa8T9rCpz6GhsBIPnsn/Fv4N2VgYquGpFzDQ==
X-Received: by 2002:adf:f30b:0:b0:366:eba0:8d8c with SMTP id ffacd0b85a97d-367cead19b5mr12729419f8f.54.1720955843858;
        Sun, 14 Jul 2024 04:17:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac74:33a8:48d1:ad5c? ([2001:8b0:aba:5f3c:ac74:33a8:48d1:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dacca16sm3597382f8f.58.2024.07.14.04.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:17:23 -0700 (PDT)
Message-ID: <96618974b45a07b06a312079646c6bf49c1474d8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Sun, 14 Jul 2024 12:17:22 +0100
In-Reply-To: <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
	 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 11:17:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16419

On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded.org w=
rote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> The previous code added local path to generated mirror tarball name which=
 had
> two potential issues when fetch from local PREMIRROR, for exapmle:
>=20
> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
> $ bitbake lsof -cfetch
>=20
> * There might be "Fix File name too long error" when the local path is lo=
ng
> =C2=A0 since the path is translated to filename and added to downloads/gi=
t2/ as:
> =C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>=20
> * When enable BB_GENERATE_MIRROR_TARBALLS:
> =C2=A0 The tarball name will be:
> =C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.tar.gz
>=20
> =C2=A0 The above tarball can't be re-used by do_fetch since bitbake looks=
 for
> =C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to.local.PRE=
MIRROR' in
> =C2=A0 the file name breaks the match.
>=20
> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can fix=
 the
> the above two issues, now the file name in downloads/git2/ is:
> github.com.lsof-org.lsof
>=20
> And the generated tarball is:
> git2_github.com.lsof-org.lsof.tar.gz
>=20
> Or when BB_GIT_SHALLOW is enabled:
> gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
>=20
> And the tarballs can be re-used by do_fetch.
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index c7ff769fdf..89d3268f7f 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -277,7 +277,10 @@ class Git(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedrev[name] =3D=
 ud.revisions[name]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revision(ud, d,=
 name)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (ud.h=
ost.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(=
' ','_').replace('(', '_').replace(')', '_'))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsr=
cname =3D '%s' % os.path.basename(ud.path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsr=
cname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').re=
place('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.startswith=
('.'):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
gitsrcname =3D gitsrcname[1:]
> =C2=A0

I started to review this, then I started wondering why we have mirror
tarballs being created for local file:// urls? Does that make sense?

Cheers,

Richard

