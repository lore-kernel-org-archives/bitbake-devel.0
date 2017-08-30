Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id CB22D78371
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:34 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995072"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:46 +1200
Message-Id: <3e7627417303deb605619ec8653166dc3ade58fe.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504135776.git.paul.eggleton@linux.intel.com>
References: <cover.1504135776.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/5] cooker: ensure we can run buildFileInternal() after cache is populated
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:34 -0000

If you run some other operations that result in the cache being
populated, and then call buildFileInternal(), then you can end up in a
situation where the cache already contains information about the recipe.
For example in OE this can now happen when you use devtool upgrade.
Normally this doesn't cause any problems, unless you have a non-absolute
path in BBLAYERS - in buildFileInternal() we are calling matchfile() which
will convert the filename to absolute, but later when taskdata goes to find
the providers of the recipe it finds the non-absolute path, sets up the
task information using this and then the runqueue can't find any tasks
matching the absolute path. To fix this, back out the optimisation I did
earlier in bitbake rev ba53e067a2d448dd63b4ca252557ce98aa8e6321 to avoid
calling parseConfiguration() again, which is unfortunate but does result
in the cached information being that causes the problem being cleared
out.

This fixes "Task do_unpack does not exist for target ..." running
devtool upgrade within intel-iot-refkit.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index db034b9..1434f01 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1242,10 +1242,6 @@ class BBCooker:
         # specify a target to be built, so show a warning
         bb.warn("Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.")
 
-        # Parse the configuration here. We need to do it explicitly here since
-        # buildFile() doesn't use the cache
-        self.parseConfiguration()
-
         self.buildFileInternal(buildfile, task)
 
     def buildFileInternal(self, buildfile, task, fireevents=True, quietlog=False):
@@ -1253,6 +1249,10 @@ class BBCooker:
         Build the file matching regexp buildfile
         """
 
+        # Parse the configuration here. We need to do it explicitly here since
+        # buildFile() doesn't use the cache
+        self.parseConfiguration()
+
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
-- 
2.9.5


