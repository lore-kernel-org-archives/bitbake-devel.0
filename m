Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4806C3DA64
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 11:06:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.4834.1722942375231087875
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 04:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PDaquLNX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3685b9c8998so341651f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722942373; x=1723547173; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jerF01IpPJMqN9z5Fd7riiOJklOzVsV44zJtWTGNP/I=;
        b=PDaquLNXZHCOimnCZi3chQF0ZgExM/god6A236gG8zlfg72cljSLFMlqld4vg5kLqj
         rbIGf2O1s2BUmZ3Lj4m69WUyY1RhFaXsGtY+r37IkIDnVHjOJYHTNtnISX/DR56lvuru
         +iOYpCY/MOI0v31jNuYfxl+p9t+OfzojxfT3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722942373; x=1723547173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jerF01IpPJMqN9z5Fd7riiOJklOzVsV44zJtWTGNP/I=;
        b=Ni6lXjSVkrm+5QjN3wmd9GteyZLRwGlgi2DGZ1/K4R6xx26tzAjfzp/LG3eGtQyU3Z
         FBciRwHKUP+wQYEYmmwLaxVGMw9fSh8IC7MCaoEDev0T3BceW81aooH/PRn5kcojPepJ
         UySMdkWMMvO/5YM0GmQdBl3LrUl6vfd+bRqj7BAFCfQN/I274R7kvzbAxPAFPgNlMrod
         mkyBCUnNNQHy6SEm9vArzj33Oys5NstZQKrcDkJakvlRiO+35sM14UIZ8PLxc8Bu9jiG
         +lw0rWKQNztoA1Rt5GRMZDH9f52bQmrmuCqlwbsR2DtZoaK4oMlfjbbCXoZKGbJZCYAV
         LQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCXSVpEnbeGFlHdIUqN5NB5tJ8oYDXcTAC5KmFw1vEUk1Kn7Ir89MuuCdx/KBvpKizr+PpmtIr9xP2OgXRyhesIB4ypIcWWNkUFWD9gRP+vJiX4NvwE=
X-Gm-Message-State: AOJu0Yxy/+ru9cEtlwnakXG5zH6g5jgcaW6tmkrgxNLmFW6B9JY5zFnI
	JAIOecs8kPW43rAm+fgn29pCUObN6W1riC/7qSDjnPNxFX/c4nz/ipdysQlMw2NCavnxTpw/Gs1
	qe5E=
X-Google-Smtp-Source: AGHT+IECTCdbw9vgJBIAm9uBXQoUFAp3iB8E/zmkGedgA3BFYG1xe8tqpIUFq9D6LHPx0VBZMuIiyQ==
X-Received: by 2002:a05:6000:c03:b0:367:923b:656b with SMTP id ffacd0b85a97d-36bbc1d2019mr9312798f8f.54.1722942373131;
        Tue, 06 Aug 2024 04:06:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeae:cd04:92c6:bd93? ([2001:8b0:aba:5f3c:aeae:cd04:92c6:bd93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0597cfsm12695899f8f.74.2024.08.06.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:06:12 -0700 (PDT)
Message-ID: <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Tue, 06 Aug 2024 12:06:11 +0100
In-Reply-To: <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
	 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 11:06:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16444

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


I did look at this patch again. I'm still not convinced about the
original use case but ignoring that, the patch itself isn't too safe.
If you have two repositories with the same name, this can break since
basename() on the URI is not a unique value.=C2=A0

Just as a note, '%s' % x is also poor code as you can just assign the
value.

Cheers,

Richard




