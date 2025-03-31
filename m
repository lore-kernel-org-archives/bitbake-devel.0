Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBFC3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 18:54:36 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.617.1743447272509326966
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Mar 2025 11:54:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P7gMA1+e;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b38896c534so2359004fac.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743447270; x=1744052070; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCX46Dmjt/oAFnPI1PZXG+Cofi+1WabRJNx+tSmsxkg=;
        b=P7gMA1+e81LLw8mtSaDZoWf7tk5thb5pKe3elef2gk9xOhn6EjljtECXItc9HLni4b
         a9CEoFHR3UavOfruW0V8yrhWb6j5zv44dmhu4yFPhx8vGCBPBpwYWlgohmfuxYBzh3Mk
         jvCuIYlh4dEX2qsgnalbhXFbIUpB5TJ4wKc1E0OnRr9MHWSQTWMl7PjOd9O1X5YSg+cK
         wgVvh1L59rUIM8+nEdoj72p1ym3CHLN/AMAtfoeEc0vKIOOJVdtfwCSne/Zqxx1vEnTX
         fBY6we38wDqnQt3058pPe/K7v2Sni9jTQ6PWG3yvIqDF+38BaOURKj6nIyumI7wwyIfq
         3zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447270; x=1744052070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCX46Dmjt/oAFnPI1PZXG+Cofi+1WabRJNx+tSmsxkg=;
        b=KposVZZL0ba8MFieMcJR7zmWGCgCTijfiYS914twmHNwHjXaBXwe1DfGPw4yxFZv+P
         wa1336U8FeEgaW4oJIVNOCTjmsnDJgUW9Jl/alCfE5eqxI8TcVdUfNcTEqfuDL1hbR+U
         s24pjZZB22C9e0U657yncB/JYjbnmBDHvt9ukp/QZkS+OvRnVBCnl+N0j2PIAC3Skw1k
         22MSdpo1oxEH8y+J9lcL7ygkJ0+u+reKAvkXVd4QGUaV7WK4vXdHFcyWQHMcaWRsV/kx
         kxZKFBL9iyIejyN44r2OnH0LQnNIr4Y/CZhB2Pggl9RL28pcT4NXxMy6cJBipeez1Puz
         EZzA==
X-Gm-Message-State: AOJu0Yy+fDVTtRFxkF/UNXPxUNfJflcJSiRyE5hVnjOPYht9QUbYgT8K
	xTdlIiF0ociL/BBPtgAiooVrHS7RuuayJJvi9FmlnViRm7TumGccPSr2SA==
X-Gm-Gg: ASbGncvrbjLVGgVZIpvjnnIl0XaPccH+RAMeqZXjzekeKhdseHhKd/QOP6mxloqggoN
	i/CNtDQYAA17hFfEf76995wrxpjjGiWQ6mwS7ePyZyFJWpBYx+0d8oTsNi7DReCVCrnvvXjB9ND
	EbvV2BnVZlpV2V9FpqAiRh9TiLZytKRxRinAzTLmHZPrdx+CtKre6d3LZIX15SupipDbDIsESjl
	dh3UAUQgQ2V0eW2RgRaUAnTBgIfLFdj3a36QOXbaaytpWYLdUX2pqEZojRPMiJT903qgCAHoax6
	udCdNvc05TICDqeDFiVE+pbfirUoh9xGAMdHSHpKXqg=
X-Google-Smtp-Source: AGHT+IGt+w66qVXm9gh2XiLEZ8eTQvk6MhRrb5Gj0btRc8wfcKU//FqGCl40Jia9nkXN4y+dl7T9SA==
X-Received: by 2002:a05:6871:890c:b0:2c2:5579:7c10 with SMTP id 586e51a60fabf-2cbcf4ed1ccmr6429233fac.9.1743447270590;
        Mon, 31 Mar 2025 11:54:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b36f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c580bc441sm1549731a34.27.2025.03.31.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 11:54:29 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] codeparser: Allow vardeps for python functions
Date: Mon, 31 Mar 2025 12:54:26 -0600
Message-ID: <20250331185426.316386-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 18:54:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17507

Adds support for python function to include [vardeps] task flags

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/codeparser.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 4bc6adbe459..e02776d8e1b 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -107,6 +107,10 @@ def update_module_dependencies(d):
         if excludes:
             modulecode_deps[mod] = [modulecode_deps[mod][0] - excludes, modulecode_deps[mod][1] - excludes, modulecode_deps[mod][2] - excludes, modulecode_deps[mod][3], modulecode_deps[mod][4], modulecode_deps[mod][5]]
 
+        deps = set((d.getVarFlag(mod, "vardeps") or "").split())
+        if deps:
+            modulecode_deps[mod] = [modulecode_deps[mod][0] | deps, modulecode_deps[mod][1] | deps, modulecode_deps[mod][2] | deps, modulecode_deps[mod][3], modulecode_deps[mod][4], modulecode_deps[mod][5]]
+
 # A custom getstate/setstate using tuples is actually worth 15% cachesize by
 # avoiding duplication of the attribute names!
 class SetCache(object):
-- 
2.49.0


