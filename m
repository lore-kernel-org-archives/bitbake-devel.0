Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D9C5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 13:36:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8232.1786541773152471598
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 06:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=OY0zRvDL;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F4251A15BA;
	Wed, 12 Aug 2026 13:36:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9DD46045E;
	Wed, 12 Aug 2026 13:36:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 656FE11C4CEE2;
	Wed, 12 Aug 2026 15:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786541766; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j3+H6qTUT1dDq5JPuMIYStJ/wIciDk89BczwFnL0ARQ=;
	b=OY0zRvDLiAQBoTX+oNLXOEWlJ33TqY3kdimhOY85lUjTmYeR9L5lAH98ugo5F41JD1RULK
	3GAHsjPMsgQ8YdQ3pkAdjSs1NhRdoa6+h93rSljGMzf+YFBGWeGJqnPqALtmP52MpecKr1
	tyfdnVCQxIohI8Dgus7ObugR/WmEpVa2C3TWuHrE1xZlIk9AT7u5/b8y76eSzr1NgB4cnL
	23E4TaB/OUhiIT+5qZH6vdXXddeLfn3e22r976lh7SkkB1OF+6KKiFQMuZGB+gqTy4n0LH
	X1La4h4A49PkeAblMxar4g8npTdpRvc6Dlrq4vV11p+0OAHqpCp/16o7Wh18zQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:36:04 +0200
Message-Id: <DKN0784SKJ24.PJP5ZNBXS2UO@bootlin.com>
To: <svsvenss@cisco.com>, "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: reuse cached HTTPS
 connections
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DM6PR11MB39629DE24C8A6EDFBBF5B89ECBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB39629DE24C8A6EDFBBF5B89ECBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 13:36:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19914

On Wed Aug 12, 2026 at 10:17 AM CEST, Fredrik Svensson via lists.openembedd=
ed.org wrote:
> The checkstatus() path reuses cached connections for HTTP requests, but
> uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability
> check therefore creates a new TCP connection and performs a new TLS
> handshake.
>
> Add HTTPS equivalents of the existing cached connection and request
> handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and
> extend FetchConnectionCache keys so HTTPS connections are kept separate
> from HTTP connections, different certificate policies and CA files, and
> different proxy tunnels.
>
> Add a local TLS self-test which proves two HTTPS HEAD requests use one
> TCP/TLS connection. The test also verifies that a connection established
> with certificate checking disabled is not reused after checking is
> enabled.
>
> In an ABBA benchmark against BitBake master, 4,283 remote sstate
> availability misses averaged 761.639 seconds without this change and
> 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x
> speedup. The benchmark had no matching mirror objects, so it isolates
> availability checks rather than download and unpack time.
>
> Signed-off-by: Fredrik Svensson <svsvenss@cisco.com>
> ---

Hi Fredrik,

Thanks for your patch.

It looks like this is failing to build here:
ERROR:  OE-core's config sanity checker detected a potential misconfigurati=
on.
    Either fix the cause of this error or at your own risk disable the chec=
ker (see sanity.conf).
    Following is the list of potential problems / advisories:

    'CacheHTTPSHandler' object has no attribute '_check_hostname'.
    Please ensure your host's network is configured correctly.
    Please ensure CONNECTIVITY_CHECK_URIS is correct and specified URIs are=
 available.
    If your ISP or network is blocking the above URL,
    try with another domain name, for example by setting:
    CONNECTIVITY_CHECK_URIS =3D "https://www.example.com/"    You could als=
o set BB_NO_NETWORK =3D "1" to disable network
    access if all required sources are on local disk.

https://autobuilder.yoctoproject.org/valkyrie/#/builders/2/builds/4382

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


