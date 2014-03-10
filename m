Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E68796F617
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A0u14u027978 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:01 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Xr9J3pJfRf_I for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:56:01 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0tpLo027973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:55:56 GMT
Message-ID: <1394412945.7883.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:55:45 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] providers/runqueue/taskdata: Optimise logger.debug calls
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
X-List-Received-Date: Mon, 10 Mar 2014 00:56:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

A run of "bitbake bash -c unpack" when the task has already been
completed resulted in about 9000 calls to logger.debug(). With this
patch which comments out some noisy/less usefull logging and moves
other logging calls outside loops, this number is reduced to 1000
calls. This results in cleaner logs and gives a small but
measurable 0.15s speedup. The log size dropped from 900kb to 160kb.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 3a4f604..637e1fa 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -325,7 +325,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
         provides = dataCache.pn_provides[pn]
         for provide in provides:
             prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide, True)
-            logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
+            #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
             if prefervar in pns and pns[prefervar] not in preferred:
                 var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
                 logger.verbose("selecting %s to satisfy runtime %s due to %s", prefervar, item, var)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 7d3e91a..c486c98 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -481,7 +481,7 @@ class RunQueueData:
             fn = taskData.fn_index[fnid]
             task_deps = self.dataCache.task_deps[fn]
 
-            logger.debug(2, "Processing %s:%s", fn, taskData.tasks_name[task])
+            #logger.debug(2, "Processing %s:%s", fn, taskData.tasks_name[task])
 
             if fnid not in taskData.failed_fnids:
 
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 58fe199..af72a1f 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -207,23 +207,29 @@ class TaskData:
         if not fnid in self.depids:
             dependids = {}
             for depend in dataCache.deps[fn]:
-                logger.debug(2, "Added dependency %s for %s", depend, fn)
                 dependids[self.getbuild_id(depend)] = None
             self.depids[fnid] = dependids.keys()
+            logger.debug(2, "Added dependencies %s for %s", str(dataCache.deps[fn]), fn)
 
         # Work out runtime dependencies
         if not fnid in self.rdepids:
             rdependids = {}
             rdepends = dataCache.rundeps[fn]
             rrecs = dataCache.runrecs[fn]
+            rdependlist = []
+            rreclist = []
             for package in rdepends:
                 for rdepend in rdepends[package]:
-                    logger.debug(2, "Added runtime dependency %s for %s", rdepend, fn)
+                    rdependlist.append(rdepend)
                     rdependids[self.getrun_id(rdepend)] = None
             for package in rrecs:
                 for rdepend in rrecs[package]:
-                    logger.debug(2, "Added runtime recommendation %s for %s", rdepend, fn)
+                    rreclist.append(rdepend)
                     rdependids[self.getrun_id(rdepend)] = None
+            if rdependlist:
+                logger.debug(2, "Added runtime dependencies %s for %s", str(rdependlist), fn)
+            if rreclist:
+                logger.debug(2, "Added runtime recommendations %s for %s", str(rreclist), fn)
             self.rdepids[fnid] = rdependids.keys()
 
         for dep in self.depids[fnid]:



