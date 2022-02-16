Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B5FC43219
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:32:07 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.10615.1645011126119857005
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fq1+t2YE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id u2so1808694wrw.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U67L4WQ3xSjVipoAMgRt0JRoAgI5A+rg5eoYeq5BOZg=;
        b=fq1+t2YE7b7MDbK6Pwjx8zGWCdmXfbbUKXdDApnt0w0U1SS0IhJdcxcxemB9CRFCat
         D1M9hDkOJmfJujLN9yf7gnLmUuLlERcfIR1UZ/jSXaMNi23W0HmYyG4B3AfksaMGAmTV
         D6uneUpGR082dMQHIiaBH/0tuh1WzPhHiQ/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U67L4WQ3xSjVipoAMgRt0JRoAgI5A+rg5eoYeq5BOZg=;
        b=p0oWF+8dingG2twwfBfce1qE8xlv0kbRm6Q1n8IbWLwSxHu7MiE0WihhvIktpP5xvK
         K3S6VH94qyUNXfragMhRqqEwofEPdnpCMYYZxEN32QdL/ZjjATBq9WWIAMl2FPjyhLHG
         tKz3LMTHnMoIQSexvE70Ivfv6Qhr8OvUdY3peZzHBcbWDz5YD66DleBkAp939Zera70W
         EJbTLDPEKc0fPU34RAS8Hajc/Fjxsybf8i6SG7SsYJR46Fh2tVr1UZbIf5e75imEZQWL
         lD4U4Ycg0WBYTCRvWY7oG6ml5q4DpNG4FDqAMv/qj6LX1MoN1N6idOPzqwOURBnk9ba7
         M83Q==
X-Gm-Message-State: AOAM532/DMTBwyI2ta2L40wJVHkkozszAp59BO72C22z5CNlh9HS1UEE
	5/0ENz5dYAGCRX7D6c6Qp+CVd/d2sylEzikB
X-Google-Smtp-Source: 
 ABdhPJwjmXmSDNh0jav2nuZxXaUuankGWVJzizLo57KdVhFHnsC5fVg6NhEbcXbpTVM6QzQJabx1gA==
X-Received: by 2002:adf:fb06:0:b0:1e6:8b27:f1ea with SMTP id
 c6-20020adffb06000000b001e68b27f1eamr1924091wrr.353.1645011124343;
        Wed, 16 Feb 2022 03:32:04 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a680:61af:4a53:1ad3])
        by smtp.gmail.com with ESMTPSA id
 x18sm35476238wrw.17.2022.02.16.03.32.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:32:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/5] data_smart: Add hasOverrides method to public datastore
 API
Date: Wed, 16 Feb 2022 11:31:58 +0000
Message-Id: <20220216113158.2899964-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
References: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 11:32:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13355

There are some cases where the metadata needs to check if a variable
has any overrides set, even if they are currently inactive. That code
currently pokes into datastore internals. Add API instead to replace
and avoid that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 242476be0e..cb2d4b620f 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -488,6 +488,8 @@ class DataSmart(MutableMapping):
         else:
             self.initVar(var)
 
+    def hasOverrides(self, var):
+        return var in self.overridedata
 
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
-- 
2.32.0


