Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA8C36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:51:01 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.7104.1742388651140843856
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 05:50:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OuSN6dyG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913cf69784so5757553f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742388649; x=1742993449; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuP+ameQeTi2/+2zVMrJ6+r+1opwMiIaF/TRYBMLUpw=;
        b=OuSN6dyGdtb2zdxlELlVpqY39DkYJGmx12xiABkMd/uGfGaq6yhCT4mP8DUSJ/DPBL
         98QcW4keXd6w/ySEg64Y+zKZY28YTckCeQTcUt/J3CUcMqXSoqsNsTspoCMghcnPiEcl
         bFV2MvOZ47EFsIpu3Afhip52Mx0SZwMb3Fxbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388649; x=1742993449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VuP+ameQeTi2/+2zVMrJ6+r+1opwMiIaF/TRYBMLUpw=;
        b=LlZoo2RcipnPdG53JoHePD22Ua1q0sfBgXE0sR2pbx3DJWR2QuIa/M8BsMHHHCgUEl
         DbiY7zP3v1XUG/BvH/LkCVpfCcurhuJxzXrnXQGYntWI8pv4eEd1Q2Rr2R7XtwVtengo
         B8BrZJovHJque5F1lXVbN0HkzC2nAUWbVtQduI2NnEYibLZ/HqEbJy3js4VciqpPmhxI
         sXch+4N05GlXnQoiqjl67S8W8P2XdczfqDCME8v6pHvaQik1qrCo/6L7IAwULLqJCWCR
         pEWh0qt0djw+oJoK4QTnv6vW21hJZcJkNU7rVlggV1aPoyfN/yymMqRDLf4x7gO8k1ZY
         8uHg==
X-Forwarded-Encrypted: i=1; AJvYcCU28EiZRzUnGAmZgNcjznul6A9+IKDCw1iP4vUnusjLCcfcBHwY803e08vbVCHWJe5AIS+ZB3gv+kKxv/sz@lists.openembedded.org
X-Gm-Message-State: AOJu0Yybw2c/KXDTmSqWevSVBTPWwNRLQmWiJCeRPMd2oxrA+XVdlWfV
	Pon26gX379uts55ZkA99HYWzhpS5QH9mD+lGOsxx8u/uyp2NfsNc/1xene05xPa8YX9aN0+/Ycp
	n
X-Gm-Gg: ASbGncupvDmoQjNJwxtq9lj/5A9dJVP40yPjCZjJmIdM6z59Bly1X76bQcRbxo1eord
	dtEYiEQZntGJcowdhWhoYe2neALL4fY47bV8tjWIZNd/F9tZ8Nt4QxUh6oekKGW7KXloyjk3y0X
	yxFRtEBgsPiUbABtrKJ2armG3j9GichfwnDF5IZdTVQEFLPr8L6t8cArFWAtMT2akeKM63PSkci
	ZNc+xUMxj+cQGdMTHHpT+tCwRXfUWfhBnrOuVceYJCfB+Rk1ZHnFPf5/heDreNDBb5Gx3keLV9r
	GkiaWttX/LJ0k1/T2+l0RrhXeAKkccuZ5spwoGCoIQ/hO076gxfjx0gsi1sE0B3mrCLmm4ortWZ
	SYcbwHTpuLj05MVhysxslwiuaK24yNoQ=
X-Google-Smtp-Source: AGHT+IHDocM+vCPIwQVKcPCFYF3rJ7mC+GwIlovTRPRbytpmd0y735w8ImVWoRoHHducjaUWHxPpUw==
X-Received: by 2002:a5d:6c67:0:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-39973b0bfa4mr2439719f8f.46.1742388649458;
        Wed, 19 Mar 2025 05:50:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dad:b471:9c34:4577? ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39973c9d93bsm1969301f8f.65.2025.03.19.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:50:48 -0700 (PDT)
Message-ID: <2db6aadfea8825f563fae177b7512f5a7e2d0871.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] tests/fetch: Add missing branch
 parameter to tests
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 19 Mar 2025 12:50:48 +0000
In-Reply-To: <D8K96KOWTA7O.1V6GVNJ037FGZ@bootlin.com>
References: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
	 <D8K96KOWTA7O.1V6GVNJ037FGZ@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 12:51:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17467

On Wed, 2025-03-19 at 13:48 +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 12:35 AM CET, Richard Purdie via lists.openembedde=
d.org wrote:
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
>=20
> Hi Richard,
>=20
> We have some selftest failures on the AB, might it come from these
> patches?
>=20
> FAIL: test_gitfetch_tagandrev (bb.tests.fetch.FetcherNetworkTest.test_git=
fetch_tagandrev)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
> =C2=A0 File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake=
/lib/bb/tests/fetch.py", line 1093, in test_gitfetch_tagandrev
> =C2=A0=C2=A0=C2=A0 self.assertRaises(bb.fetch.FetchError, self.gitfetcher=
, url1, url2)
> AssertionError: FetchError not raised by gitfetcher
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/1130
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1216
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/76/builds/1170

Thanks. I am hoping that this was fixed in the version I just merged...

(it was complex as the test was broken and hence passed for the wrong
reasons. One of the patches fixed the breakage which then meant the
test started working and erroring).

Cheers,

Richard


