Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C12C61DA3
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:01:31 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.21340.1677254486708000392
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 08:01:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HeGoZmHK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id p3-20020a05600c358300b003e206711347so2053308wmq.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 08:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O85blu3HoonFX6FaxBSyhrxxkj4QEzpy3SwhVcEuUrc=;
        b=HeGoZmHKchiqlI64FKVOwh5S7Omsn2pPPiQ58wQU0x3XczbQnYuizH4sFM1nJaZgSz
         2G5QghxC8sThz4Xch4D5EIS9OjFk9D5q3fEpAshZ9zdqLzuRZgVcrnSu6wFmTgirf++q
         gx0yPhKj/vasZb7y+RZ5lIyaP8ueJVTKxEeKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O85blu3HoonFX6FaxBSyhrxxkj4QEzpy3SwhVcEuUrc=;
        b=YUOpaeSDiYiN30caP7yObn2cH5NPSkFjtzBb5Zz5gLSF8uDN7y+D3KyYntV/O6SAsg
         xsAZVC17xpC0tkv34fcxd/IFTurI8YCyfhq3oC0GaoGz1Y+L4RrSr0a8faEygSfLg0G3
         /Sk6p8RCz8e1ubT1nGKLs4kVpOXixmSSUJtkrvfEBvVqKKUX1sME1t7gjvCI/+F92aYU
         ceV8O43TDvWc7IaWvh6AJ1I2JBSqk2Jh5/ydmdNLKOPr3p3B3tkfXmgJJL7FQTIE1gL4
         35jWY41cSjMrqMWDyiOQnt4boDkEmO95K/S5BxfD6YHL1dcgp75/G1LHuMy+QEmj/jpw
         GyPA==
X-Gm-Message-State: AO0yUKUb9iHS2Ymnyw04hRGfJyW/4fG4px1xEjWV2Z4xmhx0Cl4gDRFu
	YJFECyXdCV+IEExFBAKejAz5NvYB7Zqg2C3N
X-Google-Smtp-Source: AK7set8hh364z23NwgJT72EZn6UccBGCtYnfclHpudBecTTnm6Ly2B9AsBGzv35yn/pNM1ADnQ9WuQ==
X-Received: by 2002:a05:600c:600a:b0:3dc:4316:52be with SMTP id az10-20020a05600c600a00b003dc431652bemr151912wmb.10.1677254483738;
        Fri, 24 Feb 2023 08:01:23 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:639b:9979:fd5f:bbb7])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b003dc3f3d77e3sm3215403wmk.7.2023.02.24.08.01.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:01:23 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] utils: Use internal fetcher function to avoid duplication
Date: Fri, 24 Feb 2023 16:01:21 +0000
Message-Id: <20230224160121.321885-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230224160121.321885-1-richard.purdie@linuxfoundation.org>
References: <20230224160121.321885-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 16:01:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14488

We currently have two lists of "proxy" or "fetcher" environment exports.
Make the one in utils match the one on the fetcher which has a more complete
list of variables now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 4446997e42..0624a4f3e9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1698,22 +1698,11 @@ def disable_network(uid=None, gid=None):
         f.write("%s %s 1" % (gid, gid))
 
 def export_proxies(d):
+    from bb.fetch2 import get_fetcher_environment
     """ export common proxies variables from datastore to environment """
-
-    variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
-                    'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
-                    'GIT_PROXY_COMMAND', 'SSL_CERT_FILE', 'SSL_CERT_DIR']
-
-    origenv = d.getVar("BB_ORIGENV")
-
-    for name in variables:
-        value = d.getVar(name)
-        if not value and origenv:
-            value = origenv.getVar(name)
-        if value:
-            os.environ[name] = value
-
-
+    newenv = get_fetcher_environment(d)
+    for v in newenv:
+        os.environ[v] = newenv[v]
 
 def load_plugins(logger, plugins, pluginpath):
     def load_plugin(name):
-- 
2.37.2


