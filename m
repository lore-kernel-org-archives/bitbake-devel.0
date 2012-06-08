Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdK-0004gL-KO
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhGNv023981
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:16 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:16 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:49 -0500
Message-ID: <1339162913-23759-15-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 14/18] runqueue.py, build.py: Invalidate setscene tasks based on do_unpack stamps
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:48 -0000
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
 lib/bb/runqueue.py |   14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index fb61b00..18c28aa 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -463,6 +463,14 @@ def del_stamp(task, d, file_name = None):
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
index da3fdf9..6c802af 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -718,6 +718,20 @@ class RunQueueData:
                     for dep in self.runq_depends[task]:
                         procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
+        try:
+            new_setscene = []
+            for task in self.runq_setscene:
+                try:
+                    fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
+                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn):
+                        logger.debug(2, 'Removing task %s from queue because do_unpack exists', task)
+                    else:
+                        new_setscene.append(task)
+                except:
+                    logger.debug(2, 'Failed do_unpack check for %s', task)
+            self.runq_setscene = new_setscene
+        except:
+            logger.debug(2, 'Failed to update runq_setscene')
 
         self.hashes = {}
         self.hash_deps = {}
-- 
1.7.10



