Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E0AECD992
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 17:26:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26347.1770312359377370604
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 09:26:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WcnT4hEE;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 47D3B4E42422
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 17:25:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 049756074D;
	Thu,  5 Feb 2026 17:25:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 313D3102F1B6D;
	Thu,  5 Feb 2026 18:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770312356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4QiWSbgEA1uU4wvgDZleXuofNrr+aaLFOrxuHEb9dsw=;
	b=WcnT4hEESBSOhbgV5sl3AJiXjphjmmqsFBmb8xIgs4X0fVDW8AEoId5prhVa39wmfEjJ7N
	8G5ckVVNp4V5xXfuiPfj0viFgeO5KKjG9K+0p/n2W9Q9+Me0/ODBzWyGHRxosVJZCs+SI9
	UisUEbWZg+ROOZ4iD1QTGt3/5ba18cOBRXH16DZNlsirH2tjzesOH4kxYE7gvHeSO3RYC9
	Y15AyE2XF9ESOc6/hVTzTU2hQqZV2pBLz5/YKKhn1bOkbfDnFdt4HJi8oYG9q1ltapu95d
	K/mWzaElFjVg9DR3ZWB05ic8vniFlaQDqw8LW1oxSu6zNMJa8nM32UTO/XcUBA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 05 Feb 2026 18:25:27 +0100
Subject: [PATCH v2] bin: Hide os.fork() deprecation warning at module level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mathieu-fork-warning-filter-v2-1-7f5883ebec5d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIbShGkC/43NQQ7CIBCF4as0rB0DWGvrynuYLgCHdmILBrBqG
 u4u9gQuv7f438oiBsLIztXKAi4UybsCuauYGZUbEOhWzCSXDZf8CLNKI+ETrA93eKngyA1gaUo
 YoNNtc0JhGmU0K4VHQEvvrX7ti0eKyYfPdraI3/pfdxEgAGuNtu1qfjDior1PE7m98TPrc85fT
 SNQksgAAAA=
X-Change-ID: 20260205-mathieu-fork-warning-filter-9b867e1c6acb
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Chen Qi <Qi.Chen@windriver.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770312353; l=2905;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=dPR1yx2l+UUQjPrGaghBsfUuyhhEwdEuaF7Ihkik5a0=;
 b=yGtTl/r6BK1lQDv8TWSjJxOEash0fOVW4gCJYZstDcARFNtR67mNyX7sGxHnQdX+OMZhB1ZfT
 db83FoUHNtpCD7/tiED8ld/ZBmyeofLfoOKoU2/FBoM5MG4+thGQl7J
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 17:26:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18974

Add the message filtering directly in the python module where the error
happens, so we do not need to repeat the filter in all consumers. This
will also make sure the filter is applied in any user of createDaemon().

Fixes [YOCTO #16080]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Suggested-by: Chen Qi <Qi.Chen@windriver.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260205-mathieu-fork-warning-filter-v1-1-e4bef89403c1@bootlin.com
---
 bin/bitbake         | 1 -
 bin/bitbake-layers  | 1 -
 bin/bitbake-server  | 1 -
 lib/bb/daemonize.py | 3 +++
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 2eb5f9103d31..a995bd665352 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -14,7 +14,6 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
-warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 37c196226cbe..c49a5f30eef4 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -16,7 +16,6 @@ import sys
 import argparse
 import warnings
 warnings.simplefilter("default")
-warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 bindir = os.path.dirname(__file__)
 toolname = os.path.basename(__file__).split(".")[0]
diff --git a/bin/bitbake-server b/bin/bitbake-server
index 01f83d982f0c..1428f72a7e57 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -9,7 +9,6 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
-warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 76894044363e..70d9b8ee0e70 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -15,9 +15,12 @@ import os
 import sys
 import io
 import traceback
+import warnings
 
 import bb
 
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
+
 def createDaemon(function, logfile):
     """
     Detach a process from the controlling terminal and run it in the

---
base-commit: 921e4ce1e030e4c8c3ecd5d6ffc7343df473d13c
change-id: 20260205-mathieu-fork-warning-filter-9b867e1c6acb

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


