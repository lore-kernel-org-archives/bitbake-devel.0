Return-Path: <antoningodard@pm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A196FC25B78
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 01:53:18 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by mx.groups.io with SMTP id smtpd.web11.5173.1715651593382705176
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 18:53:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pm.me header.s=protonmail3 header.b=IXwGz0qy;
 spf=pass (domain: pm.me, ip: 185.70.43.16, mailfrom: antoningodard@pm.me)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1715651591; x=1715910791;
	bh=WbeF5GQcbqBqzjEyYWwOjthnka3HSaDB8SnLAw9dFbI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IXwGz0qyuqXDZ68vbDv2yG3xGFIQ6zf1F1F2OsjA4j+NIrCne9Hf9eTde77MLV+hK
	 JxaaxCDsh8SsJi0pJxPTAd2JWCr7uy2Am8AEM9jB5fYWB4Kmm+YdZPm9SpcD/g1/Rf
	 j+rkLVK0UTfDZ//Qzj6hKeAwv+vnee/ONoazcujVO5Oj9gxStgnqr6762jvceeheCH
	 nTT00oNsF5trzEz7R29RCBm7zadhhGemwx7yEO7vkQGKVbHEYu1iJxhKQ8AtVuJpJQ
	 Mmmwjbo060NuIrzeWTA77uPxyLWJlES4+eM5nJOEnz5F6I9xOY4gVePKKXDxFevy9q
	 Rtv6Ep5wXtqPQ==
Date: Tue, 14 May 2024 01:53:06 +0000
To: bitbake-devel@lists.openembedded.org
From: Antonin Godard <antoningodard@pm.me>
Cc: Antonin Godard <antoningodard@pm.me>
Subject: [PATCH 1/3] codeparser: support shell substitutions in quotes
Message-ID: <20240514015234.67318-2-antoningodard@pm.me>
In-Reply-To: <20240514015234.67318-1-antoningodard@pm.me>
References: <20240514015234.67318-1-antoningodard@pm.me>
Feedback-ID: 17651652:user:proton
X-Pm-Message-ID: 9edd3f9f6a3556c4388c095d1aedaa79b1f21fee
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 01:53:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16212

The current shell substitution mechanism only works without quotes. For
example:

  var1=3D$(cmd1 ...)

Will work and add `cmd1` to the correspondind `run.do_*` file.

However, although quite common, this syntax is not supported:

  var1=3D"$(cmd1 ...)"

This commit adds this feature by adding a step to process_words() to
check whether we are dealing with quotes first, and by iterating on
what's between them to detect new shell substitution candidates. These
candidates are tested and parsed like before in the next step. The
original `part` being part of the candidates means the syntax
var1=3D$(cmd1 ...) is still valid.

Signed-off-by: Antonin Godard <antoningodard@pm.me>
---
 lib/bb/codeparser.py | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 2e8b7ced3..c613806c8 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -490,13 +490,28 @@ class ShellParser():
                 if not isinstance(part, list):
                     continue
=20
-                if part[0] in ('`', '$('):
-                    command =3D pyshlex.wordtree_as_string(part[1:-1])
-                    self._parse_shell(command)
-
-                    if word[0] in ("cmd_name", "cmd_word"):
-                        if word in words:
-                            words.remove(word)
+                candidates =3D [part]
+
+                # If command is of type:
+                #
+                #   var=3D"... $(cmd [...]) ..."
+                #
+                # Then iterate on what's between the quotes and if we find=
 a
+                # list, make that what we check for below.
+                if len(part) >=3D 3 and part[0] =3D=3D '"':
+                    for p in part[1:-1]:
+                        if isinstance(p, list):
+                            candidates.append(p)
+
+                for candidate in candidates:
+                    if len(candidate) >=3D 2:
+                        if candidate[0] in ('`', '$('):
+                            command =3D pyshlex.wordtree_as_string(candida=
te[1:-1])
+                            self._parse_shell(command)
+
+                            if word[0] in ("cmd_name", "cmd_word"):
+                                if word in words:
+                                    words.remove(word)
=20
         usetoken =3D False
         for word in words:
--=20
2.44.0



