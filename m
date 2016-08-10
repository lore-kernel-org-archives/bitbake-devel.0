Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A84C2771D7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 20:59:58 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 10 Aug 2016 13:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,501,1464678000"; d="scan'208";a="863278420"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.36])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 13:59:57 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2016 16:00:04 -0500
Message-Id: <1470862804-25621-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>
Subject: [PATCH] bb/utils.py: export_proxies add GIT_PROXY_COMMAND
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
X-List-Received-Date: Wed, 10 Aug 2016 20:59:58 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>

This was added to enable the usage of git through proxies.

Signed-off-by: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>
Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/utils.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ce52960..a855d58 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1461,7 +1461,8 @@ def export_proxies(d):
     import os
 
     variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
-                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
+                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
+                    'GIT_PROXY_COMMAND']
     exported = False
 
     for v in variables:
-- 
2.1.4


