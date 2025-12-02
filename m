Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC513D1170E
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 16:31:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46.1764693052861380834
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Dec 2025 08:30:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Fv+PWS8C;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3A25BC16A21
	for <bitbake-devel@lists.openembedded.org>; Tue,  2 Dec 2025 16:30:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75A06606D6;
	Tue,  2 Dec 2025 16:30:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E9E0119197AC;
	Tue,  2 Dec 2025 17:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764693050; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7+tKJhGep8JLqqdc+Psx0pvPboOE5RhtSw4GNXeB6zY=;
	b=Fv+PWS8CYIftgEuOdrtA0P6vG18jIyyjE30fSeX2PszqcYi7qNDtFh4ZxK9f1fbW44qE/A
	am0D1SrUJR6XfTWo6UzcFqhvf9DQMzcf5HQZLVEID/IlMBxPWo+R1NnvFKkgp8NSCbtFLa
	HJupJMd5a6XWwlZfvHH3vw9w7ARZLle5LceFdClZ4jQW2/AWG1f+JNUfmUyzSBbXeENi5S
	ThqDOJJ85c9aGnl+CrXL9EBqrvRrA2MQrPKSD54x/vnKlPW5O7/1P4F/3TdmJKxL3JhFjp
	SoZb9aITF5a99uTDxMjnzzmOGJurpnvKBEEUhFQvAgyUMhLgp0TjTf3fdXnBFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 17:30:48 +0100
Message-Id: <DENVH6TU57FQ.QPAN5BAMB9P1@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: add inline URI
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
In-Reply-To: <20251202160402.819060-1-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 16:31:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18511

Hi,

On Tue Dec 2, 2025 at 5:04 PM CET, Corentin Guillevic via lists.openembedde=
d.org wrote:
> Most of the time, when we describe a remote, a bitbake-setup source looks=
 like this:
>
> "bitbake": {
>     "git-remote": {
>         "remotes": {
>             "origin": {
>                 "uri": "https://git.openembedded.org/bitbake"
>             }
>         },
>         ...
>     }
> }
>
> i.e. an URI with the common name 'origin'. Alternatively, we could simpli=
fy this, by
> using a shorter structure with the property 'uri' only:
>
> "bitbake": {
>     "git-remote": {
>         "uri": "https://git.openembedded.org/bitbake",
>         ...
>     }
> }
>
> 'uri' and 'remote' are then mutually exclusive.
>

If this is accepted, please also document this new syntax in
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


