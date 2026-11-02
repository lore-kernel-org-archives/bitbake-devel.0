Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7760.1793605570506757697
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Nov 2026 23:46:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g2LX8qxj;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15EDAC8F446;
	Mon,  2 Nov 2026 07:47:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E5A460750;
	Mon,  2 Nov 2026 07:46:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77B8910329165;
	Mon,  2 Nov 2026 08:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793605567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DAg6+WSKIAq5780ft6E2FInKIOQKfNWVGkIARU4RIbc=;
	b=g2LX8qxjxef+iXJlR056CS4KPqwGRoM2KqrdJfWz9Kn+W7ztrgk4fG+2JzBiPf1w2y6jRW
	z/dmzQ2WKVmsAp/XzUttwiGkJWiC0GjJtuf66urQCUHhf97aBvJHqMi88Tl1EZ0zPiA7Jk
	v8FeIhwkQgy5yWDqaJ3eaWHz/9Y6iG4L9DCLAdrQAEG6iPR23Zx/I9V5EI9MbGt4ieWeNX
	rMADliGP0S1D4tA0OKg+xegKMtyzeI7qOYH1Uh08YdPlsaQq10H8hr26KkEMYAPlPOCOoJ
	wHWHGtuxlcpdq5LWkfpr2GxvQsgGqBvJsfLJlrLIgQPoGqydWHLwQR70A6JPaA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 08:46:04 +0100
Message-Id: <DMKK3X9KC5EO.2YRVJLSC8NNPN@bootlin.com>
Cc: "Tim Orling" <tim.orling@konsulko.com>, "Richard Purdie"
 <richard.purdie@linuxfoundation.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <ticotimo@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/2] cookerdata: error on duplicate
 BBPATH entries
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261019020422.14365-1-tim.orling@konsulko.com>
 <20261026002048.86208-3-tim.orling@konsulko.com>
In-Reply-To: <20261026002048.86208-3-tim.orling@konsulko.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 02 Nov 2026 07:46:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20388

On Mon Oct 26, 2026 at 1:20 AM CET, Tim Orling via lists.openembedded.org w=
rote:
> A directory listed more than once in BBPATH makes include_all apply the
> same file repeatedly. Fail once the layer configuration is parsed, so
> the error points at the configuration rather than surfacing later as
> duplicate inclusion warnings. Paths are compared after resolving them,
> and empty entries are ignored.
>
> Tested with bitbake-selftest and an oe-core tinfoil config parse.
>
> Suggested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---

Hi Tim,

I just note this patch is sometimes finding duplicate entries on the
autobuilder: I opened a bug for this.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16481

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

