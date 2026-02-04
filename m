Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1300E83EFB
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 09:23:45 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16604.1770197022124900485
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 01:23:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oPB6lhn1;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 03BE11A2BE7;
	Wed,  4 Feb 2026 09:23:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6A4460745;
	Wed,  4 Feb 2026 09:23:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DB27119A865B;
	Wed,  4 Feb 2026 10:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770197019; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3dFfMGBkK+gHAk8QE0hdTmVALLYFwvE3CBx7xVHUPfg=;
	b=oPB6lhn1DpGXV2kZ8h2124egmujnBYVlF34nKs1V6FrduNAIF+q7Zb2f3a3d6A+qvidtmS
	SGSZbDQirUHLl7jmQtZTTWVpGhcGea8vjXMCUq07+cD/Xb+itmxFE+OCwDY0pMffpZ83lf
	fcXlQnNv3G5Pn7fPscupV6sh4ukiUAB5/PdobnqQdgrMG5FsXYtcNHWmj9ffMtF1KeF6/W
	VxaOy1EX2TUXXilstN1AtPfCz06IrpdjhBC6rDCdaICEVFnnNOCMAew2oeriV94kLCy5Bq
	Qr9es1qmv7d4L26FaGyHmQdJoQhXZaXISLYkvhnyk6rLneK9ae3I91joh+up9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 10:23:36 +0100
Message-Id: <DG62GYSI7PCT.1DNGYSVW66L6W@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <Qi.Chen@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
Cc: "Richard Purdie" <richard.purdie@linuxfoundation.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <1885DEB2FD4F0640.2047557@lists.openembedded.org>
 <188C9E9E281EE6E7.3547823@lists.openembedded.org>
 <be5f86b4-22ca-4690-8438-8541843d4c05@windriver.com>
In-Reply-To: <be5f86b4-22ca-4690-8438-8541843d4c05@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 09:23:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18947

On Wed Feb 4, 2026 at 3:23 AM CET, Chen Qi via lists.openembedded.org wrote=
:
> ping
>

Hi Chen,

Your patch is still in the queue, but the backlog is a bit big these
days, particularly on the bitbake side. It will be reviewed in the
coming weeks.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


