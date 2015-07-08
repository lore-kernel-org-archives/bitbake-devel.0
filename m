Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1326D7391D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 23:32:17 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 08 Jul 2015 16:32:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,435,1432623600"; d="scan'208";a="521077055"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.155])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2015 16:32:17 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 18:34:21 -0500
Message-Id: <1436398461-26014-8-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCHv4 7/7] fetch2/wget.py: checkstatus disable SSL cert validation.
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
X-List-Received-Date: Wed, 08 Jul 2015 23:32:18 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since Python 2.7.9 ssl cert validation is enabled by default
see PEP-0476, this causes verification errors on some https
servers so disable by default.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 7e90efb..545f02d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -238,7 +238,22 @@ class Wget(FetchMethod):
             return "HEAD"
 
         exported_proxies = export_proxies(d)
-        if exported_proxies == True:
+
+        # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
+        # see PEP-0476, this causes verification errors on some https servers
+        # so disable by default.
+        import ssl
+        ssl_context = None
+        if hasattr(ssl, '_create_unverified_context'):
+            ssl_context = ssl._create_unverified_context()
+
+        if exported_proxies == True and ssl_context is not None:
+            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler,
+                    urllib2.HTTPSHandler(context=ssl_context))
+        elif exported_proxies == False and ssl_context is not None:
+            opener = urllib2.build_opener(CacheHTTPHandler,
+                    urllib2.HTTPSHandler(context=ssl_context))
+        elif exported_proxies == True and ssl_context is None:
             opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
         else:
             opener = urllib2.build_opener(CacheHTTPHandler)
@@ -247,8 +262,9 @@ class Wget(FetchMethod):
         urllib2.install_opener(opener)
 
         uri = ud.url.split(";")[0]
+
         try:
-            f = urllib2.urlopen(uri)
+            urllib2.urlopen(uri)
         except:
             return False
         return True
-- 
1.9.1


