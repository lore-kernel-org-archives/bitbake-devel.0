Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060B5C77B73
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 01:39:39 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10339.1685842772670879614
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Jun 2023 18:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=bdsBpTV5;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: belouargamohamed@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso5352355a12.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Jun 2023 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685842770; x=1688434770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu8hQ3tPPSIqAhxFvWtThhH8HzKW1gPvkTlj0R0WR1A=;
        b=bdsBpTV5z9Hp26lK5F7we5rix1bM50GlJpEyQcoLU/FpHKSaHrNtbaIfyx1NY/eX+P
         AIG0vOfiZ3XYSv7ox8Rd4gm+alRZB39YZDa2+4AkMXq9xPGrG4fGLUQFZg7zUvfxMRRT
         K0+fmMA5bop+rEnQNb5UYAI1rlavUgd95Cgifw9cFsOGI9HllVC3O+gZrL/4MIHplW2I
         +Sv7/Jh+3eRVA87qDLhUKZtQOYfju8MEYf0WFeMWs3LhNch2G4okVNm2QM8OfV4CGjsT
         QaQFuMG1ILvtKTJ+jsvu4jcqq7P+eAzuFECUetR41f7M0y5hHFyF3uIRl+6jsvnYNHNp
         sqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685842770; x=1688434770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uu8hQ3tPPSIqAhxFvWtThhH8HzKW1gPvkTlj0R0WR1A=;
        b=EE5OPdYqFGTeLvaDw6kDJMe4aaxFxOv5igLD8MINl4HQ7ULdmnItnZD93cRqhfQI05
         okdyZ89NvfKw0DoCDRi3mq0HK9xnvNnmo8Pt2PliYtbW9xWhk/XIWLLCftocjmJwKqRH
         qiOQlN1s5MkLEw0pUhXIEx2xpNGwkymMX97BeBAgks0q3uVMYngm02fa1aD3+vdY/8mG
         gQV9O4pzipVX/oPOFqY8RRSnEJYVfXf5cUGWrzR5QjWGOARyzym3n2xZy3C8zexMHlJG
         8m0JveFScfeiLlSMbwWAW8KrwiiHLosWFoT6Ru6fvEkBt7zpc6yByvRpQa1Hr49pSfMN
         5Uzw==
X-Gm-Message-State: AC+VfDzHlHuszZefB5XC37Hc+Ry9q2cV1kb7QeYoLWShxNt/tvj0eCEy
	3yNKObN9oUOxYtpI5B1HDLUVhi2S+fA7YA==
X-Google-Smtp-Source: ACHHUZ7udpTa3l5ZGjaUW9VBjgtmV3lzHbnu5qMlRwvYmTLgN5umCLSF0ApEMlb5ma6PCve4gx2bnw==
X-Received: by 2002:a17:907:3e1c:b0:94f:8aff:c8b3 with SMTP id hp28-20020a1709073e1c00b0094f8affc8b3mr2949783ejc.28.1685842770328;
        Sat, 03 Jun 2023 18:39:30 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-0180-174c-8c1b-346b.rev.sfr.net. [2a02:842a:2e:7001:180:174c:8c1b:346b])
        by smtp.gmail.com with ESMTPSA id i8-20020adfdec8000000b0030796e103a1sm5825474wrn.5.2023.06.03.18.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 18:39:29 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [master][PATCH v2 2/3] fetch2: npmsw: Don't fetch dev dependencies when they are not demanded
Date: Sun,  4 Jun 2023 03:39:18 +0200
Message-Id: <20230604013919.13904-2-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
References: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 04 Jun 2023 01:39:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14828

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Dev dependencies should not be fetched only if it is specified in the
recipe.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npmsw.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 359192a29e..d89be10caf 100644
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


