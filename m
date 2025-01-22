Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8594FC02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 23:25:47 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.211])
 by mx.groups.io with SMTP id smtpd.web10.8090.1737588337638287713
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 15:25:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=SKQsaad7;
 spf=pass (domain: freemail.hu, ip: 46.107.16.211, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YdgDH5kxHzLxp;
	Thu, 23 Jan 2025 00:25:35 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2 3/4] bitbake: knotty: Use 10 Hz refresh rate (FPS) for footer update.
Date: Thu, 23 Jan 2025 00:24:10 +0100
Message-ID: <20250122232411.133-4-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250122232411.133-1-egyszeregy@freemail.hu>
References: <20250122232411.133-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737588336;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 23:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17061

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1845; bh=EsMww1/nlvt7XQo4UmA8J5yvDu51WKjRJPQ3jZ2tbF8=;

	b=SKQsaad7N4BhQNLxvNYsIqFeZKcDejoNjb63rJ+/aAZrcVD24QhQGhI84v7GSw4Y

	A19udlJNNVojqh5V6mA1e8JrC/bCpCBAgmN2lWztSVcDCiA7AN1iAtj/s3Laobf7M9p

	LQmNWbSFz5j6sJDop84eBo6tL7ChtBcGLMdH+i/Xj/SD4dpJQT0+NsMy1/HWCJRMg/D

	pdLo+FXp9FQFS5JJ2VL1CrnA4syTEKpNmziJijgNVmnu50oZUt9wAiMoWRgqrZBv/ju

	kXYEwOKD27PW0hR/lNOlgT678y67zsqq0Auuq++1wZ0CKeb3dOgcEu9mBg5jAzPXmPU

	Qip8zau0jw==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Refresh footer in 10 Hz to avoid heavy print() flooding.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/ui/knotty.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c30bd64c7..ad018a182 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -128,6 +128,10 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
=20
 class TerminalFilter(object):
+
+    # 10 Hz (FPS) -> 0.100 secs
+    _DEFAULT_PRINT_INTERVAL =3D 0.100
+
     rows =3D 25
     columns =3D 80
=20
@@ -166,7 +170,7 @@ class TerminalFilter(object):
         self.interactive =3D sys.stdout.isatty()
         self.footer_present =3D False
         self.lastpids =3D []
-        self.lasttime =3D None
+        self.lasttime =3D time.time()
         self.quiet =3D quiet
=20
         self._footer_buf =3D io.StringIO()
@@ -251,11 +255,23 @@ class TerminalFilter(object):
         failedtasks =3D self.helper.failed_tasks
         runningpids =3D self.helper.running_pids
         currenttime =3D time.time()
-        if not self.lasttime or (currenttime - self.lasttime > 5):
+        deltatime =3D currenttime - self.lasttime
+
+        if (deltatime > 5.0):
             self.helper.needUpdate =3D True
-            self.lasttime =3D currenttime
-        if self.footer_present and not self.helper.needUpdate:
+            need_update =3D self.helper.needUpdate
+        else:
+            # Do not let to update faster then _DEFAULT_PRINT_INTERVAL
+            # to avoid heavy print() flooding.
+            need_update =3D self.helper.needUpdate and (deltatime > self=
._DEFAULT_PRINT_INTERVAL)
+
+        if self.footer_present and (not need_update):
+            # Footer update is not need.
             return
+        else:
+            # Footer update is need and store its "lasttime" value.
+            self.lasttime =3D currenttime
+
         self.helper.needUpdate =3D False
         if self.footer_present:
             self.clearFooter()
--=20
2.47.1.windows.2


