Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id E3999774A3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jan 2017 20:14:08 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 30 Jan 2017 12:14:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,312,1477983600"; d="scan'208";a="1119872136"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com.fritz.box)
	([10.255.191.81])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2017 12:14:08 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jan 2017 09:14:01 +1300
Message-Id: <38c1579a145f67cda420a87071fe1b59fb903015.1485807144.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1485807144.git.paul.eggleton@linux.intel.com>
References: <cover.1485807144.git.paul.eggleton@linux.intel.com>
Subject: [1.32][PATCH 1/1] tinfoil: clean environment when starting up cooker
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
X-List-Received-Date: Mon, 30 Jan 2017 20:14:09 -0000

During normal bitbake execution, the environment is cleaned of variables
not on a whitelist while starting up cooker, and then restored
afterwards. Prior to the tinfoil2 rework in master we were taking a
number of shortcuts within tinfoil and one of those was not doing this
environment cleaning. However, prior to OE-Core rev
3d39ca5c91dbb62fb43199f916bd390cd6212e3d we didn't have any code (as far
as I'm aware) that was affected by this shortcut, hence why this wasn't
an issue up to now.

The result is the following error when attempting to run "devtool build"
in the eSDK, as CCACHE_PATH is allowed through from the eSDK's
environment setup script:

----------- snip -----------
ccache: error: Could not find compiler "gcc" in PATH
...
subprocess.CalledProcessError: Command 'gcc  --version' returned
non-zero exit status 1
----------- snip -----------

We can fix this by simply doing the environment filtering while we are
starting up cooker, thus the environment when uninative.bbclass comes to
do the gcc version check it is not affected by CCACHE_PATH or other
variables in the external environment that should be filtered out.

For clarity, this patch is only applicable to the bitbake 1.32 branch
as used for the OE-Core morty branch - master uses the reworked
tinfoil2 and doesn't need this fix.

Fixes [YOCTO #10961].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8899e86..9fa5b5b 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -51,10 +51,13 @@ class Tinfoil:
         features = []
         if tracking:
             features.append(CookerFeatures.BASEDATASTORE_TRACKING)
+        cleanedvars = bb.utils.clean_environment()
         self.cooker = BBCooker(self.config, features)
         self.config_data = self.cooker.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
+        for k in cleanedvars:
+            os.environ[k] = cleanedvars[k]
 
     def register_idle_function(self, function, data):
         pass
-- 
2.9.3


