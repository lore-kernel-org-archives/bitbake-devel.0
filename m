Return-Path: <francisco.j.pedraza.gonzalez@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C710360132
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Aug 2016 21:52:29 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP; 04 Aug 2016 14:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,471,1464678000"; d="scan'208";a="150812270"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2016 14:52:29 -0700
Received: from fjpedraz-MOBL3.zpn.intel.com (fjpedraz-mobl3.zpn.intel.com
	[10.219.128.66])
	by linux.intel.com (Postfix) with ESMTP id 2D68C6A4006;
	Thu,  4 Aug 2016 14:52:16 -0700 (PDT)
From: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Aug 2016 16:52:27 -0500
Message-Id: <1470347547-5037-1-git-send-email-francisco.j.pedraza.gonzalez@intel.com>
X-Mailer: git-send-email 2.5.0
X-Mailman-Approved-At: Fri, 05 Aug 2016 08:46:08 +0000
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
X-List-Received-Date: Thu, 04 Aug 2016 21:52:29 -0000

This was added to enable the usage of git through proxies.

Signed-off-by: Francisco Pedraza <francisco.j.pedraza.gonzalez@intel.com>
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
2.5.0


