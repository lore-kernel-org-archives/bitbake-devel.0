Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B1D11713
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:42:31 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.347.1764693747362777452
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:42:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZahZvKKe;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F92F4E419E0
	for <bitbake-devel@lists.openembedded.org>; Tue,  2 Dec 2025 16:42:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E404D606D6;
	Tue,  2 Dec 2025 16:42:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF8F811919DA6;
	Tue,  2 Dec 2025 17:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764693744; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DTjiG4UqKyTtArV4igGzjpiUAoushQbo/2J88unJv0I=;
	b=ZahZvKKeKHDK2OBdRy7YOfBD17Fi88zxxXbSQGlLZ1ULzjUZMTeH5roTUXsMb2nYtdz3nW
	PUWYvgyiARygVKXJynOZ5bv/PdhNZimX5oPD+3HZ748jcqd4E0SSoweTS0+RMdj73VZquJ
	oqc6LwK5ZXSbNOIQ20gbTm6pyRAqAae3FVGMy8zVUZTSa/F18KTTzxlASi6oRXCKzjY+vA
	VpwQ3q/9Ptjs4RCpzG4w6AcfC3DJizvd/7xZ2CemOgLDFyY6Q5q8Ti91TcaVPE3Lf97DbJ
	9qmHkANsVOmsZ5O6D1khlmA7+gYtBrcoEyB+EbqnNu87dF2KDK3SvtrBMV+HQg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 17:42:23 +0100
Message-Id: <DENVQ1W7LBQ0.2K056SQCNYUE3@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] Documenting BB_CMDLINE
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <swami310@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20251202073141.16223-1-swami310@gmail.com>
In-Reply-To: <20251202073141.16223-1-swami310@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:42:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18513

Hi Swaminathan K,

Thanks for the patch, I'm glad you were able to find out how to send your p=
atch.

On Tue Dec 2, 2025 at 8:31 AM CET, Swami via lists.openembedded.org wrote:
> Signed-off-by: Swaminathan K <swami310@gmail.com>

Please write a commit message body, even if it's short sentence.

Also include the bug number ID in the commit message body:

"""
Fixes [YOCTO #15746]
"""

> Upstream-Status: Submitted

No need to include the Upstream-Status here. This must be included for patc=
hes
applied to recipes in OpenEmbedded-Core (e.g. https://git.openembedded.org/=
openembedded-core/tree/meta/recipes-support/numactl/numactl/0001-define-run=
-test-target.patch#n6).

I guess the contributor guide might be confusing regarding this point, so I=
 will
try to make clearer.

> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..5e14e40b4 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>        Specifies if SSL certificates should be checked when fetching. The=
 default
>        value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
> =20
> +   :term:`BB_CMDLINE`
> +        BB_CMDLINE is an internal variable and is read-only. It captures=
 the exact

Please wrap BB_CMDLINE with :term:, like this:

"""
:term:`BB_CMDLINE` is an internal...
"""

> +        command line used for the current invocation of bitbake=20

s/bitbake/BitBake/

Otherwise, the sentence is missing a period, and has a trailing whitespace.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


