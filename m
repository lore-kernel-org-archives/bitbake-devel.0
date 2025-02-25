Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13612C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 12:10:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.6519.1740485399367366042
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 04:09:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AB3Ik0we;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso34565785e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 04:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740485398; x=1741090198; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeQ541r2r6Lnkf9y1cu/BysmvQ2Qthf7sYn7g7b7vgA=;
        b=AB3Ik0weHCMIGBw940gwE4sG08YZjfU/QlEvnI52/GA+EzZVnW3/Le7q3uVLnQykMI
         wOMw4mn48g0Rqel4cczz+1nnu2cAedoeKzIrHXdz7QSc/mnIawJKxCq8S/oaH60dYV2T
         pZH14dSwzvhqmpTgjWFV83GWjwTk/jRECqk+8GT7pEycovXtZnPppoSrWv1K+EgstQRz
         drqdG8yt6DjA4pVR6+5wbOyLg4IAPajhseVDGeFmGhNVfknh2whs6JhtglonlZz/PcbG
         saDXImkgD4/KZ7wfV12RtPk6NqmFegQCQXui3ca4BFA75G0a6i8DN1hfV/JwHK8jN2eA
         roUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485398; x=1741090198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeQ541r2r6Lnkf9y1cu/BysmvQ2Qthf7sYn7g7b7vgA=;
        b=gAz63nosoMlS+NWu4Z+zwnXjTVhxxL2DE/sFS1lhCaH0c5f0MM0knvZ3Y0hyFfca00
         qyF9AVLwXsJv/uVgvr0l2Mq5017tS7hetfxrvL1ApX5+mJIm+RsXzD6CQQoO+eavBvv+
         YiY6QtbkZC/b/773zLhxRHKf/Bgku7X9vYiYnBApwYMDIHcQrr78C9Kn2tgNtXuJunMB
         1Y50jneH3IbtUL8uBtScWHkad3/UJEs3PMrQGW4AmS88+cLva/WTkwLZim4+Edmr8oir
         xJEXfco7twKKM9xxq/y5RvE+llAkZ9mGurLyjh7xyd8nZlkSdvczC6CuIuyAuyDNegQe
         iMqw==
X-Gm-Message-State: AOJu0YwzRtFOgEb+xEl6DR0tjwa+xNLsmAd4K+3DHMyhpzkmuk7rOaVM
	hc0wuLHZhLGsPqriJta86MSktpKRdHbTDpZGzU/h4ERwuUbjbOo8x7Vx+A==
X-Gm-Gg: ASbGncvgMPqkAS1BgGkD4z14J6lzS/+8BSXve4vOyfnmRfTTgDMwSoN6KpzLMz/FLLt
	envuJHqQekC3yoGdEKacyq+XE/ZIWYArg8HGJ4lEvp55dzeiOtevCjK176XGNaiA7sEFNLMK+GC
	3AGnMkeqo1xflfP/b3JDMRsLy/7cBfCyhlCzL0AeGiWPVPdQk+wGqTCZijAaf7Cq78J6IvZ5bT/
	j9zYJNvnlmzi91Ke4dvqtHTmPsEDvRXlx8MJBpbW8vTA0hPE8ZtciKq7sBSA37lWYvaJitOlJhW
	jscWEwAO6dV0BXwdu+GMc72q5pyjqUXxy0J6GI5U6IegN87AOvEwxjjgPZo2gk8=
X-Google-Smtp-Source: AGHT+IG8MRJRerTP4iM0sYct+hWq+tXR+tBZ+gd+0ckEDxB7G4gH8PNVaRiYC/iyRIMx9otsE57bWQ==
X-Received: by 2002:a05:600c:3515:b0:439:9828:c422 with SMTP id 5b1f17b1804b1-43aa4c44c11mr70493565e9.18.1740485397448;
        Tue, 25 Feb 2025 04:09:57 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f24acsm139997455e9.21.2025.02.25.04.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:09:57 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] lib/bb/cooker.py: make BB_HASHSERVE_UPSTREAM issues fatal, write specific error messages
Date: Tue, 25 Feb 2025 13:09:47 +0100
Message-Id: <20250225120947.172025-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 12:10:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17314

From: Alexander Kanavin <alex@linutronix.de>

Previously if the server couldn't be contacted or websockets module was not installed
bitbake would only print a warning and continue, resulting in a degraded user
experience due to inability to use the configured sstate server.

Let's consider these as fatal misconfigurations, so that users can address
the issue properly and not wonder why builds are taking forever.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/cooker.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5b885cddd7e..668596c5cdb 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -316,10 +316,15 @@ class BBCooker:
                     try:
                         with hashserv.create_client(upstream) as client:
                             client.ping()
-                    except (ConnectionError, ImportError) as e:
-                        bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
+                    except ConnectionError as e:
+                        bb.fatal("Unable to connect to hash equivalence server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
+                                 % (upstream, repr(e)))
+                    except ImportError as e:
+                        bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
+%s
+Please install the needed module on the build host, or use scripts/install-buildtools from openembedded-core.
+You can also adjust or remove BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times."""
                                  % (upstream, repr(e)))
-                        upstream = None
 
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(
-- 
2.39.5


