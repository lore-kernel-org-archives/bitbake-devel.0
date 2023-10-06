Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8E5E92FFB
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 09:42:38 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.8841.1696585347973100820
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 02:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XseWG6AZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4066692ad35so17083815e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696585346; x=1697190146; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sgts6pwfZeKoswKTqV7jCogSY7pozfmV2QNpWbnhkIY=;
        b=XseWG6AZxXtJWf3dQ6eHJBLWNEBrXQjU1R+ZQzAofQC3gY3LjsSLrqsQ8LsRJQuxm+
         wR9qNNO2wC3RJrK7tdjYbj9mAhxPOhLL39WmzXLQtLUu0yDTNkr1oOE6QMTCT5pCPe1o
         GrUGXAtUsI3oSCnhh435jvwTfyufSYxbJcwqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696585346; x=1697190146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgts6pwfZeKoswKTqV7jCogSY7pozfmV2QNpWbnhkIY=;
        b=rkGeMl/lm6w9ipSIKkWeUDK7KUd6XAUeoWfIhwhQi6eQcl6mC0fQMO6UyXXu00e9GX
         bKU8USYcBO0C8pvzub664Ja04AY5HZux3u7fqnUQi7+a1deEwjSzobEqgrPz6BK1NbKI
         mxL+VdnaO6vqLCaSGhra0yLYxkhex4O99/mFE4oYsHuBpD8h9/Es1ieaRyb7AQNv5zOD
         wUTDvGV8maGfTyFQ5O3jY5bXIYqniup9dOOoIXin9pWEAppOjjmbVPuUc/WR6bG4CcXl
         OR5obng0XyelU8wm9C5VPTPCMT2GRtwYH0ORaXGQvNBfYkihsiFoTBgYaSLJTKCjHIOC
         Mtxw==
X-Gm-Message-State: AOJu0Yx/e3an/+zHArEJTD7UvZYjnHuZFxdJ6c5DhzmHicXjlGGYB8T3
	+ozHrTYaCQxkk2rbiEKf7O9DPO8YQCmwDjwGoYo=
X-Google-Smtp-Source: AGHT+IH8o2RFIQ7jXBppIQUC7et2TQNW5EhNzyipbZlAs6wHIUtX+JWDOimWfITB6nS2xpF/cKxqLQ==
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id o6-20020a05600c378600b00405359ac965mr7482904wmr.4.1696585345992;
        Fri, 06 Oct 2023 02:42:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2964:cec5:fab8:2212])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b004060f0a0fd5sm3339025wms.13.2023.10.06.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:42:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [PATCH] selftest/fetch: Ensure top level directory timestamp doesn't break test
Date: Fri,  6 Oct 2023 10:42:24 +0100
Message-Id: <20231006094224.3228129-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 09:42:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15186

The infrastructure changes highlighed an issue where the top level directory
mtime stamp isn't included in the tarballs. This isn't an issue the test is
meant to check for so ignore it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c5d15e9fd8..eeb7a31471 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -684,11 +684,13 @@ class CleanTarballTest(FetcherTest):
         archive = tarfile.open(os.path.join(self.dldir, self.recipe_tarball))
         self.assertNotEqual(len(archive.members), 0)
         for member in archive.members:
-            self.assertEqual(member.uname, 'oe')
-            self.assertEqual(member.uid, 0)
-            self.assertEqual(member.gname, 'oe')
-            self.assertEqual(member.gid, 0)
-            self.assertEqual(member.mtime, mtime)
+            if member.name == ".":
+                continue
+            self.assertEqual(member.uname, 'oe', "user name for %s differs" % member.name)
+            self.assertEqual(member.uid, 0, "uid for %s differs" % member.name)
+            self.assertEqual(member.gname, 'oe', "group name for %s differs" % member.name)
+            self.assertEqual(member.gid, 0, "gid for %s differs" % member.name)
+            self.assertEqual(member.mtime, mtime, "mtime for %s differs" % member.name)
 
 
 class FetcherLocalTest(FetcherTest):
-- 
2.39.2


