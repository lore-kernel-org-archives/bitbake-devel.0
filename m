Return-Path: <jacob.kroon@gmail.com>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
	[209.85.215.49])
	by mail.openembedded.org (Postfix) with ESMTP id 9E2BA6F199
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 16:55:56 +0000 (UTC)
Received: by mail-la0-f49.google.com with SMTP id mc6so161717lab.8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:subject:date:message-id;
	bh=whS98iTLaPKWnbt4E6vrgjvllYUQF/HWDFsuy9SgIHI=;
	b=iSw1MRPf9C/rIRq/eaHblgNaHHJ9pRswC8GENM3A5VwL3+di1SEJpDPZfVS8kXEuT6
	biloI5scxwxYEBjcv5ReyPuEXCIowouaxgBeBaUcWbdiC5sxd3N5kPwn8hfefNCSEIb5
	/jf7n8AforLDZ9gZERLRqHKoXd7hip7pWAgJOyob3xu46U4g0Fa1KHdWcWyVsqzT1FnK
	6eK5MTwsV0yUtNmdCVTuPC4a8ne4N2xvLaoHzaTAUtOGAF59j34GClO7OKPNe2TOx9SW
	4bkveP5O18L6iJY3T4G7SB5WGZT/p6Gsqj5pMfjFU8iqhAbqh/8kXLrQA8RbtxxwZDYf
	fW8g==
X-Received: by 10.152.1.168 with SMTP id 8mr7454352lan.74.1393088157015;
	Sat, 22 Feb 2014 08:55:57 -0800 (PST)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
	[89.253.118.72])
	by mx.google.com with ESMTPSA id w2sm16451536lad.4.2014.02.22.08.55.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 22 Feb 2014 08:55:56 -0800 (PST)
Sender: Jacob Kroon <jacob.kroon@gmail.com>
From: Jacob Kroon <jacob.kroon@mikrodidakt.se>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 22 Feb 2014 17:52:29 +0100
Message-Id: <1393087949-6183-1-git-send-email-jacob.kroon@mikrodidakt.se>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH v2] ast: Fix support for anonymous methods in wildcard .bbappend files
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
X-List-Received-Date: Sat, 22 Feb 2014 16:56:00 -0000

When using wildcard .bbappend files with anonymous methods in them,
bitbake/python fails to parse the generated code since the '%' is encoded
in the generated method name.

Fix this by including '%' in the convert-to-underscore list during
method name mangling.

While we're at it, move the method name mangling translation table
to a class variable, as suggested by Chris Larson.

[YOCTO #5864]

Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
---
 lib/bb/parse/ast.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a202053..d8c141b 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -139,6 +139,8 @@ class DataNode(AstNode):
             data.setVar(key, val, **loginfo)
 
 class MethodNode(AstNode):
+    tr_tbl = string.maketrans('/.+-@%', '______')
+
     def __init__(self, filename, lineno, func_name, body):
         AstNode.__init__(self, filename, lineno)
         self.func_name = func_name
@@ -147,7 +149,7 @@ class MethodNode(AstNode):
     def eval(self, data):
         text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
-            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-@', '_____'))))
+            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
-- 
1.8.5.3


