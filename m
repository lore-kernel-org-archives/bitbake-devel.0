Return-Path: <n.merinov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE4C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 16:43:11 +0000 (UTC)
Received: from ksserv.inango.com (ksserv.inango.com [31.154.135.10])
 by mx.groups.io with SMTP id smtpd.web10.92718.1738600983461118150
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 08:43:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com header.s=45A440E0-D841-11E8-B985-5FCC721607E0 header.b=SuHSuIsj;
 spf=pass (domain: inango-systems.com, ip: 31.154.135.10, mailfrom: n.merinov@inango-systems.com)
Received: from ksserv.inango.com (localhost [127.0.0.1])
	by ksserv.inango.com (Proxmox) with ESMTP id 7FBA121F4D;
	Mon,  3 Feb 2025 18:43:01 +0200 (IST)
Received: from mail.inango-systems.com (unknown [172.31.254.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ksserv.inango.com (Proxmox) with ESMTPS id 3DFD921FDB;
	Mon,  3 Feb 2025 18:43:01 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 9B75410804E9;
	Mon,  3 Feb 2025 18:43:00 +0200 (IST)
Authentication-Results: mail.inango-systems.com (amavis);
 dkim=pass (2048-bit key) header.d=inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 74rOZQ9e0vBZ; Mon,  3 Feb 2025 18:43:00 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 705BF108055D;
	Mon,  3 Feb 2025 18:43:00 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 705BF108055D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1738600980;
	bh=ycla5tJt0ImRGRRPZ7W/OJ4LP165NFQ92LMYxGQnD/o=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=SuHSuIsjJfrQbSdO5/NmugPy88JI7ocBDjQxDpW4yk1WQHDJkkzhjJdyjdJ8DZqQ4
	 hXHhm9PtLAB4k8+RhG6Dz3CSTr9loZeiciNtNfNTdDULBzH91zIUPHvi8W4eS4KzuN
	 lm1n3YIco2fwJUlgM6fj/YGhF4W0O48DjL+KcmVZkGDy0CNRclgncyyQrzSVl50JW2
	 YZqc2/LSQmgJiL4ngJuUvi3j8orTIzJ4NhATcdzRV6Q0giGe3xah/qoOtkLwkJMoki
	 TqXlCKDEFK+Z/hePetyEnj1jiJ1Gh9219qivq/Q1oFpPWh9hLamr50HpECd1Vkae3q
	 GY0fXNEVD9Qwg==
X-Virus-Scanned: amavis at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dYp-LiGkeLSZ; Mon,  3 Feb 2025 18:43:00 +0200 (IST)
Received: from wksv-012.inango.loc (ksserv.inango.com [31.154.135.10])
	by mail.inango-systems.com (Postfix) with ESMTPSA id D13DE10804E9;
	Mon,  3 Feb 2025 18:42:59 +0200 (IST)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Cc: Nikolai Merinov <n.merinov@inango-systems.com>
Subject: [PATCH v2] parse: Forbid ambiguous assignments to ${.}, ${+}, and ${:} variables
Date: Mon,  3 Feb 2025 18:42:36 +0200
Message-Id: <20250203164235.1503956-2-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
References: <fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 16:43:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17124

Old code that parse variable names in assignment commands behave differen=
tly for
variables that ends with special symbol for single-character variable nam=
es and
multi-character variable names. For example:

  A+=3D"1"   # Change variable ${A}, '+' glued to '=3D'
  A+ =3D "1" # Change variable ${A+}

  +=3D"1"    # Change variable ${+}, the '+' symbol not part of assignmen=
t operator
  + =3D "1"  # Change variable ${+}

New code would always assume that '.=3D', '+=3D', and ':=3D' is assignmen=
t operator.
As result code like the following would raise parsing error

  +=3D"value"

While code with extra spaces would work as before

  + =3D "value" # Change variable ${+}

This change allow to catch issues in code that generate bitbake configura=
tion
files in a manner like "echo ${VARNAME}+=3D${VALUE} >> conf/local.conf"

Signed-off-by: Nikolai Merinov <n.merinov@inango-systems.com>
---
 lib/bb/parse/parse_py/ConfHandler.py |  4 +++-
 lib/bb/tests/parse.py                | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
index 24f81f7e9..1bde59725 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, log=
ger, handle
 __config_regexp__  =3D re.compile( r"""
     ^
     (?P<exp>export\s+)?
-    (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
+    (?P<var>[a-zA-Z0-9\-_+.${}/~:]*?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
=20
     \s* (
@@ -166,6 +166,8 @@ def feeder(lineno, s, fn, statements, baseconfig=3DFa=
lse, conffile=3DTrue):
     m =3D __config_regexp__.match(s)
     if m:
         groupd =3D m.groupdict()
+        if groupd['var'] =3D=3D "":
+            raise ParseError("Empty variable name in assignment: '%s'" %=
 s, fn, lineno);
         ast.handleData(statements, fn, lineno, groupd)
         return
=20
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index cb60af364..7598d5904 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -443,3 +443,23 @@ include \\
                 in_file.write("\n".join(lines))
                 in_file.flush()
             bb.parse.handle(recipename_closed, bb.data.createCopy(self.d=
))
+
+    special_character_assignment =3D """
+A+=3D"a"
+A+ =3D "b"
++ =3D "c"
+"""
+    ambigous_assignment =3D """
++=3D "d"
+"""
+    def test_parse_exports(self):
+        f =3D self.parsehelper(self.special_character_assignment)
+        d =3D bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), " a")
+        self.assertEqual(d.getVar("A+"), "b")
+        self.assertEqual(d.getVar("+"), "c")
+
+        f =3D self.parsehelper(self.ambigous_assignment)
+        with self.assertRaises(bb.parse.ParseError) as error:
+            bb.parse.handle(f.name, self.d)
+        self.assertIn("Empty variable name in assignment", str(error.exc=
eption))
--=20
2.34.1



