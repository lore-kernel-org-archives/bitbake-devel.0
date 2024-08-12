Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ACC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 15:53:46 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.49925.1723478019690460166
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 08:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XctzoNCd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.175, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso49653801fa.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723478017; x=1724082817; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2vrfvZUlWDOvg+x6JdndqFmbSLr3uPkkPHr9QAnR+g=;
        b=XctzoNCd40nR4CfgIJMth9Mk9ktxaKiZkHzDwNeUmt3+lLjhWAJQEOWKAKTLWQJDzl
         k86AhJLemJMPyJs9VO2IpikOlmonhlikec+B1vALVAIWZgKbSSSo/UDNPngItIKeiugq
         /WHJ+EELDkMrNcJrMJzbc+2MAzNUpltTmxQvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478017; x=1724082817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2vrfvZUlWDOvg+x6JdndqFmbSLr3uPkkPHr9QAnR+g=;
        b=jGHnaO7QvSbo0R/Nc7VWtqe6bDK78Cjft0z3qkrYe860N5JymgJScPd8gQea/GR2sR
         v00UII/BYCeXrYWs017/s6AM7We92k2Mz8833xyxLrZbZtmmQheWAVi2/1E1MLjdkh0j
         Jqx7E4bdZEBN8p+pDHlRiH6NZlaVgL3XzHDcmCCzJ1vsmZysvafrtIXURuZ2LkFGmg6x
         WCxX7Zvr2cgduSETZvduNgf8Vb5VC8SZf06CT88Zxu8TOLw7PhbFCL7zA6B6b/3Hktyw
         uh3a0NStB8+HIr/r4ppsOYPb82ZcYu+rozqlWNKnZD005YNlQ+KuKLZzTqjJgWkvwUDG
         1tjw==
X-Gm-Message-State: AOJu0YyeGKPGA65SzQ+ZNhp9c6iGyybmlnSouPmypmr98VNVvEDuqCby
	T9OCKrPUM15lMQtFpwuUOAT63PgL/m5BDaXErj5hK6uPMQKG4rnsCaFkMz9OUkpCICFjHRNCXQN
	Ar3U=
X-Google-Smtp-Source: AGHT+IFq/Pf8IqmLe2cl0WqQDh4pI5BZVWaa2N7ITLIRc/uTPGdXDkDsVIMXa2v6hasw/ytjmptZQw==
X-Received: by 2002:a2e:be27:0:b0:2ef:28d2:39cc with SMTP id 38308e7fff4ca-2f2b7146aaamr5493951fa.3.1723478017106;
        Mon, 12 Aug 2024 08:53:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:450:fb95:e7af:f3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372e8sm109970015e9.33.2024.08.12.08.53.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:53:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] cache: Drop unused function
Date: Mon, 12 Aug 2024 16:53:32 +0100
Message-ID: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 15:53:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16471

I can't spot any users of this function and it is poking at variables
inside cooker that could and are about to change so drop it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 4a96f5b313..c48feb7138 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -779,25 +779,6 @@ class MulticonfigCache(Mapping):
         for k in self.__caches:
             yield k
 
-def init(cooker):
-    """
-    The Objective: Cache the minimum amount of data possible yet get to the
-    stage of building packages (i.e. tryBuild) without reparsing any .bb files.
-
-    To do this, we intercept getVar calls and only cache the variables we see
-    being accessed. We rely on the cache getVar calls being made for all
-    variables bitbake might need to use to reach this stage. For each cached
-    file we need to track:
-
-    * Its mtime
-    * The mtimes of all its dependencies
-    * Whether it caused a parse.SkipRecipe exception
-
-    Files causing parsing errors are evicted from the cache.
-
-    """
-    return Cache(cooker.configuration.data, cooker.configuration.data_hash)
-
 
 class CacheData(object):
     """

