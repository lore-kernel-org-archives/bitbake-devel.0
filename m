Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D0C54E90
	for <webhook@archiver.kernel.org>; Sun, 25 May 2025 15:17:15 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.11030.1748186227752461538
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 May 2025 08:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GLQxcjcA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a37ed01aa0so1489674f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748186226; x=1748791026; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcm+ihOFHNRH34XHYQbrH5RBwUagcBsHa+C+w9upujQ=;
        b=GLQxcjcAhiH1+X0P+iSsTN58Gc+wUvQgNynZe1mMNe4dWdL9qldF5MR2WctyBKiv8V
         +yoDRBEn8sC17bDLTTbvwdceQwvmN8iqA0iktofJMn7aqtSv3mUT32k0CHacIgNqvNWt
         SAqxt6f/RgDzHqvsbgy6ah7yHrvRhAMcLSMt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748186226; x=1748791026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcm+ihOFHNRH34XHYQbrH5RBwUagcBsHa+C+w9upujQ=;
        b=gajWAttbIOhcutFMR59mDRwSjHcxjK1gSUubVojzIK0aT0c03j2+HF7+BxpryKepVs
         p/EWbXIJBYdKv0WqN3NH9bt1KMEUJvcaDNxBhTOD0bLOZ6XeN3XPBaltsEB8SVQGZ5N5
         SCT1UqDqqpC+mFZ07+6B9PhhZIKbdq4SCZ+pzYfhEBlHcMKm2CSDT6SK3CQxELIYqIa2
         plLrXHMJuE5CUb5TqdVlYE1KTE90l9ulIPMfWeSNIstb9kKmip2Na/pNWQTsmzXG3zat
         QXQVwFJQ4wqjUIp17kzM6uP3+Jaedvts18RsUXHfZXsfC9RgQru5LPa5c/mCARS7Z8Re
         LVvw==
X-Forwarded-Encrypted: i=1; AJvYcCVMQv2f2iPYdKFYUA1prfsYRKgiPD+yTyv6AizTb9Mf4+i5X8qq5wV2J2DZoTNL8h+LShCHM489W8BzeL3o@lists.openembedded.org
X-Gm-Message-State: AOJu0YxdaUO/OtFJj47XdCYmbBX1LZTxZkITPS+WluN1eUQwWELaQ2Ji
	oZ1Iz6mS6NdOCkE/UiK7Z0MUcNc6X2UhtS2/XMBaiMIhsrI60IcDhr/bqVQhw7MMeXY=
X-Gm-Gg: ASbGncsP9XS1i9YMzvFrj4xyxjYIQLUIMJVK/bC0MEIVForCqqGcAukdVc+NQkzExS+
	0lwtD8BpTrUoElE9A9yOevVL48xzD2Q/hnDm9oRGJzRY23mFYa75Ds8dpDVS0aylaxee174hlua
	g03/26Qz8nuk1UVZKk7iAVF5zrQZaBKZFlj9uk4bhNFPS60uDOhyGkka0ECL2U9xgDzEEADGrZy
	X1KUF3Sty315lACmL+GvpHBKIBQZ867Z+in8MkR2PQwcKmfCF4u9MVTaBC1fqt5kLsmBywGRzHC
	r2SSc0r/cBZ6qie9ECwGLH8ABsjEBl6bBrT7aJDOwvBMX6DDLSo0cK6XmKpP7AUioXl/Yds5j3+
	ZeZF/rAmNUU6CPRT7vztW4A1p2F4MPLHYb5v6RAnZ
X-Google-Smtp-Source: AGHT+IE95Ohbm8Jm4jd1SK11SMp5a1j3MnS5+gDml5/BF/37SCcfXd3wSePFdXUEkDan6L8bWIVZyg==
X-Received: by 2002:a5d:588f:0:b0:3a3:5cca:a539 with SMTP id ffacd0b85a97d-3a4cb449e4cmr5195954f8f.20.1748186225858;
        Sun, 25 May 2025 08:17:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3? ([2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c868745esm6355278f8f.30.2025.05.25.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 08:17:05 -0700 (PDT)
Message-ID: <516644857309fdc44a25bfcd51695e9b527e1df0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 25 May 2025 16:17:04 +0100
In-Reply-To: <DM8PR12MB54301F0296D2101CFAFF2E168B9AA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <4dbdecf888d3d81cb0bc81d172c45f410e8b5667.camel@linuxfoundation.org>
	 <DM8PR12MB54301F0296D2101CFAFF2E168B9AA@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 15:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17639

On Sun, 2025-05-25 at 13:40 +0000, chris.laplante@agilent.com wrote:
> Hi Richard,
>=20
> > > I=E2=80=99m trying to wrap my head around how BB_WORKERCONTEXT doesn=
=E2=80=99t cause
> > task hash mismatches. For example:
> > >=20
> > > # Recipe which depends on something that deploys .bin files in
> > > DEPLOY_DIR_IMAGE
> > >=20
> > > def get_deployed_bin_files(d):
> > > =C2=A0=C2=A0=C2=A0 if d.getVar("BB_WORKERCONTEXT") !=3D "1":
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> > > =C2=A0=C2=A0=C2=A0 f =3D d.expand("${DEPLOY_DIR_IMAGE}/*.bin")
> > > =C2=A0=C2=A0=C2=A0 return " ".join(f)
> > >=20
> > > BIN_FILES =3D "${@get_deployed_bin_files(d)}"
> > >=20
> > > do_handle_bin_files() {
> > > =C2=A0=C2=A0=C2=A0 # do something with ${BIN_FILES}
> > > =C2=A0=C2=A0 ls ${BIN_FILES}
> > > }
> > >=20
> > > (Yes, this is a contrived example, and in practice I=E2=80=99d just e=
xpand the
> > > glob in the do_handle_bin_files task.)
> > >=20
> > >=20
> > > Why doesn=E2=80=99t BitBake flag this as a hash mismatch? Especially =
since
> > BB_WORKERCONTEXT is in BB_HASHEXCLUDE_COMMON. To be clear =E2=80=93 I=
=E2=80=99m
> > grateful that it works :), I just don=E2=80=99t really understand why.
> >=20
> > BB_HASHEXCLUDE_COMMON passes it into BB_BASEHASH_IGNORE_VARS and
> > BB_HASHCONFIG_IGNORE_VARS:
> >=20
> > BB_BASEHASH_IGNORE_VARS ?=3D "${BB_HASHEXCLUDE_COMMON}
> > PSEUDO_INCLUDE_PATHS BUILDHISTORY_DIR ...
> > BB_HASHCONFIG_IGNORE_VARS ?=3D "${BB_HASHEXCLUDE_COMMON} DATE
> > TIME SSH_AGENT_PID ...
> >=20
> > which means bitbake will ignore it when calculating the hashes, both fo=
r tasks
> > and for the base configuration. Since it isn't included in either worke=
r or non-
> > worker contexts, the hashes match and you don't see any warning?
>=20
> Sorry, I meant why doesn't=C2=A0 'BIN_FILES' value changing between parse=
s trigger the warning?=20

I'd have expected that to trigger an error and I suspect your real
world test case is slightly different and you're just getting lucky.

Cheers,

Richard

