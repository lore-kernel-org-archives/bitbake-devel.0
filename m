Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7CE4065C9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jul 2015 03:24:35 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t613OZKM029663
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jun 2015 20:24:35 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.224.2;
	Tue, 30 Jun 2015 20:24:36 -0700
Message-ID: <55935D71.1020105@windriver.com>
Date: Wed, 1 Jul 2015 11:24:33 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1428655392.git.liezhi.yang@windriver.com>
In-Reply-To: <cover.1428655392.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 0/1] bitbake: runqueue/cooker: catch hashvalidate error
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
X-List-Received-Date: Wed, 01 Jul 2015 03:24:35 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Hi RP,

I rebased the code and put on:

git://git.pokylinux.org/poky-contrib rbt/hx

Do you have any comments, please ?

Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Wed Aug 27 11:32:35 2014 +0800

     bitbake: runqueue/cooker: catch hashvalidate error in RunQueueExecuteScenequeue

     We need to catch the failure of self.rq.hashvalidate which invoked
     in RunQueueExecuteScenequeue, and exit in a normal build. So we
     raise bb.BBHandledException for this specific error.

     Tweak execute_runqueue's exception process order. So the build will
     exit peacefully while the above failure occurs.

     (LOCAL REV: NOT UPSTREAM) -- Sent to bitbake-devel on 20140827

     Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f31bca6..304cd27 100644
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
index 17a55d3..bd9f3b5 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1103,8 +1103,9 @@ class RunQueue:
                  pass
              self.state = runQueueComplete
              raise
-        except:
-            logger.error("An uncaught exception occured in runqueue, please see 
the failure below:")
+        except BaseException as e:
+            if not isinstance(e, (SystemExit, bb.BBHandledException)):
+                logger.error("An uncaught exception occured in runqueue, please 
see the failure below:")
              try:
                  self.teardown_workers()
              except:
@@ -1841,7 +1842,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                  sq_task.append(task)
              call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, 
sq_hashfn, d)"
              locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : 
sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
-            valid = bb.utils.better_eval(call, locs)
+            try:
+                valid = bb.utils.better_eval(call, locs)
+            except Exception as e:
+                logger.error("Hash validation failed in 
RunQueueExecuteScenequeue %s" % str(e))
+                raise bb.BBHandledException()

              valid_new = stamppresent
              for v in valid:
@@ -2027,7 +2032,6 @@ class TaskFailure(Exception):
      def __init__(self, x):
          self.args = x

-
  class runQueueExitWait(bb.event.Event):
      """
      Event when waiting for task processes to exit



// Robert

On 04/10/2015 04:44 PM, Robert Yang wrote:
> *** BLURB HERE ***
> The following changes since commit 6ebeae9b2011050c318a764e980bc47e51cc2d74:
>
>    tiff: remove extra dev and dbg from PACKAGES (2015-04-10 01:24:01 -0700)
>
> are available in the git repository at:
>
>    git://git.pokylinux.org/poky-contrib rbt/hx
>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/hx
>
> Hongxu Jia (1):
>    bitbake: runqueue/cooker: catch hashvalidate error in
>      RunQueueExecuteScenequeue
>
>   bitbake/lib/bb/cooker.py   |    4 ++--
>   bitbake/lib/bb/runqueue.py |   14 ++++++++------
>   2 files changed, 10 insertions(+), 8 deletions(-)
>

