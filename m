Return-Path: <boucman2@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 08DE870149
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 10:56:25 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id q128so2088626wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Y3fpPlWyjGkbPDT9GJ/RQcvM8vLVPDFQrIWPSMEaDmc=;
	b=ZsvYRoSuDrywZTrtSLBooJWwJvGsvvji7s045v7r5PT9g05LtXvxS2vPFfAh80OGI+
	zDIh3ovhCpLSNuqVVUgCt6jBVLNxIfTLpJCrJfzbGIyxT/nMxle9bdrNBvpiXko3r+v9
	4YCGQfLZkMHxps4z+69MXorbrqQe/N0ybLQDHZyVJHE1HLYpwr10Fpufs0FZ7j2dVvi9
	tmwA47KCudlmGIK0kgiZirFqt/mhSiVKEP6rqoklVBvEBOqZVkjPtbWpzcUKhDliqQY3
	5MYDZVTBBqhfj/Hglx9rAnOC1hLwhe5eo70iw0g0/PRxangvXJHWYt15AMd7yRU8EcuC
	FIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=Y3fpPlWyjGkbPDT9GJ/RQcvM8vLVPDFQrIWPSMEaDmc=;
	b=C+zdwRBHnWwpZbZy5Uo2Th8JHFQiv4GSss5wTPRVbXEcsDy59CYGiiSPGBYrLYzV8i
	X+CucYngOjuHyZ6TaeNFTuoulpRZmNlKD99LoShvBRqupNu98GAu2wlx4GlET12Q4jER
	Nfra2XayCY7n01Aeg0qBHKfhJh/x9tQYiR5WnhnPsJff+ImLYIWiV+7LJf2Sliu1pOKf
	Q1gAOf47g1GtZEe6Px1itxFsaSo1hhh9BlEBQMcPKjhq9rDbc1gIPv4Rq6coZevjoENh
	jAQLc2jU34def0+t+t7zGX+3mi6PGfyYufOiaRb+a0oIY3nRdV0eOG2MXiYxfUlz5icJ
	Y7Ew==
X-Gm-Message-State: ALyK8tLz7+3eIP/JDmdgSto31QeV+GfvEtVd+gq9vNSwcMeAv8tqTsE+98esxiPopQl6ag==
X-Received: by 10.28.166.2 with SMTP id p2mr17252526wme.58.1469098585242;
	Thu, 21 Jul 2016 03:56:25 -0700 (PDT)
Received: from localhost.localdomain (229.29.205.77.rev.sfr.net.
	[77.205.29.229]) by smtp.gmail.com with ESMTPSA id
	d80sm3058052wmd.14.2016.07.21.03.56.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Jul 2016 03:56:23 -0700 (PDT)
Sender: jeremy rosen <boucman2@gmail.com>
From: "=?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?=" <jeremy.rosen@enst-bretagne.fr>
X-Google-Original-From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?=
	<jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 12:55:38 +0200
Message-Id: <1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Jul 2016 14:29:05 +0000
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@openwide.fr>
Subject: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Thu, 21 Jul 2016 10:56:25 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Rosen <jeremy.rosen@openwide.fr>

unset VAR
will clear variable VAR
unset VAR[flag]
will clear flag "flag" from var VAR

Signed-off-by: Jérémy Rosen <jeremy.rosen@openwide.fr>
---
 .../bitbake-user-manual-metadata.xml               | 17 +++++++++++
 bitbake/lib/bb/parse/ast.py                        | 33 ++++++++++++++++++++++
 bitbake/lib/bb/parse/parse_py/ConfHandler.py       | 12 ++++++++
 3 files changed, 62 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 6329cd6..c42907e 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -333,6 +333,23 @@
             </para>
         </section>
 
+        <section id='unseting-variables'>
+            <title>Unseting variables</title>
+
+            <para>
+                It is possible to completely remove a variable or a variable flag 
+                from BitBake's internal data dictionary using the "unset" keyword
+                Here is an example:
+                <literallayout class='monospaced'>
+        unset DATE
+        unset do_fetch[noexec]
+                </literallayout>
+                This example results in the <filename>DATE</filename> being unset and the flag
+                <filename>do_fetch[noexec]</filename> to be cleared
+            </para>
+
+        </section>
+
         <section id='providing-pathnames'>
             <title>Providing Pathnames</title>
 
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 8b9baa7..b407b09 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -69,6 +69,33 @@ class ExportNode(AstNode):
     def eval(self, data):
         data.setVarFlag(self.var, "export", 1, op = 'exported')
 
+class UnsetNode(AstNode):
+    def __init__(self, filename, lineno, var):
+        AstNode.__init__(self, filename, lineno)
+        self.var = var
+
+    def eval(self, data):
+        loginfo = {
+            'variable': self.var,
+            'file': self.filename,
+            'line': self.lineno,
+        }
+        data.delVar(self.var,**loginfo)
+
+class UnsetFlagNode(AstNode):
+    def __init__(self, filename, lineno, var, flag):
+        AstNode.__init__(self, filename, lineno)
+        self.var = var
+        self.flag = flag
+
+    def eval(self, data):
+        loginfo = {
+            'variable': self.var,
+            'file': self.filename,
+            'line': self.lineno,
+        }
+        data.delVarFlag(self.var, self.flag, **loginfo)
+
 class DataNode(AstNode):
     """
     Various data related updates. For the sake of sanity
@@ -270,6 +297,12 @@ def handleInclude(statements, filename, lineno, m, force):
 def handleExport(statements, filename, lineno, m):
     statements.append(ExportNode(filename, lineno, m.group(1)))
 
+def handleUnset(statements, filename, lineno, m):
+    statements.append(UnsetNode(filename, lineno, m.group(1)))
+
+def handleUnsetFlag(statements, filename, lineno, m):
+    statements.append(UnsetFlagNode(filename, lineno, m.group(1), m.group(2)))
+
 def handleData(statements, filename, lineno, groupd):
     statements.append(DataNode(filename, lineno, groupd))
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index b971292..875250d 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -57,6 +57,8 @@ __config_regexp__  = re.compile( r"""
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/]+)$" )
+__unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/]+)\[([a-zA-Z0-9\-_+.${}/]+)\]$" )
 
 def init(data):
     topdir = data.getVar('TOPDIR', False)
@@ -185,6 +187,16 @@ def feeder(lineno, s, fn, statements):
         ast.handleExport(statements, fn, lineno, m)
         return
 
+    m = __unset_regexp__.match(s)
+    if m:
+        ast.handleUnset(statements, fn, lineno, m)
+        return
+
+    m = __unset_flag_regexp__.match(s)
+    if m:
+        ast.handleUnsetFlag(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.8.1


