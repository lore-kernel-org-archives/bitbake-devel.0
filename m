Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33008.1792974065504416036
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Oct 2026 17:21:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sJuVtxF9;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5fb79ce82so15474605ad.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 Oct 2026 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792974065; x=1793578865; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sYl2GBiTstOQIyh+EMhb+71HeF1fpzebrNL+Zc6NzGA=;
        b=sJuVtxF9zBBpi1n1ule6YsW7gLEHRHJkOJa0slU+h3boGGGbodM/LV0eVRi3egrfP/
         rUDQ0VqIk1E/29Zj7v/Z+09VgzIm0I7z96fMle7YKUReOtn5vfFIxPepNGNHmIFo3sc7
         nPlX4W5zocCqzGj8ivIs/OibfryGXi00m19/BqqpmsCYOb+NLyB/4dGXYs90n1finRU+
         JxqKKvqm2OcxnaJM3raVUPYv/YNAM5G90oSb28k2bFecw9VJY1hDNRqJCW9dy/5WQDqc
         IczLFD4tKX2i8tLTOEAEQ3UYzfZeF5Yv1a1vAcfXGlZnETIUY5WOP+E/Hy+Hi0K9sISi
         woHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792974065; x=1793578865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sYl2GBiTstOQIyh+EMhb+71HeF1fpzebrNL+Zc6NzGA=;
        b=mcj5nblqIzL9niWFnzRPhVSrQm2w6pxrmRMy3xQ1vU3BzzCVhRt2LOHIsuiiOkVtqq
         +05QJZwW4ZWBwC+mHj6wcvPMbEqjoxSqvwSUzq3ZW9lTGZjzgDijvNjGDUzW3RC/wH32
         BAvvNyH1LCkQ9/oHu1DY6ssMRNdcYcDoBGJlQfMNNJJrxOVFxhAEDiJx8LyZWNkBzE5B
         IiuOH59D6FuTyQUFE+viqtbSomDLn4R9+i+ksMnmMCaOdOfsyjno1fu9KbbjCBqyLq9e
         hh9MeNDvSs6FyRlaG+XgCqBBuXReYk701zx02Zfi/kVrlZWYEVk6ARBRY8ukKXa8cxVd
         +ZAQ==
X-Gm-Message-State: AFq9FYKTYZRP+bcf8zLiU046hSwZNSp6fayutBgwRpynoHnNqUP9Ai9q
	LRzPMf9vctP7kOmZ71xtloYM0Ww3SsC+yPpdxLZ0c9Tt762cUHVGiWLuMtMdKG+r
X-Gm-Gg: AYBFou0bPSRLZ1xJtikkDBU02IFBCGUosyXeTyLUrtpbtu3YrIrHN8CLFY1YAPmWiy1
	95cehDQ6CnFnsbwv8lVE1muYli8vq5x/ygRK6+KoUxwqEzNGoDGbzWwX7G4uUAzNOkBt9t4guy7
	fWRS/JD4AyG0NvA6YJojLkuTujynCOCbcN4084/quPrAlD4ifCbh3RwdoW4PhUzb2LJTjAo3Klx
	fdJvtu0hW9FSiw6yE+77+P1LdjIZFYp++02ogRw3egcZSMSoXE+nEiReaGU7niaTaItDBdS9dIt
	wCj7Z1oqLFf0rAcw/8SqDU6EbRsxfrJjJw0iqtsnAhLg51vo5EYO8ntqfZHH00Pf465aE+WcKxJ
	Wgy7J6QMs3HPC1SQxwJRPzzGA8cHBgT6auZDEI208R0g3GaMGDtqdF7SbEukxhwIf/71Tzm80Dr
	XS04ex+0VFV5LsTcptOWIyLD8lvSDAbCXp0YAkxmlGFmf/Lv4S+Tx+KUaZUnKohU03okODuNLkG
	EiRbTevi72X8oV+kdY0zRu85P533srCqTYyKgkOYiMdEvm8Kp06dOGR2e4I2cGWsE0duGGEur9g
	XI020HprGso=
X-Received: by 2002:a17:903:2309:b0:2e9:4b32:fc66 with SMTP id d9443c01a7336-2ea9c6c3520mr43262395ad.10.1792974063908;
        Sun, 25 Oct 2026 17:21:03 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c296sm9358475ad.30.2026.10.25.17.21.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 17:21:01 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH v2 1/2] parse: only search each BBPATH directory once in include_all
Date: Sun, 25 Oct 2026 17:20:47 -0700
Message-ID: <20261026002048.86208-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019020422.14365-1-tim.orling@konsulko.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 26 Oct 2026 00:21:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20380
Content-Type: text/plain; charset="utf-8"

A directory listed twice in BBPATH made include_all apply the file from
it twice and warn "Duplicate inclusion". The layer index hits this with
the core layer in both its initial BBPATH and layer.conf. Skip
directories already searched. Fixes one source of the warnings in
[YOCTO #16451].

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

