Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44ACC3DA49
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 13:32:09 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.16337.1720963928530093174
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 06:32:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FI5f4d6j;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36798779d75so3084214f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720963927; x=1721568727; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27MHSoLpOVK9aR5h9mpG+zpbFXHMQ28zpuQmF6cwDi8=;
        b=FI5f4d6jmOWtu9NdOUGGfskULsg92OfGOtEG+jFTQxK2YNKk5HvlGo0/FHwhIeLjoh
         lJaRMqKdaD3PojWSbH6Ac8mjRAD7cT6mCUzZtCeckVTUszfoyb4FS1c/SFgxhzdJU3xX
         YvNa+2nppajnh3G2xdDnntrff3fUUxw+PiWBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720963927; x=1721568727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27MHSoLpOVK9aR5h9mpG+zpbFXHMQ28zpuQmF6cwDi8=;
        b=czM1CVoYqwgH/40su+gJJJYZCXPjwHGSqvutDLbwn0ij9ZlGwE1iQy9QnyCv8J+dbp
         6e8kqQ6NanTCXJAMLaU4i6gvIOADjoYKnMDdYGVBTTYONpkFK7NUVtXmZf1hdwwGX2RN
         WSqdPRVSRxx57IbtQCtfYnCSGZZtf6epfdUnS+75WoLTlxbuOKr5oaDEDdA8OSNEER2B
         FPasAEXbKKqaMbcCu6uXG4Aj2ZGTlteIcqWtdWx5c8UFnwhMdfCgI2nLtPMf2i0jG+da
         B/T+WMLpV4sMSm7CVdfNZA/gb2AkNgMntI/VEYxcHRxQk1du8fE6Z+Ne+N6NGJQC0n+1
         SMpA==
X-Forwarded-Encrypted: i=1; AJvYcCV8emisv8DUfwnOUss0gwBxRqf1GfX7s03iWlXXgMecNwirjDCiMH8iA5GpQ1upS4lwLYViMO5eAKGGL6gZvAyDi0r/rdrItn8xv6K/bGRLe4GEUvU=
X-Gm-Message-State: AOJu0Yxod5wEjE2zTBhsdikvjjlwiTptnf68EPL3lvZE5h9Jqj43VL2p
	TWKJS+tXjmfOt+e51SvdtXonJ8MlWpsdCowX9sFsmscFFOCbxZDwy4BoFmgUC1g=
X-Google-Smtp-Source: AGHT+IGUcspYujxZJLLtbvA6Gme3xjpTvpWZI3A9vsXrmpEg7mh+LtuPiyWumGSAsuFYIQ7AzppjRg==
X-Received: by 2002:a05:6000:156d:b0:367:f054:620a with SMTP id ffacd0b85a97d-367f0546307mr10733393f8f.30.1720963926481;
        Sun, 14 Jul 2024 06:32:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac74:33a8:48d1:ad5c? ([2001:8b0:aba:5f3c:ac74:33a8:48d1:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04581sm3858454f8f.97.2024.07.14.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 06:32:06 -0700 (PDT)
Message-ID: <2fd20e75418badc5562e1f2faf340fae0e7ab891.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 14 Jul 2024 14:32:05 +0100
In-Reply-To: <6b671da0-070e-4f1c-a7cb-a3331f363a05@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
	 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
	 <96618974b45a07b06a312079646c6bf49c1474d8.camel@linuxfoundation.org>
	 <6b671da0-070e-4f1c-a7cb-a3331f363a05@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 13:32:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16421

On Sun, 2024-07-14 at 21:03 +0800, Robert Yang wrote:
> Hi RP,
>=20
> On 7/14/24 19:17, Richard Purdie wrote:
> > On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via
> > lists.openembedded.org wrote:
> > > From: Robert Yang <liezhi.yang@windriver.com>
> > >=20
> > > The previous code added local path to generated mirror tarball
> > > name which had
> > > two potential issues when fetch from local PREMIRROR, for
> > > exapmle:
> > >=20
> > > Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
> > > $ bitbake lsof -cfetch
> > >=20
> > > * There might be "Fix File name too long error" when the local
> > > path is long
> > > =C2=A0=C2=A0 since the path is translated to filename and added to
> > > downloads/git2/ as:
> > > =C2=A0=C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
> > >=20
> > > * When enable BB_GENERATE_MIRROR_TARBALLS:
> > > =C2=A0=C2=A0 The tarball name will be:
> > > =C2=A0=C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.ta=
r.gz
> > >=20
> > > =C2=A0=C2=A0 The above tarball can't be re-used by do_fetch since bit=
bake
> > > looks for
> > > =C2=A0=C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the
> > > 'path.to.local.PREMIRROR' in
> > > =C2=A0=C2=A0 the file name breaks the match.
> > >=20
> > > Use os.path.basename(ud.path) as gitsrcname when ud.proto is file
> > > can fix the
> > > the above two issues, now the file name in downloads/git2/ is:
> > > github.com.lsof-org.lsof
> > >=20
> > > And the generated tarball is:
> > > git2_github.com.lsof-org.lsof.tar.gz
> > >=20
> > > Or when BB_GIT_SHALLOW is enabled:
> > > gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
> > >=20
> > > And the tarballs can be re-used by do_fetch.
> > >=20
> > > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> > > ---
> > > =C2=A0=C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
> > > =C2=A0=C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/bitbake/lib/bb/fetch2/git.py
> > > b/bitbake/lib/bb/fetch2/git.py
> > > index c7ff769fdf..89d3268f7f 100644
> > > --- a/bitbake/lib/bb/fetch2/git.py
> > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > @@ -277,7 +277,10 @@ class Git(FetchMethod):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedrev[=
name] =3D ud.revisions[name]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revisi=
on(ud,
> > > d, name)
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (=
ud.host.replace(':', '.'),
> > > ud.path.replace('/', '.').replace('*', '.').replace('
> > > ','_').replace('(', '_').replace(')', '_'))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file"=
:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s' % os.path.basename(ud.path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s%s' % (ud.host.replace(':', '.'),
> > > ud.path.replace('/', '.').replace('*', '.').replace('
> > > ','_').replace('(', '_').replace(')', '_'))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.=
startswith('.'):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 gitsrcname =3D gitsrcname[1:]
> > > =C2=A0=20
> >=20
> > I started to review this, then I started wondering why we have
> > mirror
> > tarballs being created for local file:// urls? Does that make
> > sense?
>=20
> This patch fixed two issues:
>=20
> 1) "File name too long error" when fetch from PREMIRROR
> 2) Git mirror tarball contains local path when file://
>=20
> Create git mirror tarball for file:// doesn't make much sense, but
> the problem
> is the first issue, there would be the error when len(path) > 255
> (The NAME_MAX).

I understand that. However:

a) why it is looking for a file:// url in PREMIRRORS?
b) why does it consider mirror tarballs for a file:// url?

I'm not sure it should be doing either of those things?

Cheers,

Richard

