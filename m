Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABEE73146
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 08:32:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48190.1770021159535163773
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Feb 2026 00:32:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Y/FZRAdV;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5FFDC1A2B9B;
	Mon,  2 Feb 2026 08:32:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14F2860767;
	Mon,  2 Feb 2026 08:32:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7D78119A8891;
	Mon,  2 Feb 2026 09:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770021156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NgRGJ+0c8SuRAkXcIzpL8yRC9aiYNj9/dsLCIJRt6Ps=;
	b=Y/FZRAdVBle/NsV04WpoeoygwKRV6mSN0OasFXnqagEjCJExX70EDs1EjCiP73wDZ3etpw
	LIW3puvHBxEM4FtMZCLjiUe9PhSiJyV5kEVhOxdXcHWPit2umtH19R25KGNdVH1dh3MsL3
	5Nc9TfN6q9MHoA1aQHgDsXi9B4qS8Cui2ED8TKoT2McRhLHm7fGHaifbNeNRUZP13dIhfF
	02hljrJ9fyHSblC4iYkoQF5FM4NfE89//jrwZ0UZXOHlpMoGFoiGGUs0iwoujRid0wowBy
	THoISX5IApLsrQIdyD1XBTuseiS4NdL3eITARqXFLU4cCjROOyk7ESKW1P75vg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 09:32:34 +0100
Message-Id: <DG4C4SSPGMEU.2TU95P0C4S8KX@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Robert P. J. Day" <rpjday@crashcourse.ca>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v3] doc: bitbake-user-manual-intro: improve
 bbappend file matching doc
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc
References: <20260130-bbappend-matching-v3-1-7e3c7c7d87f5@cherry.de>
In-Reply-To: <20260130-bbappend-matching-v3-1-7e3c7c7d87f5@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Feb 2026 08:32:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18943

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


