Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id F2AFA72D74
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 08:44:25 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.9) with ESMTP id t3A8iRH7002599
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 01:44:27 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.224.2;
	Fri, 10 Apr 2015 01:44:26 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Apr 2015 01:44:26 -0700
Message-ID: <81b174ebc7cafc3595164ec8386602e82854a7cc.1428655392.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1428655392.git.liezhi.yang@windriver.com>
References: <cover.1428655392.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: runqueue/cooker: catch hashvalidate error in RunQueueExecuteScenequeue
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
X-List-Received-Date: Fri, 10 Apr 2015 08:44:27 -0000
Content-Type: text/plain

From: Hongxu Jia <hongxu.jia@windriver.com>

We need to catch the failure of self.rq.hashvalidate which invoked
in RunQueueExecuteScenequeue, and exit in a normal build. So we
raise bb.BBHandledException for this specific error.

Tweak execute_runqueue's exception process order. So the build will
exit peacefully while the above failure occurs.

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py   |    4 ++--
 bitbake/lib/bb/runqueue.py |   14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c101f2..6762239 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1298,7 +1298,7 @@ class BBCooker:
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
-            except SystemExit as exc:
+            except (SystemExit, bb.BBHandledException) as exc:
                 self.command.finishAsyncCommand()
                 return False
 
@@ -1331,7 +1331,7 @@ class BBCooker:
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
-            except SystemExit as exc:
+            except (SystemExit, bb.BBHandledException) as exc:
                 self.command.finishAsyncCommand()
                 return False
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b1fe6b8..cd63ba7 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1094,10 +1094,9 @@ class RunQueue:
             return self._execute_runqueue()
         except bb.runqueue.TaskFailure:
             raise
-        except SystemExit:
-            raise
-        except:
-            logger.error("An uncaught exception occured in runqueue, please see the failure below:")
+        except BaseException as e:
+            if not isinstance(e, (SystemExit, bb.BBHandledException)):
+                logger.error("An uncaught exception occured in runqueue, please see the failure below:")
             try:
                 self.teardown_workers()
             except:
@@ -1821,7 +1820,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_task.append(task)
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
             locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
-            valid = bb.utils.better_eval(call, locs)
+            try:
+                valid = bb.utils.better_eval(call, locs)
+            except Exception as e:
+                logger.error("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))
+                raise bb.BBHandledException()
 
             valid_new = stamppresent
             for v in valid:
@@ -2007,7 +2010,6 @@ class TaskFailure(Exception):
     def __init__(self, x):
         self.args = x
 
-
 class runQueueExitWait(bb.event.Event):
     """
     Event when waiting for task processes to exit
-- 
1.7.9.5


