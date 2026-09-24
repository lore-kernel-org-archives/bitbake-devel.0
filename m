Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F9C98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 06:36:50 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1926.1790231807635682683
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 23:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=X2iCVZpm;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4DF511A0FF6;
	Thu, 24 Sep 2026 06:36:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 181F95FB45;
	Thu, 24 Sep 2026 06:36:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 148E81032948A;
	Thu, 24 Sep 2026 08:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790231804; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ydhe5nNqpsJV+Jp/CHGKatKxkMkKsVt9BIrxfbuQoyA=;
	b=X2iCVZpm4K1CnKnO2SHzrq18TTWhCJCdHpg06W/sW/wiQhrlNxQNUBxCHyuia2zuGVbstS
	NBWJPpw/RHK+vOg8Nj1SvbbTkW/9zVdHnQzf2AxBZYFhE9qiu2QXZfXYeH+SdeMBWMA4oR
	L+UJjtW40RRFaGcr9yFv8F3S58XnDvhUH2Htzz1YrRH6uBHosw/NdxS6VzT6h/48/eaDXB
	8N4951JthO922WdjbEY/xcSvC9lk2H2v7EoV3AhNencO43PXsxX3mAs32W2Id1mUzSYHWK
	47MU6kPJ/hECCA2bL+AXaf8bZJ5euVtzSCRDlPLcCP0TBfMaFeK9q3CFmB4vsw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 08:36:42 +0200
Message-Id: <DLNC7K9T9IRB.3TSABE8ZFLIZF@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <setairidis@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/local: verify checksums for
 file:// urls
Cc: <jhonata.poma@gmail.com>, <paul@pbarker.dev>
References: <20260511-b4-yocto-9993-v2-1-9d5a1c1451ba@gmail.com>
 <20260923194435.58965-1-setairidis@gmail.com>
In-Reply-To: <20260923194435.58965-1-setairidis@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 06:36:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20249

Hi,

On Wed Sep 23, 2026 at 9:44 PM CEST, Savvas Etairidis via lists.openembedde=
d.org wrote:
> Local.urldata_init unconditionally cleared ud.needdonestamp, which
> skipped the donestamp + verify_checksum cycle for every file:// url.
> A checksum supplied via a url parameter, such as UNINATIVE_CHECKSUM
> expanded into the uninative tarball's file:// url, was therefore
> never compared against the file's actual contents.
>
> Keep needdonestamp at its default when the url carries a checksum
> parameter, and move rename_bad_checksum onto FetchMethod so Local can
> override it as a no-op, avoiding a rename of the user's source file
> on mismatch.
>
> Based on a patch by Jhonata Poma-Hansen, adapted to this tree's
> Local.urldata_init(), which now uses ud.decodedurl in place of the
> ud.path referenced by the original patch.

This cannot be applied to the master branch cleanly. Can you rebase and re-=
send
you patch?

Antonin

