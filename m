Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 20EFE77316
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 05:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2E5B1182F3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 1fymxSfqy3uy for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:34 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 2881B180F8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:34 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161851E072
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:34 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3AB1E070
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:34 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:34 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id F3844A24
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:33 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2B5UXDG023268
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Mar 2017 06:30:33 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2B5UXol023267
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Mar 2017 06:30:33 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 11 Mar 2017 06:30:32 +0100
Message-Id: <20170311053032.23184-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH] ConfHandler: Use the same regular expression for all variable names
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
X-List-Received-Date: Sat, 11 Mar 2017 05:30:34 -0000

When the regular expression for matching a variable name was amended
with allowing the ~ character as part of the variable name, this was
never done to the regular expression that matches export
lines. Similarly, the regular expression that was used for matching
unset variables also used the one without support for the ~ character.

This unifies the regular expressions. For good measures it also
corrects the regular expression used to match a variable flag name for
the unset command to match the one used when setting a variable flag.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 5759cb20ed..f7d0cf74ab 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -33,7 +33,7 @@ from bb.parse import ParseError, resolve_file, ast, logger, handle
 __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s*)?
-    (?P<var>[a-zA-Z0-9\-~_+.${}/]+?)
+    (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
 
     \s* (
@@ -56,9 +56,9 @@ __config_regexp__  = re.compile( r"""
     """, re.X)
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
-__export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
-__unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)$" )
-__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)\[([a-zA-Z0-9\-_+.${}/]+)\]$" )
+__export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
+__unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
 
 def init(data):
     topdir = data.getVar('TOPDIR', False)
-- 
2.12.0


