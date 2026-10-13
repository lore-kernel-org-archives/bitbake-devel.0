Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E3CC6B10
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:11 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5689.1791893646216322334
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Nhfsd3E8;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D5A41A11FE;
	Tue, 13 Oct 2026 12:14:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D2F960362;
	Tue, 13 Oct 2026 12:14:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48B0711D7105B;
	Tue, 13 Oct 2026 14:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e8zCv3ba4s73w2+IyKqPTXYwD4KbQoIs1tO3fxzj2f8=;
	b=Nhfsd3E8+qZDSF4tZkW6jMxE3yofhbNfT7i96z+VePlWh78U/ZySsweDCOifQRfPVWH1TT
	50lUYbNh4l4iz+5+qSsjQEdz5sk+s+77CVmgIJi3mHygewoLkwsvzpUY2NIqFzIIwxG42t
	QStCvs4W3n5KsY4DoS/Cc/E395kvtDa7mox4+bG8Jxrs81z2LYypuk5AXI6hr1Sje/rb/4
	Z7CHFijpELSp8rqcznx25ci6yfuIWT8jtxE9WvOuHyaOVYVgl2tGfqrgvAUl7sf+CYaTMf
	nzF6Nw548iFbFoWYEiGHTSguJ+J8YDJaFWj0bFtD7uv9u9eMET+NU0l2oRI+mg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 13 Oct 2026 14:13:35 +0200
Subject: [PATCH 2/4] msg: add a helper to show warnings in red color
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-warn-as-errors-v1-2-ab3658758ceb@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
In-Reply-To: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ROVXoPLlsPztgqD6Z8t2y2a3AwhvuihOqzeftQ3RxC8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqziB0PXsvYfTEgjPBNONJjtVBdyRq4eML4UNGj
 c7VzyGRJvGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCas4gdAAKCRDRgEFAKaOo
 NjIZD/4zPQKVEahmqKln1o/UN02yZYeNd2GAoG9/K7Gg0+f5R0oZokgafQCcn7DnOilX57HZ6w1
 5SjZIE0O5A9g+cOIWHqFTLq6+HTeuuMNN+i3WtCcWI7r+8+nqMF7V0/KXwWm2Lrk/JuKWHD4T9+
 I68USIb6ZBrhinSP1nCSIAUxvXxMdKrylad9IKW5+wCPIgSFxyhEf+KyiM77XcyVvROqEu6OiZO
 JSjdWnxv5eiHWG7gBlJ+w+AdKOitkcAyOYN+GGHXbcQ0lHZygmmLVp7YZqWvGWV6Hi58PrUg+rC
 LJx7aIawNn6ZVcT6W+9sntEDJqapO7aZ+Uy+JkhtDtIo++EZ/9pH+JNtZ4VcGfxURVwGU4MLiux
 yZPgckKcwx9t1CZaJ1DqVGKJCQxXwEiKMhQaBFMWUFAlNJTNfvpYDas5HhwGL+lnR2LOE6UBZS5
 zbRAcnN/gwhHM6uKAyV0EeuPLrK2JPFeGQ3HyDCkeKJkH1W7vOZDiKhnPcgwk673MI4FLtzEZJm
 jt+I309SGsRbR02zb4sKrAOqy7jH1wRiUPeRvYVwVhUnghDHPLjVJ8cA/AhtaoObXnOtjryd6q8
 RuggAQmoZRI9xkEISzu3mTCzEaTIuLsZDmU1F7r1Ib5IMhytpsJ9zuBDVmWmVc1bI4pcPdmkn2b
 f6jPfBibygSmNUA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20327

In preparation for the next commit, add a helper that changes the
warning color to be red, when warnings should be treated as errors. This
helps users recognizing that the -W argument was passed while still
being able to differentiate between warning and error messages (thanks
to their levelname).

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/msg.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 4f616ff42e7..02728c44bba 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -102,6 +102,14 @@ class BBLogFormatter(logging.Formatter):
     def enable_color(self):
         self.color_enabled = True
 
+    def set_warn_color_red(self):
+        """
+        Changes the warning messages color to red. Should be
+        used when treating warnings as errors.
+        """
+        self.COLORS[self.WARNING] = self.RED
+        self.COLORS[self.WARNONCE] = self.RED
+
     def __repr__(self):
         return "%s fmt='%s' color=%s" % (self.__class__.__name__, self._fmt, "True" if self.color_enabled else "False")
 

-- 
2.55.0


