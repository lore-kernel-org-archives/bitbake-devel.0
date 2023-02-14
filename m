Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CBC61DA4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 10:35:43 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.3495.1676370941027751853
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 02:35:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=JL2FkH/q;
 spf=pass (domain: snapchat.com, ip: 209.85.215.172, mailfrom: ecordonnier@snapchat.com)
Received: by mail-pg1-f172.google.com with SMTP id u75so9930596pgc.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 02:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca4R9ey8UNi4+ukv3IQKynP6TOvhiat844Dlc6FrIaU=;
        b=JL2FkH/qhjR6qAIUgmlaeNCZDMgUhZBaRauap6ItwPKqBiBhUQQErgRQk3uHojTkPz
         un1bzJTFzaND25DPifaEeizoz3ndXPzbdHAQCXu7lQnxZWwVcom4H2dhTpVZdb4yQGBS
         ekjwIqZ3zayVvvdfwBd/awjrzPjQx48LT/L20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca4R9ey8UNi4+ukv3IQKynP6TOvhiat844Dlc6FrIaU=;
        b=tGSAuCiRYMiYFDHe8DuiITYIfFWIjFaPSpNs75+VAtdQsLkVHoNvQHSNgmWi3oOH7y
         uqGKvqxKfOjofLCt7FfMPAtVH8WlTuPJo1P6NcZKh0umxvSaFSfPetFNpiGZBttV8Yw7
         GF7ZRDaRFcWjcsA3EckhQ+8b0uwSVkF6J3/gRxxOrnHzPUSIovFZCdHc3cfLMdlrn/xS
         k0R87k8LUkv+M5uNNaYE3ELP4LNHYD/mY3pqpXboQJCgGPqfXo6tiW7dHVob1JSrcLgE
         wTod9qsAuSTx3Y3LGUCQuABo9ckrg1S/ur1cQpqGovQqjp8Qughu1BFqxkT6Vx1dP/Xd
         ycQw==
X-Gm-Message-State: AO0yUKUki95zjCMtGajjn5tlgpPp9Afr48j1EIIkFHz+K43IRXiAAIpx
	aXEwqv3lLUjjeEhu1Z5GEsT1XY12nFnnNPEKH3w=
X-Google-Smtp-Source: AK7set/nvKCQbsTkFv8GGT339LlZt8oTJF2mlWlhy02f88x1AqZbWpMofHKNu2cnXIM+u4z4Y22BrQ==
X-Received: by 2002:a62:1947:0:b0:5a7:a688:cd89 with SMTP id 68-20020a621947000000b005a7a688cd89mr1081451pfz.5.1676370940162;
        Tue, 14 Feb 2023 02:35:40 -0800 (PST)
Received: from lj8k2dq3.sc-core.net ([213.249.125.26])
        by smtp.gmail.com with ESMTPSA id q23-20020a62e117000000b0058d91fb2239sm4365052pfh.63.2023.02.14.02.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:35:39 -0800 (PST)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>,
	JJ Robertson <jrobertson@snap.com>
Subject: [kirkstone][2.0][PATCH] siggen: fix inefficient string concatenation
Date: Tue, 14 Feb 2023 11:34:41 +0100
Message-Id: <20230214103441.1516378-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 10:35:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14404

From: Etienne Cordonnier <ecordonnier@snap.com>

As discussed in https://stackoverflow.com/a/4435752/1710392 , CPython
has an optimization for statements in the form "a = a + b" or "a += b".
It seems that this line does not get optimized, because it has a form a = a + b + c:
data = data + "./" + f.split("/./")[1]

For that reason, it does a copy of data for each iteration, potentially copying megabytes
of data for each iteration.

Changing this line causes SignatureGeneratorBasic::get_taskhash to take 0.06 seconds
instead of 45 seconds on my test setup where SRC_URI points to a big directory.

Note that PEP8 recommends explicitely not to use this optimization which is specific to CPython:
"do not rely on CPython’s efficient implementation of in-place string concatenation for statements in the form a += b or a = a + b"

However, the PEP8 recommended form using "join()" also does not avoid the copy and takes 45 seconds in my test setup:
data = ''.join((data, "./", f.split("/./")[1]))

I have changed the other lines to also use += for consistency only, however those were in the form a = a + b
and were optimized already.

Co-authored-by: JJ Robertson <jrobertson@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/siggen.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 130b38d8..2381edd2 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         data = self.basehash[tid]
         for dep in self.runtaskdeps[tid]:
-            data = data + self.get_unihash(dep)
+            data += self.get_unihash(dep)
 
         for (f, cs) in self.file_checksum_values[tid]:
             if cs:
                 if "/./" in f:
-                    data = data + "./" + f.split("/./")[1]
-                data = data + cs
+                    data += "./" + f.split("/./")[1]
+                data += cs
 
         if tid in self.taints:
             if self.taints[tid].startswith("nostamp:"):
-                data = data + self.taints[tid][8:]
+                data += self.taints[tid][8:]
             else:
-                data = data + self.taints[tid]
+                data += self.taints[tid]
 
         h = hashlib.sha256(data.encode("utf-8")).hexdigest()
         self.taskhash[tid] = h
-- 
2.36.1.vfs.0.0


