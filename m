Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 412347319A;
	Thu, 17 Dec 2015 14:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBHEsvZ2000311; Thu, 17 Dec 2015 14:54:57 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VUGDnGqBmrKZ; Thu, 17 Dec 2015 14:54:57 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBHEst6d000305
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 17 Dec 2015 14:54:56 GMT
Message-ID: <1450364095.13505.211.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-core@lists.openembedded.org, "toaster@yoctoproject.org"
	<toaster@yoctoproject.org>, "Flanagan, Elizabeth"
	<elizabeth.flanagan@intel.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Dec 2015 14:54:55 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH 7/7] buildinfohelper: Update for buildstats layout change
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
X-List-Received-Date: Thu, 17 Dec 2015 14:54:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This updates buildinfo helper for the recent buildstats layout change

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 04ce23a..279c5c7 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -866,12 +866,10 @@ class BuildInfoHelper(object):
 
     def _get_path_information(self, task_object):
         assert isinstance(task_object, Task)
-        build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
+        build_stats_format = "{tmpdir}/buildstats/{buildname}/{package}/"
         build_stats_path = []
 
         for t in self.internal_state['targets']:
-            target = t.target
-            machine = self.internal_state['build'].machine
             buildname = self.internal_state['build'].build_name
             pe, pv = task_object.recipe.version.split(":",1)
             if len(pe) > 0:
@@ -879,8 +877,8 @@ class BuildInfoHelper(object):
             else:
                 package = task_object.recipe.name + "-" + pv
 
-            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir, target=target,
-                                                     machine=machine, buildname=buildname,
+            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir,
+                                                     buildname=buildname,
                                                      package=package))
 
         return build_stats_path



