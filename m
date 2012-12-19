Received: from mail-ia0-f177.google.com ([209.85.210.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <tylerwhall@gmail.com>) id 1TlTGk-0008Dt-Gj
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Dec 2012 00:42:02 +0100
Received: by mail-ia0-f177.google.com with SMTP id u21so2263894ial.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Dec 2012 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=DrnZmUyhQrR9rMOJCfOBDUBLGUBroBR/D8LTAmBTXc0=;
	b=Il2VbbZxi6ocgy0S9cLdvxrnZBA18itEhuIFTokp505YadQc3BXu05m3Cgzfo6Kf8d
	4lc/tdDBYUYSLJK+T/fmtySY7yjHRy2al1jeTUQgPJRDfg5uW/n2C//5GlSdE/ImA/MU
	aX7m0EnqCKplQuFBebF4FauglZHJgm3QKysV6+9kgtz4GkhHQ+olyHBryFeTS2mgK0+M
	xvZgc6O1MQIO7VCWkdmATGetHBsOATFEJwsLWaIljMD/J1Iz8BhdPxoedolU/8EwLWsi
	DqVJVWR0jTdEtQv4YQbewi3FoX5TI0JQRlAS3N1YscGnqlXzWaPQPRRdB0iyxJ5/Aw7K
	tz+A==
X-Received: by 10.50.47.228 with SMTP id g4mr3742587ign.77.1355959622305;
	Wed, 19 Dec 2012 15:27:02 -0800 (PST)
Received: from localhost.localdomain (cpe-69-23-225-27.natcky.res.rr.com.
	[69.23.225.27])
	by mx.google.com with ESMTPS id gs6sm5409275igc.11.2012.12.19.15.27.00
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 19 Dec 2012 15:27:01 -0800 (PST)
From: Tyler Hall <tylerwhall@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Dec 2012 18:26:50 -0500
Message-Id: <1355959610-29470-1-git-send-email-tylerwhall@gmail.com>
X-Mailer: git-send-email 1.8.0.2
X-Mailman-Approved-At: Sun, 23 Dec 2012 23:46:00 +0100
Subject: [PATCH] fetch2: Sort file checksums by value, not path
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Dec 2012 23:42:03 -0000

Changing the path to a file could change the task hash even if the file
still has the same checksum. This occurs when the task depends on
multiple files and the sort order of their paths changes. Usually the
sorting is consistent because layers tend to have the same relative
paths, but this should take care of other configuations.

The problem arose when using a .bbappend to add files to a recipe in
another layer. If the layer is located alongside the other layers and
their parent directory is moved, the hash does not change. However,
moving the .bbappend layer outside of the common directory can change
the path sort order and the task hash.

Signed-off-by: Tyler Hall <tylerwhall@gmail.com>
---
 lib/bb/fetch2/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 150dc3c..4746356 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -30,6 +30,7 @@ from __future__ import print_function
 import os, re
 import logging
 import urllib
+import operator
 import bb.persist_data, bb.utils
 import bb.checksum
 from bb import data
@@ -729,7 +730,7 @@ def get_file_checksums(filelist, pn):
         if checksum:
             checksums.append((pth, checksum))
 
-    checksums.sort()
+    checksums.sort(key=operator.itemgetter(1))
     return checksums
 
 
-- 
1.8.0.2



