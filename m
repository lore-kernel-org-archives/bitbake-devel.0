Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.17702.1586095202316883135
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 07:00:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EG0Eo71p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id p10so14192661wrt.6
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0K2+O0A2tmK0Ihl2hA8iLw2j3Aov4dqmVYUko6D4/E=;
        b=EG0Eo71pvtmPs2P+4OCkakHEYqBG6miLA2Mu7R/OnS+5U6F1nn0cwjo47vS82V5FFm
         voL3seobths74f/Wkpl1nZV7z8gahlEItMUojEq3N8fiWjwQkyrQ7O+WmiiP1atIWEgE
         Un/oFuFTyCSZAU0UJpLsNWYNwK/8LRaSIy+lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0K2+O0A2tmK0Ihl2hA8iLw2j3Aov4dqmVYUko6D4/E=;
        b=ScVSTLJ/9/KCUTS8vBa9+tUdPTfRXZnjw9COj5jI/r/qjZgMkILWx+Zo+nRqKBQlza
         zATT/LH2dKOzEZR2SnZ+KXVD1q146Dx+kqFlEht+bQ3tG/P33Et/yUSmQQMqMih9Kl9n
         1hwvrQnsckpaX+oKC5rvsaQglTzQ/HbyNIdGyc0yBMsTUPDOr8rALH6ywK96AzOoJgV8
         ED49ign5fHbK1PBT4a7Bt1TUFey1hSpUpRw7WxQcAQsTQGiKn2kudVIOBl75Koyzuts8
         Be69myJ+dWCyc22TyTBKYIiWY8+6y6G8mA48Sz0K0dZLWYONDUlDeTP6ihV1iLYQiL5R
         bNKw==
X-Gm-Message-State: AGi0PuYLPxYK82Z1z3nz7SHucVYPuE2QGTwBokeVvock/HZ2nD7GpmXm
	n8Z/uhBbASOcA+AQH3oBWngN/DG80sU=
X-Google-Smtp-Source: APiQypIckJBmMWrkQomIZHktUhMYRa6ppVM/lvtStsF9AIZYUS99yL7OiqKwFINmDetjKAYxP/RBvQ==
X-Received: by 2002:adf:fc10:: with SMTP id i16mr3187429wrr.354.1586095200094;
        Sun, 05 Apr 2020 07:00:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id v186sm20136545wme.24.2020.04.05.06.59.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 06:59:59 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data/siggen: Don't expand ignored variables
Date: Sun,  5 Apr 2020 14:59:58 +0100
Message-Id: <20200405135958.235528-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a variable is in the signature whitelist, we'd currently expand
it, then later ignore the data. This is problemtic for code which
has effects when expanded, recently source date epoch in OE-Core
for example.

We don't actually need to do this, if we pass the whitelist into
the earlier function it can avoid the expansion. This also also
give a small performance boost since we avoid running code in some
cases.

[YOCTO #13581]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 4 ++--
 lib/bb/siggen.py     | 2 +-
 lib/bb/tests/data.py | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 6dc02172cb..b0683c5180 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -365,7 +365,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), str(execs)))
     #d.setVarFlag(key, "vardeps", deps)
 
-def generate_dependencies(d):
+def generate_dependencies(d, whitelist):
 
     keys = set(key for key in d if not key.startswith("__"))
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
@@ -380,7 +380,7 @@ def generate_dependencies(d):
         newdeps = deps[task]
         seen = set()
         while newdeps:
-            nextdeps = newdeps
+            nextdeps = newdeps - whitelist
             seen |= nextdeps
             newdeps = set()
             for dep in nextdeps:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8bfc45235d..4c8d81c5da 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -146,7 +146,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def _build_data(self, fn, d):
 
         ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH") or '') == '1')
-        tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
+        tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d, self.basewhitelist)
 
         taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, self.basewhitelist, fn)
 
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 2b137706dd..5f195047de 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -476,7 +476,7 @@ class Contains(unittest.TestCase):
 class TaskHash(unittest.TestCase):
     def test_taskhashes(self):
         def gettask_bashhash(taskname, d):
-            tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
+            tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d, set())
             taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, set(), "somefile")
             bb.warn(str(lookupcache))
             return basehash["somefile:" + taskname]
-- 
2.25.1

