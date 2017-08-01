Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 91FB960762
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Aug 2017 10:31:17 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v71AVGpb000391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 1 Aug 2017 11:31:17 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dcUSK-0000AP-Ov; Tue, 01 Aug 2017 11:31:16 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Aug 2017 11:31:15 +0100
Message-Id: <1501583475-598-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 01 Aug 2017 11:31:17 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] cooker: Ensure all tasks are shown in task dependency tree
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
X-List-Received-Date: Tue, 01 Aug 2017 10:31:19 -0000

"bitbake -g m4-native -c do_unpack" doesn't list any dependencies in
task-depends.dot. This is because no header describing the task was
added unless a task has dependencies. Tweak the code to fix this.

[YOCTO #10893]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1a5e003..81027db 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -678,12 +678,12 @@ class BBCooker:
                     depend_tree["pn"][pn][ei] = vars(self.recipecaches[mc])[ei][taskfn]
 
 
+            dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(tid))
+            if not dotname in depend_tree["tdepends"]:
+                depend_tree["tdepends"][dotname] = []
             for dep in rq.rqdata.runtaskentries[tid].depends:
                 (depmc, depfn, deptaskname, deptaskfn) = bb.runqueue.split_tid_mcfn(dep)
                 deppn = self.recipecaches[mc].pkg_fn[deptaskfn]
-                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(tid))
-                if not dotname in depend_tree["tdepends"]:
-                    depend_tree["tdepends"][dotname] = []
                 depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
             if taskfn not in seen_fns:
                 seen_fns.append(taskfn)
-- 
2.7.4


