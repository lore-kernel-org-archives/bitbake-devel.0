Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 232B571F1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Feb 2015 17:52:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 20 Feb 2015 09:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,616,1418112000"; d="scan'208";a="680980812"
Received: from marazel-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.180])
	by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2015 09:52:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Feb 2015 17:52:42 +0000
Message-Id: <0dc9f92c9ecd76d98688a15ed09ba4002eefd428.1424454574.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake-layers: fix logging
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
X-List-Received-Date: Fri, 20 Feb 2015 17:52:58 -0000

Logging output was simply not getting printed.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 2622bc0..fc62386 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -39,8 +39,18 @@ import bb.utils
 import bb.tinfoil
 
 
-logger = logging.getLogger('BitBake')
-
+def logger_create(name, output=sys.stderr):
+    logger = logging.getLogger(name)
+    console = logging.StreamHandler(output)
+    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    if output.isatty():
+        format.enable_color()
+    console.setFormatter(format)
+    logger.addHandler(console)
+    logger.setLevel(logging.INFO)
+    return logger
+
+logger = logger_create('bitbake-layers')
 
 
 class Commands():
-- 
1.9.3


