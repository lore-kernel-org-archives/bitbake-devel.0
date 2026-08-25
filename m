Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A247C61DBE
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 13:17:25 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21225.1787663842517879433
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 06:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gh+OVF1e;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4D3104E4138B;
	Tue, 25 Aug 2026 13:17:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21DFF604C4;
	Tue, 25 Aug 2026 13:17:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 113DA11C78B58;
	Tue, 25 Aug 2026 15:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787663835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zZ+vXdx93DhYRgTd0gRPvK27E00Qc6G+cND1Bge4EnQ=;
	b=gh+OVF1eRxwPfppV7ufCdpU95Xn5tuptYDhlJbOffb1uSIjHgj5PQK5kBxUvsiMBwxLEDS
	u+st+bSMAnn/4Hu2j7xPb98Q9GMtZiPhP/ZLUxHOwOJWbXYApLRBHUp1kuuK4iL30CvPAH
	Vtnm4/KNJW72BJj7LfCOkWM59som7jHEKELxGV1iNHAg2J/JQNtXoEwacpttYqhe5sXgwP
	6h4Zd4yU7so1xkx5+qh4VTmYvv6ogU82pG1jWJzO9MtP63PQYXdxaFWV1osGGj4Z0ryyF0
	4Jeir1MUzYuAu2bdpnB8oQHx7egEYwxcXnTLuiLTWgYS/3I3WXSzEXRc7s4aWA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:17:13 +0200
Message-Id: <DKY1XVP2EL02.RX322WV88ALR@bootlin.com>
Subject: Re: [bitbake-devel] [2.18][PATCH 0/2] fetch/{npm,npmsw}: fix
 security issue and re-enable fetchers
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas Perrot"
 <thomas.perrot@bootlin.com>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yoann.congal@smile.fr>, <bitbake-devel@lists.openembedded.org>
References: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com> <DKY1SVKSA25G.1G4STPIKU99KZ@smile.fr>
In-Reply-To: <DKY1SVKSA25G.1G4STPIKU99KZ@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20037

Hi Yoann,

On Tue Aug 25, 2026 at 3:10 PM CEST, Yoann Congal via lists.openembedded.or=
g wrote:
> Hello,
>
> On Tue Aug 25, 2026 at 3:02 PM CEST, Antonin Godard via lists.openembedde=
d.org wrote:
>> This is a proposal to backport patches re-enabling the npm and npmsw
>> fetcher on 2.18 (Wrynose). The two patches from this series are simple
>> cherry-picks, and had no conflicts applying.
>>
>> Applying these two patches locally is also fine to me, but as this seems
>> to be working as-is I figured this might be helpful to others - up to th=
e
>> maintainer(s) to decide.
>
> I understand this is tempting but that'd be a feature addition from
> wrynose point of view and so, unacceptable per stable policy.
>
> Without exception to the rules, we'll have to live with wrynose not
> having a NPM fetcher.

Understood, and fine by me. You'll have a link to share to others wondering
about it now. :)

Thanks for the swift answer!
Antonin

