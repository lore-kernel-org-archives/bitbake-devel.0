Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sf7B3-0000uz-0D
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 12:21:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5EAAhQE008714
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 03:10:43 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 14 Jun 2012 03:10:43 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 18:10:57 +0800
Message-ID: <6fd8d4b280166137d3ef31185eeaa4f4760c5ae9.1339653356.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1339653356.git.kai.kang@windriver.com>
References: <cover.1339653356.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/3] ui/crumbs/hig.py: simplify subprocess call
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
X-List-Received-Date: Thu, 14 Jun 2012 10:21:21 -0000
Content-Type: text/plain

According to Darren's suggestion, subprocess.call() will wait until the
subprocess complete. So simplify the code, use subprocess.call() to wait
command complete.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 0c3f56c..b586b6c 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -27,6 +27,7 @@ import hashlib
 import os
 import re
 import shlex
+import subprocess
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
@@ -871,8 +872,7 @@ class DeployImageDialog (CrumbsDialog):
                     tmpname = os.tmpnam()
                     cmdline += "\"sudo dd if=" + self.image_path + \
                                 " of=" + combo_item + "; echo $? > " + tmpname + "\""
-                    deploy_process = bb.process.Popen(shlex.split(cmdline))
-                    deploy_process.wait()
+                    subprocess.call(shlex.split(cmdline))
 
                     # if file tmpname not exists, that means there is something wrong with xterm
                     # user can get the error message from xterm so no more warning need.
-- 
1.7.5.4



