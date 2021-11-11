Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB0C4332F
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 07:45:01 +0000 (UTC)
Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web09.7695.1636616700034228965
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 23:45:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 1AB7is6E007187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 23:44:54 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 23:44:53 -0800
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 23:44:53 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] lib/pyinotify.py: Remove deprecated module asyncore
Date: Wed, 10 Nov 2021 23:44:53 -0800
Message-ID: 
 <e04cc743445d3eb3126558b9d681bfa9ffecfbbf.1636616603.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636616603.git.liezhi.yang@windriver.com>
References: <cover.1636616603.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 07:45:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12999

When build with nativesdk-python3 (3.10) from buildtools:
/path/to/bitbake/lib/pyinotify.py:55: DeprecationWarning: The asyncore module is deprecated. The recommended replacement is asyncio

The pyinotify.py's upstream didn't have any update in recent 7 years:
https://github.com/seb-m/pyinotify

And bitbake doesn't use the asyncore module, so remove the related code.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/pyinotify.py | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/bitbake/lib/pyinotify.py b/bitbake/lib/pyinotify.py
index 6ae40a2d76..8c94b3e334 100644
--- a/bitbake/lib/pyinotify.py
+++ b/bitbake/lib/pyinotify.py
@@ -52,7 +52,6 @@ from collections import deque
 from datetime import datetime, timedelta
 import time
 import re
-import asyncore
 import glob
 import locale
 import subprocess
@@ -1475,35 +1474,6 @@ class ThreadedNotifier(threading.Thread, Notifier):
         self.loop()
 
 
-class AsyncNotifier(asyncore.file_dispatcher, Notifier):
-    """
-    This notifier inherits from asyncore.file_dispatcher in order to be able to
-    use pyinotify along with the asyncore framework.
-
-    """
-    def __init__(self, watch_manager, default_proc_fun=None, read_freq=0,
-                 threshold=0, timeout=None, channel_map=None):
-        """
-        Initializes the async notifier. The only additional parameter is
-        'channel_map' which is the optional asyncore private map. See
-        Notifier class for the meaning of the others parameters.
-
-        """
-        Notifier.__init__(self, watch_manager, default_proc_fun, read_freq,
-                          threshold, timeout)
-        asyncore.file_dispatcher.__init__(self, self._fd, channel_map)
-
-    def handle_read(self):
-        """
-        When asyncore tells us we can read from the fd, we proceed processing
-        events. This method can be overridden for handling a notification
-        differently.
-
-        """
-        self.read_events()
-        self.process_events()
-
-
 class TornadoAsyncNotifier(Notifier):
     """
     Tornado ioloop adapter.
-- 
2.31.1


