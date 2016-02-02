Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 8FFC2772AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 15:13:56 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 02 Feb 2016 07:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,385,1449561600"; d="scan'208";a="875172176"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.31])
	by orsmga001.jf.intel.com with ESMTP; 02 Feb 2016 07:13:56 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Feb 2016 09:15:55 -0600
Message-Id: <e5f062fdc35926fdeb8d2e3255b591980cdeee29.1454424743.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1454424743.git.anibal.limon@linux.intel.com>
References: <cover.1454424743.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 07/20] bb/fetch2: Move export_proxies function from wget to utils.
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
X-List-Received-Date: Tue, 02 Feb 2016 15:13:58 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to use in other modules since is a common function
when needs to get proxies working.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 17 +----------------
 lib/bb/utils.py       | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 5a31730..fd25c42 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -37,6 +37,7 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
+from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
 
@@ -219,22 +220,6 @@ class Wget(FetchMethod):
 
                 return resp
 
-        def export_proxies(d):
-            variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
-                            'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
-            exported = False
-
-            for v in variables:
-                if v in os.environ.keys():
-                    exported = True
-                else:
-                    v_proxy = d.getVar(v, True)
-                    if v_proxy is not None:
-                        os.environ[v] = v_proxy
-                        exported = True
-
-            return exported
-
         class HTTPMethodFallback(urllib2.BaseHandler):
             """
             Fallback to GET if HEAD is not allowed (405 HTTP error)
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ae10213..70b42f3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1406,3 +1406,22 @@ def set_process_name(name):
         libc.prctl(15, byref(buff), 0, 0, 0)
     except:
         pass
+
+# export common proxies variables from datastore to environment
+def export_proxies(d):
+    import os
+
+    variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
+                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
+    exported = False
+
+    for v in variables:
+        if v in os.environ.keys():
+            exported = True
+        else:
+            v_proxy = d.getVar(v, True)
+            if v_proxy is not None:
+                os.environ[v] = v_proxy
+                exported = True
+
+    return exported
-- 
2.1.4


