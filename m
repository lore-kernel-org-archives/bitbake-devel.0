Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D351C54E90
	for <webhook@archiver.kernel.org>; Thu, 22 May 2025 11:32:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.21670.1747913566110537575
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 May 2025 04:32:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GBgtYfeI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so66032115e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 May 2025 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747913564; x=1748518364; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akaW5aEOwbT/pqncYSA992LHWEFUKuS49ecZAWZmAak=;
        b=GBgtYfeIE2ObltrjGeSiKuSTlK84r71f1qmhuXY2dGju/11m1on/8Ob7RIncs8PLxK
         Ryp10f/R6ySbQUo+Oqj3eUh09iYK3MRFim0cqobkPFyXAak7ZAmB2bKqwa4spj1Hw/l5
         Js8jYqDlUpUTwvm3m41xyLCaurq1CFi6OBHLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747913564; x=1748518364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akaW5aEOwbT/pqncYSA992LHWEFUKuS49ecZAWZmAak=;
        b=hJwVYYT77oBS+1m50AvnKd2dvRjX3tspNODgU8zPw4dWr/JGgVzIfA5iWLZnacS0LX
         cADynGpmH3SkZECq5dWKkZPacI4F2FxJN8xMFyfu7NynxmOOX/Dj5A+xyRiPU180hDff
         s2DU9S8Szs61FbBfZPXODRUjj8nzqYxC1sa4fYWJG2lZuFhZ1nqVEUk5EmB73WEDzO3M
         85HuFx1QlkZFkfOW2EY+BOuMHk+pcngyhptKsaOsBb8CBGAtsDHUvNcPtoVTIMfQmfA8
         zhXKbtFax7BQTIABFMOpSqL8r2FlD+haQN17yCuSQCB+Whge//KROvIlMI45xrTCCgqd
         YyCw==
X-Forwarded-Encrypted: i=1; AJvYcCXgKC0GU0UZ4jNIJD5fW1UOCenbuXolYnAbhVCMOdKD9YkcykWWO4lFUhp78PQK/iNfu5hES4rPg8QvwREo@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy7c4X9N0C8SustSim1R8irenjTqoqHiKsAFeAhi5So9D1hxuVF
	x5HAiVhQQyL9emJqO0mL8LjVyqwj7WmUN8fb0Hif+0kPLSudaAg5E7VUghkRz/Y4Uic=
X-Gm-Gg: ASbGncsHjSL6/oXJp8Rvq71I/QW00kXoEiPGp5T6MZ2Xl6XOqBwoakCn+fU9AeZN300
	J+JrY9JTgL0G1oERrt/fFfTM0TX4o1XpLQKPUfUZItuydempBnAKrP5nrNVa86p83slcFnNTVTO
	qb1U2mycVnEIglD5jEky10uAQ7BC0EE+n178tnNx/Mizd/j++94hjQe6swT6M7fqZg8lv1foLxR
	26R1AuR+0mqc422cLvjdSERdlhB0qWpNIr0SJyFReZlXtrm2TbqU8wrQkCK5uEPb4TZ32C30ddQ
	2r/1wUfi8gSgzETKAFHhMG0cWLyNAM27C0elAFdzRHO2dZV4KimlOJLf/Y3MS+PS0UlcG8690x0
	X94R2FOppaENtSJ/TRRA7Mi+cSYcluIL8/My+59nP
X-Google-Smtp-Source: AGHT+IELeM3/uMk+/q2R8lTYOwSNRRVtuFighpwE+693hwNVbk8SM7KEpxDeiqYWm3ZvcEAUTPMLNQ==
X-Received: by 2002:a05:600c:c0da:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-442fe667ec9mr188236635e9.29.1747913563812;
        Thu, 22 May 2025 04:32:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f7cf:689b:6e57:f0de? ([2001:8b0:aba:5f3c:f7cf:689b:6e57:f0de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-448ba3d8facsm80323255e9.6.2025.05.22.04.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:32:43 -0700 (PDT)
Message-ID: <b1e217227e179aa3789e0fd3263da04e14966c0d.camel@linuxfoundation.org>
Subject: Re: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Koch, Stefan" <stefan-koch@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "docs@lists.yoctoproject.org"	
 <docs@lists.yoctoproject.org>, "liezhi.yang@windriver.com"	
 <liezhi.yang@windriver.com>, "niqingliang2003@gmail.com"	
 <niqingliang2003@gmail.com>, "alex.kanavin@gmail.com"
 <alex.kanavin@gmail.com>
Date: Thu, 22 May 2025 12:32:42 +0100
In-Reply-To: <52082b629ebcc83f94f2768620a2867a1f027059.camel@siemens.com>
References: <20250521163311.2745308-1-stefan-koch@siemens.com>
		 <d11158333f8ac0f2d6525e593ba7dd0ce6a57369.camel@linuxfoundation.org>
	 <52082b629ebcc83f94f2768620a2867a1f027059.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 May 2025 11:32:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17631

On Thu, 2025-05-22 at 11:24 +0000, Koch, Stefan wrote:
> On Thu, 2025-05-22 at 12:12 +0100, Richard Purdie wrote:
> > On Wed, 2025-05-21 at 18:33 +0200, Stefan Koch wrote:
> > > - Since `ud.path` contains in that case the `PREMIRRORS` prefix
> > > path,
> > > =C2=A0 this change ensures that a correct symlink is set up.
> > >=20
> > > Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> > > ---
> > > =C2=A0lib/bb/fetch2/__init__.py | 5 +++++
> > > =C2=A01 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/lib/bb/fetch2/__init__.py
> > > b/lib/bb/fetch2/__init__.py
> > > index 2de4f4f8c..052505456 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -1117,7 +1117,12 @@ def try_mirror_url(fetch, origud, ud, ld,
> > > check =3D False):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 origud.method.build_mir=
ror_data(origud, ld)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return origud.localpath
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Otherwise the resu=
lt is a local file:// and we symlink
> > > to it
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # This could also be a li=
nk to a shallow archive
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensure_symlink(ud.lo=
calpath, origud.localpath)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # When using shallow mode=
, add a symlink to the original
> > > fullshallow
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # path to ensure a valid =
symlink even in the
> > > `PREMIRRORS`
> > > case
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if getattr(ud, 'shallow',=
 False) and not
> > > os.path.exists(origud.fullshallow):
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
nsure_symlink(ud.localpath, origud.fullshallow)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_stamp(origud,=
 ld)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ud.localpath
> >=20
> > I guess the one problem here is that we're teaching a general
> > function
> > in __init__ a fetcher specific issue :/.
> >=20
> I thought so, too.
>=20
> Anyway, I have decided for the symlink solution for two reasons:
> - the PREMIRRORS logic is handled overall within __init__
> - there is already one symlink created
>=20
> > Ideally we probably should have some fetcher specific function
> > calls
> > for this to preserve the independence of the parent methods...
> Another option I had thought about is to store the origud.path
> somewhere and reuse it in the git fetcher. Then the archive could be
> saved with the correct name instead of adding an additional symlink.
>=20
> Question here: Is this free of another side-effects?
>=20

The trouble is that doesn't nest, you can have mirrors of mirrors or
mirrors. That can be handled with a chain of symlinks.

I think the right solution here is a specific new method for fetchers
which is called after premirrors to put links in place.

The default would be:

ensure_symlink(ud.localpath, origud.localpath)

however the git fetcher would append the shallow logic.

Something like:

FetchMethod()
    def update_mirror_links(ud, origud):
        ensure_symlink(ud.localpath, origud.localpath)

Git(FetchMethod):
    def update_mirror_links(ud, origud):
        super().update_mirror_links(ud, origud)
        if ud,shallow and not os.path.exists(origud.fullshallow):
            ensure_symlink(ud.localpath, origud.fullshallow)


Cheers,

Richard

