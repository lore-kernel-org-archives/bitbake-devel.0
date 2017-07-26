Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 39A1978195
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jul 2017 15:22:32 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6QFMX8Y028369
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jul 2017 08:22:33 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 26 Jul 2017 08:22:32 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Jul 2017 10:20:34 -0500
Message-ID: <1501082435-118885-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 1/2] lib/bb/utils.py: Add missing debug level
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
X-List-Received-Date: Wed, 26 Jul 2017 15:22:33 -0000
Content-Type: text/plain

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 6a44db5..8550af3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1502,7 +1502,7 @@ def export_proxies(d):
 
 def load_plugins(logger, plugins, pluginpath):
     def load_plugin(name):
-        logger.debug('Loading plugin %s' % name)
+        logger.debug(1, 'Loading plugin %s' % name)
         fp, pathname, description = imp.find_module(name, [pluginpath])
         try:
             return imp.load_module(name, fp, pathname, description)
@@ -1510,7 +1510,7 @@ def load_plugins(logger, plugins, pluginpath):
             if fp:
                 fp.close()
 
-    logger.debug('Loading plugins from %s...' % pluginpath)
+    logger.debug(1, 'Loading plugins from %s...' % pluginpath)
 
     expanded = (glob.glob(os.path.join(pluginpath, '*' + ext))
                 for ext in python_extensions)
-- 
1.8.3.1


