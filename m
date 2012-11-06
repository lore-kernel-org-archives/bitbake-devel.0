Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TVlmc-0002QW-Og
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Nov 2012 17:13:47 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qA6CWTp6019609
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 6 Nov 2012 04:32:29 -0800 (PST)
Received: from usp-opensuse12-64.corp.ad.wrs.com (128.224.162.26) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.318.4; Tue, 6 Nov 2012 04:32:26 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 6 Nov 2012 20:18:42 +0800
Message-ID: <e8932acafcf350f634322a62fce7648da05f76d0.1352200293.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1352200293.git.liezhi.yang@windriver.com>
References: <cover.1352200293.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] print clear message for "bitbake -e ASSUME_PROVIDED"
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
X-List-Received-Date: Tue, 06 Nov 2012 16:13:47 -0000
Content-Type: text/plain

"bitbake -e ASSUME_PROVIDED" should fail, but the error message wasn't
clear enough in the past:

$ bitbake -e bzip2-native
[snip]
ERROR: Command execution failed: Traceback (most recent call last):
  File "/buildarea/lyang1/poky/bitbake/lib/bb/command.py", line 94, in
runAsyncCommand
    commandmethod(self.cmds_async, self, options)
  File "/buildarea/lyang1/poky/bitbake/lib/bb/command.py", line 323, in
showEnvironmentTarget
    command.cooker.showEnvironment(None, pkg)
  File "/buildarea/lyang1/poky/bitbake/lib/bb/cooker.py", line 325, in
showEnvironment
    fnid = taskdata.build_targets[targetid][0]
KeyError: 0
[snip]

With this patch, the massage will be:
[snip]
ERROR: bzip2-native is in ASSUME_PROVIDED
ERROR: Command execution failed: Exited with 1

Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

[YOCTO #3392]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e299059..5f88f1f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -313,6 +313,10 @@ class BBCooker:
         elif len(pkgs_to_build) == 1:
             self.updateCache()
 
+            ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
+            if pkgs_to_build[0] in set(ignore.split()):
+                bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
+
             localdata = data.createCopy(self.configuration.data)
             bb.data.update_data(localdata)
             bb.data.expandKeys(localdata)
-- 
1.7.7



