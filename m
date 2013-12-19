Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id F387A60E97
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9b7Ke005944 for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:07 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SBpzf9JSEdKC for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:07 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9b2YD005938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:03 GMT
Message-ID: <1387445818.6402.60.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Dec 2013 09:36:58 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix data being written into siginfo/sigdata files
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
X-List-Received-Date: Thu, 19 Dec 2013 09:37:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The way hash_deps was being generated was different to the way siggen generated
the data internally which lead to seemingly different sigdata/siginfo files
for the same checksum. The -S output correct but the files written during
builds contained superflous data which would look like a difference.

This patch removes the badly duplicated data and uses it from the source
which ensures its consistent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b7a602b..37dc362 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -802,19 +802,6 @@ class RunQueueData:
                         procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
 
-        self.hashes = {}
-        self.hash_deps = {}
-        for task in xrange(len(self.runq_fnid)):
-            identifier = '%s.%s' % (self.taskData.fn_index[self.runq_fnid[task]],
-                                    self.runq_task[task])
-            self.hashes[identifier] = self.runq_hash[task]
-            deps = []
-            for dep in self.runq_depends[task]:
-                depidentifier = '%s.%s' % (self.taskData.fn_index[self.runq_fnid[dep]],
-                                           self.runq_task[dep])
-                deps.append(depidentifier)
-            self.hash_deps[identifier] = deps
-
         return len(self.runq_fnid)
 
     def dump_data(self, taskQueue):
@@ -883,8 +870,8 @@ class RunQueue:
             "fakerootenv" : self.rqdata.dataCache.fakerootenv,
             "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
             "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
-            "hashes" : self.rqdata.hashes,
-            "hash_deps" : self.rqdata.hash_deps,
+            "hashes" : bb.parse.siggen.taskhash,
+            "hash_deps" : bb.parse.siggen.runtaskdeps,
             "sigchecksums" : bb.parse.siggen.file_checksum_values,
             "runq_hash" : self.rqdata.runq_hash,
             "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,



