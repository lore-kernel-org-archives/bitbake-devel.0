Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TyiC7-0003oy-CR
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 13:15:49 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0P8ZECa013581
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 00:35:14 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 25 Jan 2013 00:35:13 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2013 16:35:09 +0800
Message-ID: <fd425b3b5b4efdb216ec8fa44d6373c42708d4e8.1359080497.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1359080497.git.liezhi.yang@windriver.com>
References: <cover.1359080497.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/2] bitbake-layers: fix get_file_layer
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
X-List-Received-Date: Fri, 25 Jan 2013 12:15:55 -0000
Content-Type: text/plain

The get_file_layer can't handle the nested layer correctly, e.g.:

meta-intel/conf/layer.conf
meta-intel/meta-cedartrail/conf/layer.conf

They are two layers, the file:
meta-intel/common/recipes-bsp/amt/lms_7.1.20.bb
belongs to meta-intel's layer, but the get_file_layer() may return
meta-cedartrail accordig to BBLAYERS' order, since it uses:

for layerdir in self.bblayers:
    if regex.match(os.path.join(layerdir, 'test')):
        return self.get_layer_name(layerdir)

which doesn't care the filename, re-match the filename would fix the
problem.

[YOCTO #3387]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-layers |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index fa4e767..956e7a9 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -26,6 +26,7 @@ import os
 import sys
 import fnmatch
 from collections import defaultdict
+import re
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -458,7 +459,7 @@ build results (as the layer priority order has effectively changed).
         for layer, _, regex, _ in self.bbhandler.cooker.status.bbfile_config_priorities:
             if regex.match(filename):
                 for layerdir in self.bblayers:
-                    if regex.match(os.path.join(layerdir, 'test')):
+                    if regex.match(os.path.join(layerdir, 'test')) and re.match(layerdir, filename):
                         return self.get_layer_name(layerdir)
         return "?"
 
-- 
1.7.1



