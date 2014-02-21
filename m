Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182])
	by mail.openembedded.org (Postfix) with ESMTP id 6AC716CA61
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 16:46:18 +0000 (UTC)
Received: by mail-lb0-f182.google.com with SMTP id n15so232587lbi.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 08:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:subject:date:message-id;
	bh=4liTpMiD1PHhvTbgBOdSduVt9s5b/hApEylrJ86Fz+U=;
	b=Xkw8G0A0u9801bxxuzmuIjKUckYy9dhaExLoEizhA3+jHx16anvfOZ/+5gK2p7UtoI
	DJv3mSs84RhZvUVxCPNOJHOb4zbw4WOdHO9W2ESF08Vy+R70QBChmhtNrm5rWZtbV2c9
	C8Wn+8u70SGUO3hpqkLk5J8RNtMKs/BMkuftdikvPqY6x2/IAl+lF/30aG+Sa2C/Yevt
	vZoJXfzg2y53dnIigmpDE3cpHTXkerWL9znvh+cGFXxma48wDi3vjrybup9L3uL0aFfP
	XogJXzdiYRZr0jxZIfz9q0AgExqLK5BmvDLDeKMLMQvUa/6ip/wa1Fk29dO1uQr1nXvJ
	mdJg==
X-Received: by 10.112.22.196 with SMTP id g4mr4608005lbf.47.1393001179061;
	Fri, 21 Feb 2014 08:46:19 -0800 (PST)
Received: from localhost.gambro.com ([193.15.174.198])
	by mx.google.com with ESMTPSA id ir3sm11440462lac.9.2014.02.21.08.46.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 21 Feb 2014 08:46:18 -0800 (PST)
Sender: Jacob Kroon <jacob.kroon@gmail.com>
From: Jacob Kroon <jacob.kroon@mikrodidakt.se>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Feb 2014 17:46:03 +0100
Message-Id: <1393001163-7170-1-git-send-email-jacob.kroon@mikrodidakt.se>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH] Fix support for anonymous methods in foobar_%.bbappend files
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
X-List-Received-Date: Fri, 21 Feb 2014 16:46:22 -0000

When using wildcard .bbappend files with anonymous methods in them,
bitbake/python fails to parse the generated code since the '%' is encoded
in the generated method name.

Fix this by including '%' in the convert-to-underscore list during
method name mangling.

[YOCTO #5864]

Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
---
 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index a202053..8331b59 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -147,7 +147,7 @@ class MethodNode(AstNode):
     def eval(self, data):
         text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
-            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-@', '_____'))))
+            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-@%', '______'))))
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
-- 
1.8.5.3


