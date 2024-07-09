Return-Path: <wavexx@thregr.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29AC3DA42
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 19:00:09 +0000 (UTC)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 by mx.groups.io with SMTP id smtpd.web11.3888.1720551605228150423
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 12:00:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: m.gmane-mx.org, ip: 116.202.254.214, mailfrom: gcsb-bitbake-dev@m.gmane-mx.org)
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcsb-bitbake-dev@m.gmane-mx.org>)
	id 1sRG4I-0001wD-5N
	for bitbake-devel@lists.openembedded.org; Tue, 09 Jul 2024 21:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bitbake-devel@lists.openembedded.org
From: Yuri D'Elia <wavexx@thregr.org>
Subject: Re: [PATCH] fetch2/git: Sanitize git configuration
Date: Tue, 09 Jul 2024 20:54:57 +0200
Message-ID: <877cdu2y66.fsf@wavexx.thregr.org>
References: <20240709182057.141231-2-wavexx@thregr.org>
	<CANNYZj8zZNAwgdA3C1yxesKLX=seZ7FiUWrRHxM7n8_Sm7pLOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:gzTTL6i0/nP9kptBGjHoWNxGt9U=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 19:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16411

On Tue, Jul 09 2024, Alexander Kanavin wrote:
> Sorry, no. We explicitly allow git to use the system and user
> configuration, and there are use cases where it's the only way to make
> it work in certain environments.

I'm new to bitbake. I see why, although this seems a departure from the
explicitly-allowed list of settings passing through the build.

Seems like we explicitly need to set defaultRemoteName then.

Would that be acceptable?


