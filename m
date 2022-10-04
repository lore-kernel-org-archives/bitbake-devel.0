Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA5EC433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:28 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web08.12416.1664898923443777737
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=zcbk0U2G;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id a26so4484789pfg.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Wu7o3tuilGEMQ9r85i4+JQBAVRqbhHSx9nM74Xja2fQ=;
        b=zcbk0U2G1FqLIvvCY3KTSFGSaVGaDKaGwvQWXSJPCeyK/ISJwabKpoyR+eN/g02T4z
         4YBwtshyNG8KCEYq2r3cR4Tn1ymWRGiH1eB6/diB7IoDTmtZMYvlJ1K94wZcmXlstaMW
         /M3UuEZB+VkeunRqpkrWG2vL7dp84LjJeoOS24Lo34wF4pa8bZYpvIld3GzQQVfHvpMP
         4Sb/GYyOUiLZVeo1WZBB57j3hhyLtZp+4kvZThSvaX6bMElKBUDaeyB3UOmAGRvFhJIg
         ixPP50fX2STMFTFCiUeO2V5prR2VzS+9MayQLDMkWpiLI8U3qiSCWd6hD5Dv3mU4tWsO
         ayYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wu7o3tuilGEMQ9r85i4+JQBAVRqbhHSx9nM74Xja2fQ=;
        b=F7QkmC9K4OlvbFHgN9yBKvhAVwmm+jNYUqr9MRUihfvEBaylzHiJ1Q1H4fiwd/QYrr
         cKgWmJV6Q66TE4Lpyhfa/pBO2etv8CpqSPbj7EB1y20C3fRYN0MCZ8lXRMRrThO0wFkY
         20nlQEjz9F8lnyEx20xc7WwuYvN705qW1ZTH1+HrNkRuYECRH2hzclqy7ToKgA5v6T30
         JItmI18N23HZHd4RZ3uuJLAZguWSZSwpBBDgbtLd3uvhRVK/3xDeEraevfgTYkqJU7nQ
         AEKFAsF37ETNhKiyJ0NzceBC0rNo5op0zwd2ibWM+JjHwXVqbw52VSOGEhol0pK6l4jA
         aSQw==
X-Gm-Message-State: ACrzQf2tGvhcIp0A/1RCOW40x2T1kKNkKHZWV2gxVqaBMaL3K+j3gNmz
	XI/emN/Kj6DTHQ3vsGt1+xNOu5gKh6aJOJ06
X-Google-Smtp-Source: 
 AMsMyM5tiwaSOBo7fslP50HRcTzC54rphGQMmgk7JG1GcvqJogjBsWXTaeQHQ86cy6B5X6pnZkYKxg==
X-Received: by 2002:a63:6a85:0:b0:43b:d845:f67d with SMTP id
 f127-20020a636a85000000b0043bd845f67dmr23169506pgc.349.1664898922483;
        Tue, 04 Oct 2022 08:55:22 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:21 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 4/8] siggen: Fix insufficent entropy
 in sigtask file names
Date: Tue,  4 Oct 2022 05:54:55 -1000
Message-Id: 
 <63bb5591e833de0e7b552963ad9bc4b39e56fda9.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14019

From: Joshua Watt <JPEWhacker@gmail.com>

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
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
(cherry picked from commit 97955f3c1c738aa4b4478a6ec10a08094ffc689d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py |  2 +-
 lib/bb/utils.py  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 9fa568f6..bd6fc204 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -419,7 +419,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[tid], tid))
                 sigfile = sigfile.replace(self.taskhash[tid], computed_taskhash)
 
-        fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
+        fd, tmpfile = bb.utils.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
             with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
                 json.dump(data, f, sort_keys=True, separators=(",", ":"), cls=SetEncoder)
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 95b3c898..92d44c52 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -28,6 +28,8 @@ import signal
 import collections
 import copy
 import ctypes
+import random
+import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -1756,3 +1758,22 @@ def is_local_uid(uid=''):
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
2.25.1


