Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA45C77B61
	for <webhook@archiver.kernel.org>; Sun, 16 Apr 2023 09:19:25 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web10.26112.1681636758273179950
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Apr 2023 02:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=FwAkDNwd;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 33G9JEbi1415152
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Sun, 16 Apr 2023 11:19:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1681636754;
	bh=/Wt0EFrbzRQaIti3S3B1/ieuvciMmfudA6FLEjaY+YA=; l=897;
	h=From:To:Cc:Subject:Date;
	b=FwAkDNwdLo+XBZ1CCQd+dgCSisBaFgRs9txpff/T4q8DgoIGZLOVaS5Nv8+RhGiLN
	 /fiqjQx3jr3YSpJG83INljy1EGbX2zeZuB+h0J9ukgUD5LfPSTIRsJVIuTe73yUZb3
	 u+84NLsZVLMKzIjmGi8GRdK+KPgZoOM66GQPnEARTCTYBmCoHL4/XcNklVMx1jWZ4L
	 01kBsF5WMXDV3jmEwnHuXEhwlID5RVwRHsXfMcjR3onlf6cB9TVejSZ4f7uqY3qjAL
	 1QxaTabYaMJpT5oQcKZEqmbUNO58URgiydfGaDUKrviT9TlJKvBueuF7k5wt3aWZlN
	 mi1k3gG9fjxQA==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTP id 33G9JBlr702034
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Sun, 16 Apr 2023 11:19:12 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ([192.168.12.73])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id WK4PIMQFK7; Sun, 16 Apr 2023 11:19:11 +0200
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 33G9JAjn1475663
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 16 Apr 2023 11:19:10 +0200
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.96)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1pnyXO-00BPz5-27;
	Sun, 16 Apr 2023 11:19:10 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] cooker: do not abort on single ctrl-c
Date: Sun, 16 Apr 2023 11:18:57 +0200
Message-Id: <20230416091857.2721368-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 643bbd8f5038ce378780e9ec
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Apr 2023 09:19:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14704

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

After b7ed7e9a815c4e10447fd499508be3dbb47f06e8 bitbake aborts immediately
when a single ctrl-c is pressed.

Patch restores the previous behavior where a single ctrl-c waits for
active tasks to finish.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=15094

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1797a1d4ca5f..5b2791b2627a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1764,9 +1764,9 @@ class BBCooker:
     def shutdown(self, force=False):
         if force:
             self.state = state.forceshutdown
+            bb.event._should_exit.set()
         else:
             self.state = state.shutdown
-        bb.event._should_exit.set()
 
         if self.parser:
             self.parser.shutdown(clean=False)
-- 
2.39.2


