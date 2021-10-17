Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B4C433EF
	for <webhook@archiver.kernel.org>; Sun, 17 Oct 2021 21:51:58 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.28531.1634507517036863032
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 14:51:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mx/fmsxm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id m22so37836184wrb.0
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yq4c8UboHNxK7jCE8TT5H0LFdZ/kJe1suCCS+2nuYCI=;
        b=Mx/fmsxmAQF5dd0QfV59IoORFIVRGiDA3oIDxnPSm0G74nnkNc8FWzFlgN0+WHl9Qj
         m1lX6qCT6FM52t8RtYlBjQLC5UyQSwhZfRYmqZ+OtzOPl68R7kvOgN74PLhL95V8kEFE
         8FnFzuFS+BB0nuW1FZUYx7oThWR/Vsl5DCVXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yq4c8UboHNxK7jCE8TT5H0LFdZ/kJe1suCCS+2nuYCI=;
        b=LOQWFsDj72cmfZaF6CMAon/ITbppGLfde5t6oWWHVI8sDhBKToMaklL6nVwVyUknUo
         BmlDop3Xn/2Zpzg6k9/BmBC4c2mXadrx3b70ad0gqSIAWJH3ZPfo/DsRMEV5zhsmoTQ+
         UXJhvOx9vSHaV2njjj9PtcCSCSKsbzKdxpKpw7v5HKd9WEFlJ1sCtNgSxSTjLR+rXjIa
         22eN8FnGvi5cGREo+z9zWpoZY2SFhuhjrQ8BKeW4GHTbhQqnRmmXvMWk6zYGHG6BFGay
         cGLMGJsuW92IR+p4T9bzqqVuZG7yaz8Vdqkk2FdL1nJlECDTOKeIeHj9NDX9ZbOwu7X9
         Jelw==
X-Gm-Message-State: AOAM530scK8SXP48Rcm8rJRAw0349Z3NDE44frrmzhVLNACIVEp/oNSl
	m2MFk9Uy7Q7i8AGnlw6EXPikfoEFTYerXA==
X-Google-Smtp-Source: 
 ABdhPJwK273p7yBOaMD+Rcdp2sIXdGqilq1Qq7eHAFOPiEUlbnt6FiS5oMq7OqRIFrFeNaAeYXrXJA==
X-Received: by 2002:adf:f8c2:: with SMTP id f2mr31672269wrq.234.1634507515308;
        Sun, 17 Oct 2021 14:51:55 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:1325:5a42:b4ef:5218])
        by smtp.gmail.com with ESMTPSA id
 q14sm16234911wmq.4.2021.10.17.14.51.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:51:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] test/fetch: Update urls to match upstream branch name changes
Date: Sun, 17 Oct 2021 22:51:54 +0100
Message-Id: <20211017215154.3085857-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 21:51:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12788

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c20f746f09..8ad1c85990 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1012,7 +1012,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1027,12 +1027,12 @@ class FetcherNetworkTest(FetcherTest):
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
2.32.0


