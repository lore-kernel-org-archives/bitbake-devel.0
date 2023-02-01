Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78409C636CD
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:20:32 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.24280.1675261230146692401
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 06:20:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=gTDdDYU1;
 spf=pass (domain: snapchat.com, ip: 209.85.215.180, mailfrom: ecordonnier@snapchat.com)
Received: by mail-pg1-f180.google.com with SMTP id v3so12601141pgh.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwwC6coKoxd05wv6c+giFSjrZRe5yp6d9JXIP98qprg=;
        b=gTDdDYU1c7nHpYdgDX+visVdXo4x8vdSpAAEnDDUJ4InTgST7l6m9r5qQhYbF/KViW
         42ZMwswqeEWz7+l9dQqavqLS77R6PCYzjfYLHTTjWOZQoPMExgleTDNDOu9qU5tXdVeE
         7XE0ShkRIIpjAVahWnsIUqCB6FZN3M/WMdzyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwwC6coKoxd05wv6c+giFSjrZRe5yp6d9JXIP98qprg=;
        b=El3xqXTSqDxKBqZWec9OdaXuTUgfMxZnuf+3LcrKqDgiV4qz/4Jr/qxPkI3o799urJ
         HI7m8uXx0pwPpqVnM+B3TUJvwWK8Am48B7HycL4XPgtXnriUJkPJsqj4tSiGfNZTxzP1
         41sXs8uZzGFGvqokdCumnDvYT9b1j4noFXGrmQ+F+4idm4GLtH0DKFdGFx/OuACXAbzf
         F/pzFozBxBnJjLgs4wd3ogEKdUN6DCSlhxACczapIURlD1C9ag9ZI5n5BRxEKImwW3bW
         aBW6Rrlp/ePUfp1+3Do35oZqdcyckec006gAzYQKV7aKqotpqV4PJUAmRCDGAMrIWH4Z
         b6PQ==
X-Gm-Message-State: AO0yUKVdpnF9aV8e4y4+9BPDP+VdacyCQ2ZpQKWtYQlePq7sZYyhpQZ+
	2HIMEeB3g+9N2kKsahiXVNCD24626tSyaLx3
X-Google-Smtp-Source: AK7set+lLwaoAMw6XCy3Hrr4we4JH6ret4FyzhTTP/yw0cvKkqsEiNjP6e72BsiEvTxoNUWpli/Dwg==
X-Received: by 2002:aa7:988b:0:b0:58b:5f9d:c2fe with SMTP id r11-20020aa7988b000000b0058b5f9dc2femr2479703pfl.29.1675261229281;
        Wed, 01 Feb 2023 06:20:29 -0800 (PST)
Received: from lj8k2dq3.sc-core.net ([213.86.25.14])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0057709fce782sm11585055pff.54.2023.02.01.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:20:28 -0800 (PST)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>,
	JJ Robertson <jrobertson@snap.com>
Subject: [PATCH] siggen: fix very inefficient string concatenation
Date: Wed,  1 Feb 2023 15:19:00 +0100
Message-Id: <20230201141900.1478768-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14364

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
index 0e79404f..26e0243b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -349,19 +349,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
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


