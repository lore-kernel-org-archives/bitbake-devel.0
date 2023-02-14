Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160BDC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:25:35 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.9889.1676388333515012488
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:25:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=PM7Rxzwn;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id b5so17394230plz.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOOE5zGuriRZbQbIM8OSrS+wXEwjZfCCDO3bCcFmEwA=;
        b=PM7RxzwnDvKgcvQfII5MPllkQaEmiT/ApEVP0T/RHxQ5oyu4N531xCDKv1mF8pWnrs
         r4ZbOqpp6tuc74yQlI6Ep/IM+ATYhSjEZKuYZByFG26IgdWz9kddDYKNcnacLkC/qYnF
         yYc4KO7sf0DkLcM+HFffiRsSuXmtPfim4x6xPP0qSglNxh0lndAmt+4U69Rya/HtPswW
         FskPLOorGIkgneFTLKQKRow02PLME6QE+xInuUlOP6CC3rJ+DcFUX7/MxsXkBRczgGJY
         uRhICwmMhSGmuc6XOFeZzkQaPAJL56D/YutMGjKoaCvYuP2Ed3MSOv+By1qm+nn2ADFr
         xoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOOE5zGuriRZbQbIM8OSrS+wXEwjZfCCDO3bCcFmEwA=;
        b=08uv+0847KqPrK01aZhxXTKwMSRLhDfg6tSfGhk6SY0aSdjEbyljBa0JU4kX6NFINK
         IcSUxu9GBb5EdBGi1FBK6dHl0UaK2c39HvXx22vYXI+vwSqcImz6iKznmEwUlWk5G2/Y
         Phw68UHhc1FLhsB88wZQQix0jIiCrZwES0b/+QLBMT9Ct6gWwiaKTIYNVfms2jt+V/Mu
         7g+AYhfjAkiheBxSqYAvKRJF71DL4Q26aE7NKUdx1UUOIvvSz4x8yKmBK0+OPR/aemQm
         h2t0FPAqcc5s0asrVoaC/5yQLPt5nzhrZcQ3ZHol+0adEx/Nq9pW59zfIsgUHSisyVMw
         KsMA==
X-Gm-Message-State: AO0yUKU38rBUW+QPwBOh+oOFBuFvYSjAnAH2x2PRjlzn19XixcVoooAq
	G5Gz6n23DftrBHBVi0ljcU/sfCDvwQxxeJFuB+M=
X-Google-Smtp-Source: AK7set+LBEUzE2oTlzqSs0r5YaLQQBej9keoAOrygxXKnSs8L5poBKD63wCzNff2DIKKVDneXZy2Qw==
X-Received: by 2002:a17:90a:199:b0:234:6a1:635d with SMTP id 25-20020a17090a019900b0023406a1635dmr3047553pjc.49.1676388332479;
        Tue, 14 Feb 2023 07:25:32 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id s93-20020a17090a69e600b002339491ead6sm7914416pjj.5.2023.02.14.07.25.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:25:32 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 1/1] siggen: Fix inefficient string concatenation
Date: Tue, 14 Feb 2023 05:25:23 -1000
Message-Id: <592ee222a1c6da42925fb56801f226884b6724ec.1676388239.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676388239.git.steve@sakoman.com>
References: <cover.1676388239.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:25:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14413

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 195750f2ca355e29d51219c58ecb2c1d83692717)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 07bb5294..dd7039e5 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -332,19 +332,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
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
2.34.1


