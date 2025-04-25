Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB9C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:58:39 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5879.1745585914473618164
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 05:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ekveqB/T;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1491919f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745585913; x=1746190713; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6JOcmqUZDFyeuecub2FhaCE+h5zE42ShcRBE+QWjik=;
        b=ekveqB/TRrFQfFvn06AYx2Ug/7SaR/FzpYuK7nmjgkCpN31I42Avx39paL2Il9ZiUs
         y/BN5g9l5cfkVhv02XNjpVVdrYIGdMT98fpmEVrSbGz1mIMD0dfXj33AA225axrtgc2s
         dYN1BtPcIx03Zp6lbar6S7RjZosv2FxLW4ujg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585913; x=1746190713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6JOcmqUZDFyeuecub2FhaCE+h5zE42ShcRBE+QWjik=;
        b=FOWqDFvGbdyfrdnCOYNeJfRF+O1AhEga9UdUjxyzgxQzGSRyZYvtHmbUQJBhf+1thC
         Deh6Nah1pJ+SeC4uLRAlAfL/yS4DHtZE4XASoK0YkkWrhO9/w1KxFrelvZsuqyjOkuXc
         DGxlbVRet3ZiQDbMw7GRs633rgrstdmqT9eJ39abOsU9gWbkxMptnScKjDqcJK1Zv5Du
         k0heN21KVbuojqmaGXbiFS7FZ9twkVd/AQPXBnJiF25pJF1CqKODPhfMizrynEWBdTHQ
         Ojal6TBZ+HgcwgadlE7y3vZsnhNGLujwL0w3BZH5nMpuqf8vNy/LXhA1mi5casUjnzgc
         m+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61sLV8QAZYLtnJGianKRJsppu6zHPJr7NOgrtqo+OOU8RxqF7zKF0kYc0h53qa+d0h3LAXK6cr3u2H74i@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy3UV63MIv6vo+dhsn6qzx4G4ip58k8wCme2pQCeLuC/l6JLDre
	7PxTjoEGKIFuMhy1tZWjlvV3+4cEs9DdqLgnxPhgm9IFWDj063W/zvL1SShgbEw=
X-Gm-Gg: ASbGncs+BZsivVhK6YsJ2DcK8ZS26E/Dk150QWRWRKnomUBw+KyXuWRmtnVnjzOO7Cs
	dvv4QtdCtvKlHZb6Sj42a6YoTyPOJ7V2Ljzsf8v7h08+Al+Cm6NSZkW8ymb4kvdZl/pJXsekLad
	Fg/rlhpidDXnZqehchzVjYXEaKmQkmWeR03rXa3zyUqe8/Ur+LXGKJ4j+3IttvSEhKN1LcT9YC5
	5MNmBLMptY/rPj54HvOpsOrnDxzLbDrar+Vn2qMAov+v+6Qk1Bz4NZGjVNC1psQlbPx0fKzxAtj
	30ID1Dg0AYW+K14a0HTc58Q+8cYkKfSqxivNg30jxjZFy2qSoefP7Azc8qBg/6eTg9twcDLufSq
	/lFq86uWAwIe9gqlt39WQpQSr1F/QjLSHITSPYMSC
X-Google-Smtp-Source: AGHT+IEomLSrjF8SLeY2KXw2KceoVTN16f16n7dEgXJnd2J0Jol+vG6Q9ATEuxJV7PD60LPuHSdiGA==
X-Received: by 2002:a5d:5f8b:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-3a06d641db8mr5438511f8f.4.1745585912873;
        Fri, 25 Apr 2025 05:58:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4b43:cc8c:5e78:12c1? ([2001:8b0:aba:5f3c:4b43:cc8c:5e78:12c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d264sm2335175f8f.95.2025.04.25.05.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:58:32 -0700 (PDT)
Message-ID: <8cafce5a8d505bab25b5fa1e5ca0220df667dca6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Marko, Peter" <Peter.Marko@siemens.com>, "philip.lorenz@bmw.de"
	 <philip.lorenz@bmw.de>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>
Date: Fri, 25 Apr 2025 13:58:31 +0100
In-Reply-To: <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
	 <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
	 <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 12:58:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17568

On Fri, 2025-04-25 at 12:45 +0000, Marko, Peter wrote:
>=20
>=20
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> > lists.openembedded.org
> > Sent: Friday, April 25, 2025 14:36
> > To: philip.lorenz@bmw.de; bitbake-devel@lists.openembedded.org
> > Cc: mathieu.dubois-briand@bootlin.com
> > Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
> >=20
> > On Fri, 2025-04-25 at 12:11 +0200, Philip Lorenz via
> > lists.openembedded.org
> > wrote:
> > > This patch series fixes a number of issues we observed when using
> > > the
> > > gitsm fetcher in conjunction with git-lfs.
> > >=20
> > > I'd like to highlight two patches in this series:
> > > * 0004-fetch2-Simplify-git-LFS-detection: I could not come up
> > > with a
> > > =C2=A0 good reason on why the code so far preferred the content of
> > > =C2=A0`.gitattributes` on the repository's branch instead of always
> > > =C2=A0 considering the state of the target revision. Please let me
> > > know
> > > =C2=A0 if there's something I didn't take into account.
> > > * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I
> > > could not
> > > =C2=A0 replicate the `git-lfs fetch` behaviour in versions going back
> > > to
> > > =C2=A0 2.13.2 released in 2021. This leads me to believe that the
> > > issue
> > > =C2=A0 leading to this workaround is no longer in place. However, if
> > > anyone
> > > =C2=A0 remembers the actual issue / versions involved I can also
> > > retest to
> > > =C2=A0 confirm that there are no regression.
> > >=20
> > > ---
> > > V1 -> V2:
> > > * The correct parameter is now passed for each submodule URL when
> > > LFS is
> > > =C2=A0 explicitly disabled
> > > * Smudging for submodules is now skipped when LFS is explcitly
> > > disabled.
> > > =C2=A0 This ensures consistent behaviour in setups where git-lfs is
> > > installed
> > > =C2=A0 but should not be used.
> > > * Test cases are extended to test the LFS disabled state.
> > > * Explicitly install git lfs into submodule in the test cases to
> > > make
> > > =C2=A0 sure that git-lfs is actually used for storing the files.
> > >=20
> > > Philip Lorenz (8):
> > > =C2=A0 fetch2: Clean up no longer used name parameter
> > > =C2=A0 tests/fetch: Move commonly used imports to top
> > > =C2=A0 fetch2: Check for git-lfs existence before using it
> > > =C2=A0 fetch2: Simplify git LFS detection
> > > =C2=A0 fetch2: Use git-lfs fetch to download objects
> > > =C2=A0 fetch2: Fix incorrect lfs parametrization for submodules
> > > =C2=A0 fetch2: Fix LFS object checkout in submodules
> > > =C2=A0 tests/fetch: Test gitsm with LFS
> > >=20
> > > =C2=A0lib/bb/fetch2/git.py=C2=A0=C2=A0 |=C2=A0 69 ++++++----------
> > > =C2=A0lib/bb/fetch2/gitsm.py |=C2=A0 13 ++-
> > > =C2=A0lib/bb/tests/fetch.py=C2=A0 | 183 +++++++++++++++++++++++++++++=
+-----
> > > ------
> > > =C2=A03 files changed, 163 insertions(+), 102 deletions(-)
> >=20
> > With this series applied, OE-Core throws a lot of errors, see
> > below.
> > I'm not convinced we have that much LFS use so something seems
> > wrong...
> >=20
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1465=
/steps/13/log
> > s/stdio
>=20
> I think what is wrong is the default for lfs (enabled).
> It badly chosen default if lfs is not a requirement and whole core
> builds without it.
>=20
> Adding additional commit to switch lfs default to disabled should
> solve it.
> I think it will not break the core itself as until now it built
> successfully without git-lfs installed, but migration note will be
> needed for the custom layers.

I'm not quite convinced that it is a "default". The code was meant to
detect if lfs was needed and error if the tool wasn't present or the
repo wasn't specifically marked as needing lfs.

I think we have the following scenarios:

url has no lfs listed - error if lfs detected

url has lfs=3D0 - don't do anything with lfs and we don't need git-lfs

url has lfs=3D1 - error if git-lfs isn't present

Cheers,

Richard


