Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57210A3D8D
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 12:35:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47118.1774528546579172983
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 05:35:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YhFdRYPu;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7030C1A2FFE
	for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 12:35:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46D665FDEB;
	Thu, 26 Mar 2026 12:35:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00B2B1045000B;
	Thu, 26 Mar 2026 13:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774528544; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mhcHFiE8hVE3CAaYCVAQL+XKr27vgsCSVvEZU+mBR8c=;
	b=YhFdRYPu+15JuU99MPTDZavdhHmZXkkSgCepDoX4QmeSLCq5MGN4xW04oSO/qSnXuMb230
	cNYK2SCNA/t3O5fq/Yx6hyw99eo405ag2Eq79IFLE1dVXfp+uigGgtW+OckqGQV2ycRlof
	XahFk44upB+yDljYXV1c2Ezxf60+poFCULUwwwnSK74xbB4n+BV/03ZWOUhin0QVBHhhQY
	x1yUxvt/QvSLJjdwl9VdquUdTLKLjWS9vme+dJ12ZmOe1Rkzm+aSS4qQSwHKS/E8tXnl7T
	i/3qjDt4dOAvC4n7Nn9+s80iYGC7S8FBSSrgIvJU42BOSutmLRcfmDDAl730BA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 13:35:42 +0100
Message-Id: <DHCPVA8TJK5L.29B9T1URJFJW2@bootlin.com>
To: <adrian.freihofer@siemens.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] bitbake-setup: improvements,
 VSCode workspace generation
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 12:35:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19238

Hi Adrian,

Could you document the newly added features/options in
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst?

I think --init-vscode/--no-init-vscode and --rebase-conflicts-strategy shou=
ld be
covered.

Thanks,
Antonin

