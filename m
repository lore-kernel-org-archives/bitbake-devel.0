Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E57CCF2D4
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 02:04:37 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25963.1792375469165315750
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Oct 2026 19:04:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Lwuc9w9a;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e96502e447so11404535ad.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Oct 2026 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375468; x=1792980268; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GS1jVCqQuMQJ94TQGssyjvG+JMsu2if5ZZReokvw/lw=;
        b=Lwuc9w9aglBvMBs/GQQ05e/3QPdLtA5C5IVcPk11aDFSGD8zi36by4BnG7nryLKZGo
         YPc6Kb8FnhuQe+ngznZQP5qv3a0WmvLQsV/33ATeW3/rxhrF6swyFsG25dJ3tGhUHX2/
         t66vrgBJ8fCQZ8pCeZsXJDmsYDQwIhKkGCIUD+inz6nDx/QilGnwnCwhhyi2NJooy/tF
         ACZmkWZLuwOYgPF+SqmYa/dogePHlMgZH2NAtM8g1DT+5Hao51+4yEu/J6t+NLMVk5yy
         i1U1MH7zHVURNh6lJpclhdysU3JoKbQTjE+OvTT044rlQ+TR+fYw+OO/MJOtsov3P8dr
         QTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375468; x=1792980268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS1jVCqQuMQJ94TQGssyjvG+JMsu2if5ZZReokvw/lw=;
        b=JgZsEew0f1fWvqlyrZt1uN7OdvqY1tY86s1uk4c/uuMEQNqpJb92VlMdLGzto6UwrW
         yncxxslhaPCQEYEUKQe38EDM1nFMl8We0VSazTjXKhOAtYDC+NDqNPUIWXamM/gy9/Lk
         WlFG/4q+r9VPOFQ839muzN6HXk8jgxtb8bGy+Cu3s4cAxvSI2g9PQvSchDjiDOOgYWsm
         HWZEh8qHIO/3qP99hmMTy2zLdd69zmyU8x+IVEv2Q716gWIxoNfA1eIab8ekOTfSyTgm
         ksSCvtUIbp4H5QlkVK6adIyuEUveko5CzkI3Chvm+5RA//2WxjHKO4HEd4T6LKvYRi6L
         3LuA==
X-Gm-Message-State: AFq9FYKFLpx5FdQ7rD0f4NxQeaW5/PIsR3W2QK8KgAt0VAQw5onDcyKN
	+eZEKbgyRwe/kppDcRwtjCH6ex3Db2yBgUmjul+AYBLkZfrLfhnloXEk0ymJOgrm
X-Gm-Gg: AYBFou0WNpt6Cvwdnms1PJ+Wx4kA43FEBoWLWhi2mI7kdFfCiTM2GKLK3So7RVATIz2
	x3mLY9zCqOZJ8fjHCqpJxqmJViIMQULfS3u0YpA3A/gEforYz/pVRqVUJaxwOwgD4C4SGE5igiX
	SNDmstxm9FiErUKalqDA9Kv17ugC37kyf5aNJ0NvTB6hACF1RTt5evm2LRnVLaAkl+7t5FImIPB
	zUSQ8q6sqTIK5t39C6OnXBOhS/94k0dwlxdxoJLyHVIbpcSLDdg39rGyLYkloDnz8dRHYj/ImaM
	HZUcWblX7rj36U54PZmhKzdHPjCoOx3X5lkrNo/+ymxRFiVTF4PYHoj9/sDmesoBkFNioaTyHAG
	Jn9Edn8AK1LvjoqBW3CPjflk3mlfMVgPZZpSyOwfgvbEwec74iPINRVaQh3wUk9UIWIgoAGhYQ5
	Byo9NzkWz1nRstajMWwSkvzRQAIz7iJN6O0MSvh+waQBue7M8tUJvT/GBuroWT46ZMnWTEsWW7+
	lroJOb9apGiXK8f3D9p8PK9K2cn0So=
X-Received: by 2002:a17:903:4b48:b0:2e9:734c:5026 with SMTP id d9443c01a7336-2e9a6d403b8mr50617795ad.22.1792375468393;
        Sun, 18 Oct 2026 19:04:28 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834ef9sm34124935ad.42.2026.10.18.19.04.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 19:04:27 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] parse: only search each BBPATH directory once in include_all
Date: Sun, 18 Oct 2026 19:04:22 -0700
Message-ID: <20261019020422.14365-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Oct 2026 02:04:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20360

If a directory appears in BBPATH more than once, include_all includes
the file from it again, applying it twice and warning "Duplicate
inclusion". The layer index hits this because the core layer is in its
initial BBPATH and appended again by layer.conf. Skip directories
already searched, and add a test for it.

This fixes one source of the warnings in [YOCTO #16451]; the duplicate
inclusion of defaultsetup.conf reported there has a separate cause.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/bb/parse/ast.py   |  3 ++-
 lib/bb/tests/parse.py | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 5f2aaadfb..d5d53a7c7 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -55,7 +55,8 @@ class IncludeAllNode(AstNode):
         s = data.expand(self.what_file)
         logger.debug2("CONF %s:%s: including %s", self.filename, self.lineno, s)
 
-        for path in data.getVar("BBPATH").split(":"):
+        # A directory listed more than once in BBPATH is only searched once
+        for path in dict.fromkeys(data.getVar("BBPATH").split(":")):
             bb.parse.ConfHandler.include(self.filename, os.path.join(path, s), self.lineno, data, False)
 
 class ExportNode(AstNode):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 6ac2137e0..cd8f02388 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -511,6 +511,26 @@ EXTRA_OECONF:append = " foobar"
             test_helper("include_all some.conf", " bar foo")
             test_helper("include_all some3.conf", " foobar")
 
+    def test_include_all_duplicate_bbpath(self):
+        # A directory listed more than once in BBPATH is only searched once
+        with tempfile.TemporaryDirectory() as tempdir:
+            os.makedirs(tempdir + "/conf1")
+            os.makedirs(tempdir + "/conf2")
+            with open(tempdir + "/conf1/some.conf", "w") as f:
+                f.write(self.someconf1)
+            with open(tempdir + "/conf2/some.conf", "w") as f:
+                f.write(self.someconf2)
+
+            self.d.setVar("BBPATH", ":".join([tempdir + "/conf1", tempdir + "/conf2", tempdir + "/conf1"]))
+
+            with self.parsehelper("include_all some.conf") as f:
+                with self.assertLogs("BitBake.Parsing", level="WARNING") as logs:
+                    d = bb.parse.handle(f.name, bb.data.createCopy(self.d))['']
+                    # assertLogs fails if nothing is logged at all
+                    bb.parse.logger.warning("parse done")
+            self.assertEqual(d.getVar("EXTRA_OECONF"), " foo bar")
+            self.assertEqual(logs.output, ["WARNING:BitBake.Parsing:parse done"])
+
     def test_file_variables(self):
         # Tests the values of FILE and __BB_RECIPE_FILE in different
         # combinations of bbappends, includes, and inherits
-- 
2.56.0


