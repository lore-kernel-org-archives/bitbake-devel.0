Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C57F9937D
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 11:50:44 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17697.1776945037532352054
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 04:50:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QvEZnwrn;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D0EC1A33C4
	for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 11:50:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B93860495;
	Thu, 23 Apr 2026 11:50:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0B9610460BE8;
	Thu, 23 Apr 2026 13:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776945034; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2vcNmlXdmbmnu/KzQgHPx6/7zSJS6EVu60v7a/mcXQo=;
	b=QvEZnwrn0Bglf0i1GDXH8z/zYpv+5SI6oZkZUWXIge3CRkxVwmxmhAxOWMICvB3v+eG2IQ
	zK+bFCsYJO8IEOyN0vjjDqO3wqAxzWEMipQGdXZdtGcYud8Kbkutiv01FWRsFWL523yxTh
	Rf+JGY3BUwvAuLdDQiTzBIDjQcaeNVZsDDfJX1QqGvcXdqcL8UYxbm2t0c52QBELxYOudg
	Xz98cTP6li/XbgxmjRBVi8tXd/cXN7EuUV00Xo6RTaRzTIVG3IZbEVI93gH5Kq1B94UBW4
	pNQxOzKEnV5PFBqB2Tr0mtLqt46J86UEIioZ1ok7almzbc4pLFDAS3mSyP1ecA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 13:50:32 +0200
Message-Id: <DI0IFYJSJO0R.1R0JWU725EZ6@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: limit the execution of the
 hashequiv client/server ping
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
References: <20260423102950.697501-2-corentin.guillevic@smile.fr>
In-Reply-To: <20260423102950.697501-2-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 11:50:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19379

Hi,

On Thu Apr 23, 2026 at 12:29 PM CEST, Corentin Guillevic via lists.openembe=
dded.org wrote:
> From: Corentin Guillevic <corentin.guillevic@smile.fr>
>
> The ping method is used to test the connection to the hash equivalence se=
rver.
> However, if the server is unavailable, the bitbake server has to wait sev=
eral
> minutes for the system to terminate.
>
> While waiting for a response from the hash server, the bitbake server doe=
s not
> provide any feedback to the bitbake client. The latter then closes the li=
nk and
> fails with the error:
>
> Timeout while waiting for a reply from the bitbake server (60s at 09:50:1=
5.377337)
>
> Adding a timeout to the ping step allows quicker action when a remote ser=
ver is
> unavailable, and prevents disconnection of the client due to timeout.
> The default timeout is 10 seconds, but this can be set using the
> BB_HASHSERVER_TIMEOUT variable.

Can you please document this new variable in
doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst in the same
commit?

Thanks,
Antonin

