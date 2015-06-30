Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 87ABE75C9D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jun 2015 14:37:19 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jun 2015 07:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,378,1432623600"; d="scan'208";a="753307251"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.55])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2015 07:37:18 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jun 2015 09:39:14 -0500
Message-Id: <1435675155-3431-6-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: [PATCHv3 5/6] fetch2/wget.py: checkstatus fix using proxy handler
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
X-List-Received-Date: Tue, 30 Jun 2015 14:37:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aníbal Limón <limon.anibal@gmail.com>

Only use ProxyHandler opener when exists proxies in env.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8cb5f2b..7e90efb 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -221,17 +221,29 @@ class Wget(FetchMethod):
         def export_proxies(d):
             variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
                             'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
+            exported = False
 
             for v in variables:
-                if not v in os.environ.keys():
-                    os.environ[v] = d.getVar(v, True) or ''
+                if v in os.environ.keys():
+                    exported = True
+                else:
+                    v_proxy = d.getVar(v, True)
+                    if v_proxy is not None:
+                        os.environ[v] = v_proxy
+                        exported = True
+
+            return exported
 
         def head_method(self):
             return "HEAD"
 
-        export_proxies(d)
+        exported_proxies = export_proxies(d)
+        if exported_proxies == True:
+            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
+        else:
+            opener = urllib2.build_opener(CacheHTTPHandler)
+
         urllib2.Request.get_method = head_method
-        opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
         urllib2.install_opener(opener)
 
         uri = ud.url.split(";")[0]
-- 
1.9.1


