Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web12.8635.1612035885712442492
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Jan 2021 11:44:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=iQJOB7EC;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id p21so17284469lfu.11
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Jan 2021 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkfCplTJYKTzgrQu7uxtpexS6pHkk8fVOFxm1GTnEXw=;
        b=iQJOB7EChKc8B/OXCedexJOsRcOWVWPLVNWiAPIa/J5o1PVd4n/COSXxKXt0L7L4q7
         +29vbh6apmNEFB7BTlRDsT/ORObIyf4k25DePo4/2LuZiluUgMOMdNP19Ipxyo9XRUUd
         hwrKjjnAfdVx7H243hzPDmLxcRVU1r9KHZSavDcK1UBIT+nsjAXxFfxEZzuDiC98xZ4r
         WAAOv/ROO33Vg2v1o0hmZQHhExAYzsyANC9E/GnFzN4efUBrxpL8LgNx+zEM82kiXZ4K
         cluCFzmnhpkHjO778UmOmp7JEiMOPTInztbwd1aG6Zr92oMzgvTCBT4260OIiySshj8w
         IMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkfCplTJYKTzgrQu7uxtpexS6pHkk8fVOFxm1GTnEXw=;
        b=YvzvNCVTjqGY+e500EFcJblaS8oaanZvaM1ss0jgJ2pDJ/G1/DjoG+JPRMy5JhAoLH
         MRTqCZWIr59qgN2st+Hg3rQAAuLEMupHsfCLGMDVof6lT/E/ylx6Lj17Lwb+k6x0bVRy
         TacAxQqFq0gK+fSlY77dUF0uqOAUYo/IaxQpmdNKUeQqG4MRcAToyFidzHtIdEvHJaIQ
         YGkuP6dE6tLIRs69atk+MnLbgfGBgFiv0B9Cf2Dt/Wo6sHTGdiR5oXAs2YH89/Y/bDFf
         uZjOMT79Im0sw0wHHoqdZq84WuBMJBOInkeOqMhQbpS6DB/6e85nBVNoiynyu9FqxBT2
         uHFg==
X-Gm-Message-State: AOAM531Xbs1Q/gjc7HqT9CplnDbZ/b2ZY/8yW1RoWpiNp2Nc5o5iAr5P
	6j1NJtaL8uhvi/71uYH4NhW9mwoWkLLQdg==
X-Google-Smtp-Source: ABdhPJxLDMJBXzNuKaztfiaov72F4pwGAql/4f5BFPqPNWX8iG8rj4+DhxNxFpIAUvhoaWJholGvtw==
X-Received: by 2002:a19:691b:: with SMTP id e27mr5068490lfc.84.1612035883524;
        Sat, 30 Jan 2021 11:44:43 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id b5sm2438438lfi.3.2021.01.30.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:44:42 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v2] lib/bb: Don't treat mc recipe (Midnight Commander) as a multiconfig target
Date: Sat, 30 Jan 2021 20:47:12 +0100
Message-Id: <20210130194712.1331960-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we run `devtool build mc` recipe's task dependencies are expanded
to "mc:do_populate_sysroot" where "mc" name is treated as multiconfig
and "do_package_sysroot" as multiconfigname.

| ERROR: Multiconfig dependency mc:do_populate_sysroot depends on
| nonexistent multiconfig configuration named do_populate_sysroot

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- skipped change in showEnvironment() to keep "bitbake -e" working
--- replaced == 2 with >= to fix selftests, since in tests there might be more colons in multiconfig target name. tests are passing now
--- fix paths - use bitbake repo, not poky
---
 lib/bb/cache.py    | 4 ++--
 lib/bb/cooker.py   | 4 ++--
 lib/bb/runqueue.py | 6 +++---
 lib/bb/siggen.py   | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 36270d00..c85effd6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -238,7 +238,7 @@ def virtualfn2realfn(virtualfn):
     Convert a virtual file name to a real one + the associated subclass keyword
     """
     mc = ""
-    if virtualfn.startswith('mc:'):
+    if virtualfn.startswith('mc:') and virtualfn.count(':') >= 2:
         elems = virtualfn.split(':')
         mc = elems[1]
         virtualfn = ":".join(elems[2:])
@@ -268,7 +268,7 @@ def variant2virtual(realfn, variant):
     """
     if variant == "":
         return realfn
-    if variant.startswith("mc:"):
+    if variant.startswith("mc:") and variant.count(':') >= 2:
         elems = variant.split(":")
         if elems[2]:
             return "mc:" + elems[1] + ":virtual:" + ":".join(elems[2:]) + ":" + realfn
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 83cfee7f..4446addc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -614,7 +614,7 @@ class BBCooker:
         # Replace string such as "mc:*:bash"
         # into "mc:A:bash mc:B:bash bash"
         for k in targetlist:
-            if k.startswith("mc:"):
+            if k.startswith("mc:") and k.count(':') >= 2:
                 if wildcard:
                     bb.fatal('multiconfig conflict')
                 if k.split(":")[1] == "*":
@@ -648,7 +648,7 @@ class BBCooker:
         for k in fulltargetlist:
             origk = k
             mc = ""
-            if k.startswith("mc:"):
+            if k.startswith("mc:") and k.count(':') >= 2:
                 mc = k.split(":")[1]
                 k = ":".join(k.split(":")[2:])
             ktask = task
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 28bdadb4..7d493eb4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -38,7 +38,7 @@ def taskname_from_tid(tid):
     return tid.rsplit(":", 1)[1]
 
 def mc_from_tid(tid):
-    if tid.startswith('mc:'):
+    if tid.startswith('mc:') and tid.count(':') >= 2:
         return tid.split(':')[1]
     return ""
 
@@ -47,13 +47,13 @@ def split_tid(tid):
     return (mc, fn, taskname)
 
 def split_mc(n):
-    if n.startswith("mc:"):
+    if n.startswith("mc:") and n.count(':') >= 2:
         _, mc, n = n.split(":", 2)
         return (mc, n)
     return ('', n)
 
 def split_tid_mcfn(tid):
-    if tid.startswith('mc:'):
+    if tid.startswith('mc:') and tid.count(':') >= 2:
         elems = tid.split(':')
         mc = elems[1]
         fn = ":".join(elems[2:-1])
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0ac39524..e0e03318 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -748,7 +748,7 @@ def clean_basepath(basepath):
     if basepath[0] == '/':
         return cleaned
 
-    if basepath.startswith("mc:"):
+    if basepath.startswith("mc:") and basepath.count(':') >= 2:
         mc, mc_name, basepath = basepath.split(":", 2)
         mc_suffix = ':mc:' + mc_name
     else:
-- 
2.30.0

