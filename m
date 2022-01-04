Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1089C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 23:11:35 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.1094.1641337894650674416
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 15:11:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WPxVR8IK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id o30so21713625wms.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Vu5VGNLM8bs8V9HBZ90mOH1lbVqm3/CPVmXvdH2kM=;
        b=WPxVR8IKUaHJ7rQShJKnyu97X++2zLpDtC2g0ELYBvDmKhZkI0F0se5mzo7mA1jeLn
         q5OSoneRYgvkjrZTg0AFSZU85ZnNDMetAcBosLK/PvxINBAWulC4rGLQ0ST0WeqnNTY3
         arFYKcgwOQf3sLLverjMqXx2ZInqKAp5FSW1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2Vu5VGNLM8bs8V9HBZ90mOH1lbVqm3/CPVmXvdH2kM=;
        b=cGHLx83SqRBtdzS/WX7wwW+Lc8t8B/eNVL4+A4yK+mbiRAFI9tGhz7yi/JiCj/ZIqT
         zRnEQ0Ord6ZrBFuB/2QVQYCaTncBDqfJrtOVbFAFYtE3RbkDAePG1CpXvDk2Rojbpy15
         ZAWhK0dlss+c0Deu0nnZEJxVU4A7pasbb9UwcLVyO12eorituHXw5/sg14wC59TtyTK3
         lgW7ms4N+ZI0ME0XFWNWYzfK2ZsuhGwCapnug98sZgQXAWVamUb8kAhT5P0DX8B3hNTf
         pecCQD7dDsf0T9YzH1Tk6NlBJv8GbQJEN2vCmb5q0ryTuMADJuLvNXRnKOhIG3fTsk54
         dUYw==
X-Gm-Message-State: AOAM532xL9TTbtnL3kLpYTfE6CMcIWJE0WRpOIq3u7voqjRlaQVhW0pc
	1QGmxfG286e9vZjjXQFwORXCnLahC4oaKA==
X-Google-Smtp-Source: 
 ABdhPJxGOAS8zMvmVMrl3CLegYCP21/EtljSq0EfP6fFH0hBAOT22dcZvMw+rGDFal6QaqrMrKMXdA==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr475197wmh.68.1641337892932;
        Tue, 04 Jan 2022 15:11:32 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4930:6fc6:9dcd:7b1c])
        by smtp.gmail.com with ESMTPSA id
 l14sm34391331wrr.53.2022.01.04.15.11.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:11:32 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Update to use exec_module() instead of load_module()
Date: Tue,  4 Jan 2022 23:11:32 +0000
Message-Id: <20220104231132.1383733-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 23:11:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13220

This is deprecated in python 3.12 and Fedora 35 is throwing warnings so
move to the new functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 8006f7bd2d..a288f9bb8c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1651,7 +1651,9 @@ def load_plugins(logger, plugins, pluginpath):
         logger.debug('Loading plugin %s' % name)
         spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
         if spec:
-            return spec.loader.load_module()
+            mod = importlib.util.module_from_spec(spec)
+            spec.loader.exec_module(mod)
+            return mod
 
     logger.debug('Loading plugins from %s...' % pluginpath)
 
-- 
2.32.0


