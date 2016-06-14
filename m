Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B65806612D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 11:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5EBmeo0014117 for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 12:48:40 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FU8eaPlShWNO for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 12:48:40 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5EBmb78014114
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 12:48:38 +0100
Message-ID: <1465904917.13979.207.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 14 Jun 2016 12:48:37 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] parse/ast, event: Ensure we reset registered handlers during parsing
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
X-List-Received-Date: Tue, 14 Jun 2016 11:48:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When parsing, we should reset the event handlers we registered when
done. If we don't do this, parse order may change the build, depending
on what the parse handlers do to the metadata.

This issue showed up as a basehash change:

ERROR: Bitbake's cached basehash does not match the one we just generated (
/media/build1/poky/meta/recipes-core/meta/nativesdk-buildtools-perl-dummy.bb.do_unpack)!

This is due to the eventhandler in nativesdk.bbclass being run, despite
this .bb file not inheriting nativesdk.bbclass. The parse order was
different between the signature generation and the main multithreaded
parse.

Diffsigs showed:

bitbake-diffsigs 1.0-r2.do_unpack.sigbasedata.*
basehash changed from 887d1c25962156cae859c1542e69a8d7 to cb84fcfafe15fc92fb7ab8c6d97014ca
Variable PN value changed from 'nativesdk-buildtools-perl-dummy' to '${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}'

with PN being set by the event handler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 023300b..3c5caaf 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -228,6 +228,13 @@ def remove(name, handler):
     """Remove an Event handler"""
     _handlers.pop(name)
 
+def get_handlers():
+    return _handlers
+
+def set_handlers(handlers):
+    global _handlers
+    _handlers = handlers
+
 def set_eventfilter(func):
     global _eventfilter
     _eventfilter = func
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 548929f..8b9baa7 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -306,7 +306,8 @@ def handleInherit(statements, filename, lineno, m):
     statements.append(InheritNode(filename, lineno, classes))
 
 def finalize(fn, d, variant = None):
-    all_handlers = {}
+    saved_handlers = bb.event.get_handlers().copy()
+
     for var in d.getVar('__BBHANDLERS', False) or []:
         # try to add the handler
         handlerfn = d.getVarFlag(var, "filename", False)
@@ -331,6 +332,7 @@ def finalize(fn, d, variant = None):
     d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
 
     bb.event.fire(bb.event.RecipeParsed(fn), d)
+    bb.event.set_handlers(saved_handlers)
 
 def _create_variants(datastores, names, function, onlyfinalise):
     def create_variant(name, orig_d, arg = None):



