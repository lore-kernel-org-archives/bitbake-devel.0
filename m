Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9240ECD6DC
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 18:06:38 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25755.1770833191606167711
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 10:06:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=KcHP/tDE;
 spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fB5wQ1FMpzB3M;
	Wed, 11 Feb 2026 19:06:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1770833190;
	bh=L6H1tw62hGL2vdwemXZyjMbUMe2jbN/HpT66YshS+1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KcHP/tDEMYYp0nDo7zisAUi896xoFN/IoRej639ufU+KCdcw+Cp2b7MwAk6jBSv85
	 NuBAdFGFDHOqQHyI+agB9YqejXFAIx+utt/cwmh2g7f9qa9IF5P9zwJDxw/ZU/5MF/
	 DjdYN0mqRP4JmSurH6BIHRFK9Ev/syoZVbCvHZvzr47kPQ/fvzEVyGDIyvTdqhoCq0
	 NtpC2eQJIuHLF6GvZOPmduvBjALSG89sf5ZwlV7MqKK9t6yWj7becJqdpMzI9k+rzB
	 0VqFSgS1Hirm75SW8rpaprSCFLzzab0Cvl5rbhsKIAEAos9fWCu7ijXK14cAdKJD7y
	 4ZR/7RMJrh/lA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fB5wP4b84zcfC;
	Wed, 11 Feb 2026 19:06:29 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 11 Feb 2026 19:06:20 +0100
Subject: [PATCH 1/4] doc: bitbake-user-manual-ref-variables: clarify BBMASK
 directory matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-bbmask-slashes-v1-1-b72161c647ef@cherry.de>
References: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
In-Reply-To: <20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 18:06:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19009

From: Quentin Schulz <quentin.schulz@cherry.de>

BBMASK matches files in the directories matching the regex, and also in
their respective subdirectories, so make that clear in the wording
leading to the example.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 4b3b10d46..18bbd638d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1051,8 +1051,8 @@ overview of their function and contents.
       documentation at http://docs.python.org/3/library/re.html.
 
       The following example uses a complete regular expression to tell
-      BitBake to ignore all recipe and recipe append files in the
-      ``meta-ti/recipes-misc/`` directory::
+      BitBake to ignore all recipe and recipe append files in
+      ``meta-ti/recipes-misc/`` directories (and their subdirectories)::
 
          BBMASK = "meta-ti/recipes-misc/"
 

-- 
2.53.0


