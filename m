Return-Path: <Hongxu.Jia@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 183CB7114D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 15:38:53 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s7RFcZUA001353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Aug 2014 08:38:35 -0700 (PDT)
Received: from pek-hjia-d1.corp.ad.wrs.com (128.224.162.194) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Wed, 27 Aug 2014 08:38:35 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
	<richard.purdie@linuxfoundation.org>
Date: Wed, 27 Aug 2014 23:38:25 +0800
Message-ID: <926a73b2fb856493ca80dbdbfff13a3bd9ec2c3f.1409153318.git.hongxu.jia@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1409153318.git.hongxu.jia@windriver.com>
References: <cover.1409153318.git.hongxu.jia@windriver.com>
MIME-Version: 1.0
Cc: Zhangle.Yang@windriver.com
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
X-List-Received-Date: Wed, 27 Aug 2014 15:39:01 -0000
Content-Type: text/plain

We need to catch the failure of self.rq.hashvalidate which invoked
in RunQueueExecuteScenequeue, and exit in a normal build. So we
raise bb.BBHandledException for this specific error.

Tweak execute_runqueue's exception process order. So the build will
exit peacefully while the above failure occurs.

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 bitbake/lib/bb/cooker.py   |  4 ++--
 bitbake/lib/bb/runqueue.py | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f463603..4c47cbc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1147,7 +1147,7 @@ class BBCooker:
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
-            except SystemExit as exc:
+            except (SystemExit, bb.BBHandledException) as exc:
                 self.command.finishAsyncCommand()
                 return False
 
@@ -1180,7 +1180,7 @@ class BBCooker:
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
-            except SystemExit as exc:
+            except (SystemExit, bb.BBHandledException) as exc:
                 self.command.finishAsyncCommand()
                 return False
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e13dc57..897eccd 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1093,10 +1093,9 @@ class RunQueue:
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
             locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
-            valid = bb.utils.better_eval(call, locs)
+            try:
+                valid = bb.utils.better_eval(call, locs)
+            except Exception as e:
+                logger.error("Hash validation failed in RunQueueExecuteScenequeue %s" % str(e))
+                raise bb.BBHandledException()
 
             valid_new = stamppresent
             for v in valid:
@@ -2003,7 +2006,6 @@ class TaskFailure(Exception):
     def __init__(self, x):
         self.args = x
 
-
 class runQueueExitWait(bb.event.Event):
     """
     Event when waiting for task processes to exit
-- 
1.9.1


