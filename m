Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC231C3F6B0
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 13:43:45 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.5774.1660139021453022420
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BSLWnSPw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id z16so17744173wrh.12
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=mffHTrJYgT6xdIgFpLXUDTYaf5/8FiHkdJ1q/0R4gAY=;
        b=BSLWnSPwxLYyiYQoaVjUcBwchDow8JQ1hJPZQPwBy8CTkKu//Q9RHvFXy7cgxqkIrv
         HSJnHum8b40Lt/mKGtqroZk0igi6Kc0lK5vqi5GVnW/8YO00mtKkQRkViEes650L+u1f
         1D+hnwLBfflhPbhjEkGOKvRBHOueqdoAou+HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=mffHTrJYgT6xdIgFpLXUDTYaf5/8FiHkdJ1q/0R4gAY=;
        b=IHGWtZzHfLeVobikL2Anm7jFpg9i70c5JYjapRtA7KgE9PC7/i95TRdeGV/Q5PDZvj
         RfVg05CX1x2kyZGYItPzQWfgLvWtVJmdRiP9ts0NwB+NJmVnEZMjFQEW7i19JGLYLuYP
         mhVuHWsraW3Yyo/5SQj2CaXBEZKH1osMkFwCo2M5EI1Ardgm5J8CCHIPvr99i1KpoL85
         pYWoEitGIyzeH+KRDFh0o5Jb9sGlkhp6wA0SIgO0fGt/IfAl3pvWWoDU6cwRmg81EH4z
         i2KIpyu1rdH3lBjKG63f8DoiP/QZIMu5GIGc9IHKJKblsn6PXOQhrK5EyWYCev/9XH2J
         dLSg==
X-Gm-Message-State: ACgBeo0bSA1LrAZCagw8VELwJyIGCYSTwBx+loTefNwyQnRax5p4e6tU
	CxOqL3LYqQpho+PtB+83CbsU/xh5nUPqDA==
X-Google-Smtp-Source: 
 AA6agR7ITJkrdalQhXa6cWImgtLuZ50rEuCPccznyY6orBZHIVAn7489mBQUKkggwOJpO6NzNxnN2Q==
X-Received: by 2002:a5d:59a8:0:b0:220:7076:dce0 with SMTP id
 p8-20020a5d59a8000000b002207076dce0mr17932363wrr.570.1660139019338;
        Wed, 10 Aug 2022 06:43:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:54f2:80ed:9b2b:a32b])
        by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c154800b003a540fef440sm2917768wmg.1.2022.08.10.06.43.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:43:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] BBHandler: Allow earlier exit for classes not found
Date: Wed, 10 Aug 2022 14:43:35 +0100
Message-Id: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 13:43:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13880

Rather than relying on later code to error if the class isn't found,
exit earlier and more clearly from a code perspective.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 68415735fd..532a4e08f1 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -56,6 +56,9 @@ def inherit(files, fn, lineno, d):
             if abs_fn:
                 file = abs_fn
 
+        if not os.path.exists(file):
+            raise ParseError("Could not inherit file %s" % (file), fn, lineno)
+
         if not file in __inherit_cache:
             logger.debug("Inheriting %s (from %s:%d)" % (file, fn, lineno))
             __inherit_cache.append( file )
-- 
2.34.1


