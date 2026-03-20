Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ECE109193C
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 00:26:17 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2588.1773966376608808765
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 17:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=m4wHKFGb;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso944905e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773966375; x=1774571175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7ch6NEFQBLiey3BkCQwVphC2JH8/he69fIO2/9bYmo=;
        b=m4wHKFGbiEGRkHmaUfVb8UEZDSoFiIeG+oMQv6HGQo9Ei7aIubGKLR1FBScwDUmcOk
         zrjIrqVFvP0PO5rUlHfSwBvgRd8qlWXuYMox2jgiXXJY3N0Y7z03FcQa2QF+YoBcS+d1
         fRKnSqbIYzZC325SjtJhosVKvU8kLiuPuQSfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966375; x=1774571175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7ch6NEFQBLiey3BkCQwVphC2JH8/he69fIO2/9bYmo=;
        b=RlFeHAq26ePAmAMVGlDl9545LwW+LPwrDELWSATgf9Xepw4wi4ghKEBWlUGtMMkt97
         8o8ecSKJMVUddxpvLCY18NpZxShU8F/QRItRVTU4kJLM6eOsNW7hxPg9Tka+oxEdP27A
         ZgG9wsv1NFZdFLDxipBdTM9cxJhTyHAmHowoWyvOJkaoi4ZE7+5QhOZN14i1C9QzOefn
         S6YQmQJ+6rUVTK6dxA1DJpnQsEumVlyyCOpUWnypEKzYLh0HR6OSQnqQlT3C1WZw77Q4
         TdVsI3ontATCacaw41YDgsPMRu5dc0M7FRkaQB/JZDF8ID06iJDqGDlA9kKTlDUF+KhY
         mqfA==
X-Gm-Message-State: AOJu0YzFMKdoKUBF4mxbZdzwTV7Fix6DBQXH6dtivDos75WgKgPc8mRG
	lmqxO5HAcw44feliscTP/Dnff62AijNfQnm1vG6wxBgYr7WuETAIdNCXxQuxVGk6otOSKXfB3HJ
	xlfQk
X-Gm-Gg: ATEYQzzqdfbVqqH+fw+56UctQuTUuz/vAs7E2hdFDnUt/BwohIL6i/2yH+7+m8ANJ71
	myu1JboSUy82aw2TQcUju+F3Mwx2LL5ScacbTXzYjVeHlbwmVNLxeQXrPtWXf5ruAdUXBbOCeQ3
	6zod2nxR3UH9cXqEeeLFvilYfd3fd9Kca9LhwcddbQx1FAp9EngH3DUT9xzJO4KDJLl+SOE35kh
	Ocdic0JGPi4HleIO8okFKD6AvkJXhV/oxrzpnx2mxPhsO8EIHNK/kKzaf+AozOx5b8+2xAiXFRj
	Ss3pNtAm+YV9LygUl2WdzMqzyvC7nUPE/HpwGanbTsqvC3ZGKY9h1ew0vYaR5QRwh9QBLR/ljpe
	dcfb/oDdFzUE0BiAaZcMVNUGdvSJcBfUv0BUpTgoFfg1Al2TdD9P+QlsMc0Qz415Iu36asg5f4q
	hfrvAbKtj+NqguC+8uUDcuRlGEue67hHJIiPQRYAgAdO+JaOob2BIa9ks4NOE1ttcmbqexKlVZd
	+JmjCIdmb4M7QQjgHDZMRHEFQU0c/8WrztX3w==
X-Received: by 2002:a05:600c:5291:b0:485:34b3:8589 with SMTP id 5b1f17b1804b1-486ff04d42fmr13976135e9.31.1773966374678;
        Thu, 19 Mar 2026 17:26:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb4309d1sm106036545e9.3.2026.03.19.17.26.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:26:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] gitsm: Add clean function
Date: Fri, 20 Mar 2026 01:26:09 +0100
Message-ID: <6cb07e8c702b750c5047dcd646ca72ca5f75321c.1773966318.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773966318.git.yoann.congal@smile.fr>
References: <cover.1773966318.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 00:26:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19181

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
$ bitbake utfcpp -cfetch && bitbake utfcpp -ccleanall

The downloads/git2/github.com.nemtrif.ftest won't be cleaned without this fix.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 79f25fc5c1b8d0e08540f4aa07875309f5325f47)
Suggested-by: Michael Siebold <michael.siebold@gmail.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/gitsm.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index fab4b1164..ba62517f0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -249,6 +249,19 @@ class GitSM(Git):
             # should also be skipped as these files were already smudged in the fetch stage if lfs
             # was enabled.
             runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+    def clean(self, ud, d):
+        def clean_submodule(ud, url, module, modpath, workdir, d):
+            url += ";bareclone=1;nobranch=1"
+            try:
+                newfetch = Fetch([url], d, cache=False)
+                newfetch.clean()
+            except Exception as e:
+                logger.warning('gitsm: submodule clean failed: %s %s' % (type(e).__name__, str(e)))
+
+        self.call_process_submodules(ud, d, True, clean_submodule)
+
+        # Clean top git dir
+        Git.clean(self, ud, d)
 
     def implicit_urldata(self, ud, d):
         import shutil, subprocess, tempfile

