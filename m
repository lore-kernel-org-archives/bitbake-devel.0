Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9ECCD183
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 08:33:56 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.7125.1759998827273315627
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 01:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1014tOYT;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AD74BC0359A
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Oct 2025 08:33:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3729D6062C;
	Thu,  9 Oct 2025 08:33:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FE27102F1D48;
	Thu,  9 Oct 2025 10:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759998824; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CnlwMJ+OWlTU3S9gn9VdHfBIfn6Z5hzHToq2A2o7G2k=;
	b=1014tOYT1KvU2OcgHsuseI7eIhmDLAyvkqt/PLzT7BsFouIYpEMhATXmE5WWBIbjIh5qN6
	HRSbsURu71Hh68xwgPppi5w3bTJgjqcpLayW4Xw03eE5yfq2ey6cteevUuXvsfmE6kHTWp
	zKBH6eZZKovKv0Tycb7906oPrhJ62zEKeCVZ/nLQXSJoDZfQHvoaqZ9DffShBLLiolP6BO
	dSKcVaJl550jdn78chhlsyKxof4OjpGkB03kcq1ZF31V9mYNOozk5gC2GCRLM+E7PzV+Uw
	aeweF/wBQUFlZPhjHKTxHss4FKCDDBGT9sYVpEZnrGFCzPgHDOeV0BQZMKttog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 10:33:42 +0200
Message-Id: <DDDNIGXMQAXT.75OA8UABJUFG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v3]
 doc/bitbake-user-manual-ref-variables: improve INHERIT
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>
References: <20251006181951.39364-1-adam.blank.g@gmail.com>
 <DDCTRS0A6C72.13SF4HEOH56TD@bootlin.com>
 <CAFAffzzR=DYqbtaGVun07AeCw8yMcj+aNDLCPv0WTx+U1v27SA@mail.gmail.com>
In-Reply-To: <CAFAffzzR=DYqbtaGVun07AeCw8yMcj+aNDLCPv0WTx+U1v27SA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 08:33:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18149

On Wed Oct 8, 2025 at 12:40 PM CEST, Adam Blank via lists.openembedded.org =
wrote:
> Right, thanks for the tips :) I've sent a V4 of this patch.
> On a side note, would it make sense to chase other references to
> OpenEmbedded in BitBake's documentation?

I don't think it's _that_ important for existing references, unless someone
comes out and complains about it.

If you are looking for ways to contribute, there a list of bugs we try to f=
ix
here: https://wiki.yoctoproject.org/wiki/Newcomers#Newcomer_Bugs

Some of them are docs-related

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


