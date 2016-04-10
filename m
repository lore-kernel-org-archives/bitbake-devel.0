Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DD9CF7705D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 10:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3AA9NON024339 for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 11:09:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BbttZ9BZKNQb for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 11:09:23 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3AA9L7C024336
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 11:09:23 +0100
Message-ID: <1460282961.9308.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Apr 2016 11:09:21 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Improve 'mulitiple .bb files are due to be built' message
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
X-List-Received-Date: Sun, 10 Apr 2016 10:09:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When multiple recipes which both provide something are being built, bitbake
informs us that most likely one of them provides something the other doesn't,
which is usually correct, but unfortunately it's rather painful to figure out
exactly what that is.

This patch dumps two sets of information, one is the provides information for
each recipe, filtered so only common components are removed. The other is a list
of dependees on the recipe, since sometimes this can easily identify why something
is being built.

Its not straightforward for bitbake to obtain the information but since the
warning/error code path isn't the normal one, we can afford to go through some
less than optimal processing to aid debugging.

Also provide the same information even if we're showing a warning since its still 
useful.

[YOCTO #8032]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 2990de7..ac3cdae 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -261,6 +261,13 @@ class RunQueueData:
         taskname = self.runq_task[task] + task_name_suffix
         return "%s, %s" % (fn, taskname)
 
+    def get_short_user_idstring(self, task, task_name_suffix = ""):
+        fn = self.taskData.fn_index[self.runq_fnid[task]]
+        pn = self.dataCache.pkg_fn[fn]
+        taskname = self.runq_task[task] + task_name_suffix
+        return "%s:%s" % (pn, taskname)
+
+
     def get_task_id(self, fnid, taskname):
         for listid in xrange(len(self.runq_fnid)):
             if self.runq_fnid[listid] == fnid and self.runq_task[listid] == taskname:
@@ -753,11 +760,72 @@ class RunQueueData:
                         seen_pn.append(pn)
                     else:
                         bb.fatal("Multiple versions of %s are due to be built (%s). Only one version of a given PN should be built in any given build. You likely need to set PREFERRED_VERSION_%s to select the correct version or don't depend on multiple versions." % (pn, " ".join(prov_list[prov]), pn))
-                msg = "Multiple .bb files are due to be built which each provide %s (%s)." % (prov, " ".join(prov_list[prov]))
+                msg = "Multiple .bb files are due to be built which each provide %s:\n  %s" % (prov, "\n  ".join(prov_list[prov]))
+                #
+                # Construct a list of things which uniquely depend on each provider
+                # since this may help the user figure out which dependency is triggering this warning
+                #
+                msg += "\nA list of tasks depending on these providers is shown and may help explain where the dependency comes from."
+                deplist = {}
+                commondeps = None
+                for provfn in prov_list[prov]:
+                    deps = set()
+                    for task in xrange(len(self.runq_fnid)):
+                        fn = taskData.fn_index[self.runq_fnid[task]]
+                        if fn != provfn:
+                            continue
+                        for dep in self.runq_revdeps[task]:
+                            fn = taskData.fn_index[self.runq_fnid[dep]]
+                            if fn == provfn:
+                                continue
+                            deps.add(self.get_short_user_idstring(dep))
+                    if not commondeps:
+                        commondeps = set(deps)
+                    else:
+                        commondeps &= deps
+                    deplist[provfn] = deps
+                for provfn in deplist:
+                    msg += "\n%s has unique dependees:\n  %s" % (provfn, "\n  ".join(deplist[provfn] - commondeps))
+                #
+                # Construct a list of provides and runtime providers for each recipe
+                # (rprovides has to cover RPROVIDES, PACKAGES, PACKAGES_DYNAMIC)
+                #
+                msg += "\nIt could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful."
+                provlist = {}
+                rprovlist = {}
+                commonprovs = None
+                commonrprovs = None
+                for provfn in prov_list[prov]:
+                    provides = set(self.dataCache.fn_provides[provfn])
+                    rprovides = set()
+                    for rprovide in self.dataCache.rproviders:
+                        if provfn in self.dataCache.rproviders[rprovide]:
+                            rprovides.add(rprovide)
+                    for package in self.dataCache.packages:
+                        if provfn in self.dataCache.packages[package]:
+                            rprovides.add(package)
+                    for package in self.dataCache.packages_dynamic:
+                        if provfn in self.dataCache.packages_dynamic[package]:
+                            rprovides.add(package)
+                    if not commonprovs:
+                        commonprovs = set(provides)
+                    else:
+                        commonprovs &= provides
+                    provlist[provfn] = provides
+                    if not commonrprovs:
+                        commonrprovs = set(rprovides)
+                    else:
+                        commonrprovs &= rprovides
+                    rprovlist[provfn] = rprovides
+                #msg += "\nCommon provides:\n  %s" % ("\n  ".join(commonprovs))
+                #msg += "\nCommon rprovides:\n  %s" % ("\n  ".join(commonrprovs))
+                for provfn in prov_list[prov]:
+                    msg += "\n%s has unique provides:\n  %s" % (provfn, "\n  ".join(provlist[provfn] - commonprovs))
+                    msg += "\n%s has unique rprovides:\n  %s" % (provfn, "\n  ".join(rprovlist[provfn] - commonrprovs))
+
                 if self.warn_multi_bb:
                     logger.warn(msg)
                 else:
-                    msg += "\n This usually means one provides something the other doesn't and should."
                     logger.error(msg)
 
         # Create a whitelist usable by the stamp checks



