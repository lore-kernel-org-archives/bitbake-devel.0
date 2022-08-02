Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E5C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 13:14:22 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web12.5833.1659446058124683869
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Aug 2022 06:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pClViM4h;
 spf=pass (domain: gmail.com, ip: 209.85.167.170,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id h125so16437855oif.8
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Aug 2022 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySp69KXFZw4SvFzFd2ptHxbjZeHfEvEk9SbbuTIK8aM=;
        b=pClViM4hg27fuy3uC27S9Z9Nav3uR1w2vu3GjOMc+ufZSsOADWGys7QVgA/03V+YbY
         5XBh0uzpx01PBwWFowrXUsy6TC5IdScptFNENfcgM+un6SNbPXD8QXGJ6oAro/T3hQ4r
         BzPf/5ymuHx6ciBED+Bxd2kM/cb/wvLOqDt2QwlU2nwNNs0QvGTFGqJXOjPWieZzIekq
         TR55EFC3fXHxP5ngSYVqFIEiLmnzGIR7A35imXChgqtZ2oRlmKuMZJBvfLcmsupidck+
         q56fenZfULFQwDt96IoZi8LITI0qhN+Xa8z/zlSPUa46QvQ/uFjp0vfHJwonV75BgEmT
         LqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySp69KXFZw4SvFzFd2ptHxbjZeHfEvEk9SbbuTIK8aM=;
        b=R4iCBfr4HWosefjzeJps/2+lgWxp7WFBhfisbrbyOWqWZd59lRWKQHevSZ5xEAg9WH
         Z1v9OrYAvlUQgKeA1MAhr+afbpJnP3PtEmzrNkWHqXeuDP2u/SwEkL3Nw9+H3oiOednj
         B7fcFhGYV5hQ9T/+vQXguRrhf5B4X4Ke1JCRdJP1p/E7PY60jRP1oE2E1T04HcFgfBb0
         4lhUiuJ93+dIvaBsudh398T/hKVWBvk8X8UF7aCQ51rbAi1phj04sqlNyU7T5p6s9vJg
         DClssWT586Pk83DwYLH/eIP73tHt9Yudg0KZhH2DTipp8jeKxohvJLioy9WJnFNGiBmT
         WEfQ==
X-Gm-Message-State: AJIora+pQ8keYD+mPQnTMmhqeevUPH+w2J4qY8UDB45uZ4rjvru0O4TE
	My72MBwh5idVaXd8i+yhesPwNEg+kns=
X-Google-Smtp-Source: 
 AGRyM1utxYHDQ+NRrflZIRhGhNRDaoCi8O0kYyUkdiCN2y+Ifv8kObx+uIfHdUKVrMoGvD5hm3YdnQ==
X-Received: by 2002:a05:6808:13d6:b0:33a:aae5:853f with SMTP id
 d22-20020a05680813d600b0033aaae5853fmr8554039oiw.147.1659446057050;
        Tue, 02 Aug 2022 06:14:17 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 p4-20020a9d76c4000000b0061c4d5a5616sm3372258otl.63.2022.08.02.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 06:14:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] siggen: Fix sigtask data not being renamed
 atomically
Date: Tue,  2 Aug 2022 08:14:05 -0500
Message-Id: <20220802131405.318201-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220801203418.57677-1-JPEWhacker@gmail.com>
References: <20220801203418.57677-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Aug 2022 13:14:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13864

Signature generation uses mkstemp() to get a file descriptor to a unique
file and then write the signature into it, however it closed the file
before doing the chmod() and rename() operations. Closing the file means
that other mkstemp() could potentially open the same file and race with
the chmod() and rename(), causing a error. While it may not sound like
this would be very likely, glibc (at least) generates the filename for
mkstemp() using the system clock, meaning that it is much more likely
for highly parallel builds sharing sstate over NFS to encounter the race
condition.

To fix the problem, perform the chmod() and rename() while the file is
still open, since this prevents other mkstemp() calls from being able to
open the file (due to the O_EXCL flag).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 3f3d6df54d..f3c8ff796f 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -426,18 +426,18 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 sigfile = sigfile.replace(self.taskhash[tid], computed_taskhash)
 
         fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
-        try:
-            with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
+        with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
+            try:
                 json.dump(data, f, sort_keys=True, separators=(",", ":"), cls=SetEncoder)
                 f.flush()
-            os.chmod(tmpfile, 0o664)
-            bb.utils.rename(tmpfile, sigfile)
-        except (OSError, IOError) as err:
-            try:
-                os.unlink(tmpfile)
-            except OSError:
-                pass
-            raise err
+                os.fchmod(fd, 0o664)
+                bb.utils.rename(tmpfile, sigfile)
+            except (OSError, IOError) as err:
+                try:
+                    os.unlink(tmpfile)
+                except OSError:
+                    pass
+                raise err
 
     def dump_sigfn(self, fn, dataCaches, options):
         if fn in self.taskdeps:
-- 
2.33.0


