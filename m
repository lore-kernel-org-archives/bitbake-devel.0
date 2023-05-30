Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD7C77B7A
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 22:43:08 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.309.1685486582581268972
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 May 2023 15:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=Zbu9Xi6J;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: belouargamohamed@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30af86a966eso846378f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 May 2023 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685486580; x=1688078580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01hkLWaN3EJu6QEoO921fM9qZzIi8fTvZRBOOz+I25M=;
        b=Zbu9Xi6J6d3QT/UgxK5LcP0j15bnSPaHpNwFwcXtr6snl8cDb+fc9L+p03AUWrHi2i
         zTwxOS14ZoTzr0o4kLLduSL/xhZ4QS1GJWwLz1b2YZZ2Cv8S3Lc4qG+Kw3fb2Pt7I3HN
         3lqk9BS0jOdJfKtQw1mDzjerfoeDtleLh1hE7PtasGMEVszZ24Nr+kEWqMqesxZvBxWo
         /CCu7j9Gi8NLK3WOYrlCa/yyUz/PbeMBQcarg8miSYZsBg/hz7TrW1Ee9tmoLf9u0DHj
         8xgnfY0hU8MYXR/peJRG8pZPadGpHRYGoNOp9YRDixuAMZKtr00TrG6EaYZxuDFNIu05
         26NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486580; x=1688078580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01hkLWaN3EJu6QEoO921fM9qZzIi8fTvZRBOOz+I25M=;
        b=Nbc6qyg62zycTb4rAklhFIPkePK+kadiiWbMBJ995PvuyqkjeqdIJ2+nfZATo20Qeg
         MSuelw7hPPMfeJTWrITQ+FRk0C+nf64CCLW6A1tBfJXrm2m1/cHF6dTkvcV+h10dzPai
         9Y4hdN2k1EnhvF8uB8vgG5ginPWYRqAk9Qw+l5SMAuyHun6GhkOpAFYj6I/Fb0nA16S0
         f4jFgeQPqeFusW0dD8s5Fw5Co9Jy1Fxmua4KQzukTgmliaQZb1zM8jwn/L5Kaw/xUWWs
         lZXMJQBJ2+sbgFzd9LOciZFm6rxxioosTVORpbeBlPUBi4m8+fHfyPyp4LwZBks8aU26
         4f3A==
X-Gm-Message-State: AC+VfDxpz88OxgtBljppOPASrcm8Y/6Jm2mJA+HQxjiLP4u3FYwDthPW
	wdu44CxutpMvUJrkz+A3NF7XI8PUR6Swx7jX
X-Google-Smtp-Source: ACHHUZ6t7viiXAsFOcmW3HM5ezERb3VLwwgZ78OUXULge+qjQLgPCxSXFG8CUjiJXYNDbDeeoMSV2Q==
X-Received: by 2002:a5d:428d:0:b0:30a:d7a7:3db4 with SMTP id k13-20020a5d428d000000b0030ad7a73db4mr2521662wrq.12.1685486580585;
        Tue, 30 May 2023 15:43:00 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-af81-84f4-744a-71c9.rev.sfr.net. [2a02:842a:2e:7001:af81:84f4:744a:71c9])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b0030ae93bd196sm4606395wrr.21.2023.05.30.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:43:00 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: f.lahoudere@technologyandstrategy.com,
	e.aubineau@technologyandstrategy.com,
	j.guignard@technologyandstrategy.com,
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [master][PATCH] fetch2: npmsw: Don't fetch dev dependencies when they are not demanded
Date: Wed, 31 May 2023 00:42:54 +0200
Message-Id: <20230530224254.43797-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 May 2023 22:43:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14819

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Dev dependencies should not be fetched only if it is specified in the
recipe.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npmsw.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 359192a2..d89be10c 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -49,6 +49,8 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
         if package != "":
             name = package.split('node_modules/')[-1]
             package_infos = packages.get(package, {})
+            if dev == False and package_infos.get("dev", False):
+                continue
             callback(name, package_infos, package)
 
 class NpmShrinkWrap(FetchMethod):
-- 
2.25.1


