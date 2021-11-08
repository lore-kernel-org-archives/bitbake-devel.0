Return-Path: <n.papenkov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3495C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 08:20:09 +0000 (UTC)
Received: from mail.inango-systems.com (mail.inango-systems.com
 [178.238.230.57])
 by mx.groups.io with SMTP id smtpd.web09.42325.1636359608369562078
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 00:20:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com
 header.s=45a440e0-d841-11e8-b985-5fcc721607e0 header.b=AoRdtIjP;
 spf=pass (domain: inango-systems.com, ip: 178.238.230.57,
 mailfrom: n.papenkov@inango-systems.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 2D53D1080447
	for <bitbake-devel@lists.openembedded.org>;
 Mon,  8 Nov 2021 10:20:06 +0200 (IST)
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AYfO93b6Y3mP; Mon,  8 Nov 2021 10:20:05 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 30E12108043F;
	Mon,  8 Nov 2021 10:20:05 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 30E12108043F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1636359605;
	bh=r8FnFcJkXjj42Z7xT8TZNUOEtpEXmNlo2+4wCwr4ti0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=AoRdtIjP2Cb+c1uZ2IeH62cxSEglgMIoVAj0iTZvJGUOJFq1r5Qvv5rxs4BdvAoqX
	 9aF7aoHi0k6eaZO8O+H7GpbvpMdgEQutA0jNeWxWbIPdATX6x1czVSqqly8WdF/A4H
	 nab3CUeHaZkL3D9SiHiiOxZPauR0Qb9J/3huJ4MJfYOg1qujTQKBA7eA8Blc8VY9Cl
	 hjec9KfTfWt0qdHA6chRgipG5nA6P3w9g4BmkA5/UdaLwyEm3R8mXk9I3AMFt9jwcQ
	 gxvP+NpZ0wguowAD57WkbKlnsdTbAZEgJhI7EuLti+T7j7sm9SXFVcYP0Xksfh4ccn
	 iacABzyj7H5eg==
X-Virus-Scanned: amavisd-new at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
	by localhost (mail.inango-systems.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HiA3tnwTYLPX; Mon,  8 Nov 2021 10:20:05 +0200 (IST)
Received: from mail.inango-systems.com (mail.inango-systems.com
 [172.17.220.3])
	by mail.inango-systems.com (Postfix) with ESMTP id 0FA88108042E;
	Mon,  8 Nov 2021 10:20:05 +0200 (IST)
Date: Mon, 8 Nov 2021 10:20:04 +0200 (IST)
From: Nikolay Papenkov <n.papenkov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Dmytro Slovinskyi <d.slovinskyi@inango-systems.com>
Message-ID: 
 <1169595873.137875.1636359604857.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <20211026074217.1637-1-n.papenkov@inango-systems.com>
References: <20211026074217.1637-1-n.papenkov@inango-systems.com>
Subject: Re: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long
 time
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF88
 (Linux)/8.8.15_GA_4173)
Thread-Topic: bitbake: a cooker is stuck for a long time
Thread-Index: ft+3BX/tQTJ6U6nGtk+LHw1lshvNZw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 08:20:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12932

Hello list,

Any comments on the patch? The solution is rough and straightforward but what approach to the problem can be accepted?

Regards,
Nikolay

----- Original Message -----
From: "Nikolay Papenkov" <n.papenkov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Nikolay Papenkov" <n.papenkov@inango-systems.com>, "Dmytro Slovinskyi" <d.slovinskyi@inango-systems.com>
Sent: Tuesday, October 26, 2021 10:42:17 AM
Subject: [bitbake-devel][PATCH] bitbake: a cooker is stuck for a long time

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
-- 
Nikolay Papenkov 
Architect, Arch group 


Inango. The Service Orchestrator. 
web. [ https://mail.inango.com/inango.com | inango.com ] 
mail. [ mailto:n.papenkov@inango-systems.com | n.papenkov@inango-systems.com ] 
tel. +357 99 615176 

The information contained in this message is proprietary to Inango Systems, protected from disclosure, and may be privileged. The information is intended to be conveyed only to the designated recipient(s) of the message. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, use, distribution or copying of this communication is strictly prohibited and may be unlawful. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer.

