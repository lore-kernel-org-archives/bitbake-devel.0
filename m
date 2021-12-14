Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC4FC433F5
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 01:26:00 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web08.20089.1639445158687040632
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 17:25:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=intel header.b=Fd8afYgd;
 spf=pass (domain: intel.com, ip: 134.134.136.20,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639445159; x=1670981159;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=EEBfn2p9+M6XA0pVCQZPjbJl2Xw9/7uEQfpdaV8VV9E=;
  b=Fd8afYgdV/v5/Y2cRlUcVjLyQlh90gE5fdzeePiDelRJgNnvKwS9kllL
   keGoi4cWUSDkrDLe9+ssr/qGJ1skFeVNcfgwenjWJbLih3F6mlcpCVEGg
   hGRJslrI/IJl6lhfIB3vntv1w1XlBxKwAPX1TWBro/yqgmRj3tgT1xS1a
   JhTPm26KDiKKN3PA3KoQUi2bR9sMmRVQciiJzU78/CZaLyGGbXSMkZxQH
   vpQVReu7AWu8ahL8+QAIlRr9UDr/aPcN+mnDUyADJ2eSOirAk91jcA00G
   AyJ7k76JcgP5xsPQ8/QeCE32Fk4s1wXgtlKppyhzrbH6lhjnKw37ZUU7a
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226147972"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600";
   d="scan'208";a="226147972"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 17:25:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600";
   d="scan'208";a="464869988"
Received: from zyteoh-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.239.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 17:25:57 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/1] lib/pyinotify.py: Remove deprecated module asyncore
Date: Tue, 14 Dec 2021 09:25:47 +0800
Message-Id: 
 <58e96da6c8aee974a644439b081e778da2725364.1639444935.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639444935.git.anuj.mittal@intel.com>
References: <cover.1639444935.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 01:26:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13154

From: Robert Yang <liezhi.yang@windriver.com>

When build with nativesdk-python3 (3.10) from buildtools:
/path/to/bitbake/lib/pyinotify.py:55: DeprecationWarning: The asyncore module is deprecated. The recommended replacement is asyncio

The pyinotify.py's upstream didn't have any update in recent 7 years:
https://github.com/seb-m/pyinotify

And bitbake doesn't use the asyncore module, so remove the related code.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/pyinotify.py | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 6ae40a2d..8c94b3e3 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
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
2.33.1


