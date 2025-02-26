Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70356C021BC
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.1835.1740560340617401568
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 00:59:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FSBMsOuG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so3455575e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 00:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740560339; x=1741165139; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1CmtTpZVLRSjxUddt7ViB+C5fsvrj+nJjU3MeFHxLso=;
        b=FSBMsOuGewtx0VNnAitM3ryB0ShVkwVpjITYVLM6rqlXjli5vRumyupgAlWc0S2H1d
         m2IFOmItMyzLP6ncF1OTXXWhIyWyDZ6PJjch3CtsJ/MvuI5Gie0bMeDCnR0Ijl16UqXW
         BjAsYOUuEVsdRsO6+5Gj33Fuzqs7fam6Y5cSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560339; x=1741165139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CmtTpZVLRSjxUddt7ViB+C5fsvrj+nJjU3MeFHxLso=;
        b=tVcFdHo7kiX9aJsUyZgT7NtRiIvbo4hW9mreGVOnwApF9GLWknnPsI+GZ4SUrYzmZ3
         V2oyeOTsqH5CSqbeUmJpJrIeq3ivYUsjp0Wu3Aa5tVbUCOzOoMEqxBIdqvPNCVoG7AOV
         gZXzkY2pt0inEbFROeDXdTTvExTO91ecF7+gqnpDzc4Zewk7MCHcLEPORId/8D193EXp
         FiueEbPvLEseCCq6BOjyzR6zeCC5cLaq62Fb8k52VHsPYW/fZKoxn+jZLOMIIvSTrdHO
         Hx0jWkDD9/rLqhdgZDfVQ0MfWxYmTijGK/CJW5InUyeVHE6F78wzHgV0AgKgdl0mAzHp
         DMDA==
X-Forwarded-Encrypted: i=1; AJvYcCUIHQyCh0EdCRrw6lfE2tY3DbVG2ZeGJ+aEbfQPuXWwDqrql3vUR5OhjVRSYyBGh+l6QmoF/ZFOYcIn8hpV@lists.openembedded.org
X-Gm-Message-State: AOJu0YxxNPlwHKWa1/v2z3t7zhkfPvvfFOSbZHiFmF0jijXYTYBEvDCF
	IIABL5HEr2qa6Z4jchc9xH3PhcO9vBBzj9pKPPph0RJwdOIPZPzDm9E06wYpBdQ=
X-Gm-Gg: ASbGncuNzQjIWZapFHsAl6/5YqS5dp+vHynxsKiDl3OkwXVYd+PONkuGctTkZTentGO
	6/3mZ+PClc1APbLmwlY93aGyCX7Fp6caZX09fz0Yz4sB1jeeXXMDBVEs/cHs3YLYIJt+BZrvVMQ
	MlvBbC7VYhJLtT97mBSKEa7mievukn91fO9ox2L5tm8S9lTR4kV1Klts5oTCtfMvAHa1lQ4kHOm
	vPaClHJWvYMa0cMNH6Vm5m3lOiDxWZz72o87tpMSCm+6orF9aj9njRauDj6f4VUlJWkwSZSZY+C
	dgX6Vh6PDUUwvKGKQcrshnGj4YlINN1vacNIgKL/cJvO8Pas/rwIoroDPHCw3o81zxLhlX2+/kv
	vteVTR45rNTawRT0=
X-Google-Smtp-Source: AGHT+IE3m9rX6wlyHPYl6ihYJi/hZ6sJrmpXasgyxkOokL2lrBpBlWRKrxIc52i8OhEtjmp78Ll8WA==
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr165836195e9.4.1740560338974;
        Wed, 26 Feb 2025 00:58:58 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5bde:6c25:9c05:f012? ([2001:8b0:aba:5f3c:5bde:6c25:9c05:f012])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532d7asm13663845e9.13.2025.02.26.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:58:57 -0800 (PST)
Message-ID: <71d9ba0fa4b44a27f3e221b69039b816a882f522.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, "Koch,
 Stefan"	 <stefan-koch@siemens.com>, "bitbake-devel@lists.openembedded.org"	
 <bitbake-devel@lists.openembedded.org>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Date: Wed, 26 Feb 2025 08:58:56 +0000
In-Reply-To: <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
	 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
	 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
	 <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
	 <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
	 <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
	 <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 08:59:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17325

On Wed, 2025-02-26 at 09:39 +0100, Mathieu Dubois-Briand wrote:
> On Tue Feb 25, 2025 at 6:04 PM CET, Stefan Koch wrote:
> > So far, I can't reproduce the issue using a ubuntu 20.04 container.
> > git clone git://git.yoctoproject.org/poky
> > Patching subdir bitbake/
> > oe-selftest -r
> > devtool.DevtoolUpdateTests.test_devtool_git_submodules
> > bitbake git-submodule-test
> >=20
> > The current master-next branch from bitbake contains the v4
> > patches,
> > now. Do you still have the issue?
> > >=20
> >=20
> > --
> > Stefan Koch
> > Siemens AG
> > http://www.siemens.com/
>=20
>=20
> Hi Stefan,
>=20
> Yes, it does look like Richard had the same issue on his branch:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1045/s=
teps/14/logs/stdio
>=20
> I will try to provide you with an easy way to reproduce this failure.

The problem has now moved into an issue with the gitsm fetcher which
wraps the git fetcher.

oe-seltest -r archiver.Archiver.test_archiver_mode_mirror_gitsm_shallow

would be the command to run that specific test. I suspect the retry on
failure logic isn't working in gitsm.

I'm also still thinking we shouldn't expose that skip variable to users
as we're creating problematic API we'll then just have to maintain. I
agree we probably need the fallback logic just in case there are older
servers out there.

Cheers,

Richard

