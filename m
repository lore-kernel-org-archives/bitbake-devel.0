Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A66CEE020B
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 19:04:43 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.5857.1694631877224552636
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 12:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=ijfAeiAR;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bdcbde9676so80980a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694631876; x=1695236676; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp7z320JJ6JYEJx2hv1rs2qxS6RNfYbNSqdZg8Qwo6Y=;
        b=ijfAeiARHSRycLlfD2ru3Ei6uMTLoC6GaJ4zS2glTdlFFJZUIWmh5v3kkBKeOoduwm
         9I6QM5caeeGj4OaH6w7iMny1IthSREyC7SUpTnDX3MI7Xd0VtWoCImifFuyfURreWbYt
         CZYp+KvKmzRAvuCkAKrazHB7l7Y/pLRg0eW9p24vgGMsxSYE6dCGE+tEPJLm/gjNfAy/
         9EG0FLA0HaA0f2cyuunBfnipKWvRTJswOewFiSr0bKSsIEgqOO6laZ4ndGnxqPlMGOMz
         g4+5n6D0DEOMXEUVxzq4b5re6YldvHMM7y+nz9jkZHKcIJrWQe8e74xfppgJ0MM/tBS7
         PZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631876; x=1695236676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp7z320JJ6JYEJx2hv1rs2qxS6RNfYbNSqdZg8Qwo6Y=;
        b=kFISdjla6hifPZHA/G11FtTWopUdA7F+jRvyGBHE+3rHhlcXDPaX5NGJew1ijKbKVB
         kJbpVE08MMNR5HDeqt9q2l9hUqfpg22slu9TTxyrLPVLnih8ZEeS10Ig3x9CEVjIOReb
         3AiVWTsNFM610zA7mF1KvY7tkOGclO0ripKZ+L8qiNWOlClnnKW+IX0HG05Tunq0uQ3D
         boWPRlroSja7yUpi0e1OcxpEJt5LvDKAFkWLVYQ+EdxumPADVUiMKEKF2gCdqjEkflAT
         HXjKEniaQeeUmVqwCBuUH2DaozRVs7P52D5St/pYr1t4sSecMQA4cQg61E6PVm8xYI5p
         GwpQ==
X-Gm-Message-State: AOJu0YzW2fTNrpXou0GQ31K3CLdtegWuA8vCZHlQxp13hVfiIL6zAIeO
	p8UKWdiTEFtk31bnBx1eG/77HND5EyQ=
X-Google-Smtp-Source: AGHT+IEyWL9y/85yTcese3jpaN9w8g8FWrZ418eRa8bXU9QT+RDy77GwLG1Ykvl9pPRe196nCU2lZw==
X-Received: by 2002:a05:6830:1bd7:b0:6bd:680:dc13 with SMTP id v23-20020a0568301bd700b006bd0680dc13mr3999549ota.21.1694631875896;
        Wed, 13 Sep 2023 12:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::88cf])
        by smtp.gmail.com with ESMTPSA id f16-20020a9d5e90000000b006b83a36c08bsm5189593otl.53.2023.09.13.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:04:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] utils: Add path_is_descendant()
Date: Wed, 13 Sep 2023 13:04:24 -0600
Message-Id: <20230913190425.3761792-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913190425.3761792-1-JPEWhacker@gmail.com>
References: <20230913190425.3761792-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 19:04:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15056

Adds a utility that checks if one path is an descendant of another. This
check uses os.path.samestat() to make it immune to symlinks and bind
mounts.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/utils.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0624a4f3e9a..b401fa5ec7a 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1828,6 +1828,29 @@ def mkstemp(suffix=None, prefix=None, dir=None, text=False):
         prefix = tempfile.gettempprefix() + entropy
     return tempfile.mkstemp(suffix=suffix, prefix=prefix, dir=dir, text=text)
 
+def path_is_descendant(descendant, ancestor):
+    """
+    Returns True if the path `descendant` is a descendant of `ancestor`
+    (including being equivalent to `ancestor` itself). Otherwise returns False.
+    Correctly accounts for symlinks, bind mounts, etc. by using
+    os.path.samestat() to compare paths
+
+    May raise any exception that os.stat() raises
+    """
+
+    ancestor_stat = os.stat(ancestor)
+
+    # Recurse up each directory component of the descendant to see if it is
+    # equivalent to the ancestor
+    check_dir = os.path.abspath(descendant).rstrip("/")
+    while check_dir:
+        check_stat = os.stat(check_dir)
+        if os.path.samestat(check_stat, ancestor_stat):
+            return True
+        check_dir = os.path.dirname(check_dir).rstrip("/")
+
+    return False
+
 # If we don't have a timeout of some kind and a process/thread exits badly (for example
 # OOM killed) and held a lock, we'd just hang in the lock futex forever. It is better
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
-- 
2.34.1


