Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E871098797
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 15:03:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15020.1774019014878299330
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 08:03:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pmakByPi;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so19349675e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774019012; x=1774623812; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBco/5MR/qFsiTgsx+QAWHKMY1U8GDhvFKRm/A/bAAk=;
        b=pmakByPiTEh/df6iW7nQ7IrrpDETgcnGcCoBQEVsnAuKRriGIUUYk8s+pflq5F/rj4
         y/XwY3JY5hgdp0PhUVhcBC+l9tS44ykPofQwzqoked8TtyEN6ZoEFmC9J9AIokLQ60pg
         XAV6pIbcS2QI/VK2sZNb8yG8nzpsbluhEw76TAp8ZBR5nwkyp9jmukvNoZWREGTG7pz3
         8jln8k3cZEObZHfVS/eHNRegLcyNHSYcm2cLNwBtFlfsiL6ugbFlz+l7CWFRKfclyAKo
         zIKtEWIn22nxqitig307zsm+X55gTpLZoI4s4HLjVLI+kSxTHWy+3so0CChdNsX11LRx
         rgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019012; x=1774623812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBco/5MR/qFsiTgsx+QAWHKMY1U8GDhvFKRm/A/bAAk=;
        b=rqG0yIbqR3ueAfCpVyq3z3YWyHmUzf0iSTgT1CYLYlSAkIN6hPDnO65LtaO8eDv9pd
         xTXohvTNMV0VOaBZ+VtvP6yAYPLatOQWr+0EkBzntSZmVqgCzm+ATNhAtI6VXp6bxuFP
         O4y9H7f0tbwU4eEK+TuT4z7fcZ0+/2af8Te4zZ1k0FOcLVdHv9Ppw8NxRxaQNgwkVKHQ
         Vj+NjLFwj5D6giNiIZLzLSNp8qBiUhiKVPEmFWWfYkU8+t7AI97umz77Oye5HNAyuaZW
         PWJ9WfrwHS8MBX+Pk4kNz1wGH1Q/DcO6LVUerdm9SguReebH/oiJzaVVxJTKLPeqNkjX
         p5iw==
X-Gm-Message-State: AOJu0YxIJMjiNIQIbf+rhPhVJWqXAwBX1oStoDjzj+jLdJeSOk1qURSx
	yXmxv/+iMbt0uAo+UPwH5Obb95+15J+XthzYI8G70zpYgIjI597vjChdYHv4yAQnswMyL1kMD+V
	28bz2rqSKKg==
X-Gm-Gg: ATEYQzxH+aA9Z/NXkxm+6H/vSuf41RQUHRRaAUFFvtqKIbgjJ2pjx2HgtVBp36XFPEg
	WyGHFoii8ped7vH7CUJ5EZYWo6Sc7FFyxDlLhlCKrtWCm4r8J4GxYkzWOaXnk7DF9D4pUC8BjLb
	c/rr9SBEEVzS759mcmRANhEQjTnut2LahQGUl1QgjYTTmXhm+WoiDm03UR4rU8WDBHzZhnLKhXY
	0w7/F/6B+Ln0V7QQy7v52LcwvTzHw1sFCAXHF0LOZ1a6xQiaj0W5+FiSBMkX0sFc4IysCg6RFKK
	OUtnFQsUyFk6agYIWjCNHCbqJdGT8oTUThkKJs16W4BUGzxSA+R6mWuoP7STLyDDJYD4lzElM7P
	i1C5qxV7JnGK3/1lAtGoGfPB78ERmO3aDONkS2RX5r7by1VHNrB8kXBYnfTKdt32YWHOmeDZcZY
	ls3DXwzpZr3Xk8+9Hlq0b1458eZe490jUiwWQWE7Y51qOFFOQNOhlkXAeJ2QSTdmJDXrhahIWf
X-Received: by 2002:a05:600c:a402:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-486fedb54c2mr41756425e9.10.1774019012207;
        Fri, 20 Mar 2026 08:03:32 -0700 (PDT)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm132096145e9.8.2026.03.20.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:03:30 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: christopher.obbard@linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/3] bitbake-setup: add bb-target build wrapper
Date: Fri, 20 Mar 2026 15:03:11 +0000
Message-Id: <20260320150312.1243270-3-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
References: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 15:03:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19193

Allow configurations to define 'bb-target'.

When set, bitbake-setup creates a setupdir/build-target helper script
that sources build/init-build-env and runs bitbake with the configured
default target (or with arguments provided by the user).

This reduces wrapper-script logic and makes setup usage closer to
one-command project build workflows.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 bin/bitbake-setup | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index edb8c4d1f..04cb15dab 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -361,6 +361,30 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             f.write('\n')
             f.write(content)
 
+    def _make_default_target_wrapper(setupdir):
+        default_target = bitbake_config.get("bb-target")
+        if not default_target:
+            return
+
+        wrapper = os.path.join(setupdir, 'build-target')
+        script = """#!/bin/sh
+# build-target wrapper created by bitbake-setup
+set -e
+
+if [ "$#" -gt 0 ]; then
+    target="$*"
+else
+    target="{default_target}"
+fi
+
+. "$(dirname "$0")/build/init-build-env" >/dev/null
+bitbake $target
+""".format(default_target=default_target)
+
+        with open(wrapper, 'w') as f:
+            f.write(script)
+        os.chmod(wrapper, 0o755)
+
     bitbake_builddir = os.path.join(setupdir, "build")
     logger.plain("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
 
@@ -394,6 +418,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         _make_init_build_env(bitbake_builddir, os.path.realpath(oeinitbuildenvdir))
 
     _prepend_passthrough_to_init_build_env(bitbake_builddir)
+    _make_default_target_wrapper(setupdir)
 
     siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
     siteconf = os.path.normpath(os.path.join(setupdir, '..', "site.conf"))
-- 
2.34.1


