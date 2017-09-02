Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 4C01A70018
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Sep 2017 15:15:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v82FFnOc012416
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 2 Sep 2017 08:15:49 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.361.1;
	Sat, 2 Sep 2017 08:15:48 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 2 Sep 2017 10:09:43 -0500
Message-ID: <1504364983-46357-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH] cooker.py: Fix layer priority processing
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
X-List-Received-Date: Sat, 02 Sep 2017 15:15:48 -0000
Content-Type: text/plain

If you have a layer with a blank BBFILE_PATTERN the layer was ignored
when processing the list of layers with priorities.  This list is not
only used for processing recipes, but also by additional programs such
as bitbake-layers show-layers.

Without this change, a layer that provides configuration or classes
only does now show up in show-layers, which is used by the
yocto-compat-layer.py script.  This causes a failures in the compatibility
check.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/cooker.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f5ae831..90de40d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1171,13 +1171,13 @@ class BBCooker:
                 elif regex == "":
                     parselog.debug(1, "BBFILE_PATTERN_%s is empty" % c)
                     errors = False
-                    continue
-                try:
-                    cre = re.compile(regex)
-                except re.error:
-                    parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
-                    errors = True
-                    continue
+                else:
+                    try:
+                        cre = re.compile(regex)
+                    except re.error:
+                        parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
+                        errors = True
+                        continue
                 self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
         if errors:
             # We've already printed the actual error(s)
-- 
1.8.3.1


