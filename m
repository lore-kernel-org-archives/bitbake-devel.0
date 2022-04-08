Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE532C47080
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:35 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.6857.1649429077554237367
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Apr 2022 07:44:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=RJ6ArOWW;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649429078;
  x=1680965078;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WNRR+AIEMPv0VILdW3i10l7ywSVBO12LyT55sCQAvzI=;
  b=RJ6ArOWWrgbrfLXdIfL6fUaGPNoTJD8nc+cdZK5YYvnszsb+UTld17l6
   rkxlL1AZZJ07dc4DZe7i7NuGkfScpM4qjBOfRyuK1/2LqI9PgGyVjAkWT
   HRsJtWbz2FE3IPIJtUjnZ2YWSKdz2H0nXJTKTVWBSoSwBwDEl2BHEQVHI
   UtCASWGthxGWETZ+MlgS7FtWxYXzvofs4w52Tb5zjIys3GoA+RaEjiX1x
   CVbjp/yhokolVXUW+IunMsmjgEzPfaNEEYcRH6tGLqnc1tGWmrOrYGii9
   DM1P6Yb99bzImJAS6SGUmFQ3WsEnNoZi1FJXdI3s+he04v7wSXsPGgr2M
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] pyinotify.py: Simplify identification of which event has
 occurred
Date: Fri, 8 Apr 2022 16:44:30 +0200
Message-ID: <20220408144430.29768-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Apr 2022 17:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13596

Use bitwise operators to manipulate the received event mask in
_ProcessEvent.

Also minor clarification & clean up of the related comments.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/pyinotify.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/pyinotify.py b/bitbake/lib/pyinotify.py
index 5c9b6d0fe2..3c5dab0312 100644
--- a/bitbake/lib/pyinotify.py
+++ b/bitbake/lib/pyinotify.py
@@ -595,24 +595,23 @@ class _ProcessEvent:
         @type event: Event object
         @return: By convention when used from the ProcessEvent class:
                  - Returning False or None (default value) means keep on
-                 executing next chained functors (see chain.py example).
+                   executing next chained functors (see chain.py example).
                  - Returning True instead means do not execute next
                    processing functions.
         @rtype: bool
         @raise ProcessEventError: Event object undispatchable,
                                   unknown event.
         """
-        stripped_mask = event.mask - (event.mask & IN_ISDIR)
-        # Bitbake hack - we see event masks of 0x6, IN_MODIFY & IN_ATTRIB
+        stripped_mask = event.mask & ~IN_ISDIR
+        # Bitbake hack - we see event masks of 0x6, i.e., IN_MODIFY & IN_ATTRIB.
         # The kernel inotify code can set more than one of the bits in the mask,
         # fsnotify_change() in linux/fsnotify.h is quite clear that IN_ATTRIB,
         # IN_MODIFY and IN_ACCESS can arrive together.
         # This breaks the code below which assume only one mask bit is ever
-        # set in an event. We don't care about attrib or access in bitbake so drop those
-        if (stripped_mask & IN_MODIFY) and (stripped_mask & IN_ATTRIB):
-            stripped_mask = stripped_mask - (stripped_mask & IN_ATTRIB)
-        if (stripped_mask & IN_MODIFY) and (stripped_mask & IN_ACCESS):
-            stripped_mask = stripped_mask - (stripped_mask & IN_ACCESS)
+        # set in an event. We don't care about attrib or access in bitbake so
+        # drop those.
+        if stripped_mask & IN_MODIFY:
+            stripped_mask &= ~(IN_ATTRIB | IN_ACCESS)
 
         maskname = EventsCodes.ALL_VALUES.get(stripped_mask)
         if maskname is None:

