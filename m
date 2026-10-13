Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099ECC6B15
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 12:14:11 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5605.1791893645930077572
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 05:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=IU16DxUw;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B38B44E41209;
	Tue, 13 Oct 2026 12:14:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 796C060362;
	Tue, 13 Oct 2026 12:14:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4864A11D70F56;
	Tue, 13 Oct 2026 14:14:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791893642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ePXH4HJQ4a+lTQ+SxgkBFQ2FiI7hYt4TMo+I4SO48Bs=;
	b=IU16DxUwWEPd308hE49xB+t4m9giE29xBhMQ64QDARCXNCehTa/bLSOwze0ko+LHcHlvmr
	ApNtvLC10QsQxBPH1EB8+HqunJDLqmBsoQWx4Wxnc5YKp89nt267WpP1PjdLBqRvSIi+uL
	PTis0hoqModj7PMMjWUkE1RzoVLgsYHcOoYn4Ua+qgV5ii0cNthusSk5F+daWGvObLqls5
	CNcImSmIkRm04+uQLIzz0OzL5n1UJpdcRUAuQZS1TMRsij6g1sgTaXSRYg+I+5bj5q2UVN
	+QoHpMLS8T/BqRn5Ef9Cad6I7b0gJmnHCP7OmUrSGtCZKFNGR4CFtml/UXTq4Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 13 Oct 2026 14:13:34 +0200
Subject: [PATCH 1/4] main: add an argument for showing warnings as errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-warn-as-errors-v1-1-ab3658758ceb@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
In-Reply-To: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=XI8cvf1wI6d/zdJv0v0/Pc/0Za77HiOxQM/1xHSQgNE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqziB0PQujZKp++DkI6chP+EKkxo5nIT7eHBR+I
 lJEXjTDlAWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCas4gdAAKCRDRgEFAKaOo
 NhD8EADD6N9UL44/YENstSQg+gYakmVlUpTk34wldMUiOMZRDUm5C/8CeytrQvqXLR8jiztaOPx
 R1tYZdJuKgocVLfq018mPzB8+rhoTWKhN05ixTqN0I3cr7r0zlMcUAHlek6pFAgEMeT66+JZQ3I
 J9DS7i6R/gHXYVRzOgLvuEo60dTHJt3LZh1YniCcGnNFqAjuWRZa4FbSwRqMUk+sVxVYqcq3OsJ
 lnaYKMB43Bw9hRyUoBdvQEADotJi6fOfY2LdQbh/WrYYMk0VfQVCFPW+nRmzjnzNu+bHtl3Et4y
 eGJG+RGrFaoxXZxkl6cyIGhFllmS5EJz29+xShxSLTr+Vc9VvlNVKUt1BljFFBq1ovRJHdX2YI4
 IAZR4X2gEmvkGjyw40BXyHa9oAsMP5bgXkxDkYd/4kIXEIsKIEDeSxCLuf5HIe0ySg0FuMi7FNe
 lOMzv9YFxmANbCdUGHNXx8uM3Y47QVSNjOHnyl7QKs04BocXEexqX1JdC2cdM3UYcqr45FvTk6I
 pz6EvZ2YXlCmxDP3Pv3+OUnWoAnxO3+iblZkaj4GshBMVvHhiGnZHRBGOZWA4lFuA2zdusQy/c5
 J6UXFiJJojqNBddt/4QWv0sIPvb7wVWiCdwa4jhDezhgKtxaVURzzIZO4sBnBpMctebEpproPHp
 +n+o+zNYnsH591g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 12:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20326

Add -W/--warnings-as-errors to make it possible to turn warnings into
errors. The werror boolean should be used by UIs to turn their warnings
into errors.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/main.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 73a66468fef..7c65dfff1af 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -256,6 +256,9 @@ def create_bitbake_parser():
                         help="Output less log message data to the terminal. You can specify this "
                              "more than once.")
 
+    logging_group.add_argument("-W", "--warnings-as-errors", action="store_true", dest="werror",
+                        help="Treat warnings as errors.")
+
     logging_group.add_argument("-w", "--write-log", dest="writeeventlog",
                         default=os.environ.get("BBEVENTLOG"),
                         help="Writes the event log of the build to a bitbake event json file. "

-- 
2.55.0


