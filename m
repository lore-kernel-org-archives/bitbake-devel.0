Return-Path: <namhyung@gmail.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
	by mail.openembedded.org (Postfix) with ESMTP id 33720708AA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Jul 2014 02:17:21 +0000 (UTC)
Received: from unknown (HELO sejong.aot.lge.com) (10.177.220.181)
	by 156.147.1.125 with ESMTP; 30 Jul 2014 11:17:20 +0900
X-Original-SENDERIP: 10.177.220.181
X-Original-MAILFROM: namhyung@gmail.com
From: Namhyung Kim <namhyung@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Jul 2014 11:17:20 +0900
Message-Id: <1406686640-8785-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 2.0.0
Subject: [PATCH] cooker: Get rid of duplicate 'import re'
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
X-List-Received-Date: Wed, 30 Jul 2014 02:17:23 -0000

The re module was imported at the top, no need to do it again.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 lib/bb/cooker.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ecb3f9b..2c7788e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -818,7 +818,6 @@ class BBCooker:
         or to find all machine configuration files one could call:
         findFilesMatchingInDir(self, 'conf/machines', 'conf')
         """
-        import re
 
         matches = []
         p = re.compile(re.escape(filepattern))
@@ -1228,7 +1227,6 @@ class BBCooker:
         '''
         Create a new image with a "require"/"inherit" base_image statement
         '''
-        import re
         if timestamp:
             image_name = os.path.splitext(image)[0]
             timestr = time.strftime("-%Y%m%d-%H%M%S")
-- 
2.0.0


