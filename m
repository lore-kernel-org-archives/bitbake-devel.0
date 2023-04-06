Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8044C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 11:12:54 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.155688.1680779572192168199
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 04:12:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Czt2CpqN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id v1so39129946wrv.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 04:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680779570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jjmd15wy1j4OEPnEbwlmxgn7Eym13kevzZ+Aogv0qb8=;
        b=Czt2CpqNWKSDGVR7bK4xQbwG3tBQsZlIK5w6Ff7A9bgo9TNNjYYvilJJAJt8HXrSK+
         59JdDuLH2xB4s2h5ysH8nlYirXVuZktlXfEtpqldyzlurszrnaHpJ6KEpdSplcL6QQxQ
         wWnr4sT/tNHry+20ddLM5MVpHUVSmHGIiAalc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680779570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjmd15wy1j4OEPnEbwlmxgn7Eym13kevzZ+Aogv0qb8=;
        b=xburEw+PO2qtdcvHOr1s2dd8URir5+fwY56qZiiEWxGgFeXDeZcfqRFBm6m8jm8b7e
         6wnIqYxism1d76iFou1pfsUs/+nvlGeEw9oOhwiWp+dRdFx6zSxoz3TTDRT2jsnzwa8C
         Mr642GN4/ACJG1GTJ5nl3x4mVmcD7s2tsWybC9miL6eA6mkGqLUgobQ0xAedsDLkKmtc
         rL/XVcedvaV1NZ0ABds1c6XcewAy9VkwQuMou8o5HGkgn7wTCpXABIC2sZzFZI2dXLTo
         AuJZ/ailLijSctwMRQY5K6VL0M/v3qiSWHv7e+v5w/sgZfRcXNc1s5lQ3vQ/xxyRBBGu
         l1pA==
X-Gm-Message-State: AAQBX9fVVBbr1QdfeonHhfB7eE/SxBFegig6oZaMR6IQ6E8k68DE9Iy9
	dPedzdbSpYBS1UAWKgeoGjd6nA==
X-Google-Smtp-Source: AKy350bb69ryMDPlbfVcvYBvZUfWk2vJm/nHtJntromm3bZt6XTM+OElYpecOtBpockwikSAKCGfsg==
X-Received: by 2002:adf:e30e:0:b0:2c7:46f:c410 with SMTP id b14-20020adfe30e000000b002c7046fc410mr6122109wrj.36.1680779570530;
        Thu, 06 Apr 2023 04:12:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002c55306f6edsm1481452wrh.54.2023.04.06.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:12:50 -0700 (PDT)
Message-ID: <141e58560476f8401afcda5ace07bcc714428278.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url
 with parameters
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Steve Sakoman
	 <steve@sakoman.com>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 06 Apr 2023 12:12:49 +0100
In-Reply-To: <DB5PR02MB10213AA7D4BB051D113ED80A5EF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
	 <20230317081916.1857201-3-frederic.martinsons@gmail.com>
	 <DB5PR02MB10213D211F48E6ACF5D4505BFEF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
	 <37f0b57bb3fc25c4232378f94fb8d30929c53e6d.camel@linuxfoundation.org>
	 <DB5PR02MB10213AA7D4BB051D113ED80A5EF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 11:12:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14670

On Thu, 2023-04-06 at 10:56 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Sent: den 6 april 2023 10:43
> > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; Steve Sakoman
> > <steve@sakoman.com>
> > Cc: Frederic Martinsons <frederic.martinsons@gmail.com>; bitbake-
> > devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate ur=
l
> > with parameters
> >=20
> > On Thu, 2023-04-06 at 03:40 +0000, Peter Kjellerstedt wrote:
> > > Please cherry-pick this to Kirkstone and Langdale so that they can re=
ad
> > > updated recipes that use crate:// URIs with parameters.
> > >=20
> > > I assume it should be ok to cherry-pick part one of this series too, =
as
> > > long as you do not cherry-pick part two, as it would be a breaking
> > change.
> >=20
> > If we do this does this mean we're committing to forwards compatibility=
?=20
> > I'm not sure I like that precedent...
>=20
> While not a requirement, I sure hope we can strive for forward compatibil=
ity=20
> where it does not impact the older branches negatively. At least in cases=
=20
> where it affects parsability or involves parts that are hard to override=
=20
> in a higher layer.

The trouble is I take this patch, then next time something breaks you
tell me "in the past such changes were only made so that this didn't
break things" and quote it as precedent.

I worry a lot about people relying upon us doing this as it isn't a
guarantee we've ever made.

> The problem for me in this case is that Mickledore now requires that all=
=20
> URIs have a checksum, which basically requires that parameters are used=
=20
> for the crate:// URIs since it is quite common that recipes depend on
> multiple versions of the same crate and thus requires the name=3D paramet=
er.=20
> At the same time the crate fetcher in Kirkstone and Langdale will fail=
=20
> if any parameters are specified for the URIs. This means it is not possib=
le=20
> to use the same version of the generated crates.inc files, which causes=
=20
> a lot of maintenance burden.

I understand the problem but you're effectively asking we would always
do this going forward too :/.

> It is also very hard to modify the crate fetcher without actually modifyi=
ng=20
> OE-Core. At least I find my Python-fu lacking in regards to how I can
> monkeypatch the fetcher to use a modified version of crate.py.
>=20
> On the other, it is trivial for you to backport this patch to the two
> branches in OE-Core. And as long as the second patch in the series (which=
=20
> requires that checksums are used) is not backported, I cannot see that it=
=20
> should have any negative impact.

This change alone is fine. The behaviour where people expect older
layers to always work with newer code changes is what worries me, a
lot. We have done things to make this happen before and I'm not sure it
is good to continue the expectation.

Cheers,

Richard



