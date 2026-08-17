Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E8C5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 14:07:40 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30997.1786975650293178835
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 07:07:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aNPkMxeZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso23878035e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786975648; x=1787580448; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gtL7IZlQswGK8BfkBwMoX2DMmqcHLAYXb+YVcfG/FKc=;
        b=aNPkMxeZ6G+1SEJVPAa1fpyrHXcdWJSEfyhs5deYPgoa/zqbCUC7nZJYYLN1Gn8m6O
         46cYcot3RMxfKXQmuLJOFlrYyytofXf5xZr04xMHbU3SdlrknBcKTdHk7H5r9IH4+kJj
         /suZKmo0q7bqLQAdiY4XzspnN8A9jYJ+q699c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975648; x=1787580448;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtL7IZlQswGK8BfkBwMoX2DMmqcHLAYXb+YVcfG/FKc=;
        b=d9cVntBnrNXtr68NKgFt32ASHsUIdtfb3VYN30V6G6/mlnsCNpcG//DECDiPWe7+2D
         32f/nDVh2n2HENj3iRyMN0lqFauATJwygDtAfrJcndDEwKL7NYfYacXEvfsB1bQlfCwk
         5e1+YNCj8dwnTS65AdjyNCF17COi9lMu/Q39Z9gvYMahSQpRNULkjGfoHlZ2jFzqOiGb
         SYQkIVfAZRCyGUV3TxrWfNVNKsqW7iLXIVDkegL6S0hpvyhU4DR2t3dvuiuCP3/Igebc
         sLxItTQMvkUNLcgFQLsu+nLwZU3Mn4KLoDi53VqG22E3pN3mg9CRm9weIOYnqrmWApd6
         5+vQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6eJrnUE8k73Ci+ns6xwM2r87TiyjVcJrGCYSjhN5h+ZBWLa3IRYz0yzur8IfIBeWEgHb2Ct+icqF5yE6J@lists.openembedded.org
X-Gm-Message-State: AOJu0YxXxCGskoKhRjA24AG+St+G0Am2jtV7VNuMwNGDXCao4xwidSg6
	+XvEKWhkmKvNo/ittK3qH4ejIfBkd4+/MCKqL1wi/XXvUPqsQJNR5E2nKEjdk0jn6OM=
X-Gm-Gg: AR+sD12HdMWz9u47dOU8xl/rlCAYIGP+MTaB5v6+tZKGDR4Q4a9H3sHECchBnUhCKQo
	3gEZiyQLGduTL7PkgrJ4cMRtJWM/96mAZhuQxzo2+8DFxDCcmSV9HEsy2WlEUtcPGPpCGXz7587
	o0MG/JPp8Pb1YcSvNJyAslN70Zxi8sFOCuR+tkxXEv7W7D0yoo44iz1pDotmpQBWLmCEChzxxQZ
	hY+g8+DxDJ3BBUggr8MRADyQ9dHvbdiBjIO8PWSRyUOMcpUmyYuJEqfDsKnQjUuYpzx3pQXIZ6x
	45sSBRMFpytnHw2Fzy0HMBwq516hR21qdFq+JG/+treF0YZu5xnCT95Wwcbme8vJRCwT28ZBV7l
	sOeE4dsr0KE+AaEf8xvGeo6ZZ/+4vQNvK1bKm4BoodNPaWhZDKN7BbpuJo0trgvsm84apHpwwBz
	0NAGbI1/cJa+cU6vF6WRaDUw8H4UFr6LC5GWmg9xM3PUDBQ1JO4kjuKT9jF6Vb1hstzHmI+03gm
	4KaEysGQPrWdrhl/n9J1X4QeZXEjwAmLOBkUbHbvmdRGt+LO+N8hA==
X-Received: by 2002:a05:600c:3b92:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4999faf5569mr8068535e9.5.1786975648522;
        Mon, 17 Aug 2026 07:07:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132? ([2001:8b0:aba:5f3c:4d4c:ee18:5ecd:c132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499906aaf1dsm165063785e9.4.2026.08.17.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:07:27 -0700 (PDT)
Message-ID: <22dc23fea8c881c3ae8e7a1c2379a53590b89c39.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel]
 =?ISO-8859-1?Q?=5BPATCH=A0v2=5D=A0fetch2=2Fwget?=
 =?ISO-8859-1?Q?=3A=A0reuse=A0cached=A0HTTPS?=
 =?ISO-8859-1?Q?=A0connections?=
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 17 Aug 2026 15:07:27 +0100
In-Reply-To: <DM6PR11MB39624B046C4D0AD55A2ECF73CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
		 <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
		 <DM6PR11MB396271299B36AB33F27D6BE2CBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
	 <2a1dfb64170ef90dde4f5def6fe7d86f720257f6.camel@linuxfoundation.org>
	 <DM6PR11MB39624B046C4D0AD55A2ECF73CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 14:07:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19970

On Mon, 2026-08-17 at 06:55 +0000, Fredrik Svensson (svsvenss) wrote:
> Thanks, the new output makes the problem clearer.
>=20
>=20
> The buildtools OpenSSL is trying to load its configuration from the
> original SDK build path:
>=20
>=20
> /usr/local/oe-sdk-hardcoded-buildpath/.../openssl.cnf
>=20
>=20
> It looks like enable_tools_tarball() adds the buildtools binaries to
> PATH, but does not source the scripts under environment-setup.d. The
> OPENSSL_CONF value is set by environment-setup.d/openssl.sh, so
> OpenSSL falls back to its compiled-in path instead.
>=20
>=20
> I reproduced the same error with the 5.1 buildtools tarball when
> using its OpenSSL without sourcing the complete environment. It works
> when the environment is sourced normally.
>=20
>=20
> I think the proper fix is for enable_tools_tarball() to import the
> complete sourced environment, including the environment-setup.d
> scripts.
>=20
>=20
> That would also explain why running the test manually over SSH works.
> I think this is an issue with how yocto-autobuilder-helper imports
> the buildtools environment, rather than with the BitBake HTTPS cache
> change.

Agreed, I was coming to the same conclusion. The issue is that code in
the autobuilder helper... :/

Cheers,

Richard

