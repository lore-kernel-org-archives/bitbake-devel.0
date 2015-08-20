Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 6C29865CBC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 21:00:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 20 Aug 2015 14:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,717,1432623600"; d="scan'208";a="752457430"
Received: from bitbang.jf.intel.com ([10.7.201.51])
	by orsmga001.jf.intel.com with ESMTP; 20 Aug 2015 14:00:38 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Aug 2015 14:00:36 -0700
Message-Id: <1440104436-12491-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 2.4.3
Subject: [PATCH] bitbake:main.py: Handle RuntimeError exception in list_extension_modules
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
X-List-Received-Date: Thu, 20 Aug 2015 21:00:59 -0000

It seems to just be an exception that was missed that can occur during
import and would cause bitbake to completely fail.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 bitbake/lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index c98cf44..910cd64 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -60,7 +60,7 @@ def list_extension_modules(pkg, checkattr):
             continue
         try:
             module = __import__(pkg.__name__, fromlist=[modulename])
-        except (ImportError, SystemExit):
+        except (ImportError, SystemExit, RuntimeError):
             # If we can't import it, it's not valid
             continue
         module_if = getattr(module, modulename)
-- 
2.4.3


