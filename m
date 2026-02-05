Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CFEC1E9D
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:20:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18367.1770290400772445134
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 03:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AoB1NvBr;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CAB5D1A2C17
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 11:19:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 95171606FD;
	Thu,  5 Feb 2026 11:19:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7BF8119A865B;
	Thu,  5 Feb 2026 12:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770290398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rPzGM010puxS1NMcKiHMi9C0q1IM7fQxtppKHp8IKm0=;
	b=AoB1NvBrR6Ay2Fwm3frUwbUFyhIhjd3rFBZJUBN//YXs/h2lrwXjk44R06gbFEgm7oXDX3
	o269IGo2iczC8GM3cMTmzcF2EUL+yzI4pc1tSpYFssbL9AcPQ24xIFTW94qiLfK/AGxA7L
	vg1ZE4PivSYSPhL+pL6v0bVnbmrOYpJ7xuxn893aF82n+AxyaxoyS1dxFmwA5piOxVVNcu
	W6gMeSa0CRIlv141cjnFBTeC3G2PZEpBZRLeSP+K5HmrgrmCPmOTxVWXdRqPUXps2ALEIs
	8/oewAQZ+s62hN4x+lm0N6fNzdEjbiWC26MNl5R2H1jhJUw2MPt9PbYvVXUblQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 12:19:56 +0100
Message-Id: <DG6ZKKY4O7JJ.243MNUQEG6E0R@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
Cc: <bitbake-devel@lists.openembedded.org>, "Alexander Kanavin"
 <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
 <20260129120421.4413-2-alex.kanavin@gmail.com>
 <DG6ZBGNEUSSR.E95H6B6IK8MM@bootlin.com>
 <CANNYZj8=NLgUPttWTy2suUnxj45MJ3F_gScL0tvyykFdwqJS_Q@mail.gmail.com>
In-Reply-To: <CANNYZj8=NLgUPttWTy2suUnxj45MJ3F_gScL0tvyykFdwqJS_Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 11:20:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18964

On Thu Feb 5, 2026 at 12:12 PM CET, Alexander Kanavin wrote:
> On Thu, 5 Feb 2026 at 12:08, Antonin Godard <antonin.godard@bootlin.com> =
wrote:
>> > +                SSTATE_DIR ?=3D "{sstate_dir}"
>>
>> Nitpicky I know , but we should add a line return here, as DL_DIR above =
is
>> already separated from SSTATE_DIR by a line return.
>
> You could also argue that the two sstate settings are in a group, and
> should be visually 'together'.

I didn't think it that way, up to you. It's just the way things were organi=
zed
prior, in the template files.

Antonin

