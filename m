Return-Path: <rich.tollerton@ni.com>
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1FCE572726
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 01:11:24 +0000 (UTC)
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id
	sBI1BP8X006005 for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Dec 2014 19:11:25 -0600
Received: from weregild.amer.corp.natinst.com ([130.164.14.198])
	by us-aus-mgwout2.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014121719112517-1243304 ;
	Wed, 17 Dec 2014 19:11:25 -0600 
From: Richard Tollerton <rich.tollerton@ni.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Dec 2014 19:11:17 -0600
Message-Id: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
X-Mailer: git-send-email 2.1.3
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/17/2014 07:11:25 PM,
	Serialize by Router on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/17/2014 07:11:25 PM,
	Serialize complete at 12/17/2014 07:11:25 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2014-12-17_07:2014-12-17, 2014-12-17,
	1970-01-01 signatures=0
Subject: [PATCH] data: Avoid attempting to assign readonly shell vars
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
X-List-Received-Date: Thu, 18 Dec 2014 01:11:32 -0000

Attempting to set a read-only shell variable kills the shell. This is
required POSIX behavior, it can't be disabled, and it's implemented by
both dash and bash (although it seems to have only started happening in
bash 4.3 and later, and only when run as /bin/sh).

This breaks `bitbake -c devshell` if bash 4.3 is installed, because
BASHOPTS (and a boatload of other shell variables) are readonly.

The fix is to attempt to modify the variable in a subshell before doing
the assignment.

Signed-off-by: Richard Tollerton <rich.tollerton@ni.com>
---
 lib/bb/data.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index eb628c7..6c8d644 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -231,6 +231,10 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))
         return 1
 
+    # If the variable is readonly, attempting to set it will KILL THE SCRIPT.
+    # Avoid this by attempting to modify the variable in a subshell.
+    o.write('(unset %s 2>/dev/null) &&' % (varExpanded))
+
     if export:
         o.write('export ')
 
-- 
2.1.3


