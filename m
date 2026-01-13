Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2277D29DF8
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:40 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.55283.1768297052316492226
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Jan 2026 01:37:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DstegA/n;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9B249C20878;
	Tue, 13 Jan 2026 09:37:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 269EA60732;
	Tue, 13 Jan 2026 09:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 123C9103C92F2;
	Tue, 13 Jan 2026 10:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768297049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WKDyASyE59m0+8gCsxGiVykTM7c/CqWoT6Ar3tskxfM=;
	b=DstegA/n1ci2ny8CyHrmgKPu6piA1Q9JMTXW0fO+w6cJTQelaC80y0RX2yQMWZwoi5hUx5
	U9bkXxnA5upa5IBlCK6iniSDTDpwBB4HOM/4Jyu+nTXSNA6MTTFZ22rN3cIYTIBvLzmhBK
	54MZs/UvJf/FmYQfsA/xMbMiF8WE5X2BlExyEYIGtSuKvKayjgqRzFXfwyXmuI6e4P5NJO
	s0sFwj1H4x4fzFYH+JyiVB1Ev0nAXZ7R6U8Zv1r6Q0xtW9Fj4/yohdD2W3Vg6Hu8iQGK/L
	nIvfRvhcRkSVS4VXk7/PHzbDihpYj5M3FD0Cui7o/WK61mDVfDGJ4bKsm0AoCQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 10:37:27 +0100
Message-Id: <DFNCZL4DGO9X.1I4P89HIL9I30@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Robert P. J. Day" <rpjday@crashcourse.ca>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 0/8] doc: bitbake-user-manual-metadata:
 misc improvements on sharing functionality
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc
References: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
In-Reply-To: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 09:37:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18744

On Mon Jan 12, 2026 at 5:36 PM CET, Quentin Schulz wrote:
> This expands on the include_all directive by providing an example and
> highlighting the difference with the include directive.
>
> It fixes some highlighting and cross-referencing inconsistencies as well
> as the wrong path in the examples.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (8):
>       doc: bitbake-user-manual-metadata: list (in order) all sharing dire=
ctives
>       doc: bitbake-user-manual-metadata: highlight configuration fragment=
 differently
>       doc: bitbake-user-manual-metadata: use a cross-reference for addfra=
gments
>       doc: bitbake-user-manual-metadata: specify that current dir won't b=
e searched for include_all
>       doc: bitbake-user-manual-metadata: add missing highlight for BBPATH=
 and PATH
>       doc: bitbake-user-manual-metadata: fix incorrect path in example fo=
r locating files
>       doc: bitbake-user-manual-metadata: expand on search paths for inclu=
de directive
>       doc: bitbake-user-manual-metadata: expand locating files example fo=
r include_all directive
>
>  .../bitbake-user-manual-metadata.rst               | 65 ++++++++++++++++=
++----
>  1 file changed, 54 insertions(+), 11 deletions(-)
> ---
> base-commit: f23e186a75e71ba885b9b53a1dfda99af29c67b0
> change-id: 20260112-doc-directives-6e42bc047525
>
> Best regards,

Great improvements over what I wrote a while back! I'm glad we have a detai=
led
explanation on all of these directives now.

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


