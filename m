Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CD8A97CF1B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Mar 2019 06:21:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2K6LjEP002703
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 23:21:46 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Tue, 19 Mar 2019 23:21:44 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Mar 2019 14:40:50 +0800
Message-ID: <bb11bef31b406c5636af8637114d56e48638ec05.1553063929.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1553063929.git.liezhi.yang@windriver.com>
References: <cover.1553063929.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] fetch2: runfetchcmd(): Print workdir in debug message
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
X-List-Received-Date: Wed, 20 Mar 2019 06:21:47 -0000
Content-Type: text/plain

The workdir is an important message when run git command, for exmample, before the patch:
Running git -c core.fsyncobjectfiles=0 branch --contains [snip]

We don't know where it is running, now it is:
Running 'git -c core.fsyncobjectfiles=0 branch --contains [snip]' in /path/to/git.opensvc.com.multipath-tools..git

Which is easier to debug.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 5c2a1c7..f5a5928 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -858,7 +858,10 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     # Disable pseudo as it may affect ssh, potentially causing it to hang.
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
-    logger.debug(1, "Running %s", cmd)
+    if workdir:
+        logger.debug(1, "Running '%s' in %s" % (cmd, workdir))
+    else:
+        logger.debug(1, "Running %s", cmd)
 
     success = False
     error_message = ""
-- 
2.7.4


