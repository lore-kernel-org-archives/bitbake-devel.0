Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5764EC00144
	for <webhook@archiver.kernel.org>; Mon,  1 Aug 2022 20:34:26 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by mx.groups.io with SMTP id smtpd.web10.2440.1659386064903838754
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Aug 2022 13:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ImlrGTVH;
 spf=pass (domain: gmail.com, ip: 209.85.160.41,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-10bd4812c29so15014189fac.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Aug 2022 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2r9J45byGwlhW8rnyuOfQpdAkaIc5QqAF9t497PkGs=;
        b=ImlrGTVHis7EM97QE+ncPK+YhChqm+uLSzcr7MN0bBr7yQgd7JaqakK/nCpc1b9N6i
         5dv1e1KrRtuMBhzlgVVsBG+4DNFRRxKAwxlvwH7HuLW9HfEYjqL7UuWE+XgFY9A5fs2Z
         7vc6MQ54rrvXvq5Hqt4n7uASRtCQC68997WMhDYahYEaBUWZlruGVPFffpBqbGjEtVfj
         Q+P3ysl4CIAv9Y8xbk+vOQqOHp8xJh2vaRUSfRotLNTKODJvzSnf8upGz/ikrMfpL3V3
         OxW5oW5D4RkrzLGXmfanH3B1HRcdSMgS2dxYz/AxraKX2vJmrvPdSFicBbwPfk3hOB2k
         6Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2r9J45byGwlhW8rnyuOfQpdAkaIc5QqAF9t497PkGs=;
        b=dvMJWv6e+qXUc31cZWt6iGzEu8GrY18ybYAYAL6ayzXAgZsHJrXANbFXGUMM9EBsby
         yIRjwa1mfkyZsyB7WQqvKox6VR/uaS9aLgLUii2LDoJA6F5KtuP8Kr5Y+LZBYx9YLQOa
         2hK90UtmRYktElAgYt2YwPxfau33BnZsoB5Ivf3nHWRTsW5xBnY6kwZ55YhOu7zKLyrF
         YUVORXgwZHimYO3uEZWLDOfL25cYlSgXROjdnuo0rOUGld+KmYdNaPpF000Lpa01mh16
         k6Z9GyepbUucOIZFFb7CAKk6+24DG+9nE2z3KPihS0LNHSC22RylmZq3glltLYFJWs2v
         JTWA==
X-Gm-Message-State: AJIora9K3lKO9tRafdwokqFacagWIpgwYhCxx/Z+7ObW8X2kupuuIF3u
	IjMVoj8oYeUokHdk1PL9+mXugnySWt8=
X-Google-Smtp-Source: 
 AGRyM1typ02csKyjW7k+a9M4OYNXJMaZDfQBAC8FNrC2DOqlnlfKnC103VmBv/pNI/kikOGkkdayOQ==
X-Received: by 2002:a05:6870:3486:b0:10e:62b:159a with SMTP id
 n6-20020a056870348600b0010e062b159amr8340964oah.254.1659386063946;
        Mon, 01 Aug 2022 13:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 d184-20020aca36c1000000b00339e6212ea7sm2585617oia.55.2022.08.01.13.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:34:23 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] siggen: Fix sigtask data not being renamed
 atomically
Date: Mon,  1 Aug 2022 15:34:18 -0500
Message-Id: <20220801203418.57677-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Aug 2022 20:34:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13862

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
index 3f3d6df54d..55f25235df 100644
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
+                os.chmod(tmpfile, 0o664)
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


