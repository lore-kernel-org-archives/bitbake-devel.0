Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DCC5B572
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:21:37 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12850.1786713690391799106
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 06:21:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CVTyrLjN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-480033bdcf4so582185f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786713688; x=1787318488; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NmnvY8+sBm5P+La/Q9bKGhaH0/+JfcTx2TXX+22XGwg=;
        b=CVTyrLjNqyCIIFJi3/GDPDUt2RQldvFwtLntWvwOxl33ohEdLpCGAGqMEXJtjXPLGp
         BkVaAWY4CtEsUkZIgf1WBl6zgEGwefYyvnHa7jkU6Iy34lRpusqnampkGR8wTc4ii23P
         UU08v8TqP6Mf+GsL6XJPRU2pdw03lwih3Pq1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786713688; x=1787318488;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmnvY8+sBm5P+La/Q9bKGhaH0/+JfcTx2TXX+22XGwg=;
        b=LbN5G50klMhgstv2Ujc77pk9VgZ6PTwoDvRGqK+1l5VOfaRtRcLmwn3fpW3K+7exlO
         mpGzUpMvzkWtqa/u8woSxiUSMhpS6FuthIiH3I+xbeztmtudtlDprr2FqeHJ04PDnDzJ
         Csthg005pcpQ1nqjsAgmlUQgYKSzglJ9D4tm1llIdOhdFJkSWcSGdiEd9zxYPVv9rOR9
         Y9ZJe2TKLm71rozuk99e9KwvglV59acqdwSK0QklFg80ZwQTTej+RKsjwR3x+AL4RZ1/
         vbAnsP4T5PgquXKWegiKo8k+zSmZAkEZTpC4XIpOQgG9kFz/36n0gCWNkKtRios7G9TA
         qrCA==
X-Forwarded-Encrypted: i=1; AHgh+RrGBM89kIut0YMH8E4zVweyQAJGA2tKVAjbGVwiyxy1TTrcJ9f5MUa8PAoH1Wl6Z7By/iPu269teH41OF9r@lists.openembedded.org
X-Gm-Message-State: AOJu0YyhDJwpblIqII+SM5whGOGJGUt24C0iz1kJSyj1vLRh9mCpD1Fc
	xDk7HEYo10UoRoQYVv5OCPzGvt7qtbBeQBm3j0p4AN7Un+HgX0GR6Lk1Jvv9Tzn6fd8=
X-Gm-Gg: AR+sD13iVVybo1i3lK9x6jeQoSNlp742Vl6DFa6OVBYyM6UaWhG6mLDcYdjjnNM3CuV
	FwDrjXZ+PMOqGaVOnrciIJQcoSOfw70EzK68Pxn7R02C+JBrEnKvBb1IUaNByRd3rTEl5hBe8+M
	0InOL6zqr4noDgAh7Wwwik3OUrTUuEQef/uarY/yOoWhTO4mrDMlamcN7yGOX7Sxt3TEq1xV0q0
	S8s5koAeEh8Zc+b//U/sSLsPn8y7PU/z8Nqsw6hShSIRiCg+IHGv9DKYdRMGZvkplIFCUNrBYyA
	DqxUlqXTIC1kZOYo+sJVNebX0Kn+6qfj0NQjCjMXUCTHSMXta4zEqz6ntFcc56KRV/xrIyNq0Mv
	cYH1VMcSBLMBun6rMRE9IZCPO+n1OAnQtZX9Nxl9BGlIhtxxgO6XvP9GvESeE17mkKlinxf3N8N
	IGuy1LWPFPcgnufMSxvQl3lEt5sV4rF8zM848Ww3bVvWT8gRRgD7I5GG+/YQULi2VoJsXeDoaU9
	c5OdPok42YU79uxvdigDVCj+MTvCdEiuM74pMKCZS+l//lAsSoQ1w==
X-Received: by 2002:a5d:5f4c:0:b0:481:3db1:a62f with SMTP id ffacd0b85a97d-481607627bamr8013066f8f.17.1786713688401;
        Fri, 14 Aug 2026 06:21:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9095:412f:3012:ddca? ([2001:8b0:aba:5f3c:9095:412f:3012:ddca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d90sm8545463f8f.22.2026.08.14.06.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:21:27 -0700 (PDT)
Message-ID: <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel]
 =?ISO-8859-1?Q?=5BPATCH=A0v2=5D=A0fetch2=2Fwget?=
 =?ISO-8859-1?Q?=3A=A0reuse=A0cached=A0HTTPS?=
 =?ISO-8859-1?Q?=A0connections?=
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: svsvenss@cisco.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Aug 2026 14:21:27 +0100
In-Reply-To: <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
	<DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 13:21:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19935

Hi,

On Wed, 2026-08-12 at 17:03 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
> The checkstatus() path reuses cached connections for HTTP requests, but
> uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability
> check therefore creates a new TCP connection and performs a new TLS
> handshake.
>=20
> Add HTTPS equivalents of the existing cached connection and request
> handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and
> extend FetchConnectionCache keys so HTTPS connections are kept separate
> from HTTP connections, different certificate policies and CA files, and
> different proxy tunnels.
>=20
> Add a local TLS self-test which proves two HTTPS HEAD requests use one
> TCP/TLS connection. The test also verifies that a connection established
> with certificate checking disabled is not reused after checking is
> enabled.
>=20
> In an ABBA benchmark against BitBake master, 4,283 remote sstate
> availability misses averaged 761.639 seconds without this change and
> 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x
> speedup. The benchmark had no matching mirror objects, so it isolates
> availability checks rather than download and unpack time.
>=20
> Signed-off-by: Fredrik Svensson <svsvenss@cisco.com>

Thanks for the patch, this looked good to me and we did merge it. We then s=
tarted seeing:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4378/ste=
ps/15/logs/stdio

which is probably worker specific and occuring on alma8 (which we do
use buildtools tarball on). Have you any idea why that might be
breaking?

Cheers,

Richard

