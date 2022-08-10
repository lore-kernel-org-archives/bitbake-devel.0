Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608EC00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 13:43:55 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.5758.1660139022440384019
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Z/cVKm3r;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 az6-20020a05600c600600b003a530cebbe3so1022685wmb.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=OmJ9ghvtoiiKVUhO31w6bEM1jqcGy+qMdiO958bL8yU=;
        b=Z/cVKm3rejtW/mmf2hVPlCkOT/QLtHKkuxF7KKI11JVzQZkSNUz3fCbKWje2948KzR
         Kc3ZgxRdOtYklvjXWPpdyvOS8oVbtRk4dGpvIW89XfplNms6EcFExxQ3eOSeU+lMtqAs
         vVM0BJOY7nFE5pGbZwr6IwyQOhFlUWXCuW904=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=OmJ9ghvtoiiKVUhO31w6bEM1jqcGy+qMdiO958bL8yU=;
        b=V5DgLE6P+wLhjXZbjeUCJJHp2m2Z1suYOR4hev24+eLPqlybjEx77nifeAH7+Z21uw
         SQuqB/1xd0yZr4cB+LD16AAfcti2xPWErt3pc1RVtIxFnYD4Jkyeaw77j6LuMRg+Lq0l
         jQUGzo5fFJSfqgthcaP499JgXUAPvsZgzNRGQIfVk4L/b88xs2cK/8hS3O4RlCoPU/+6
         6l7YsBtVWRGU4NmEShvuz3qSVyoD8w8IyIt9SX6cc73riy3Qg5FtVZh189wcy6mJhHR6
         52mf52YSqXZXITRx6hALhwdRWpGgD2o2JKKm9ItPFukbglWLpf0q7xM9J79jPy9K/1XD
         AL8Q==
X-Gm-Message-State: ACgBeo0V5NPLn9EmoUCzu0jdsB2/eQyWbvrLn9fVeMNgKreZh00VNh0n
	f9vDJuvFNkTPumpQkBiKfKZml/5JvzZrxA==
X-Google-Smtp-Source: 
 AA6agR5cG4jiKB9THAh1/fc7o9rZ5Jt97v6QnEX7hZCca0PgE/YTbGDz3g1CWo418agLqUGwBKHRIw==
X-Received: by 2002:a05:600c:3d93:b0:3a3:3a93:fb16 with SMTP id
 bi19-20020a05600c3d9300b003a33a93fb16mr2647627wmb.190.1660139020343;
        Wed, 10 Aug 2022 06:43:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b003a540fef440sm2917768wmg.1.2022.08.10.06.43.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:43:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] BBHandler: Make inherit calls more directly
Date: Wed, 10 Aug 2022 14:43:36 +0100
Message-Id: <20220810134337.420149-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 13:43:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13881

Rather than recursing into the conf handler code, simply call into
the parse code directly when inheriting files as we've already resolved
the paths and don't need anything the other codepath brings. This
makes the codepath clearer at the expense of some slight duplication.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 532a4e08f1..1189114341 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -63,7 +63,10 @@ def inherit(files, fn, lineno, d):
             logger.debug("Inheriting %s (from %s:%d)" % (file, fn, lineno))
             __inherit_cache.append( file )
             d.setVar('__inherit_cache', __inherit_cache)
-            include(fn, file, lineno, d, "inherit")
+            try:
+                bb.parse.handle(file, d, True)
+            except (IOError, OSError) as exc:
+                raise ParseError("Could not inherit file %s: %s" % (fn, exc.strerror), fn, lineno)
             __inherit_cache = d.getVar('__inherit_cache', False) or []
 
 def get_statements(filename, absolute_filename, base_name):
-- 
2.34.1


