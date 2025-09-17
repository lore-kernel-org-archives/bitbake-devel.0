Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF9CAC5A0
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 13:09:32 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.22455.1758114563768730840
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 06:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ist4HyLL;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e9042021faso2858451f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114562; x=1758719362; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rw60JswBmIOmoQ42N74BPK3IZj5X3tOqBbOdJqttDsM=;
        b=ist4HyLLcBAc5EmrTyxxvHEwMa8DRfE4Ue142w0GLkhIxy6Z07Ep9Yu44hMRboOt5t
         MW5qQMy9B4iKqSfdq+dSsOHG2SL2YHe1BcdyOggmbAThvGm1bFspU0TFQfv8Pcm5DMAs
         v4vE5iM7+Xc7L/THH21jqRdcD2Rr7YSOOeGU1hBA39fVBEacuto2QrVPQwJbMf5uCzQm
         parpDzUsn3ZFpvOUxeehavGfWxzGUh353SzlBrMXrx5qc8k+sS1A/K5SEbzZ4MbxeGgS
         kmSpZf1rL66aLG2jVBBDuA3exwe6Gaa8IPEJAKz0hXutahdrKCC3D4JfKv9bgHLFabfe
         3FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114562; x=1758719362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw60JswBmIOmoQ42N74BPK3IZj5X3tOqBbOdJqttDsM=;
        b=gXcGbZNpTgcGoX9EMDmvcUj6h6Wwd3jnzDEPjmdqwyWK3HW+D5w4RJh4foRgEZJcbt
         k4N5yFhoT17s5Bs5YHmUGxJskzqm4swC3qAZGZfVQpAhu1VDp5TktjWnum2fOopginXw
         lfgM1sNKJQBW7OJBoVRKd/PIXSQpg5aqqzrFYgWIj3CxdgzxS2qWcqtGpTnMo8Yj0bsV
         BhCxX0R21B8Tf8RiCRxGUE+YViNF0G6tyq6UHwemnmb7x4f5+4cUwEe3/+oGPL/4gf90
         LkNrdhenqN1aqiyGTjYS5BcOs+eESgB4WfMOPtsFUGm/9OfgQwZ+J9ZF2bRedLOlosd5
         asHw==
X-Gm-Message-State: AOJu0YzxDg0Ou8V3UMd06ncFwv7hVTV9L8ODg3lm+I/vfIJlpzgO5c5h
	c81yfoHattQIlnmfj2qhKEuxGkoP51CniuW8VT5vqAk7iiIICIGngq/82E3gUA==
X-Gm-Gg: ASbGncvhqJ0v4t7W0wOvNrYiPmLD4QDMO4euJ/qkPbgwEg3WZJn6bQJOrH9S/MdvHmh
	GDejS+ija+o4jnHM2JCqQ3YlWalOrlh2VSaYH2EfQT0Ro+Bj5n1BBTMfCGY+T6d6uo/3w6ZeNKh
	9/jq0+hkjLiy8sX3bmQCLUCDRVFzDZNvhKMCtdchIrGbzwF0HEW0zLdwBaDOTGMRGgJSCVjt7fI
	0jux17ASMhiDlB9lVn0BmFqyAXhxBSGYYh5ZLSzqadu48oMqNSgLX7JXYbsT6fxdANEAm20KTli
	UvHsO6NS78ARG+hStZqzmI4B7rG4DWlkOHQP0tdnIKZSfPCAAoUq87rkGAJgwWbgX+vRsLrGNrj
	QcFokrRg2OLjecMsnQoywvRm54VNoCOa+Lya8j6FuKZ5lXbOtiSSbUVPQhDNBQUKDNxY=
X-Google-Smtp-Source: AGHT+IHm2ln3K0wTZOSIyuwbZu+9yhKFG0WelWQVUsL7ouWTlCagsKl93vc825VPHEQIE80nGKdqiA==
X-Received: by 2002:adf:ea85:0:b0:3ec:ea72:ad53 with SMTP id ffacd0b85a97d-3ecea72b05fmr472807f8f.33.1758114561930;
        Wed, 17 Sep 2025 06:09:21 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46136daf992sm41962685e9.1.2025.09.17.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:09:20 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.8][PATCHv2] bitbake: Bump version to 2.8.13
Date: Wed, 17 Sep 2025 15:09:13 +0200
Message-ID: <20250917130913.2489819-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 13:09:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18052

From: Martin Jansa <martin.jansa@gmail.com>

To indicate compatibility with python 3.14

[YOCTO #15858]

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f494eaa13..74f1517e1 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.8.0"
+__version__ = "2.8.13"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index f59c2515b..91a56f46e 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.8.0"
+__version__ = "2.8.13"
 
 import sys
 if sys.version_info < (3, 8, 0):

