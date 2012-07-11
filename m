Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Wenzong.Fan@windriver.com>) id 1Sor4v-0008L0-OO
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jul 2012 09:11:18 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q6B3SDYu010351
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 20:28:13 -0700 (PDT)
Received: from wenzong-desktop.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 10 Jul 2012 20:28:13 -0700
From: <wenzong.fan@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 Jul 2012 11:28:11 +0800
Message-ID: <05c49df922dac41a9d86377c1400ae2ef58fe4ae.1341977062.git.wenzong.fan@windriver.com>
X-Mailer: git-send-email 1.7.3
In-Reply-To: <cover.1341977062.git.wenzong.fan@windriver.com>
References: <cover.1341977062.git.wenzong.fan@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: Abort build if runtime dependency conflict
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
X-List-Received-Date: Wed, 11 Jul 2012 07:11:18 -0000
Content-Type: text/plain

From: Wenzong Fan <wenzong.fan@windriver.com>

Currently if there are multiple preferred providers available for
a runtime dependency, bitbake will print an Error message and let
the build go on. Anyways the build should abort while any Errors
occured.

[YOCTO #2734]

Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
---
 bitbake/lib/bb/providers.py |    2 ++
 bitbake/lib/bb/taskdata.py  |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index bd729df..24cb217 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -35,6 +35,8 @@ class NoProvider(bb.BBHandledException):
 class NoRProvider(bb.BBHandledException):
     """Exception raised when no provider of a runtime dependency can be found"""
 
+class MultipleRProvider(bb.BBHandledException):
+    """Exception raised when multiple providers of a runtime dependency can be found"""
 
 def findProviders(cfgData, dataCache, pkg_pn = None):
     """
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 55cdde5..aed3a16 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -482,6 +482,7 @@ class TaskData:
                     providers_list.append(dataCache.pkg_fn[fn])
                 bb.event.fire(bb.event.MultipleProviders(item, providers_list, runtime=True), cfgData)
             self.consider_msgs_cache.append(item)
+            raise bb.providers.MultipleRProvider(item)
 
         # run through the list until we find one that we can build
         for fn in eligible:
@@ -580,7 +581,7 @@ class TaskData:
                 try:
                     self.add_rprovider(cfgData, dataCache, target)
                     added = added + 1
-                except bb.providers.NoRProvider:
+                except (bb.providers.NoRProvider, bb.providers.MultipleRProvider):
                     self.remove_runtarget(self.getrun_id(target))
             logger.debug(1, "Resolved " + str(added) + " extra dependencies")
             if added == 0:
-- 
1.7.3



