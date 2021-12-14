Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8875C433F5
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 21:01:44 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web09.31692.1639515703346716919
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 13:01:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 079F720009;
	Tue, 14 Dec 2021 21:01:40 +0000 (UTC)
To: YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Question about "hash-equivalence passthrough to the matching server"
Organization: Bootlin
Message-ID: <83a56ef9-711e-a804-ed49-f64d864252a8@bootlin.com>
Date: Tue, 14 Dec 2021 22:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 21:01:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13158

Greetings,

I'd need clarification about this section in Poky's
meta-poky/conf/local.conf.sample file:

# Yocto Project SState Mirror
#
# The Yocto Project has prebuilt artefacts available for its releases,
you can enable
# use of these by uncommenting the following lines. This will mean the
build uses
# the network to check for artefacts at the start of builds, which does
slow it down
# equally, it will also speed up the builds by not having to build
things if they are
# present in the cache. It assumes you can download something faster
than you can build it
# which will depend on your network.
# Note: For this to work you also need hash-equivalence passthrough to
the matching server
#
#BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
#SSTATE_MIRRORS ?= "file://.*
http://sstate.yoctoproject.org/3.4/PATH;downloadfilename=PATH"

How to set enable "hash-equivalence passthrough"?
I haven't managed to find details in the source code yet...

Thanks in advance
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


