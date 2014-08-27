Return-Path: <Hongxu.Jia@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id F1B7F7070E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:27:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7RARokx023225
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 03:27:51 -0700 (PDT)
Received: from pek-hjia-d1.corp.ad.wrs.com (128.224.162.194) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Wed, 27 Aug 2014 03:27:50 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Aug 2014 18:27:41 +0800
Message-ID: <799c28a907f60124d76d7f55c286f2714016eaf5.1409135111.git.hongxu.jia@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1409135111.git.hongxu.jia@windriver.com>
References: <cover.1409135111.git.hongxu.jia@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: runqueue: terminate build safely while RunQueueExecuteScenequeue init failed
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
X-List-Received-Date: Wed, 27 Aug 2014 10:27:50 -0000
Content-Type: text/plain

While RunQueueExecuteScenequeue init failed, the exit of build is mess.
Here is the example while bb.fatal invoked in RunQueueExecuteScenequeue:
...
Traceback (most recent call last):
  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/runqueue.py", line 1824, in RunQueueExecuteScenequeue.__init__(rq=<bb.runqueue.RunQueue instance at 0x7f87dd7d5050>):
                 locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
    >            valid = bb.utils.better_eval(call, locs)

  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/utils.py", line 374, in better_eval(source='sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d)', locals={'sq_fn': ['virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb', 'virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb', 'virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb'], 'sq_task': ['do_populate_sysroot', 'do_populate_lic', 'do_package_qa'], 'sq_hash': ['7d132e7705b5772accce5544cf785c70', '52387c5751c018ddfe2c6a5eecf59e36', '315bcde98908fd36442830f9ae7469c1'], 'sq_hashfn': ['Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:', 'Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:', 'Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:'], 'd': <bb.data_smart.DataSmart object at 0x7f87e15cde10>}):
     def better_eval(source, locals):
    >    return eval(source, get_context(), locals)

  File "<string>", line 1, in <module>
  File "sstate.bbclass", line 110, in sstate_checkhashes(sq_fn=['virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb', 'virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb', 'virtual:native:/home/jiahongxu/yocto/poky/meta/recipes-support/db/db_6.0.30.bb'], sq_task=['do_populate_sysroot', 'do_populate_lic', 'do_package_qa'], sq_hash=['7d132e7705b5772accce5544cf785c70', '52387c5751c018ddfe2c6a5eecf59e36', '315bcde98908fd36442830f9ae7469c1'], sq_hashfn=['Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:', 'Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:', 'Ubuntu-14.04/ sstate:db-native:x86_64-linux:6.0.30:r0:x86_64:3: sstate:db::6.0.30:r0::3:'], d=<bb.data_smart.DataSmart object at 0x7f87e15cde10>)
  File "/home/jiahongxu/yocto/poky/bitbake/lib/bb/__init__.py", line 102, in fatal:
         logger.critical(''.join(args))
    >    raise BBHandledException()

BBHandledException
...

We should terminate build safely while RunQueueExecuteScenequeue init failed.

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e13dc57..c7b1dc0 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1046,7 +1046,12 @@ class RunQueue:
                 self.state = runQueueComplete
             else:
                 self.start_worker()
-                self.rqexe = RunQueueExecuteScenequeue(self)
+                try:
+                    self.rqexe = RunQueueExecuteScenequeue(self)
+                except:
+                    # The RunQueueExecuteScenequeue init failure
+                    # terminated the build safely
+                    self.state = runQueueComplete
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
             self.dm.check(self)
-- 
1.9.1


