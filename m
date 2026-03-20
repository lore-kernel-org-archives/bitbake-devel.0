Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997031098799
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 15:03:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15029.1774019017741635010
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 08:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FCKi93c8;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4870206f73bso2827885e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774019015; x=1774623815; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRlWjYAxTjgu09xRrYvad1lZ06Zx13fRvHxlh1szo8M=;
        b=FCKi93c8HQQHeBwXrAUkFTCkMV3QGb4H3aru2HOQjxd68phqMhdpAqTcwgShl8cvjm
         ogZGMr0jHShmEk3BWWnurI9NiaLIXB6xoEGCgEIajhTYzDr6cgvhByttnusfQYsX3N0y
         gXCd2RsMtYq4bbiN0goP5IjMGfpcH8mFDCtpqRTxFBBFAAjkHCJRrYznZP9yJH3Cslyt
         FYIFbXSdy9QnDY9zy9ql7vIkXF9S4XOSFixGyCPbKCoissRI676KFHVaCUJAcywedz9y
         GJTVnL9Un2WYb+I2yHpJWlFR2+/8wqE3q8m45W3/Z82o1UWald6fUzUNhiljO1Gf2oxK
         DpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019015; x=1774623815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRlWjYAxTjgu09xRrYvad1lZ06Zx13fRvHxlh1szo8M=;
        b=oLHqpK0dVDPx6QpCiFbfUckltJcQuvw7vp8usLjrrxzKiUQj6bqcc8wbX9hrGFivrL
         Z6ol0UXaXlQ4G8KtfT///BKecDoR9fnma/28kbaI4sTbUPxpBscys045bDwKpG1gANlo
         OQuexKWcHFGRI1+q0qQYsVIKg5sPuCBstj53aRQgjqI8OaV+Pmci08WJiMcBqC2gFME2
         uZFK9YvV5ILXI2RVa7xnhHMBeLI2fWRK9swyDE8GFfmVfmiz8gd1cbTMB4xTRTzTLAPy
         fa+8SHdR17/1LT2jsrVeLEwSn90NcCaXOvJYBek2OvoBXVWStfLPdNZ7VrHDp78SL3/r
         wesA==
X-Gm-Message-State: AOJu0YxnMYp+Qfqz6nbCBZFuTyhHR59+QAKh3lKy/8ZTVQxb7NU2ihl2
	BWARUnudQpoJgtrC8aTAkue9/SxEkC/2BmtddVfnSlGLuSatAOD+DEtCMhnOOBSxLwdspJqK2Jf
	nzk3zII/hUw==
X-Gm-Gg: ATEYQzx9CxfMRzB4tkmBs5nxg3D3fxgp1PEjMOFT6+l74zmYMSVOt+KLh9TOaqvG4to
	CZkzdMZsKA9PRRI/GavePsO1wdwx9myBYtcMx8+QugVIm6zI+AGhh0FOcB23GNtbuzv5WyqrLTK
	yprg2jfXFE0TrVFGCn0sZe6xA7OQkXHlnlQvcMudzSWyEkASfKMmk1Vddx0X03D6aW3Nai2k/WW
	HN3BAnWPdV9hnGzEQ/V6rsPtUx/ncujD/hH+IvzqiKUDyjIt8C7v9QJ+fJbs79/EdorB0k2Uo17
	d7Sv1cB8tU//FDiQ3e6wRlYi54beSwIxCxb+0HDFgeYbPXw8efbXmWch6vPCpqXPg3lsppT+fpe
	+1+ktBq8NPKq7iz/JmVP+72Ce51Wfh+bIVWSB/1cVBtPpBtBL3yCzgW9SXala3kkuFRB4li0t+l
	7429DeQ7KBi5MM2yiTjG0fC7ScoWA+wHjZzZnpZqPYUTSIkSdj4UYwsoAZ7YU6Ak7KSHNsTpVR
X-Received: by 2002:a05:600c:a55:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-486fedc3db0mr49876215e9.14.1774019015412;
        Fri, 20 Mar 2026 08:03:35 -0700 (PDT)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm132096145e9.8.2026.03.20.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:03:32 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: christopher.obbard@linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 3/3] doc: document bb-local-conf-header and bb-target
Date: Fri, 20 Mar 2026 15:03:12 +0000
Message-Id: <20260320150312.1243270-4-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
References: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 15:03:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19194

Describe two optional bitbake-setup configuration keys in the user
manual:
- bb-local-conf-header
- bb-target

Include behavior notes and a minimal JSON example for local.conf
injection and setupdir/build-target usage.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../bitbake-user-manual-environment-setup.rst | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index f7580c8e0..fc9ab12ac 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -847,6 +847,29 @@ They contain the following sections:
    -  ``bb-env-passthrough-additions`` (*optional*): List of environment
       variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
 
+   -  ``bb-local-conf-header`` (*optional*): Local configuration lines to
+      append into ``build/conf/local.conf`` during :ref:`ref-bbsetup-command-init`.
+
+      This can be either a single string or a list of strings.
+
+      Example::
+
+         {
+            ...
+            "bb-local-conf-header": [
+               "MACHINE ?= "qemux86-64"",
+               "DISTRO ?= "poky""
+            ],
+            ...
+         }
+
+   -  ``bb-target`` (*optional*): Default bitbake target to
+      use for the generated ``build-target`` helper in a :term:`Setup`.
+
+      If this key is present, bitbake-setup generates a ``build-target`` script
+      in the setup directory. Running ``./build-target`` uses this default
+      target. Passing arguments to ``./build-target`` overrides the default.
+
    -  ``bb-layers`` (*optional*): List of layers to add to the ``bblayers.conf``
       file. Paths in this list are relative to the ``layers/`` directory of a
       :term:`Setup`.
-- 
2.34.1


