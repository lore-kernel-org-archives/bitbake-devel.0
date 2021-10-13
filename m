Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5087C433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web08.9564.1634137821724179781
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:10:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413F0147A
	for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:10:21 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02303F694
	for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:10:20 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] codegen: implement ast.NodeVisitor.visit_Constant
Date: Wed, 13 Oct 2021 16:10:17 +0100
Message-Id: <20211013151017.293725-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 15:10:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12769

Since Python 3.8 visit_Num(), visit_Str() and so on are all deprecated
and replaced with visit_Constant.  We can't yet remove the deprecated
functions until we require 3.8, but we can implement visit_Constant to
silence the deprecation warnings.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/codegen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/codegen.py b/bitbake/lib/codegen.py
index 62a6748c47..6955a7ada5 100644
--- a/bitbake/lib/codegen.py
+++ b/bitbake/lib/codegen.py
@@ -401,6 +401,12 @@ class SourceGenerator(NodeVisitor):
     def visit_Num(self, node):
         self.write(repr(node.n))
=20
+    def visit_Constant(self, node):
+        # Python 3.8 deprecated visit_Num(), visit_Str(), visit_Bytes(),
+        # visit_NameConstant() and visit_Ellipsis(). They can be removed=
 once we
+        # require 3.8+.
+        self.write(repr(node.value))
+
     def visit_Tuple(self, node):
         self.write('(')
         idx =3D -1
--=20
2.25.1


