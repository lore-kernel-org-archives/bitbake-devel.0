Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2669C28CA7
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 15:13:25 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.93474.1638371605156344317
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Dec 2021 07:13:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1D7E11BF20D;
	Wed,  1 Dec 2021 15:13:22 +0000 (UTC)
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
To: YP docs mailing list <docs@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Bitbake's manual only refers to DocBook versions
Organization: Bootlin
Message-ID: <4126a709-c4e9-b844-1fca-f72e71d4093a@bootlin.com>
Date: Wed, 1 Dec 2021 16:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Dec 2021 15:13:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13122

Greetings,

If you look at https://docs.yoctoproject.org/bitbake/releases.html, only
DocBook manuals are mentioned (for example
https://docs.yoctoproject.org/3.1.2/bitbake-user-manual/bitbake-user-manual.html),
but not the newer Sphinx versions. For example
https://docs.yoctoproject.org/3.1.12/bitbake-user-manual/bitbake-user-manual.html
doesn't exist.

Fortunately, at least the latest Sphinx build is available on
https://docs.yoctoproject.org/bitbake!

What about modifying this page to refer only to BitBake versions (1.48,
1.50, 1.52... plus past ones), which are the only ones that we generate,
instead of Yocto Project ones? It would then make sense to update the
switchers.js file to make it specific to BitBake.

I'm asking your opinion before proposing such a change.
Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


