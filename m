Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E9C433FE
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 15:35:44 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.9875.1634139343971391874
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XE6tjTjZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id e12so9795794wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yxU5LKtktoJZ+UnJpSREGKVrJ75T+Z9L3N9Meo125wU=;
        b=XE6tjTjZdukf95NSff9Qece8f0WvzijhPtLN3udacVbBjpHlESZKicQ7vWA7DIj1qS
         xcu/UMB19inikjVhuxV1kMkmtJbt3/OB9c9zorpzhNy+XfLGLKH59OqzboRfLRsWzB+u
         qrGZQ6doemCnGCXydqM8XVdhQkgDYdVUyU2TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxU5LKtktoJZ+UnJpSREGKVrJ75T+Z9L3N9Meo125wU=;
        b=0WlwpKIbiBmkRVF9Gh9Jtm1OwvsuloBXXzqpBCuChazaOU3PDrqTjx6FxYIaFDbK7N
         uP4ie4tJP5fMjt8ebj3SvjWEaYud6KethA9ksMdjHDMLIexF9VbztpvMEde3XSMtzoKO
         3uFolfBoJf89IHLfhojn6dej6yu93ps5yBKtiun6iosIE6438O/MlnviSbn/7QaLR4ol
         oF0NI/Qkex1aYDoO5nvaPkqUyxjyjgHglkFbS1bPE+wqQc+1+hs7O3xA6EBKYwH1fba8
         1sU5tdlUUFupjcq2EaWtbZ2LzTDPRAh3eDF2KljxcwK4CfTgNmmHUbkPSOZQn7Qc7QGA
         pMyw==
X-Gm-Message-State: AOAM531ql2HJeSjc/4+U/ZXexPXbjoZgrEzSe3TuKGOSxwCMiFSREAC8
	KaIFZiQNm6+fFuN2JU93zaIoFWEVzXJhWw==
X-Google-Smtp-Source: 
 ABdhPJxwtw3GGtHajOzKS4ylEWLCnesnrLUv4S399bKL1MnOznrWBYkKv+LNrUcHnFlaDEVLnHsGxQ==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr41734940wrg.359.1634139342380;
        Wed, 13 Oct 2021 08:35:42 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:65b2:89df:e6ae:44c4])
        by smtp.gmail.com with ESMTPSA id
 q18sm5631717wmc.7.2021.10.13.08.35.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:35:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] siggen: Change file format of siginfo files to use zstd
 compressed json
Date: Wed, 13 Oct 2021 16:35:40 +0100
Message-Id: <20211013153540.2873636-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013153540.2873636-1-richard.purdie@linuxfoundation.org>
References: <20211013153540.2873636-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 15:35:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12771

Since OE is about to change to zstd compression of sstate, it would make it
timely to convert the siginfo files from pickle which isn't reproducible
to json which is both reproducible and also human readable. At the same time
add zstd compression. This makes the siginfo files smaller, reprodubicle
and easier to debug.

Backwards compatibility mixing the two formats hasn't been supported since
in reality if sstate changes at the same time, files will be in one format
or the new one but comparing mixed formats won't make much sense.

Since json doesn't support sets, we translate them into lists in the files
themselves. We only use sets in bitbake since it makes things easier in
the internal code, sorted lists are fine for the file format.

[YOCTO #13973]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 625a9cf3bb..f526792efd 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -11,6 +11,8 @@ import pickle
 import bb.data
 import difflib
 import simplediff
+import json
+import bb.compress.zstd
 from bb.checksum import FileChecksumCache
 from bb import runqueue
 import hashserv
@@ -19,6 +21,12 @@ import hashserv.client
 logger = logging.getLogger('BitBake.SigGen')
 hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
 
+class SetEncoder(json.JSONEncoder):
+    def default(self, obj):
+        if isinstance(obj, set):
+            return list(sorted(obj))
+        return json.JSONEncoder.default(self, obj)
+
 def init(d):
     siggens = [obj for obj in globals().values()
                       if type(obj) is type and issubclass(obj, SignatureGenerator)]
@@ -398,9 +406,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
-            with os.fdopen(fd, "wb") as stream:
-                p = pickle.dump(data, stream, -1)
-                stream.flush()
+            with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
+                json.dump(data, f, sort_keys=True, separators=(",", ":"), cls=SetEncoder)
+                f.flush()
             os.chmod(tmpfile, 0o664)
             bb.utils.rename(tmpfile, sigfile)
         except (OSError, IOError) as err:
@@ -794,12 +802,10 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         formatparams.update(values)
         return formatstr.format(**formatparams)
 
-    with open(a, 'rb') as f:
-        p1 = pickle.Unpickler(f)
-        a_data = p1.load()
-    with open(b, 'rb') as f:
-        p2 = pickle.Unpickler(f)
-        b_data = p2.load()
+    with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+        a_data = json.load(f)
+    with bb.compress.zstd.open(b, "rt", encoding="utf-8", num_threads=1) as f:
+        b_data = json.load(f)
 
     def dict_diff(a, b, whitelist=set()):
         sa = set(a.keys())
@@ -1031,9 +1037,8 @@ def calc_taskhash(sigdata):
 def dump_sigfile(a):
     output = []
 
-    with open(a, 'rb') as f:
-        p1 = pickle.Unpickler(f)
-        a_data = p1.load()
+    with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+        a_data = json.load(f)
 
     output.append("basewhitelist: %s" % (a_data['basewhitelist']))
 
-- 
2.32.0


