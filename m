Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SIMPt-0000mw-7G
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 17:58:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 12 Apr 2012 08:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="128444620"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 12 Apr 2012 08:49:15 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 23:46:25 +0800
Message-Id: <7cacaa562688f1b5bd78f7dc12b1c1d1a70196e2.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/3] command.py: Add a hook for config parsing
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
X-List-Received-Date: Thu, 12 Apr 2012 15:58:37 -0000

To make the UI settings take effect, we need to hook at the end of each
config file parsing and set UI specific values.

Signed-off-by: Richar Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py                    |    7 +++++++
 lib/bb/parse/parse_py/ConfHandler.py |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 73aaca0..fd8912a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -179,6 +179,13 @@ class CommandsSync:
         """
         return bb.utils.cpu_count()
 
+    def setConfFilter(self, command, params):
+        """
+        Set the configuration file parsing filter
+        """
+        filterfunc = params[0]
+        bb.parse.parse_py.ConfHandler.confFilters.append(filterfunc)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index fa811f3..f108c24 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -71,6 +71,8 @@ def include(oldfn, fn, lineno, data, error_out):
             raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
         logger.debug(2, "CONF file '%s' not found", fn)
 
+confFilters = []
+
 def handle(fn, data, include):
     init(data)
 
@@ -107,6 +109,9 @@ def handle(fn, data, include):
     if oldfile:
         data.setVar('FILE', oldfile)
 
+    for f in confFilters:
+        f(fn, data)
+
     return data
 
 def feeder(lineno, s, fn, statements):
-- 
1.7.4.1



