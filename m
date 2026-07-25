Return-Path: <zizuzacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC60C531C9
	for <webhook@archiver.kernel.org>; Sat, 25 Jul 2026 14:30:14 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.260.1784989810718328479
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jul 2026 07:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HDJ4Urnb;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: zizuzacker@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca80d708489so916810a12.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784989810; x=1785594610; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVSBmN6aUz7nQ6RXgq0TXfcW2Ftw0KUnER98RrK9+Hs=;
        b=HDJ4UrnbLIvAAKc1JLp5A7jPqO7LI9N+xj/dMjlPZcm+IXYwPpEVsy1wmCdOfoVkkh
         QbJVJywItPx76omEYVaVxdh4LnDotg3iIHNIYMCKAE5xHORLIqq9WQTS1GZwwtbaQ2za
         rWPI14j1K1E5R/TigCNtNk5m/6eyprJ6wLYf8Q0a4HQrDvZLMrprCrE37WEvHS7FCe7b
         TMXhFg3XkG3+pPvscKAX463LZXh2IgTww9Pez23/1lWQTUdOgNi5ggoSfmF/e99VRWBx
         PWucKEB917FCpsG931QJ+yN78rO2LjDbsrWGrIOgLLwyjK522etdypW7NOXRTQcrFP6E
         pTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989810; x=1785594610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVSBmN6aUz7nQ6RXgq0TXfcW2Ftw0KUnER98RrK9+Hs=;
        b=Drx5RmTnENKaLJHP+nggInzAeQ/D2cMfMg9KCLa5r5PLocVXpuzRHvJ/l6ROxwUeZ6
         1O7oDgcTudFsc6AUfyfvdjYwIL9JgfcrMvYdTS0ixELcRefqBzrYtXe7KcQue8twfLYO
         sW5A+rZZnRUti7dLugN3/Q5CRfFD5JLojX2y8Ord/RPMXArZGHf8vFisZ58b41qLB3JX
         EBYKHHcF1Ah/dkWP6A/3AHlUsroJBe+JiiRCE4M2YJ5SWXjyAFguQJx98TGUPRyFnVa/
         m/hx/wPe5aC9JNnHYU1zKAsM4SbxTb2OVWaFuuGTvQUCZgSUT/nvTWri/rhjOdu5ix/O
         /+9g==
X-Gm-Message-State: AOJu0Yx6FjhSTIZkcdiCSpPJk5KXKJwFEUU1YzI8rL2XcXZqbkYslQKt
	UPUAQGD4Pqw6K+Xzqz9ssJNqgv26I/KeUFWl8AM97RxuYD0QHkkvjOs+uAlNQjcO
X-Gm-Gg: AR+sD12AuKe4ae2427+oGtmOo0I4iy+fD338xLLRdyeUEe7pc/dOgms2gN2yz17JHNW
	nHsXsBRBE0CzcUyFpfiVKqcoYyBqFrxnFULdsAAqvlFK49TSDKxSHCnqLuGSglBLJBFosV8Peox
	ESQeFKIirYSX9WQL1YEg4ReO+gL6dYMlS53j8hEAi7ULnXkfFdxhMAjxvlYLGLT5hvXPz71oh4i
	16rL1XQT7/ApLoPGsYXC5y4A81Q9eYwNFH1+Dz78qr6wWxFqzLmOt2tKj3EJ21KodfI5ezKyxDy
	Z2zwe7VO4btaMdJu9AK0MKKUUEg0420lCk6HH2CP/BK3r3RS/e0vDB/hUwGbtyYjQbhqqnC3qIi
	qkGPNXnPHQUM0SSnNTorrw2K4MEA0UcygQTfYJfdmvRgwaKEaWZnjnwiW9giW1aZ0c6TN5g==
X-Received: by 2002:a05:6a20:2d10:b0:3c4:320a:737 with SMTP id adf61e73a8af0-3c67242ad29mr4922071637.16.1784989809904;
        Sat, 25 Jul 2026 07:30:09 -0700 (PDT)
Received: from ltu.. ([2001:ee0:4041:efc5:bfb0:104e:8f:340f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm16909480eec.31.2026.07.25.07.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:30:09 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: zizuzacker@gmail.com
Subject: [PATCH 1/1] data_smart: fix operations lost when an override name contains a variable
Date: Sat, 25 Jul 2026 21:30:02 +0700
Message-Id: <20260725143002.23596-2-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260725143002.23596-1-zizuzacker@gmail.com>
References: <20260725143002.23596-1-zizuzacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 14:30:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19858

An operation whose override name needs key expansion is silently dropped:

    RDEPENDS:${PN}:append:pn-foo-${MACHINE} = " bar"

renameVar() rebuilds the dependent override keys with a plain string
replace, so renaming RDEPENDS:${PN} leaves the append attached to
RDEPENDS:foo:append:pn-foo-${MACHINE}, which never matches an active
override. expandKeys() cannot fix that up afterwards either, as it works
from a list of keys collected before any renaming happened.

Expand the derived name before renaming it. Only do so once newkey is
itself expanded, otherwise expandKeys() has still to rename newkey and
handles the dependent keys along with it.

Add regression tests for both cases.

Fixes [YOCTO #14867]

Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
---
 lib/bb/data_smart.py | 11 +++++++++--
 lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 9961269a3..5738aff95 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -697,8 +697,15 @@ class DataSmart(MutableMapping):
             found = True
             self.overridedata[newkey] = []
             for (v, o) in self.overridedata[key]:
-                self.overridedata[newkey].append([v.replace(key, newkey), o])
-                self.renameVar(v, v.replace(key, newkey))
+                newv = v.replace(key, newkey)
+                # The derived name may still hold a variable reference which
+                # expandKeys() will never revisit, so expand it here. Only once
+                # newkey is expanded though, otherwise expandKeys() has still to
+                # rename newkey and handles the dependent keys along with it.
+                if '${' in newv and '${' not in newkey:
+                    newv = self.expand(newv)
+                self.overridedata[newkey].append([newv, o])
+                self.renameVar(v, newv)
 
         if not found:
             # No variable to rename so not worth the work in writing extra
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index fd690a9e2..5ef159eae 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -406,6 +406,31 @@ class TestOverrides(unittest.TestCase):
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("VERSION"), "2")
 
+    # Test an :append whose override name is only resolved by key expansion
+    def test_append_in_expanded_override(self):
+        self.d.setVar("MACHINE", "qemux86")
+        self.d.setVar("PN", "gizmo")
+        self.d.setVar("OVERRIDES", "gizmo:pn-gizmo-qemux86")
+        self.d.setVar("TEST:${PN}", "base")
+        self.d.setVar("TEST:${PN}:append:pn-gizmo-${MACHINE}", " appended")
+        bb.data.expandKeys(self.d)
+        self.assertEqual(self.d.getVar("TEST"), "base appended")
+
+    # Test renaming to a key which is itself not expanded yet, as native.bbclass
+    # does. The dependent override keys must be left for expandKeys() to rename.
+    def test_rename_to_unexpanded_key_with_override(self):
+        self.d.setVar("BPN", "gizmo")
+        self.d.setVar("PN", "gizmo-native")
+        self.d.setVar("OVERRIDES", "class-target")
+        self.d.setVar("TEST:${PN}-lib", "base")
+        self.d.setVar("TEST:${PN}-lib:class-target", "target")
+        with LogRecord() as logs:
+            self.d.renameVar("TEST:${PN}-lib", "TEST:${BPN}-lib-native")
+            bb.data.expandKeys(self.d)
+            self.assertFalse(logContains("renameVar with equivalent keys", logs))
+            self.assertFalse(logContains("replaces original key", logs))
+        self.assertEqual(self.d.getVar("TEST:gizmo-lib-native"), "target")
+
     def test_remove_with_override(self):
         self.d.setVar("TEST:bar", "testvalue2")
         self.d.setVar("TEST:some_val", "testvalue3 testvalue5")
-- 
2.34.1


