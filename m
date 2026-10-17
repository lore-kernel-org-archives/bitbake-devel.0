Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22BCCF2C4
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 15:02:33 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7980.1792249351412686131
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 08:02:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bWDLrUjy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so10185715e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792249349; x=1792854149; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eCEQbtVnImFRGVqMSCTd8yE46Pz6mMTg9FcJ9aDUfvc=;
        b=bWDLrUjyGpCcpHn1eg/1O0Avq5g4KB0txwBMBqUZRfOi0TmkaBiY8bJgwWTVy8+3TK
         EOInTAHc/EIZoQryi0bFNzpCI58xfZ7YLxm2wLuiPIotwXNMt5rQv91p1WdONUAR/ID/
         O6tEHnTfNyWlvmW6paHdXPX5igAmBkkaOIhU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792249349; x=1792854149;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCEQbtVnImFRGVqMSCTd8yE46Pz6mMTg9FcJ9aDUfvc=;
        b=DRFN6VulYYC1qfxcj0LurgDG16kSPbi69sBHUS44xwzV4G9W6KNa0AQ6Zr8tkI/EVe
         dRcFfv0Hf97oSIN351iZ9vpZLm7ep6Ms7whPwcH9O5jyE6Ui9Gxq98wgE+U6BWjGMbxa
         jui2Pmmb0o4/vOC6iOdSBc2kS2DKUq1WdqIaogjvqG187ERPKZFCvqJ40qGyWnF7YSOT
         2KGLXsq838kUSq4K1ND/I1bmt9yoYWLkqdq5GtJeam45dqi1BXqq/33qqofT9yEeDmwm
         FYhCeV2qhvCgC3nU3cBxuFqWuqkDF3TiCcViT4bS0ONVmDOqFtI30Y+th0n/JUKYnR+R
         TeMA==
X-Forwarded-Encrypted: i=1; AKwUvBzYce1aUkBQ2x6ILVNU4cSEDQIhbYNYKg3vnAeoNMipmaTyZduqHnSggLimCWUNvEWC4D9URTMcl7tkIaVn@lists.openembedded.org
X-Gm-Message-State: AFq9FYJFO5n29OxkOqU35Z67JQkb1ihee/4wdBwr8BV5KDMJJov690++
	eRNnP20zPsZgtCpskXGEvA/9FjGnHKmgoEfCeghgo7EqkzL0wF+03hx0mP6wj0lLZPo=
X-Gm-Gg: AYBFou0R6N4afKcZ9//Q3VJjvwxJ9jPlNPMBr1lb3Nzo4oPdJXZcJlcEggN7ZisIi9d
	RFBFa25UYR39NJQFjCP3Wq8oUbjNhEywITGpLPH9LoN+NtdIhH0m0sVxDCv/yaXexj/dNjfSIU8
	xqQUaI2dmwE3dWShKg++va0N8QEmvyYiOlFMcoqxyJyUGULIsQ1UFxU7qQuBCm9SErA2oIkeQPB
	s5q2PGMhixVMTKqP7BMILXvmIvh0HQFkLdSxA8CwgtP0l4jYtvAS8kWD7PEgANeEugHMUkxYlhq
	nbRzWovzE5yfv0OLjuo+17GH80BTuGKKgSJC6PFRfs267H6uLhffvt9jI5F5G05MHQA10OgSueH
	cthuJBUj3yvibPezvCQxpaeCZDzbRixZoq6HazAHQ4FqgyqXcgHYlr8Adc9Fd8RxFeWvNA5X5+t
	HRKm7oTIkdb7liIhPe5yKIlXDJq/OHhL+8gnTOt37xi1WCZgbLvZF1zO9B/cqXLcVAGcB1uV/5I
	mJloXAw9oDxuYf1KMWNnDl1ePy606/ng6PFxUMGseNlhHNhbbdNX0Nqg8tfHxM=
X-Received: by 2002:a05:6000:4021:b0:48e:cd3:b3ec with SMTP id ffacd0b85a97d-48e0cd3b575mr2946413f8f.28.1792249349334;
        Sat, 17 Oct 2026 08:02:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378? ([2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm12489786f8f.6.2026.10.17.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:02:28 -0700 (PDT)
Message-ID: <3cb5e5d5db79f81b58c943752dcff67e7c603308.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, michalwsieron@gmail.com, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2026 16:02:27 +0100
In-Reply-To: <DM6ADVADR7L1.F48JUYUSVTMF@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
	 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
	 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
	 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
	 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
	 <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
	 <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
	 <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
	 <2040945.1792137545176168291@lists.openembedded.org>
	 <DM6ADVADR7L1.F48JUYUSVTMF@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 15:02:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20354

On Fri, 2026-10-16 at 15:11 +0200, Antonin Godard via lists.openembedded.or=
g wrote:
> Hi,
>=20
> On Fri Oct 16, 2026 at 9:59 AM CEST, Michal Sieron via lists.openembedded=
.org wrote:
> > Hi,
> >=20
> > two cents from my side. I think that warnings as errors would ideally w=
ork like normal -Werror in compilers.
> >=20
> > 1. Regarding name: -W doesn't indicate anything about errors. Only some=
thing
> > =C2=A0=C2=A0 with warnings. I am not sure if having this short option i=
s worth it.
>=20
> I agree.
>=20
> > 2. This might be controversial, but ability to do -Wno-error, would be =
great.
> > =C2=A0=C2=A0 Problem is we don't have categorized/named warnings/errors=
. But I think
> > =C2=A0=C2=A0 that it could support a syntax where we use file name (or =
partial match on
> > =C2=A0=C2=A0 its path) and disable warnings-as-errors for that source f=
ile. Or this
> > =C2=A0=C2=A0 might be even easier to implement: regex for warning messa=
ge. It it
> > =C2=A0=C2=A0 matches, it won't be treated as an error.
>=20
> That sounds like an interesting idea - but maybe as a follow-up of this t=
hough?
>=20
> > 3. Exit code only change won't force developers to immediately fix thei=
r code
> > =C2=A0=C2=A0 as it's really easy to ignore in interactive terminals. Su=
re, later CI
> > =C2=A0=C2=A0 would catch it, but I would prefer early fail if possible.
>=20
> That's true - however, I checked again, and error messages originating fr=
om
> bb.error (or bberror) do NOT stop the execution of bitbake. This is the r=
ole of
> bb.fatal (or bbfatal). bb.error only affects the return code of bitbake, =
but
> goes as far as possible - for example I was able to build an image recipe=
 even
> though one of its recipes emitted a bb.error.
>=20
> So if we want warnings to act like errors, I think this is already what t=
his
> series does. If we want warnings/errors to act like bb.fatal, that's anot=
her
> question.

I should also mention that ERROR_QA and WARN_QA allow many warnings to
actually become errors. That is the mechanism we should really be
pointing people at if they want errors IMO...

Cheers,

Richard

