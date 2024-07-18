Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F24BC41513
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:48:41 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.15450.1721310515696264889
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:48:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=lAX8PGk6;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so644547b3a.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1721310515; x=1721915315; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNwM5aTSd2sbzgcMMotTGqNSOYmhwFagg/tQjHoD1Fc=;
        b=lAX8PGk6O0GzFc25hhPFvmUjBGCEOcWdteQFQKq2WjGXeUTibX/Ny6zqVWDLH+16DS
         qR+1wT9jF4UEcJvSKhkgUan0eyIJTuKu25Aur3JJbG3Acs7afzeGGYXBdtiM2pqE3pcB
         I152ZNWoSncXjv9mVeq+bjZ4XIGCBFFGReqioYFFnirFioIuP1jsBwHkG/uU3q8mASXD
         Q+6FDjbPRKdfynkaP0ti9lAFesGIKs4OYsG4tWfyZeqjD3U6wU8rN7V7uTq9pNWblvJ8
         S4YlGzmxJ2RI/nQdwFrp4J5X2m/1PVfS44fK44hatApWiRoTm2kkbEzz7Qg0Yro24tjm
         /IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310515; x=1721915315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNwM5aTSd2sbzgcMMotTGqNSOYmhwFagg/tQjHoD1Fc=;
        b=EGvi9hz4NDpPes9OonR/e0wW5IXvLjerCIoaFsjfTu+O8qCnwot8fbqRHR9Sl+6OfO
         OFV0ZDYSNnYV6fVXiUFfWD+Py92eO1rhFYTTCqpkrb3fPL9jE4aRpjgqcAB+C5Z1FAnX
         IqykildMlofz3aFBbu5Ki8oRCWInnVA6rdMgS/WqU0qk1kXfVtHQ4Lk/bn/8qlc1puMF
         Zz5MkQKwmFWU9hn+ER7vNxhIsq1tfDZ4G2+ZSQNbPW0FsktpsxcPmDDBqR1FRFC0aGyD
         YwS0WskPu9fefVT6Ifk+UQNwp2KSuE+v5lJN0XR5/zzazmkw5w6yCUc82ccrZzjanrzV
         OZfg==
X-Gm-Message-State: AOJu0YzZiW2+dztGgLgqUZPIeHEB+kYOSgmrl6qdytAPzHq6Y61iPOX+
	wOyiIkdVwgkTP7nV6Op9K1MEPit6eC9nbryDZgEegn0s+lnYr/SjzL4UNxxR6mp+yMt89X8gGTr
	V
X-Google-Smtp-Source: AGHT+IEpQdKVS73SvelwXjsx7z/+JcEVi7NzU6XWbPxAt85vr7DaovKfeoyTKlYdC8vlkrcHPi5WLA==
X-Received: by 2002:a05:6a20:918d:b0:1c0:e9f7:29da with SMTP id adf61e73a8af0-1c3fdca1d6fmr6041424637.24.1721310514851;
        Thu, 18 Jul 2024 06:48:34 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77a33ee9sm671269a91.24.2024.07.18.06.48.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:48:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] codeparser: Skip non-local functions for module dependencies
Date: Thu, 18 Jul 2024 06:48:27 -0700
Message-Id: <11d83170922a2c6b9db1f6e8c23e533526984b2c.1721310419.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721310419.git.steve@sakoman.com>
References: <cover.1721310419.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 13:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16425

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If modules do something like "from glob import glob" then we end up
checksumming the glob code. That leads to bugs as the code can change
between different python versions for example, leading to checksum
instability.

We should ignore functions not from the current file as implemented
by this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1e6f862864539d6f6a0bea3e4479e0dd40ff3091)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/codeparser.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 0b2890cf8..1001ca190 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -72,6 +72,11 @@ def add_module_functions(fn, functions, namespace):
             parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
             #bb.warn("Cached %s" % f)
         except KeyError:
+            targetfn = inspect.getsourcefile(functions[f])
+            if fn != targetfn:
+                # Skip references to other modules outside this file
+                #bb.warn("Skipping %s" % name)
+                continue
             lines, lineno = inspect.getsourcelines(functions[f])
             src = "".join(lines)
             parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
-- 
2.34.1


