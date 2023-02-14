Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7CC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:28:55 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.10123.1676388533445745013
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=a5mAeElX;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id w5so17379155plg.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp86yPkudrRq6/6EkvY8obX3gbfSDtCSAiMRIEZ0eBU=;
        b=a5mAeElXQuqkkhC4VLYcZdLrkl1N0whgpV77IaQh4PCMaJRLCqAh6b5IdYM7ewhg8E
         Y3+eCMoqe52XcxzmySGBbhiibjoynE8TImG7g6r7/CKuQH2ulki6Pf16aLP1dWiS0gWK
         fhCw+MfnEP9qeYShRdVCL8NufiFgvgV/z45laJJMXaocMvyPO1sa0LpBu1NiXyadBojX
         kM+XG8AuCdM1bP52hJVkOrJldA4s7T20kYrBD/JgFdlGuwfbygrxg6JJkPTQhjSKrhtN
         nVsDAzJwcBjL2usiPAJuC7RtMhjQB033P+8HFBU1NRQqmeZG2UQUmAVeOFlr7lkt2fZz
         m53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp86yPkudrRq6/6EkvY8obX3gbfSDtCSAiMRIEZ0eBU=;
        b=PD0bQmTCIlMmfERy8Pdi/5TtE76Z8Z//WZnNtN3oyVxEhd4iLLyRDjLCJWng/3CSTK
         RnJOkvIRB45LVfBW4kRt9znTho4zMbxWGeiHpaTTWQPpZc1yd/LQLE0qUWhsEepw8x9n
         jVG2OXjo/CB6GA4nGUbv/5chE3aBvKuRLi3t/0mwNNEFVQeamXBaure3c3dahhqBqWJV
         0GjVMDdKDFRXStJN/1uB0dwx7bj4jsfFzPJe9/2SOQtTLW5XzUTW77f2vNYQCJEuyei5
         8B9Ug47Zk0/KlGaGOc51Tc3z2aPoWQKdLOJo0Thsc6zOGW2UxDqfuEt39ipeV20C32EX
         jD/g==
X-Gm-Message-State: AO0yUKVKhGnbyw/EEDYdwv1AaE1gDJfVuHc175tkYcX4o/UI1x4Yyaib
	J0ons5n7HyqsJ5X7V/fmYNJFHNst204n1m+NP+U=
X-Google-Smtp-Source: AK7set+lb6/Jy4QSgM1xLxgqKYZP+iSEiL1QaLfOY8hyXEs28VIilY5HeXxHhccirXzAQFN3Ne3mRA==
X-Received: by 2002:a17:90b:4c09:b0:22b:b832:d32 with SMTP id na9-20020a17090b4c0900b0022bb8320d32mr2918239pjb.9.1676388532512;
        Tue, 14 Feb 2023 07:28:52 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5624203pji.21.2023.02.14.07.28.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:28:52 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/4] siggen: Fix inefficient string concatenation
Date: Tue, 14 Feb 2023 05:28:41 -1000
Message-Id: <590ae6fde9da75db3a368e5c0d47920696c33ebf.1676388410.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676388410.git.steve@sakoman.com>
References: <cover.1676388410.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:28:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14415

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
index 9a20fc8e..cea3a538 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -329,19 +329,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
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


