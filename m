Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3150C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 13:49:31 +0000 (UTC)
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
 by mx.groups.io with SMTP id smtpd.web10.16195.1716558569471357579
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 06:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.174, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm5xg3v1nzs51;
	Fri, 24 May 2024 15:49:27 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vm5xg0ZsPzLnw;
	Fri, 24 May 2024 15:49:26 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 24 May 2024 15:49:16 +0200
Subject: [PATCH] add basic b4 config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
X-B4-Tracking: v=1; b=H4sIANuaUGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3SQT3eLSgoL8ohLdVEsLU9O0ZFOTFBMDJaCGgqLUtMwKsGHRsbW
 1AHtetnBcAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 13:49:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16251

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the Cc recipients
to always add, in our case the mailing list.

This shouldn't be necessary if we had a script that b4 prep --auto-to-cc
could call to find the mail address(es) to send to. While we could do
that, this opens the door to people trying to add a way to notify some
people (e.g. a MAINTAINERS file) which is not somewhere the project
wants to go right now, and this also makes sure the address is always
added even if one forgets to run b4 prep --auto-to-cc (which is part of
the typical workflow for U-Boot and Linux kernel, but is not necessary
thanks to this patch).

[1] https://pypi.org/project/b4/
[2] https://b4.docs.kernel.org/en/latest/config.html

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This adds a basic config file for b4 to avoid to have to add the mailing
list by hand. For documentation patches, one will still need to run
b4 send --cc docs@lists.yoctoproject.org
manually for sending it to the docs ML as well.

Note that b4 supports patchwork, c.f.
https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
though I have no clue what it does with it as I am no maintainer, but
maybe something worth having a look at if some maintainer of this repo
wants to use b4 to merge stuff?
---
 .b4-config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000..632e39db4
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,2 @@
+[b4]
+  send-series-cc = bitbake-devel@lists.openembedded.org

---
base-commit: ce166ae25793c11b0a190c531bef0c296fd74497
change-id: 20240524-b4-support-e9855fc54d40

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


