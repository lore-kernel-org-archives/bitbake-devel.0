Return-Path: <n.merinov@inango-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EAFC0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:55:48 +0000 (UTC)
Received: from ksserv.inango.com (ksserv.inango.com [31.154.135.10])
 by mx.groups.io with SMTP id smtpd.web11.20481.1738176944382422493
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jan 2025 10:55:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@inango-systems.com header.s=45A440E0-D841-11E8-B985-5FCC721607E0 header.b=nsHj6/Z6;
 spf=pass (domain: inango-systems.com, ip: 31.154.135.10, mailfrom: n.merinov@inango-systems.com)
Received: from ksserv.inango.com (localhost [127.0.0.1])
	by ksserv.inango.com (Proxmox) with ESMTP id 6CFC82AC06
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 20:55:41 +0200 (IST)
Received: from mail.inango-systems.com (unknown [172.31.254.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ksserv.inango.com (Proxmox) with ESMTPS id C6F872ABAC
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 20:55:40 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 60195108055D;
	Wed, 29 Jan 2025 20:55:39 +0200 (IST)
Authentication-Results: mail.inango-systems.com (amavis);
 dkim=pass (2048-bit key) header.d=inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4HftdY7BeXNI; Wed, 29 Jan 2025 20:55:39 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inango-systems.com (Postfix) with ESMTP id 364DB1080565;
	Wed, 29 Jan 2025 20:55:39 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-systems.com 364DB1080565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
	s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1738176939;
	bh=mQUDZ1olZiSjwLGtPalgj3itzSYEfMN93Vy+R4swAuU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nsHj6/Z6rTR00Z16gVauEDe6nNKhtIg9nIjK36yDgijQa3eK7VRxyyivnG3nM1AZ1
	 EuDnM/A4TPyxQMNwGbHw70YpzGLW0VxnKPQ7ct7n6uWqJwi6LgVo4gD2dkSOg3Ibot
	 WFaA7II608Sfnb4j1rk7j5C2KDzb83E0RMR+3mZKxiMqHr8Fyym8JADB4u1A1obl9g
	 WTqEwm3blEXp5+tvJOxjLr9fPyYb3E3qvZtpgwPnPreWHUe6Mf8eqQVkN2O8O72vbC
	 A9qs8HGiPx+hoIZlShys9bufyr7tkFie2enPeU7f5KIW7RH/AZ85O9j42lfGznA6jQ
	 fpmQDjdDIyJpQ==
X-Virus-Scanned: amavis at inango-systems.com
Received: from mail.inango-systems.com ([127.0.0.1])
 by localhost (mail.inango-systems.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id AFw3neN8epGQ; Wed, 29 Jan 2025 20:55:39 +0200 (IST)
Received: from wksv-012.inango.loc (ksserv.inango.com [31.154.135.10])
	by mail.inango-systems.com (Postfix) with ESMTPSA id C052D108055D;
	Wed, 29 Jan 2025 20:55:38 +0200 (IST)
From: Nikolai Merinov <n.merinov@inango-systems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Nikolai Merinov <n.merinov@inango-systems.com>
Subject: [PATCH] parse: Forbid ambiguous assignments to ${.}, ${+}, and ${:} variables
Date: Wed, 29 Jan 2025 20:55:31 +0200
Message-Id: <20250129185531.3752682-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jan 2025 18:55:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17119

Old code that parse variable names in assignment commands behave differnt=
ly for
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
 lib/bb/parse/parse_py/ConfHandler.py                       | 2 +-
 lib/toaster/toastermain/management/commands/buildimport.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py=
/ConfHandler.py
index 24f81f7e9..bdac66004 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, log=
ger, handle
 __config_regexp__  =3D re.compile( r"""
     ^
     (?P<exp>export\s+)?
-    (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
+    (?P<var>([a-zA-Z0-9\-_${}/~] | [+.:](?!=3D))+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
=20
     \s* (
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b=
/lib/toaster/toastermain/management/commands/buildimport.py
index f7139aa04..37d27a445 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -60,7 +60,7 @@ def _log(msg):
 __config_regexp__  =3D re.compile( r"""
     ^
     (?P<exp>export\s+)?
-    (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
+    (?P<var>([a-zA-Z0-9\-_${}/~] | [.+](?!=3D))+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
=20
     \s* (
--=20
2.34.1



