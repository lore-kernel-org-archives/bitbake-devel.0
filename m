Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web12.7304.1620827340601287370
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 May 2021 06:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=m2pdbFXl;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id j26so23489822edf.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 May 2021 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+eDFX7Hg29FxaV3l5z1pi1PqeEydAWV19F5nUp79Hmk=;
        b=m2pdbFXlkcBKIPKEcCMQs3zCLq6eimYUbAdlj2JXSBwPo4Xv9fChJN1HVucZRezFOZ
         Vn27RzgGZWDORmQOTQ6HxpgYV3RcZnRWh0XMiAxvXrO0p1AslQlgHVhWyWghtCs+/Gil
         USZ8rSYPnbG0vxhO2nJqJ5aB+IfsaZ5fyRTh99d2OOjwtQFTeAFW75ybJPQ9WHu4Bwbv
         e1iAjFnX3wUbZ0ryCD4b++fKCPmDJeySJD7KR0HSAiHxD8wOTZTqaDgKu7+jS7jP/7oi
         ZqFoIcSzQSeDsf4NkTgvYdgfESQ5MbrZ2QSi/n6/ufj0NpXvrDNHx4RmULkA89Qt9jG4
         mgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+eDFX7Hg29FxaV3l5z1pi1PqeEydAWV19F5nUp79Hmk=;
        b=Bb+VGYGQGttNabTiwraiwH+z7SDe315jUuAmuyJ5z4x+msji7ytXwkXMYr5SXuA+DC
         yS1XL7Wj27EY+8b/pbzMeg1wKtclZETA/TTJaslr7bJ6dFPX4NYvW2IYT3I1yrUDT3Ev
         o8cyNV9dPO056a1gNN+XuEcS0Yj82GMjmSvK20CA5haA4oGzu1lw47+C9TnB0dcTWMOG
         rfj5eb8ZGWSzfTrwsSoh15zZCcDQEO0n+kegrCUQQb7uF3+TTVeFMniVj8TCGjUEpbzL
         ZLBh9qYckBuJ7gNHxNp0TtW3/HKd/lJweVEHY8HI99NDV1UpXBBXyIvBZ03aUf3bNN3I
         slMg==
X-Gm-Message-State: AOAM5302lvww5rSwlMhF7QyWctwEv3mPXTc55IqUs/A11sIfhLnMDpvN
	TVGgCWvC8YAvJzBxeh7onBM=
X-Google-Smtp-Source: ABdhPJyky8rKpaA5QDMtBaREHKPBG1oM7+2QKJhYX6ZwK3NXe4Mq9pRGCpf/cCn5Qk8Bs+6f/+JGlw==
X-Received: by 2002:a05:6402:30bc:: with SMTP id df28mr43367088edb.67.1620827339002;
        Wed, 12 May 2021 06:48:59 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a24sm17781141edr.74.2021.05.12.06.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:58 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 12 May 2021 15:48:57 +0200
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Yocto-mailing-list <yocto@yoctoproject.org>
Subject: Re: [bitbake-devel] Git Fetcher Branch Default
Message-ID: <20210512134857.nmxnmr5si6anlqbt@jama>
References: <CAB=6tBSrVooUvS4G_NDPUHrHTLjxoHqJ269AVHA2K+4guYzerw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=6tBSrVooUvS4G_NDPUHrHTLjxoHqJ269AVHA2K+4guYzerw@mail.gmail.com>
X-Groupsio-MsgNum: 12311
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ei5vvdtmrs55e3ed"
Content-Disposition: inline

--ei5vvdtmrs55e3ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 05:51:24AM -0700, Chuck Wolber wrote:
> I got a fetcher failure on go-systemd today, which puzzled me. That
> recipe has not changed in ages, and the SRCPV hash is clearly visible
> in the repository.
>=20
> After looking at it closer, it seems that github.com/coreos/go-systemd
> has changed its default branch from master to main about six days ago.
> This appears to break a fundamental assumption on the part of the
> fetcher when looking for SRCREV and SRCPV hashes.
>=20
> Looking at lib/bb/fetch2/git.py makes it evident that this is the
> case. I can trivially fix this with a .bbappend, but it seems to me
> that the fundamental default branch assumption needs to be updated.
>=20
> Has anyone discussed adding main to the list of default branches to
> try? If not, I may be able to come up with a patch, but the code does
> process default branches as a list, so I will need to think a bit on
> the best way to approach this. Any guidance would be appreciated.

I agree it's a bit annoying that some projects have chosen to rename the
existing branches instead of just adopting "main" to be the default
branch only for new projects (as the defaults changed e.g. on github).

I've already added explicit branch=3Dmain in 10+ recipes in various layers
for dunfell and newer branches (ostree in meta-oe just today or e.g.
https://github.com/ros/meta-ros/pull/846 yesterday).

Luckily it's easy to fix with local bbappend, so even people using
unsupported release (zeus and older) can do so or finally upgrade to
some supported release which might have this fix already.

It was also discussed shortly in #yocto yeasterday:

22:38 < zeddii> RP: did we come up with a policy on anything we can do
with the fetcher to make "main" be a fallback default to master. Or was
the end decision to just add explicit branch statements everywhere ?
23:21 < RP> zeddii: I'm open to patch proposals or we just set the
branch on urls
23:23 < RP> zeddii: being explicit is perhaps the better option that
magic in the fetcher

And I agree with RP, especially because fetcher magic won't get
backported to old bitbake used in zeus and older anyway, so it won't
help there and backporting fetcher change locally will be more risky
than backporting simple SRC_URI change for individual recipes which need
it.

Regards,

--ei5vvdtmrs55e3ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCYJvcyQAKCRA3VSO3ZXaA
HBcRAJ4maeZv6jYu5vKNz1JFEU44m2VYHQCaAjPBB2JlhcnUTtqXbfMu917oKGE=
=GwxG
-----END PGP SIGNATURE-----

--ei5vvdtmrs55e3ed--
