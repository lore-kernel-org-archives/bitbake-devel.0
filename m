Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F208C4708D
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 17:26:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.21659.1670779561938266971
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 09:26:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gEr5Yvyk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 206-20020a1c02d7000000b003d21f02fbaaso867533wmc.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdDutOkoEAFuetsl0csX0ilMDNXVY9G/eXJo54yq6N8=;
        b=gEr5YvykqyKM2HwFnnu5sK272CQdnR2Wxgy4Ur2zYeRkD5C6ltVzF9AlMm2SHgJf1W
         IgsTNij/s0RS3z6BjIDViTXuBPL/kip539Ob+4ay8QVCgsOvrTMQ71UYKMgph9h4fk6n
         Mah7Mbif4Xxhrn7ezZUoQIScY2LyaScFAtjds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdDutOkoEAFuetsl0csX0ilMDNXVY9G/eXJo54yq6N8=;
        b=1i7N6Ye+eyadasPWYIcKVwrmNm7o9ehVAu8fi5S6FYHqGAR23qgFlBEEL0wG65qnyz
         IGnq3OZihLDUDDNZgXh9/ZK8RSYDeVNnKtq4Wq+jwY3ojYuW4ucvdycu+fp0xkvw6gOy
         urYZhlOMouje5I8qV614p9qEheWdf9fPrX/y1J886jlbd6Iuld6mh6JI2xa2Ue0PV7LX
         1BMezuocJ02OammYc35M9vCwdFGUzXHv9IQWViTTI/Ge6aOJOqf5uPKtNSnH0Fiu1kYY
         CTqlIwtI6POpg+A5m9aq2A3GVvx/VQnhdrttMXrAA5j+eV528jL2rZla8hDUf51dfcuM
         6q+w==
X-Gm-Message-State: ANoB5pn0qB+bNMKvMV7afKcYs8cSyUOPZ+wv6JSB9GOBP8mmX5/GAfAt
	x79UyDZis9GagoujeUZh8/2opquZwGeAzOgG
X-Google-Smtp-Source: AA0mqf7+iA0TQddiHhpbqonnd8szG1zaAGTBswgRBeoERE81ru+Hhv3nbrRMbkVvTcKMA9i7ScuwgQ==
X-Received: by 2002:a05:600c:34cb:b0:3d1:f16d:5848 with SMTP id d11-20020a05600c34cb00b003d1f16d5848mr9965440wmq.26.1670779560172;
        Sun, 11 Dec 2022 09:26:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b003cf4eac8e80sm7592804wme.23.2022.12.11.09.25.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:25:59 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] siggen: Directly store datacaches reference
Date: Sun, 11 Dec 2022 17:25:54 +0000
Message-Id: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 17:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14171

It is becomming clear the siggen needs access to our cache data but we
can't always obtain it in the contexts we need to. Add it directly,
meaning over time we should be able to simplify the APIs and stop
convoluting new ones!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 lib/bb/siggen.py   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 63cce8184f..991aa94f67 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -651,6 +651,8 @@ class RunQueueData:
             # Nothing to do
             return 0
 
+        bb.parse.siggen.setup_datacache(self.dataCaches)
+
         self.init_progress_reporter.start()
         self.init_progress_reporter.next_stage()
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index cdf7d03a34..e57f1ffe69 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -70,6 +70,9 @@ class SignatureGenerator(object):
     def postparsing_clean_cache(self):
         return
 
+    def setup_datacache(self, datacaches):
+        self.datacaches = datacaches
+
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
-- 
2.37.2


