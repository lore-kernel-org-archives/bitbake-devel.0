Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6557C49EA1
	for <webhook@archiver.kernel.org>; Tue,  6 Aug 2024 14:10:20 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.8208.1722953415779668146
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Aug 2024 07:10:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UZtY59hn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.179, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f136e23229so7278551fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722953414; x=1723558214; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v9f4aJ0syC3Duoro7nCtexBKq+oC9PpSMmb7v1y9fs=;
        b=UZtY59hna0xnRd3Y5S5IlgxZzpbyqnOmPVudilz/4yqFWbo0Xb14fxxFpHVEGD4C6Z
         yOMOLxSG0ts0R8N5xotCbWDS0Qt/1pW/j7xP3kONjV05kCIl54r8+T9oPLMobDfdmp9F
         sDqhrUk58o1eLmna0iL2eSjeEC1UqSrsqqQio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953414; x=1723558214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2v9f4aJ0syC3Duoro7nCtexBKq+oC9PpSMmb7v1y9fs=;
        b=VuWupIWYSrKDkYKDs7HY50OXLnzfggj1eiIh36J9y/CJv/KoH3LsM2Yar1Au/E+i2X
         m9JaQKNDg3o+bHSUtQsdHX6QmseqTuIeObaOOKQoFmdJ5OoGBZJuxgNvFNKwlxCFe7Lk
         HFPhcl3GJspaaoyLHEqjUYCYd/BnRilxNoWAviwZfvd83c0wYWfYpGVCgIXsXEoHECqd
         VaP5Xz7Wv4QaGFwC2oAdiAM95gpvHpd2yBd8NLmUNUBvueYEvPQtTQ0ryGQy5io1uOW3
         2yeNVgYduhGA8SfxJIXQJ2RZAWpP0qoDYOyjqzf0ZH7MuGEyyhe6Cws+cktC4jYxDOZk
         CZGw==
X-Forwarded-Encrypted: i=1; AJvYcCXrexzaHSZsujO8KSCr4HYlfljD2HHssyP9pJ7AF2CV9qIBumREzCcLa9P5S3HIcaG4k/09hPq1CCkWNPJZGS0RNBOYCjGd6YVqrulBpT7yiaAaacE=
X-Gm-Message-State: AOJu0Yw2uJoGar5T6BaouUYTMFIdWshrGhSWW+gis+BYrczZBjTdiXFS
	81CUJ5OZw2zvTMU1D73VmIPQtpHZPjx7/Y2MuoPbiro2c09XM3NZFD5w2T0MCTE=
X-Google-Smtp-Source: AGHT+IH90UXdgd/iiyLYfty/epVJjDXkE3RYNPv71/FyfE8IgmpDlalnjbTCOgJtrhYDkDsgRwSJoQ==
X-Received: by 2002:a2e:9e54:0:b0:2ef:2e0e:c888 with SMTP id 38308e7fff4ca-2f15ab53f7fmr106684171fa.48.1722953413697;
        Tue, 06 Aug 2024 07:10:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeae:cd04:92c6:bd93? ([2001:8b0:aba:5f3c:aeae:cd04:92c6:bd93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa86sm245363295e9.3.2024.08.06.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:10:13 -0700 (PDT)
Message-ID: <0aa2cd5ba0a59dfeb5810beb34130a0b9bd803db.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
 bitbake-devel@lists.openembedded.org, "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 06 Aug 2024 15:10:12 +0100
In-Reply-To: <e089ca2e-5834-42bb-998b-3515b2fccaed@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
	 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
	 <24cba6a8909e5b3470ca8e51812dc6f3138538dd.camel@linuxfoundation.org>
	 <e089ca2e-5834-42bb-998b-3515b2fccaed@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Aug 2024 14:10:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16449

On Tue, 2024-08-06 at 21:42 +0800, Robert Yang wrote:
> Hi RP and Ross,
>=20
> On 8/6/24 19:06, Richard Purdie wrote:
> > On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded.o=
rg wrote:
> > > From: Robert Yang <liezhi.yang@windriver.com>
> > >=20
> > > The previous code added local path to generated mirror tarball name w=
hich had
> > > two potential issues when fetch from local PREMIRROR, for exapmle:
> > >=20
> > > Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
> > > $ bitbake lsof -cfetch
> > >=20
> > > * There might be "Fix File name too long error" when the local path i=
s long
> > > =C2=A0=C2=A0 since the path is translated to filename and added to do=
wnloads/git2/ as:
> > > =C2=A0=C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
> > >=20
> > > * When enable BB_GENERATE_MIRROR_TARBALLS:
> > > =C2=A0=C2=A0 The tarball name will be:
> > > =C2=A0=C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.ta=
r.gz
> > >=20
> > > =C2=A0=C2=A0 The above tarball can't be re-used by do_fetch since bit=
bake looks for
> > > =C2=A0=C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to=
.local.PREMIRROR' in
> > > =C2=A0=C2=A0 the file name breaks the match.
> > >=20
> > > Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can=
 fix the
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
> > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git=
.py
> > > index c7ff769fdf..89d3268f7f 100644
> > > --- a/bitbake/lib/bb/fetch2/git.py
> > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > @@ -277,7 +277,10 @@ class Git(FetchMethod):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedrev[=
name] =3D ud.revisions[name]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revisi=
on(ud, d, name)
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (=
ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').repl=
ace(' ','_').replace('(', '_').replace(')', '_'))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file"=
:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s' % os.path.basename(ud.path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
itsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.'=
).replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.=
startswith('.'):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 gitsrcname =3D gitsrcname[1:]
> >=20
> >=20
> > I did look at this patch again. I'm still not convinced about the
> > original use case but ignoring that, the patch itself isn't too safe.
>=20
> Thanks for looking into this, the main problem is that we need a way to f=
ix the
> filename too long error as described in the commit message above.
>=20
> > If you have two repositories with the same name, this can break since
> > basename() on the URI is not a unique value.
>=20
> If the two repos are identical, then it isn't a problem since bitbake
> can handle them correctly, if the two local repos with the same
> name but have different contents, I think that the user should fix their =
repos.

The trouble is that this doesn't just affect local repos, the contents
of DL_DIR can and will be shared as a public mirror so it is any two
repos with the same name, not just two local repos.

This is partly why I still think mirrors of local file repos don't make
sense.

Cheers,

Richard


