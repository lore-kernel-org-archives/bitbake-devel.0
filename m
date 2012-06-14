Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0hp-0006TS-8Q
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:26:45 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5E3G8tW019103
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:16:08 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:16:07 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:16:01 -0500
Message-ID: <1339643761-23149-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
References: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] runqueue.py, build.py: Invalidate setscene tasks based on do_unpack stamps
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Jun 2012 03:26:45 -0000
Content-Type: text/plain

If you have a fully populated sstate cache and have used it to
execute a build, it is not possible to invalidate repackage
an intermediate build after you have forced a compiled

Example when you have build from a complete sstate cache build:
  bitbake core-image-sato
  bitbake -c patch acl
     *** Make some changes to the C files for experimentation.
  bitbake -f -c compile acl
  bitbake acl

The bitbake will refuse to build the acl package at this
point and instead keep populating it from the sstate.  Using
the cleanstate is no longer a good option because it will
also erase the scratch area.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/build.py    |    8 ++++++++
 lib/bb/runqueue.py |    2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 055d382..9d78764 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -499,6 +499,14 @@ def del_stamp(task, d, file_name = None):
     stamp = stamp_internal(task, d, file_name)
     bb.utils.remove(stamp)
 
+def exists_stamp(task, d, file_name = None):
+    """
+    Removes a stamp for a given task
+    (d can be a data dict or dataCache)
+    """
+    stamp = stamp_internal(task, d, file_name)
+    return os.path.exists(stamp)
+
 def stampfile(taskname, d, file_name = None):
     """
     Return the stamp for a given task
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f1fabfa..93d36c9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -730,7 +730,7 @@ class RunQueueData:
             for task in self.runq_setscene:
                 try:
                     fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
-                    if (self.cooker.configuration.invalidate_stamp and fn in test_fns):
+                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn) or (self.cooker.configuration.invalidate_stamp and fn in test_fns):
                         logger.debug(2, 'Removing task %s due to invalidated build stamps', task)
                     else:
                         new_setscene.append(task)
-- 
1.7.10



