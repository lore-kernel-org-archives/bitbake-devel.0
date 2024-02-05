Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE02C48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 15:42:47 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.66048.1707147758051559802
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Feb 2024 07:42:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lW0iFjIR;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eac018059so5517216e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707147756; x=1707752556; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmCW3+au6tlEav+YOtml7EAl1mjnMW1RQcErQP7CNYA=;
        b=lW0iFjIROQIG119F5JItvSVL5gTs3yAYq4Vwbld0mPPY7i2FsfqfKOfLCzGkv63Qi8
         K/Xekep0VCd+DJ3qH+zrkvWRVFael696UFpacgQu1+3hmEjG6J4+4SzjUyDD9c5TJ/Dd
         5y8dOsoITQ9U0YuIfJxKicup9cUyk7Zt2cld1+zIBGACsBRMUcJf4sXW50pUHIaO4r+s
         8vraU7o91N8HNOEbq6r/yCg4dNPgcEb+HQRSJIPylQBCTwZOPaudsyRBgBf/K160X+Kv
         hkkU++GKJZbNrkq6gk8fBjX/etRCz7FS7FRBkrB1UQujASuqpi9H4HYIZ4gl8g459nRT
         fuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707147756; x=1707752556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmCW3+au6tlEav+YOtml7EAl1mjnMW1RQcErQP7CNYA=;
        b=hCxBvIzwg+BmAYLyaNClhpfmyG8Nit1n9KB41iuoIzzl4t/VwQX3ryaXFOFtgkYL1o
         yxX1vwVEOfDnSdzu8zTZH//m1GCkdSuqDjWzzUgTARaIw9Xo2aEfMHOw50g9Gq7yaLM7
         dHXznz9bH+Mf2FxJSJLeJECHizrrMZWfIuMHALVkSyauU2VMcD7z6klxNPVhoJeG1BvM
         sGDMdIF+D4bNWW1bmROsK1MROcTYC7oHHcK/PnQbmfjRXR6tOYUfWlaA2JHO19BTzOq6
         Mf9QDl5gE62gP444Q4BH1zwtUy67ImQDesCbF+h/fwJEUioOjU/l8/FhsRSc+hdyMheL
         +gVw==
X-Gm-Message-State: AOJu0Yx9G8TEliHHxu0wNi3vXvZ1i7Cl9+dnHwxgV4DdzGf2G7OvsTj6
	kLEg7dMTM/FGgJzrsGUp6Ba1WKrDSzB3Ptoo0Z1zxZCOe3Yr9VKlblSVX+ul
X-Google-Smtp-Source: AGHT+IEcGr/P1dw7O50wKluUMQzQBrMH+XTM7fLUsozeMUqziy+e+1+Amgr/W4wbhcAeb252YTQJbw==
X-Received: by 2002:ac2:5de2:0:b0:511:5423:848d with SMTP id z2-20020ac25de2000000b005115423848dmr1238406lfq.60.1707147755961;
        Mon, 05 Feb 2024 07:42:35 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id cw10-20020a170907160a00b00a3493e2dbfesm4462209ejd.53.2024.02.05.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:42:35 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] bitbake-diffsigs: fix walking the task dependencies and show better error
Date: Mon,  5 Feb 2024 16:42:32 +0100
Message-ID: <20240205154232.441704-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 15:42:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15824

* when comparing 2 tmp/stamps/*do_configure.sigdata* I got
  TypeError("filename must be a str or bytes object, or a file")
  but both files I was comparing were
  Zstandard compressed data (v0.8+), Dictionary ID: None
  according to "file"

  with TypeError catched to show which file it failed to open I got better
  error which shows it was trying to read "do_prepare_recipe_sysroot.sigdata"
  file now and after a while you might notice that it's not just the expected
  file, but a dict with 'path', 'sstate', 'time'.

  Fix that in bitbake-diffsigs but keep the TypeError and add OSError
  in case it will eventually walk on file which isn't zstd compressed
  pipecompress throws CompressionError.

ERROR: Failed to open {'path': '5.15.do_prepare_recipe_sysroot.sigdata.99b12a401341a0df7c3553cb00c87a7674295496bd5c25ed71764ee0d0fb8eb8', 'sstate': False, 'time': 1707136354.991718}: filename must be a str or bytes object, or a file
Traceback (most recent call last):
  File "bitbake/bin/bitbake-diffsigs", line 192, in <module>
    output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, recursecb, color=color)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "bitbake/lib/bb/siggen.py", line 1039, in compare_sigfiles
    recout = recursecb(dep, a[dep], b[dep])
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "bitbake/bin/bitbake-diffsigs", line 102, in recursecb
    out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "bitbake/lib/bb/siggen.py", line 857, in compare_sigfiles
    raise err
  File "bitbake/lib/bb/siggen.py", line 853, in compare_sigfiles
    with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "bitbake/lib/bb/compress/zstd.py", line 12, in open
    return bb.compress._pipecompress.open_wrap(ZstdFile, *args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "bitbake/lib/bb/compress/_pipecompress.py", line 59, in open_wrap
    raise TypeError("filename must be a str or bytes object, or a file")
TypeError: filename must be a str or bytes object, or a file

* if I replace zstd file with just plaintext it fails with:
  $ echo foo > foo
  $ echo foo > bar
  $ bitbake-diffsigs foo bar
  zstd: /*stdin*\: unsupported format
  ERROR: Process died with 1
  sys:1: ResourceWarning: unclosed file <_io.BufferedReader name='foo'>

  with this change it shows the name of the file which it failed to uncompress:

  $ bitbake-diffsigs foo bar
  zstd: /*stdin*\: unsupported format
  ERROR: Failed to open sigdata file 'foo': Process died with 1
  ERROR: Process died with 1
  sys:1: ResourceWarning: unclosed file <_io.BufferedReader name='foo'>
---
 bin/bitbake-diffsigs |  2 +-
 lib/bb/siggen.py     | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index a8f49191b..8202c7862 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -99,7 +99,7 @@ def recursecb(key, hash1, hash2):
     elif hash2 not in hashfiles:
         recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
     else:
-        out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
+        out2 = bb.siggen.compare_sigfiles(hashfiles[hash1]['path'], hashfiles[hash2]['path'], recursecb, color=color)
         for change in out2:
             for line in change.splitlines():
                 recout.append('    ' + line)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 5a584cadf..58854aee7 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -849,10 +849,18 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         formatparams.update(values)
         return formatstr.format(**formatparams)
 
-    with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
-        a_data = json.load(f, object_hook=SetDecoder)
-    with bb.compress.zstd.open(b, "rt", encoding="utf-8", num_threads=1) as f:
-        b_data = json.load(f, object_hook=SetDecoder)
+    try:
+        with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+            a_data = json.load(f, object_hook=SetDecoder)
+    except (TypeError, OSError) as err:
+        bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))
+        raise err
+    try:
+        with bb.compress.zstd.open(b, "rt", encoding="utf-8", num_threads=1) as f:
+            b_data = json.load(f, object_hook=SetDecoder)
+    except (TypeError, OSError) as err:
+        bb.error("Failed to open sigdata file '%s': %s" % (b, str(err)))
+        raise err
 
     for data in [a_data, b_data]:
         handle_renames(data)
@@ -1090,8 +1098,12 @@ def calc_taskhash(sigdata):
 def dump_sigfile(a):
     output = []
 
-    with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
-        a_data = json.load(f, object_hook=SetDecoder)
+    try:
+        with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+            a_data = json.load(f, object_hook=SetDecoder)
+    except (TypeError, OSError) as err:
+        bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))
+        raise err
 
     handle_renames(a_data)
 
-- 
2.43.0


