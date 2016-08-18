Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id A324D731F7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 15:06:33 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id i5so37651wmg.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=9DB1+21jtYAmGYaU2HpX5IAmUHoJpGs9ipsry96FwG0=;
	b=M8A1QLJbfZjZaMf1j5OoY1A2osQuLQxHA6HJPxinbbwDzDghXSH0x+052Ags4jSwNH
	qUJHdl+zyEC6wlLciPe0AnAPona//CsgxYSzYC7a96gWTFKNFBSdgGk3zgTr+Uq7BBsc
	m1NI+3sVn5WHN/qZcWV2QNUDoYcPygicerXmg6bjVKLrrNBoeihJEN0Gq6rmGb/vUIid
	2hVQGppCi6MHrBlKIVnKeRCCaiJu2VGbr5kgEklLsIb3rV5bKt0FPY48Grw073rpbw1A
	+ZS/nWrVCvU7wvrnG6RksCIOmJeLo342xjVKbYECAbPajVCHfAPkzAiwsJ2s8ntETmB8
	cFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9DB1+21jtYAmGYaU2HpX5IAmUHoJpGs9ipsry96FwG0=;
	b=a7gGudOEjbpl/0yHqg6oTzPRHAjxGCUyKcZviJldShLGSMc4pUm8o2pG9sfnKFCvy7
	9lYQ9z0B4ohfBm47L0u11nKUpdfxzLuyZ/S3NIoJg7v2j7pv3ahyENAEKxekcg3jUc7f
	ecjIHj/H8iY+l1nxgdOgBaPs3vNaGR50ZiHPgzlVdR6cwVDsxzS33ZmCxU4T8qhC2x3i
	touAzmXbmV3aLAEaAkEu2DtvueshePpDg0gdXJxVuCN56wKPCXPyD7AOXDBBGLiGSvoo
	aJ9fZXq3QYT8qfRNFDD+GwCbAxMDV56ssTIChXzYSXhp+0TzcUKsbw1VT3H4I8Hum+OD
	IfZw==
X-Gm-Message-State: AEkooustmxt1xBkXJRrDtn/aKCKcM5kifcZtznP7KNkKC8n3HTZhe75K+AQ0SYpCuULOgA==
X-Received: by 10.194.144.161 with SMTP id sn1mr2567450wjb.29.1471532793284;
	Thu, 18 Aug 2016 08:06:33 -0700 (PDT)
Received: from localhost (ip-89-176-104-169.net.upcbroadband.cz.
	[89.176.104.169])
	by smtp.gmail.com with ESMTPSA id v189sm16086wmv.12.2016.08.18.08.06.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Aug 2016 08:06:32 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 17:06:29 +0200
Message-Id: <20160818150629.2338-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.9.2
Subject: [PATCH] toasterui, knotty: don't print taskid followed by taskstring which are now in most cases identical
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
X-List-Received-Date: Thu, 18 Aug 2016 15:06:35 -0000

* unify the format how the task is described
* don't show taskid followed by taskstring as the taskstring is
  different only for setscene tasks (by _setscene suffix)
* the duplicated output was introduced by:
  2c88afb   taskdata/runqueue: Rewrite without use of ID indirection
  as reported and confirmed as a bug here:
  http://lists.openembedded.org/pipermail/openembedded-core/2016-June/123148.html
* show:
  NOTE: Running task 541 of 548 (/OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_package)
  instead of much longer:
  NOTE: Running task 541 of 548 (ID: /OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_package, /OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_package)

  and similarly for failed tasks:
  ERROR: Task (virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_install) failed with exit code '1'
  instead of much longer:
  ERROR: Task virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_install (virtual:native:/OE/build/oe-core/openembedded-core/meta/recipes-core/zlib/zlib_1.2.8.bb:do_install) failed with exit code '1'

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/ui/knotty.py    | 12 ++++++------
 lib/bb/ui/toasterui.py |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b30135b..a1856ec 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -588,23 +588,23 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     tasktype = 'noexec task'
                 else:
                     tasktype = 'task'
-                logger.info("Running %s %s of %s (ID: %s, %s)",
+                logger.info("Running %s %d of %d (%s)",
                             tasktype,
                             event.stats.completed + event.stats.active +
                                 event.stats.failed + 1,
-                            event.stats.total, event.taskid, event.taskstring)
+                            event.stats.total, event.taskstring)
                 continue
 
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 return_value = 1
                 taskfailures.append(event.taskstring)
-                logger.error("Task %s (%s) failed with exit code '%s'",
-                             event.taskid, event.taskstring, event.exitcode)
+                logger.error("Task (%s) failed with exit code '%s'",
+                             event.taskstring, event.exitcode)
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
-                logger.warning("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
-                               event.taskid, event.taskstring, event.exitcode)
+                logger.warning("Setscene task (%s) failed with exit code '%s' - real task will be run instead",
+                               event.taskstring, event.exitcode)
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index c9213cc..b5422cf 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -358,8 +358,8 @@ def main(server, eventHandler, params):
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 buildinfohelper.update_and_store_task(event)
                 taskfailures.append(event.taskstring)
-                logger.error("Task %s (%s) failed with exit code '%s'",
-                             event.taskid, event.taskstring, event.exitcode)
+                logger.error("Task (%s) failed with exit code '%s'",
+                             event.taskstring, event.exitcode)
                 continue
 
             if isinstance(event, (bb.runqueue.sceneQueueTaskCompleted, bb.runqueue.sceneQueueTaskFailed)):
-- 
2.9.2


