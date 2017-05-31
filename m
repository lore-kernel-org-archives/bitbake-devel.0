Return-Path: <ola.x.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0B30F7804E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 08:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 4A6E918487
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id awZhNRBcFWqx for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id B79D21843D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A38501A07E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9894C1A07D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by seth.se.axis.com (Postfix) with ESMTP id 8CB42220B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 10:44:09 +0200 (CEST)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id 8942A409BA; Wed, 31 May 2017 10:44:09 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 10:44:09 +0200
Message-Id: <20170531084409.1246-1-olani@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Subject: [PATCH v2] ConfHandler: Require whitespace between export and variable name
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
X-List-Received-Date: Wed, 31 May 2017 08:44:10 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index f7d0cf74..bf7e9859 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -32,7 +32,7 @@ from bb.parse import ParseError, resolve_file, ast, logger, handle
 
 __config_regexp__  = re.compile( r"""
     ^
-    (?P<exp>export\s*)?
+    (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
 
-- 
2.11.0


