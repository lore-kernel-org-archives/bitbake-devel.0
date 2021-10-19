Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22FFC433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:44 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web08.15455.1634674004475727600
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=QufqSWEE;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id
 na16-20020a17090b4c1000b0019f5bb661f9so819946pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9wy031SeTHxN6QpbAlA0F8kg/HHVMHySKw3inAAd0ac=;
        b=QufqSWEEfHDl2nkbj8ldXjiW8r0BXbIkZh/ec5AW3qUvTZulU3Hl5z3SAXsnczn99/
         fwcORTFOZRlj3CY+jkrUmxDV0kOsR6Ewsy2/UAOBq0sOQEyBI516wQvKKkDg6oJLEbUd
         9ulP9I3/FobWPFHQXHrIvQ8/PmM+n4medubEYF5miqXfPGCOpufg/a2xy9tSx+oMh7ft
         8Dp3lDFdy99k/cAHmYlIx5Ze3ZWW0rgnwjLuaO1Epk/vrjm6vxMfVxAnaq02SYAtrFFd
         wiKmJGM8vykZfB5SaxmUZ+KIQrcL4eLsG2bJ11rVMT2nh1YIuotwhpgzTEzfJZxDh4nM
         O4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wy031SeTHxN6QpbAlA0F8kg/HHVMHySKw3inAAd0ac=;
        b=gKFviFbAaNBS0SHtd7v5L49SltyfiQP88jHF6ub+Ffzczhh4D3zscadnc7m/U0+Zl4
         CoXI4ybulzU4daw2kD2KSaJ+u4lwvR1eoTDOWK0CRrcg2pVBmNyqn50WihbfvpXWD681
         9NijTXb1McZN69p2I/aPxJ+KAnTbc111Yxng/VHUmoKCrXSFjMgGnvPk82mOLVB+lySb
         rb25tjDJ7f2AAFZh5JjDQ5GxgnMdZEhSs176vOXWOvPl1+QcvC0mApst6XaO3NIA0VO/
         lLnFyebB+znmPjjkOmOkIz2kDFcNrcm7nflUqG3mr3JQ7mZ8aOB8mTJY9Nqae0BGjYk+
         qIpw==
X-Gm-Message-State: AOAM530Eg+z9X1wa+jMVtbj6eBoXf5uIPzfT6dbyKcH+hB2mkMJfoEpl
	IBYgku+xlWbHhx/13u9mJ8+sGWkOIJFICiPR
X-Google-Smtp-Source: 
 ABdhPJz2Fo8sezDUk2GXXB/NCi2nU6zFBQJTx0KOnZdsm5dUqjLpVTjC+oRB4bIyq6n4MmkT+HmU2g==
X-Received: by 2002:a17:90b:78d:: with SMTP id
 l13mr2288634pjz.37.1634674003519;
        Tue, 19 Oct 2021 13:06:43 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 7/8] test/fetch: Update urls to match
 upstream branch name changes
Date: Tue, 19 Oct 2021 10:06:15 -1000
Message-Id: 
 <df0d77000ab600c59f7ceae62ce859bd34478ff6.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12809

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 473e2a5486bd972ad0f808db089abcb8945d3a48)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0787952..8ad10708 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -937,7 +937,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -952,12 +952,12 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
 
         # CLI11 that pulls in a newer nlohmann-json
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
2.25.1


