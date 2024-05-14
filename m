Return-Path: <antoningodard@pm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B1C25B78
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 01:53:28 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by mx.groups.io with SMTP id smtpd.web10.5147.1715651606498955040
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 18:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pm.me header.s=protonmail3 header.b=IokB8CO0;
 spf=pass (domain: pm.me, ip: 185.70.43.22, mailfrom: antoningodard@pm.me)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1715651604; x=1715910804;
	bh=e4ID/A/jz5V+/0zM76Kx/KPz3oJql3KB3ClRo+Pmi4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IokB8CO0AVEuajlPRWcx4WgXPWW+Xxil+mooe6aagijqB8PxRR+hFyEQPygKFTshU
	 yF/YjgCyn41cHtsuxsSVSPu0FUo53w/cknsvdDeDWxrWnKDiN0eZZKEupncMfAsL52
	 i1Wq71reDpFckJVZxvi4xy4zZ9FN8xEj5dE+oGu8kaxPqJZ5vD29duvweuou3UmJmi
	 vllCo5pGfgJI23iCX7OluAp9U0rF6RBHqxGzhtVlgq1yn1ZaAzspNNwIrjtAe7VOQz
	 C+Rs8SLgPWIgAqcBKO4uSIS52M4woNmMtJ2Ez0lpugCr/azXj3DdDNfDQmMIs/Gx5o
	 Zch3YLkbzNO2g==
Date: Tue, 14 May 2024 01:53:21 +0000
To: bitbake-devel@lists.openembedded.org
From: Antonin Godard <antoningodard@pm.me>
Cc: Antonin Godard <antoningodard@pm.me>
Subject: [PATCH 3/3] tests.codeparser: add tests for shell expansions
Message-ID: <20240514015234.67318-4-antoningodard@pm.me>
In-Reply-To: <20240514015234.67318-1-antoningodard@pm.me>
References: <20240514015234.67318-1-antoningodard@pm.me>
Feedback-ID: 17651652:user:proton
X-Pm-Message-ID: 920e3077656712ea94219c6d7cb9ed27e251b181
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 01:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16214

Tests quotes around `` and $() expansions, nested and multiple
expansions, and that escaped quotes are treated as characters by the
parser.

Signed-off-by: Antonin Godard <antoningodard@pm.me>
---
 lib/bb/tests/codeparser.py | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index f6585fb3a..c0d1362a0 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -106,6 +106,46 @@ ${D}${libdir}/pkgconfig/*.pc
         self.parseExpression("foo=3D$(echo bar)")
         self.assertExecs(set(["echo"]))
=20
+    def test_assign_subshell_expansion_quotes(self):
+        self.parseExpression('foo=3D"$(echo bar)"')
+        self.assertExecs(set(["echo"]))
+
+    def test_assign_subshell_expansion_nested(self):
+        self.parseExpression('foo=3D"$(func1 "$(func2 bar$(func3))")"')
+        self.assertExecs(set(["func1", "func2", "func3"]))
+
+    def test_assign_subshell_expansion_multiple(self):
+        self.parseExpression('foo=3D"$(func1 "$(func2)") $(func3)"')
+        self.assertExecs(set(["func1", "func2", "func3"]))
+
+    def test_assign_subshell_expansion_escaped_quotes(self):
+        self.parseExpression('foo=3D"\\"fo\\"o$(func1)"')
+        self.assertExecs(set(["func1"]))
+
+    def test_assign_subshell_expansion_empty(self):
+        self.parseExpression('foo=3D"bar$()foo"')
+        self.assertExecs(set())
+
+    def test_assign_subshell_backticks(self):
+        self.parseExpression("foo=3D`echo bar`")
+        self.assertExecs(set(["echo"]))
+
+    def test_assign_subshell_backticks_quotes(self):
+        self.parseExpression('foo=3D"`echo bar`"')
+        self.assertExecs(set(["echo"]))
+
+    def test_assign_subshell_backticks_multiple(self):
+        self.parseExpression('foo=3D"`func1 bar` `func2`"')
+        self.assertExecs(set(["func1", "func2"]))
+
+    def test_assign_subshell_backticks_escaped_quotes(self):
+        self.parseExpression('foo=3D"\\"fo\\"o`func1`"')
+        self.assertExecs(set(["func1"]))
+
+    def test_assign_subshell_backticks_empty(self):
+        self.parseExpression('foo=3D"bar``foo"')
+        self.assertExecs(set())
+
     def test_shell_unexpanded(self):
         self.setEmptyVars(["QT_BASE_NAME"])
         self.parseExpression('echo "${QT_BASE_NAME}"')
--=20
2.44.0



