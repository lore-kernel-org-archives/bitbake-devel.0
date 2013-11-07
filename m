Return-Path: <gthomas@mail.chez-thomas.org>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id A6E246BE6E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 17:24:26 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 996)
	id A1A3DF81226; Thu,  7 Nov 2013 10:24:28 -0700 (MST)
From: Gary Thomas <gary@mlbassoc.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Nov 2013 10:24:27 -0700
Message-Id: <1383845067-1320-1-git-send-email-gary@mlbassoc.com>
X-Mailer: git-send-email 1.7.7.6
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
X-List-Received-Date: Thu, 07 Nov 2013 17:24:29 -0000

Since -g is required, tell the user exactly so.

Signed-off-by: Gary Thomas <gary@mlbassoc.com>
---
 lib/bb/ui/depexp.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.7.6


