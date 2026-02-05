Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77343E83F1F
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 14:14:11 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21627.1770300840298866618
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 06:14:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=eV6NvCre;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 57DA21A2C2F
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 14:13:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F42A606FD;
	Thu,  5 Feb 2026 14:13:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18A28119A8891;
	Thu,  5 Feb 2026 15:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770300837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hunB+qqZfdDJrkW9+L/dUU2gJrfQdN8o4D4G1d+N8Vc=;
	b=eV6NvCreAudANBLKyaaviiZyjpmmUHkIc6CzVeAZne2l+ZezZ5JiXa31aBj7DlTwMaUX4d
	eIAPfCioJcCyPu3XbjVTICjoo/I/uOTvz7DxHW3l3f9N/eR5PwtIkCeu6YzlT/Y+prjyrx
	qq2vjA1jlTKA3qw+yhgXS5HK7JV0kvFa+hhJcIdqbzlBhrkizj09W9QP2p0UZa9+GEUls/
	ifJcDtFB2YkrLujpHY3rIfJVu6pFHyvfurNYKKR+4OK/o03ZyErbfKv0V+LA8MCvAa5PK+
	qRNgsU9h6d270n+5coAnZKOVqBjss8oHKqj/1fT4xkpiAtbKAImmjRnZQq4eWA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 05 Feb 2026 15:13:36 +0100
Subject: [PATCH] bin: Hide os.fork() deprecation warning at module level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mathieu-fork-warning-filter-v1-1-e4bef89403c1@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAI+lhGkC/x3MSwqEMAwA0KtI1gZqwY56FXFRO6kGtUrqD8S7T
 5nl27wHIglThCZ7QOjkyGtIKPIM3GjDQMjfZNBKG6VViYvdR6YD/SoTXlYChwE9zzsJ1n1lPlQ
 4Y10PadiEPN//ve3e9wdxKa3rbQAAAA==
X-Change-ID: 20260205-mathieu-fork-warning-filter-9b867e1c6acb
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Chen Qi <Qi.Chen@windriver.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770300834; l=3193;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=g6/0SrxGyBvAbJYPsFgqzrOcdCld/RLEE1RJZEhQxHI=;
 b=mwbTjDU+KMsmFZBcb44CwTLltm1oCIHF6V+d8uq1h5vb1PwuyxHuOaNAb0CurPzoR3DSnRyU2
 FtDbrryV0lCCCEUm3Y8d6RuL6eKSkMWDrGQ+CI7HVXwZX6f0mA1OXty
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 14:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18970

Add the message filtering directly in the python module where the error
happens, so we do not need to repeat the filter in all consumers. This
will also make sure the filter is applied in any user of createDaemon().

Fixes [YOCTO #16080]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Suggested-by: Chen Qi <Qi.Chen@windriver.com>
---
 bin/bitbake         | 1 -
 bin/bitbake-layers  | 1 -
 bin/bitbake-server  | 1 -
 bin/bitbake-worker  | 1 -
 lib/bb/daemonize.py | 3 +++
 5 files changed, 3 insertions(+), 4 deletions(-)

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
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index d2b146a6a92f..d522ca54b7f8 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -9,7 +9,6 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
-warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 from bb import fetch2
 import logging
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


