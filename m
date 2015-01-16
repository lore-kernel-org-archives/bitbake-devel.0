Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id DD98D72332
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 09:38:16 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0G9cGfN026693
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Jan 2015 01:38:17 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Fri, 16 Jan 2015 01:38:16 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 16 Jan 2015 17:33:57 +0800
Message-ID: <11681bae97a459ce186f80489311cbd82de550d4.1421400193.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421400193.git.Chong.Lu@windriver.com>
References: <cover.1421400193.git.Chong.Lu@windriver.com>
MIME-Version: 1.0
Subject: [RFC][PATCH 1/1] bitbake: cooker: wait seconds to unlock bitbake.lock
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
X-List-Received-Date: Fri, 16 Jan 2015 09:38:24 -0000
Content-Type: text/plain

Sometimes, we get following error when bitbake command is executed continuously

    "ERROR: Only one copy of bitbake should be run against a build directory"

For example, "bitbake -p m4 && bitbake -e".
Add seconds to wait unlock after first bitbake command exit.

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
---
 bitbake/lib/bb/cooker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 95f65ac..8ebb335 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -140,6 +140,14 @@ class BBCooker:
         # directory at a time
         lockfile = self.data.expand("${TOPDIR}/bitbake.lock")
         self.lock = bb.utils.lockfile(lockfile, False, False)
+        n = 0
+        while n < 3:
+            if not self.lock:
+                time.sleep(0.5)
+                self.lock = bb.utils.lockfile(lockfile, False, False)
+                n += 1
+            else:
+                break
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
         try:
-- 
1.9.1


