Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web09.7235.1612029210881180348
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Jan 2021 09:53:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=NuzjNvxf;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id a12so17089679lfb.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Jan 2021 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxIhyBQ/wyFOLhPeEYs0WHU/R6dArTHK2k06xJSfSJQ=;
        b=NuzjNvxfpJY3PWtCQ/ahxNNf4qTh+fWTW0CWXSMCORB+llrCfRgbd7nLHp2awqz/po
         wPrFkCykX+cdTQxHeucpVbuoPJ/YBYHYYbYTQmzoyAXvyFfrZU9WAXWLudkyJaBQ4ENn
         AH+E7j7cJDYf7IQxJhQsMZXL2shMvbdEkioSTXegB/9T3FqJZw61zJfu1bSIJQPcHeja
         r5NRN1Z+P9aM2qB3UlkM5yk8RMMGfohVqUkRBN50WzYg4uawlTiwbjj1bFJe3ZRVWSz+
         iTmP2Jmh0N/q8TISZhYwjsKzVe6BBMY1Qvqk94TvuJYAnicuyUZUBkcjYsk6gajPS0zZ
         uF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxIhyBQ/wyFOLhPeEYs0WHU/R6dArTHK2k06xJSfSJQ=;
        b=ezduukub/Q3uwWn+TmNYbS1eWfsglfORSfxsYUZebmmtik/+OAqoZarlCFZ1aHFcCt
         1qBzkASy+tgfDKqmjt50glrv3QZ7xQkhxFxcYhSJqie2fJA/eEaF3S+C7/4OHK8gTFVK
         R3j8j5pIB3jeC0wsg67qd2oD+0QS1Pvq0H155Gh2SXdlDsgqkG7rxAP4+sYYOSOp5w7o
         H1NWaHOZm1j3sGI6kRpjMb19QJZCjbjZenb0jaha/JAYyFhjvr5EhdyChCUXLOJYAcvl
         LXxJLIXOMyCvUGfXAYd2kUpC6sP1jeCPAJF6sIUhfZC7vqh0dj1qV+T2ZnO4lsMeKCUr
         0MTg==
X-Gm-Message-State: AOAM530gO20B03sHpWBnKzxRwfF4MYdKcQHcU4iO3KiH1+Skty6Tz5bZ
	HIOMJUrkCNcD4MZFXrpfLZD127DAY7l3Pg==
X-Google-Smtp-Source: ABdhPJxe4jsb1C25cxH/T6i+SJ2f5YqvBmk9j9TkgR0q1SyphgA5G0hntknSFAdXkLw6x4MdRWV8kA==
X-Received: by 2002:ac2:4152:: with SMTP id c18mr4772517lfi.616.1612029208683;
        Sat, 30 Jan 2021 09:53:28 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id p19sm3028617ljn.75.2021.01.30.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:53:27 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] lib/bb: Don't treat mc recipe (Midnight Commander) as a multiconfig target
Date: Sat, 30 Jan 2021 18:56:04 +0100
Message-Id: <20210130175604.1326701-1-tomasz.dziendzielski@gmail.com>
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
---
 bitbake/lib/bb/cache.py    | 4 ++--
 bitbake/lib/bb/cooker.py   | 4 ++--
 bitbake/lib/bb/runqueue.py | 6 +++---
 bitbake/lib/bb/siggen.py   | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 36270d00937..c85effd6f08 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
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
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 83cfee7fb4a..4446addc77c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
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
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 28bdadb45e9..7d493eb402e 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
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
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 0ac3952466b..e0e03318a6e 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
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

