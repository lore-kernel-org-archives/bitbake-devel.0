Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BCDC982F1
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 08:11:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5140.1790064673845131705
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Sep 2026 01:11:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0JF8+Ogs;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C145C23DB6;
	Tue, 22 Sep 2026 08:11:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE86C60580;
	Tue, 22 Sep 2026 08:11:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8136710329258;
	Tue, 22 Sep 2026 10:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790064671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q5nL3FC6xHQgA52YNBnTa/zBsZQJENz8sMJa0NiM7OU=;
	b=0JF8+OgsUZ3F4Fy18Q0iCCP/+PQ20XUTF9HXGqaiU/XaAb6cReglbkBo0cTu9OVTkizvnB
	oTE1JPlBFepKQCi4xbbmA0sLlNV6ZEs5Yrz3pBSuS2k7fpdaoY1NvSo+8ai4zSQsT6IiqF
	XqFxMMtkrxf4XQzzuhMIdo+DESV7q7uJY3RKhNSXqREDaeJ+E5O1N0Qe9zPfu79YZkdRr5
	7L+psyRjFv6pL82vy2IpMHgVi61mtLQEogXTBvLBPBRbEHbsmUvvH/p0/Or2jpOuZ0LE/Q
	/Y2WBms6iuHDAzWYrNL//ksSbLt7PSgvcFY68tktsTScLef9E32+TDtXk0RX7Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 10:11:10 +0200
Message-Id: <DLLOYSTZ6OMD.LKRDMZZLZRB8@bootlin.com>
To: <twoerner@gmail.com>, <docs@lists.yoctoproject.org>
Subject: Re: [docs] [PATCH v2] doc: document the conventions used in the
 manual
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260922015519.313312-1-twoerner@gmail.com>
In-Reply-To: <20260922015519.313312-1-twoerner@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Sep 2026 08:11:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20235

On Tue Sep 22, 2026 at 3:55 AM CEST, Trevor Woerner via lists.yoctoproject.=
org wrote:
> The manual uses angle brackets for placeholders and a prompt to mark a
> command, and says so nowhere. A reader can only infer both.
>
> Add a page stating them, in the sidebar beside the other top-level
> entries, so it is reachable from any page of the manual.

A similar patch was sent to yocto-docs[1]. Let's hold off this one until th=
e
definitive version in yocto-docs is merged, please.

[1]: https://lore.kernel.org/r/20260922013912.55583-1-twoerner@gmail.com

Thanks,
Antonin

