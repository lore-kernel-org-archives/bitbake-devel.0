Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D299AC282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 23:27:49 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.595.1741390062246402136
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 15:27:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UNh2waZX;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390f69e71c8so1351430f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390060; x=1741994860; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlbI+FwwCdUiguD3OOY3D2jN1bUUmupGPvzCRTy4B9o=;
        b=UNh2waZXe+JQLWrgPrJc7Y4Wzm+OX2S2Yt9CYxgLJm3dt2rQHCIJkXfr6yVbA1Vbl1
         +Wl2GX401odFHlPhnzm9TMKMxBZqWU51ndv7b1vhG5yBL+UfqnEseJd1Zx3Bc7YU/BOc
         RbniFJ5Iny6WRGLFC6AVGT4E+EDQJgEzBrWn3wdDkazgN3WS9WMCiRk0g0Zq9YWQFqIU
         JqBznIuJC+TTNUvrDAuoj8iIibXGOKmMtRj7uIulOHPsHcxhGHPV0+dFZjq3Z5Pom96L
         BX3zwyM0GS5HDoz+jjo94ikORS2iJHT4059jaQAXj7FpSywQ/ysHnJ6XIdX1Aa6+JTlr
         n5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390060; x=1741994860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlbI+FwwCdUiguD3OOY3D2jN1bUUmupGPvzCRTy4B9o=;
        b=DuuRkQGDxCoqnZt/mqneSlza0R0D5on6r1xiql3WRWbB9R5DdH4ZZ0AqL4raI+6y5D
         pA0FhjnRXbWg9d1SLBcEmgwcOY3KnzxgX4z8JOc+efgNISU+Mn31vEmrbjhiMqTdsufT
         zWlSszh5Mk+rkiuwtecENfvA0ouzeGo3Ak8vWUbiYrpiwX7+UsY8yiO2gH4VONuHCsFD
         8w+ZwlekejSLAZD+TYqVuYic3FoamrQPJIkmCZHdSaC3//+HbedeYn1NPkq5ODADgyco
         pCqXd2a0be1dGKgZx6sc15BD8Ep/Ag3lfUESmMFgkf7oeMlr+fnFUmG1++cbBxTASf05
         kErQ==
X-Gm-Message-State: AOJu0YyVltkQ8L8WqfwtaOOx3TbsOquvUkq3/OpPkSnd6By3nmk8O//D
	rKtbnx5VDSr2aJToxzu4df5EIV6jsizbK3/dpQtk90D84W25E7LlKKjjtQ==
X-Gm-Gg: ASbGncurF4eEAWoGK6CJpJhda106gevuHxMIhjawof/woVqMtkRXx61/z/SUQWod5un
	Qcg6dE6iaMZB2JpGMwPhVKoBkbb+J+AGB2g0LoZe1skpjarUklZ1KryVsuxwItQZZgaDcQ7N0IN
	wcYJ8ZgjR1EBTeDd8XcuJQpNZoCBY8gyVBQrl+9oiThRFbydJzphX/srY/qrFwTkG2zGaBpe4V9
	LVUhwH9UUWErsHNLp/C8CzsiGxVeWO61U4vZlxTCfq7NynoXribZ8XGUz/+T7Ymn6Y37KQOcqhj
	igRXvrCclpG5jP6Y77NxK57/4WFPL4l7cejHxNyoVqb8MOE=
X-Google-Smtp-Source: AGHT+IEA7fMe7xtJHDIpkr4A/4WhjvQQ9BJsVjukyDuXw+O5ICaorTQBQ4xJS5B2Umj/IiVh54dqgw==
X-Received: by 2002:a05:6000:1869:b0:391:2eaf:eca1 with SMTP id ffacd0b85a97d-3913aed396emr813386f8f.2.1741390060365;
        Fri, 07 Mar 2025 15:27:40 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c102d76sm6689116f8f.86.2025.03.07.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:27:39 -0800 (PST)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Paulo Neves <paulo@myneves.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.0][PATCH] siggen.py: Improve taskhash reproducibility
Date: Sat,  8 Mar 2025 00:27:20 +0100
Message-ID: <20250307232720.2170981-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 23:27:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17414

From: Paulo Neves <paulo@myneves.com>

file checksums are part of the data checksummed
to generate the task hash. The list of file checksums
was not ordered.

In this commit we make sure the task hash checksum takes
a list of checksum data that is ordered by unique file name
thus guaranteeing reproducibility.

Signed-off-by: Paulo Neves <paulo@myneves.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 lib/bb/siggen.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0a9ce0ede..828729d8b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -331,7 +331,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for dep in self.runtaskdeps[tid]:
             data += self.get_unihash(dep)
 
-        for (f, cs) in self.file_checksum_values[tid]:
+        for (f, cs) in sorted(self.file_checksum_values[tid], key=clean_checksum_file_path):
             if cs:
                 if "/./" in f:
                     data += "./" + f.split("/./")[1]
@@ -393,7 +393,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[tid]
             data['file_checksum_values'] = []
-            for f,cs in self.file_checksum_values[tid]:
+            for f,cs in sorted(self.file_checksum_values[tid], key=clean_checksum_file_path):
                 if "/./" in f:
                     data['file_checksum_values'].append(("./" + f.split("/./")[1], cs))
                 else:
@@ -720,6 +720,12 @@ class SignatureGeneratorTestMulticonfigDepends(SignatureGeneratorBasicHash):
     name = "TestMulticonfigDepends"
     supports_multiconfig_datacaches = True
 
+def clean_checksum_file_path(file_checksum_tuple):
+    f, cs = file_checksum_tuple
+    if "/./" in f:
+        return "./" + f.split("/./")[1]
+    return f
+
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")

