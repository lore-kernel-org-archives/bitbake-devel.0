Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF93C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 14:05:03 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.8801.1659535497407760049
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 07:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HnPqf5G8;
 spf=pass (domain: gmail.com, ip: 209.85.167.175,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f175.google.com with SMTP id w72so15666817oiw.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Aug 2022 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDmyB37NaKmbfgkJU6o8fJZNztPhvgnfRLy02PAIxVY=;
        b=HnPqf5G8qsK8cWDZea6A003lsOs0VjKWhwbT2pSoKcM5v1MTHHdQTYKSEr6hhtB/cl
         7JdUTs5jQqmymNtwyLWs4jc4fZ4s9+NdI7rDeoCpkeBRKgnGqAybUXWf5iAMJGRegtaV
         4vIbt1aL0umcZ1jraAIv+jk+VnkZLzXIaZHttjSy4dy0GIdRywX0JhArKjfLOvYa4qRw
         vnX3ec7fOeoQmpeh2tIhxkaCjJD7ZZVBE9Rh6PhP5HpqR+b6zDoTOKf7/p/9Abb6SINl
         WrztAURQ8RxtStbrSRBJm0fFaDo+4mVw63ULAxHuvJAl7Gc7rg95p9cn/wjsWoKf3aNc
         bhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDmyB37NaKmbfgkJU6o8fJZNztPhvgnfRLy02PAIxVY=;
        b=IFDNu032EDl3EFQ7eKeE0l+GTIx0p/g0Nol1WaIElDmPyAwi8hSjbMgsy8l0+PyXuI
         COc3XN0Nwi+EK00/+p+ykmrzd4CrszcPn/5Xuh5d996gjuzBBMKl8iD68pDhGC7VWBSk
         TV2OFr7M99iUlgk0a987wU1CdsutiAtoebiBopBObucRtXtDSUH1YgtRk/9uZ2DVf9Vf
         cekOurEi5zB1DjSVI5hcR0A26I7wbYqGjTYTjXXlLyE0ETN9Ujwjenw6dcI6F2+U6Qhj
         BrODGxp2YyWQ5UuJxqYSYF4803klwPaRB3kFn6zoq/2nJm3Jo+O0NQBfkD6MAjjTbMXb
         hbvA==
X-Gm-Message-State: ACgBeo3A2Ho5ObvUPN4VlFkS3m6aPKlse9wH0ZCAfwbbn5v0oOeQD5WA
	hiqPF14fJPqxueS05fOmXNKEmaOniTU=
X-Google-Smtp-Source: 
 AA6agR495R32S/DphSKmolBdzWhS2/aaMDV8MGw5Ke0RBw+vAMXrUpaVj3+E7aLtvhE/notlmRidXg==
X-Received: by 2002:a05:6808:17a3:b0:33d:4f0e:eca2 with SMTP id
 bg35-20020a05680817a300b0033d4f0eeca2mr1690893oib.220.1659535496258;
        Wed, 03 Aug 2022 07:04:56 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 a15-20020aca1a0f000000b00339c8aab320sm3539794oia.3.2022.08.03.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 07:04:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: rasmus.villemoes@prevas.dk,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] siggen: Fix insufficent entropy in sigtask
 file names
Date: Wed,  3 Aug 2022 09:04:41 -0500
Message-Id: <20220803140441.1196056-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Aug 2022 14:05:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13867

Signature generation uses mkstemp() to get a file descriptor to a unique
file and then write the signature into it. However, the unique file name
generation in glibc is based on the system timestamp, which means that
with highly parallel builds it is more likely than one might expect
expected that a conflict will occur between two different builder nodes.
When operating over NFS (such as a shared sstate cache), this can cause
race conditions and rare failures (particularly with NFS servers that
may not correctly implement O_EXCL).

The signature generation code is particularly susceptible to races since
a single "sigtask." prefix used for all signatures from all tasks, which
makes collision even more likely.

To work around this, add an internal implementation of mkstemp() that
adds additional truly random entropy to the file name to eliminate
conflicts.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py |  2 +-
 bitbake/lib/bb/utils.py  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 3f3d6df54d..bb80343a97 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -425,7 +425,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[tid], tid))
                 sigfile = sigfile.replace(self.taskhash[tid], computed_taskhash)
 
-        fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
+        fd, tmpfile = bb.utils.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
             with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
                 json.dump(data, f, sort_keys=True, separators=(",", ":"), cls=SetEncoder)
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 19ed68ea62..b8b90df8d3 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -28,6 +28,8 @@ import signal
 import collections
 import copy
 import ctypes
+import random
+import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -1754,3 +1756,22 @@ def is_local_uid(uid=''):
             if str(uid) == line_split[2]:
                 return True
     return False
+
+def mkstemp(suffix=None, prefix=None, dir=None, text=False):
+    """
+    Generates a unique filename, independent of time.
+
+    mkstemp() in glibc (at least) generates unique file names based on the
+    current system time. When combined with highly parallel builds, and
+    operating over NFS (e.g. shared sstate/downloads) this can result in
+    conflicts and race conditions.
+
+    This function adds additional entropy to the file name so that a collision
+    is independent of time and thus extremely unlikely.
+    """
+    entropy = "".join(random.choices("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", k=20))
+    if prefix:
+        prefix = prefix + entropy
+    else:
+        prefix = tempfile.gettempprefix() + entropy
+    return tempfile.mkstemp(suffix=suffix, prefix=prefix, dir=dir, text=text)
-- 
2.33.0


