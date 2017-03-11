Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id F100477316
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id E21612E59B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ujNUPPgmRQ1b for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bes.se.axis.com (Postfix) with ESMTPS id 4F0852E59A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD281A077
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309CE1A075
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 24B6FA24
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5U81X022676
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:08 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5U8cn022675
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:30:08 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:30:06 +0100
Message-Id: <20170311053006.22619-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH] knotty: Remove extra whitespace after task progress bars
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
X-List-Received-Date: Sat, 11 Mar 2017 05:30:08 -0000

For some reason, BBProgress.setextra() always adds a space at the end.
This prevents the task progress bars from filling the entire width of
the terminal, making them stop one character short. This looks odd
when shown together with the main progress bar, which does fill the
entire terminal width.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 521c262e45..82aa7c4644 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -75,10 +75,8 @@ class BBProgress(progressbar.ProgressBar):
                 extrastr = str(extra)
                 if extrastr[0] != ' ':
                     extrastr = ' ' + extrastr
-                if extrastr[-1] != ' ':
-                    extrastr += ' '
             else:
-                extrastr = ' '
+                extrastr = ''
             self.widgets[self.extrapos] = extrastr
 
     def _need_update(self):
-- 
2.12.0


