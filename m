Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U5xEy-0003qh-1K
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 12:44:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 11FDE19DFD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 12:28:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZgoXS15IOXpJ for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 12:28:33 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by anubis.se.axis.com (Postfix) with ESMTP id 5977B19DC5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 12:28:33 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 1C72B3E306
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 12:28:33 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Thu, 14 Feb 2013
	12:28:33 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id C6B979C077; 
	Thu, 14 Feb 2013 12:28:32 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 12:28:32 +0100
Message-ID: <1360841312-14357-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Cc: Olof Johansson <olofjn@axis.com>
Subject: [PATCH] ConfHandler: Use re.X to make long regexp more readable
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
X-List-Received-Date: Thu, 14 Feb 2013 11:44:45 -0000
Content-Type: text/plain

The __config_regexp__ in ConfHandler is quite long, and using re.X to
break the expression onto several lines make it a bit easier to read.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 4b62a3a..3255c8b 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -29,7 +29,30 @@ import logging
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger
 
-__config_regexp__  = re.compile( r"(?P<exp>export\s*)?(?P<var>[a-zA-Z0-9\-~_+.${}/]+?)(\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?\s*((?P<colon>:=)|(?P<lazyques>\?\?=)|(?P<ques>\?=)|(?P<append>\+=)|(?P<prepend>=\+)|(?P<predot>=\.)|(?P<postdot>\.=)|=)\s*(?!'[^']*'[^']*'$)(?!\"[^\"]*\"[^\"]*\"$)(?P<apo>['\"])(?P<value>.*)(?P=apo)$")
+__config_regexp__  = re.compile( r"""
+    ^
+    (?P<exp>export\s*)?
+    (?P<var>[a-zA-Z0-9\-~_+.${}/]+?)
+    (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
+
+    \s* (
+        (?P<colon>:=) |
+        (?P<lazyques>\?\?=) |
+        (?P<ques>\?=) |
+        (?P<append>\+=) |
+        (?P<prepend>=\+) |
+        (?P<predot>=\.) |
+        (?P<postdot>\.=) |
+        =
+    ) \s*
+
+    (?!'[^']*'[^']*'$)
+    (?!\"[^\"]*\"[^\"]*\"$)
+    (?P<apo>['\"])
+    (?P<value>.*)
+    (?P=apo)
+    $
+    """, re.X)
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
-- 
1.7.10.4



