Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6C53079F0A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 22:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id E66A818420
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id qnsNNQp6MfOr for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 61AE818415
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAA71E060
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4381C1E057
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 367C21CFE
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:26 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id wBMMGPd5005148
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2018 23:16:25 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id wBMMGPo5005147
	for bitbake-devel@lists.openembedded.org;
	Sat, 22 Dec 2018 23:16:25 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 22 Dec 2018 23:16:21 +0100
Message-Id: <20181222221621.5101-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [thud][PATCH] siggen: Adapt colors used by bitbake-diffsigs to support light themes
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
X-List-Received-Date: Sat, 22 Dec 2018 22:16:26 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

The colors specified for use with bitbake-diffsigs were adapted for a
dark theme, e.g., by setting the background color to black, which made
it look very bad when used with a light theme.

To make it look good both with a dark or a light theme, it is better
to drop the background color. It is also better to leave out the color
altogether for the title and just use bold. Finally, dropping bold for
the red and green texts indicating removed/added values better matches
other colorized diff implementations as, e.g., git diff.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---

This is a backport from master.

 bitbake/lib/bb/siggen.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index c619b596d8..fdbb2a3998 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -342,10 +342,10 @@ def dump_this_task(outfile, d):
 def init_colors(enable_color):
     """Initialise colour dict for passing to compare_sigfiles()"""
     # First set up the colours
-    colors = {'color_title':   '\033[1;37;40m',
-              'color_default': '\033[0;37;40m',
-              'color_add':     '\033[1;32;40m',
-              'color_remove':  '\033[1;31;40m',
+    colors = {'color_title':   '\033[1m',
+              'color_default': '\033[0m',
+              'color_add':     '\033[0;32m',
+              'color_remove':  '\033[0;31m',
              }
     # Leave all keys present but clear the values
     if not enable_color:
-- 
2.12.0


