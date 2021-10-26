Return-Path: <n.papenkov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF2C433F5
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 07:42:33 +0000 (UTC)
Received: from mail.inango-systems.com (mail.inango-systems.com
 [178.238.230.57])
 by mx.groups.io with SMTP id smtpd.web10.9012.1635234152276768027
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 00:42:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com
 header.s=45a440e0-d841-11e8-b985-5fcc721607e0 header.b=HKq8ShPz;
 spf=pass (domain: inango-systems.com, ip: 178.238.230.57,
 mailfrom: n.papenkov@inango-systems.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id DF7CE1080630
	for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 10:42:29 +0300 (IDT)
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qJX5ey3COvSE; Tue, 26 Oct 2021 10:42:29 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 054EF1080627;
	Tue, 26 Oct 2021 10:42:29 +0300 (IDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 054EF1080627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1635234149;
	bh=Szb7kZua5iyqAEKy0i1kX5IzQvL4Xx7cPHZ4f8kISKc=;
	h=From:To:Date:Message-Id;
	b=HKq8ShPzJNWwNHmgadpIQTu4ACv9102DWFkg/fxZpaELA/MVhqfc6iN/NBwQwsYYO
	 SpE85sXag74gQrxBc8Tp8MQM7evaRYLQjhu2bwVO4rj8ePczdLqfqp5ysMH2RhNdNi
	 sKZXZSjPquNhVAPu4ZY0bTTER5jgyrM0BfT5FUNMe9ou4YO1YNQnNgSqeq6AVMzaoJ
	 k4WMdn8c3QeYiio98PzKnNZ2Gmr+dwU2sc5PJrxzRNKarWhQxriJlIBhhQPMNAQacg
	 i63F876xb2IbQ8lRVhbxLpQQex6nKGGO4DEbtOov0hkAs14/C8m/DMB1xQge0o1RSr
	 yWT53ShPPhx7g==
X-Virus-Scanned: amavisd-new at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yvp7eUGEApt6; Tue, 26 Oct 2021 10:42:28 +0300 (IDT)
Received: from 87fb558b1369.phoenix.local (unknown [93.109.15.169])
	by mail.inango-systems.com (Postfix) with ESMTPSA id 8C73D10802E1;
	Tue, 26 Oct 2021 10:42:28 +0300 (IDT)
From: Nikolay Papenkov <n.papenkov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Cc: n.papenkov@inango-systems.com,
	Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
Subject: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long time
Date: Tue, 26 Oct 2021 07:42:17 +0000
Message-Id: <20211026074217.1637-1-n.papenkov@inango-systems.com>
X-Mailer: git-send-email 2.17.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 07:42:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12829

From: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>

bitbake process has a deadlock in cooker.py, function parse_generator.
The loop expects that all threads will increment self.parsed variable until it
reaches self.toparse. When a random parse thread(s) are killed, the procedure
is not finished and as a result self.parsed never reaches self.toparse.

The fix breaks the loop after 25 seconds of no updates in self.parsed
number.

Signed-off-by: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
---
 bitbake/lib/bb/cooker.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index af794b4c42..0c07a073fa 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2208,10 +2208,19 @@ class CookerParser(object):
             yield not cached, mc, infos
 
     def parse_generator(self):
+        current_parsed = -1
+        no_updates_iter = 0
         while True:
+            if current_parsed == self.parsed:
+                no_updates_iter += 1
+                # Give up after 2 minutes
+                if no_updates_iter > 480:
+                    raise bb.parse.ParseError("No updates of parsed items for 2 minutes. Probably parsing thread was killed. Exiting.", None)
+            else:
+                no_updates_iter = 0
+                current_parsed = self.parsed
             if self.parsed >= self.toparse:
                 break
-
             try:
                 result = self.result_queue.get(timeout=0.25)
             except queue.Empty:
-- 
2.17.1


