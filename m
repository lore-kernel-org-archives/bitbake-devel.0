Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E9C49EA5
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.7559.1650460937513311258
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Nv++LRQn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id e21so2239160wrc.8
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=irlB99RuN1rv1VVg5GuohtZv+h4kYg/zO75CUrxeu/0=;
        b=Nv++LRQntJptlvi0oVQV/Bbd83pjDAVG9Kg4rVFIp7NohPmsy8WcXKqOaUQ8E5uxa7
         w1DVza7wIuB2bqcFQw3ZnwC5/U3DWTEjQDg5AddzqG7kzm4OXusYchMgxUSeWfMeemWy
         i5m2sdtkWo1IPn2kUL6R564CHncNgJqxMCR6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irlB99RuN1rv1VVg5GuohtZv+h4kYg/zO75CUrxeu/0=;
        b=fvinFkQgMW5s0P1OVGFFwhkQ4vf1HshNIBOLsuFOg4jzWl++bqKVC+xzGzkQ3VA5UK
         wHTKE2ScmGjYTkl5Rp0YZrQtO5AhupfyD33+N7yFhOCpl8o//5ZKj4JdkpQC/03SyCxE
         0/y3dEgmrVhXhRKFsanKr7PZFYGGGRjnWElANcS+RYw4R1A9jBz3NDOvYQc1xUkHHDU0
         SwbaobJl18F9UlFWcaEKX/sfXsf4vwuRVQi6MZeoxT8ZPHPlIOz6Nw1MYO8sFh/vYHnu
         39E8TW0b6ic8gI1uSUvPSsSSEOZx8+FlTl/9rKIKmVmmXDVueuMkEQF5gEruUieOSha5
         C5nA==
X-Gm-Message-State: AOAM530tyMGebk/Ian+tnU7Mg8zv3Jll0hA9LGuxHyMbLIMV0nr91a3l
	Qi4wLapMAU8aPfaVwkRN688Vj/WJzDMcWg==
X-Google-Smtp-Source: 
 ABdhPJwzsFKciB2rlIWkvBfCVINRnpaZ9upUrOwHR7ol0X87eqtyK/1QYjQClN+OAfM1+tGsJxZGUQ==
X-Received: by 2002:a05:6000:186c:b0:20a:806e:ad8a with SMTP id
 d12-20020a056000186c00b0020a806ead8amr16227514wri.207.1650460935489;
        Wed, 20 Apr 2022 06:22:15 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/11] fetch2/crate: Drop unused import
Date: Wed, 20 Apr 2022 14:22:00 +0100
Message-Id: <20220420132205.2530591-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13648

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/crate.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index aac1221c87..f4ddc782a9 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -13,7 +13,6 @@ BitBake 'Fetch' implementation for crates.io
 import hashlib
 import json
 import os
-import shutil
 import subprocess
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
-- 
2.32.0


