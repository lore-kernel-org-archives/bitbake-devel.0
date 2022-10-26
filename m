Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723FC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 16:03:14 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.9354.1666800186809847378
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Oct 2022 09:03:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A6DCN+YM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1890996wma.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Oct 2022 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kxr6zqebeXsIF7AGc0MGTtqujDDrQ4AftmP6vYiUP0g=;
        b=A6DCN+YMKdBsvuGWys70gUGSGjTpONu20CRAJ+YGytsK0Ae4yvijYt/MeuYCgr93Zl
         Wc5CDxBS9VFOvpT42rKjplAEa7N35l43V8oWgTSzzRJPn4VE3Y/y1kPjOdK2wcJN+9Gf
         xQWDXSw/48wvk4qRG9CYqnX5Pwj2/0bOGmNnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxr6zqebeXsIF7AGc0MGTtqujDDrQ4AftmP6vYiUP0g=;
        b=pIzTcMssKRS8VarutVws7FCKwW6myuxck3NbhHRpiRJ3hTb51UZ4uKoYufzZo8SXCp
         lidDwyIT+TKXGTIn/2ac7mI5WZsWYCyaAz7ON+Qf9zlkw0duRGK4PA+GPVJnhcqdxykS
         oXqorztpeQfizEB/bemswqCKD4GYIAyMSvAL1guvSqDfvX8//NtpPRflg6hY1h1QXYna
         6zoadQV2OFjJP7mg1rAIk4iP4COFZh4pZnx+38oTPFgJKFpYrubxVps+gcjRciPU05yd
         /e8EqP8l+fWVZmyJoGkTQRFS9MLmeS6V7P8WTy1mS8k2+4HYgTqEzanSRG+00fCw3Qc0
         dTrQ==
X-Gm-Message-State: ACrzQf1Ck9xk57EjbsfWTrEZvCj3F0GvZwTY3N7/wfPtst5OvznF6iwZ
	WEuZPojU4fHsbR8zObevOH/NLwAECcKFzg==
X-Google-Smtp-Source: AMsMyM7IdVTtCggZcrcdojrJfjEPUc2XSr/YgY+09T866dwFlNe9kK0Df5+hO3J6aiZ2UpWWeibN/Q==
X-Received: by 2002:a05:600c:3d08:b0:3c6:fb56:ac9f with SMTP id bh8-20020a05600c3d0800b003c6fb56ac9fmr3070528wmb.193.1666800184442;
        Wed, 26 Oct 2022 09:03:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bd65:7511:b73b:c094])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d6382000000b002368a6deaf8sm2481156wru.57.2022.10.26.09.03.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:03:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Allow handling of a file:// url within a submodule
Date: Wed, 26 Oct 2022 17:02:56 +0100
Message-Id: <20221026160256.3749563-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Oct 2022 16:03:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14052

CVE-2022-39253 in git meant file:// urls within submodules were disabled. Add
a parameter to the commands in the tests to allow this to continue to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c5f6ce9dab..0af06e46e5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1871,7 +1871,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('bsub', cwd=smdir)
 
         self.git('submodule init', cwd=self.srcdir)
-        self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
+        self.git('-c protocol.file.allow=always submodule add file://%s' % smdir, cwd=self.srcdir)
         self.git('submodule update', cwd=self.srcdir)
         self.git('commit -m submodule -a', cwd=self.srcdir)
 
@@ -1901,7 +1901,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('bsub', cwd=smdir)
 
         self.git('submodule init', cwd=self.srcdir)
-        self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
+        self.git('-c protocol.file.allow=always submodule add file://%s' % smdir, cwd=self.srcdir)
         self.git('submodule update', cwd=self.srcdir)
         self.git('commit -m submodule -a', cwd=self.srcdir)
 
-- 
2.34.1


