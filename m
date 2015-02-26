Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 343A473770
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:21 +0000 (UTC)
Received: by wghl2 with SMTP id l2so15103028wgh.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hhZVSBO+fZTF3zREALiJuvXobh78DF8YE3wKXCMhRi8=;
	b=D6SGMDiGnT3c3rSQv0T+sZk8nJM0+hMr6Clkla3zrjSTann/EP5bCGcfwGu09bcilJ
	R7A2hDBvQQjkzj8GYpQHNsn8sDBoXArsx9/g9/1T0AxuZ1A47Zna0RJLdzn1YDC5TwR+
	rPoOJ2HQ4guAxMxJpttNQY800c65EavHisDXw77fpvvpoYCSy5xnDG+gaPSKP2qzuTIz
	qYF67LESsxiGcN3uXCX0t8Ws2s7hY+0PSnc1c+1OKLianr3FB8bftJj175IJXD7705Ki
	Emr0snstfvmRIM3K+F+YJPJ3hbOKkZI1bIMdbKTkNSyYc3BFacBjbFfWEPPo6TeUOCYz
	sGtA==
X-Gm-Message-State: ALoCoQnbJBS6KRDldjrOeaDsYK0P2MZp6191gjCInJtzCP66rjdJW+r0aWCPDGT4I7YZVZw5p0u+
X-Received: by 10.194.78.72 with SMTP id z8mr21689581wjw.0.1424986942875;
	Thu, 26 Feb 2015 13:42:22 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm40943wib.8.2015.02.26.13.42.21
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:21 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C357E5616F7; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:58 +0000
Message-Id: <81ba25a30b5d113f5704cbccc504cd0cbe31f2ea.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 5/8] toasterui: do not use transactions if the database autocommits
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Feb 2015 21:42:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Some databases, notably the SQLite3 adapter, force autocommits even if
the autocommit is turned off. The behavious is tracked in this bug:
http://bugs.python.org/issue8145#msg109965

Django refuses to work with autocommit off in this case, so we have
to take the same precautions when using manual transaction support.

[YOCTO #7363]
[YOCTO #7365]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c0f42d2..19ddd8e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -35,7 +35,7 @@ from bb.msg import BBLogFormatter as format
 from django.db import models
 import logging
 
-from django.db import transaction
+from django.db import transaction, connection
 
 logger = logging.getLogger("BitBake")
 
@@ -609,7 +609,9 @@ class BuildInfoHelper(object):
         self.task_order = 0
         self.autocommit_step = 1
         self.server = server
-        transaction.set_autocommit(False)
+        # we use manual transactions if the database doesn't autocommit on us
+        if not connection.features.autocommits_when_autocommit_is_off:
+            transaction.set_autocommit(False)
         self.orm_wrapper = ORMWrapper()
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
@@ -929,11 +931,12 @@ class BuildInfoHelper(object):
                 task_information['outcome'] = Task.OUTCOME_FAILED
                 del self.internal_state['taskdata'][identifier]
 
-        # we force a sync point here, to get the progress bar to show
-        if self.autocommit_step % 3 == 0:
-            transaction.set_autocommit(True)
-            transaction.set_autocommit(False)
-        self.autocommit_step += 1
+        if not connection.features.autocommits_when_autocommit_is_off:
+            # we force a sync point here, to get the progress bar to show
+            if self.autocommit_step % 3 == 0:
+                transaction.set_autocommit(True)
+                transaction.set_autocommit(False)
+            self.autocommit_step += 1
 
         self.orm_wrapper.get_update_task_object(task_information, True) # must exist
 
@@ -1207,4 +1210,5 @@ class BuildInfoHelper(object):
                 for event in self.internal_state['backlog']:
                    logger.error("UNSAVED log: %s", event.msg)
 
-        transaction.set_autocommit(True)
+        if not connection.features.autocommits_when_autocommit_is_off:
+            transaction.set_autocommit(True)
-- 
1.9.1


