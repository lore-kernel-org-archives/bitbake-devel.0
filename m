Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC3C6FA99
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:01:31 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.21339.1677254486159960668
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 08:01:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dfwkzaIJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id p8so14544882wrt.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/GS5zk2swuxEczXbj/ByoaTjJIT1vZ1tM+jkc0CatQ=;
        b=dfwkzaIJ99I+91+3z/8dxybNOQ1wjjREKdtwlr8NNLS2zL9GJ1KuCeJCXurGQmQoIg
         eIb4JMGS75DRnDN84BBfr7BhwTPBr6SS9FTmwa+Mxngcv5Huv280BTpMdX8A0511FNp5
         RFAHMx5kvbrTggY0G5DSBmluUPyDcIq0dvYcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/GS5zk2swuxEczXbj/ByoaTjJIT1vZ1tM+jkc0CatQ=;
        b=PguzN/56eRXyE8na4GSxoYIF80yw9xOh3KLI+9k433VNI3L1uIiOiL8Tj/hVHEI44y
         dh2o40bWc7zUW7gnC8g+83KhmGvb4uyuNXpj2kmcYO2z2O7tWhUZ9m1VHFQ7J7JhIbxr
         6lYbN66X1UNOpNj+FpGXgzFnpxPlPMmCKqx6MGLUUwrI25TrRJYZfK7DQAfZ2e4lMVO8
         kyZT0kBr/DDBka9MrebmiwqmUum+GzJeX1O6L83ZtgydQzRsy5Zc0zt8tl1e7eBs6A+w
         jYlOXbCDRTqrpYOjTQyM8UemBgbiXuyI7JKNTWJLzYbug/53bdO1Kuevh138MuI1z3X+
         epYg==
X-Gm-Message-State: AO0yUKXUERksu+ni+n2apBFfzPZ0696poi5RgTrdifrh1EYW0OW4ktKA
	8kAiOy0M803Ta88j+jGDW5qAFtsjkURwkUnw
X-Google-Smtp-Source: AK7set8ULuCGjXLdgZDsHk5YKUPTnOAXcBfDDXESauZnXLKOMIR5bwCZiQsN7iSZBK1H8DtfSxz8fg==
X-Received: by 2002:adf:f247:0:b0:2c7:1e00:d514 with SMTP id b7-20020adff247000000b002c71e00d514mr2661519wrp.38.1677254483158;
        Fri, 24 Feb 2023 08:01:23 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:639b:9979:fd5f:bbb7])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b003dc3f3d77e3sm3215403wmk.7.2023.02.24.08.01.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:01:22 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2/wget: Drop unused import
Date: Fri, 24 Feb 2023 16:01:20 +0000
Message-Id: <20230224160121.321885-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 16:01:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14487

This import is no longer used anywhere so can be removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6d365729e0..859b4f99e2 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -26,7 +26,6 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
-from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
 
-- 
2.37.2


