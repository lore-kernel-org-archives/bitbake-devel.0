Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id B901660FF0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 17:09:11 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id C545AF81228; Thu,  7 Nov 2013 10:09:13 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from zeus.chez-thomas.org (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id D9769F81226;
	Thu,  7 Nov 2013 10:09:11 -0700 (MST)
From: Gary Thomas <gary@mlbassoc.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Nov 2013 10:09:23 -0700
Message-Id: <1383844163-29633-1-git-send-email-gary@mlbassoc.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] depexp: Improve wording on requirements
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
X-List-Received-Date: Thu, 07 Nov 2013 17:09:11 -0000

Since -g is required, tell the user exactly so.

Signed-off-by: Gary Thomas <gary@mlbassoc.com>
---
 lib/bb/ui/depexp.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/depexp.py b/lib/bb/ui/depexp.py
index 0b160e2..4578dce 100644
--- a/lib/bb/ui/depexp.py
+++ b/lib/bb/ui/depexp.py
@@ -202,7 +202,7 @@ def main(server, eventHandler, params):
             return 1
         cmdline = cmdline['action']
         if not cmdline or cmdline[0] != "generateDotGraph":
-            print("This UI is only compatible with the -g option")
+            print("This UI requires the -g option")
             return 1
         ret, error = server.runCommand(["generateDepTreeEvent", cmdline[1], cmdline[2]])
         if error:
-- 
1.7.9.5


