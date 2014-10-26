Return-Path: <oscar@oscr.io>
X-Greylist: delayed 1456 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 26 Oct 2014 23:16:51 UTC
Received: from slow1-d.mail.gandi.net (slow1-d.mail.gandi.net [217.70.178.86])
	by mail.openembedded.org (Postfix) with ESMTP id B4367601F5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Oct 2014 23:16:51 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
	[217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 4991747B5B3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Oct 2014 23:43:45 +0100 (CET)
Received: from mfilter26-d.gandi.net (mfilter26-d.gandi.net [217.70.178.154])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 1C0BFFB886;
	Sun, 26 Oct 2014 23:43:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter26-d.gandi.net
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
	by mfilter26-d.gandi.net (mfilter26-d.gandi.net [10.0.15.180])
	(amavisd-new, port 10024)
	with ESMTP id 5TetZhtMtICC; Sun, 26 Oct 2014 23:43:35 +0100 (CET)
X-Originating-IP: 85.225.63.5
Received: from Loke.lan (c-053fe155.653-1-64736c12.cust.bredbandsbolaget.se
	[85.225.63.5]) (Authenticated sender: oscar@oscr.io)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0BD4DFB87E;
	Sun, 26 Oct 2014 23:43:34 +0100 (CET)
From: Oscar Utbult <oscar@oscr.io>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 26 Oct 2014 23:43:32 +0100
Message-Id: <1414363412-30555-1-git-send-email-oscar@oscr.io>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] utils.py: don't use len() for truth value testing.
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
X-List-Received-Date: Sun, 26 Oct 2014 23:16:55 -0000

Signed-off-by: Oscar Utbult <oscar@oscr.io>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 670e592..c6f4071 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -522,7 +522,7 @@ def filter_environment(good_vars):
         os.unsetenv(key)
         del os.environ[key]
 
-    if len(removed_vars):
+    if removed_vars:
         logger.debug(1, "Removed the following variables from the environment: %s", ", ".join(removed_vars.keys()))
 
     return removed_vars
-- 
1.9.1


