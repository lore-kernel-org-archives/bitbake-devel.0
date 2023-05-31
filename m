Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E8C77B73
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 18:45:58 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.2437.1685558749026955019
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 May 2023 11:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=LhT/FxXc;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: belouargamohamed@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so54227f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 May 2023 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685558747; x=1688150747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hC6HqyLjuwyvhLu0LLpZSDlo2wvGtic/KhURRPHCg0=;
        b=LhT/FxXcW3rteV7UYi+RH27trHNopcif3lxOioH0QVl7G1qMY+3WgUmtC/ZF8Dstc5
         LrkVpNnvvyVjsvYo/1bpiq5Dot7Yte7SMc365rtaWvN+d33XkWd71FXJMkPbz2TWKEdm
         rI6bf5ZPKR4CkKJFwWhvEw84tdeaFDq6/lrUWb45/FC1xWCNiZSksse/eI7sNutdlkwF
         mZ1Sl3xxwe9dI+E5JJxd1SioRe3GdRfYEWb5mQNz0eGWlMCv0Sb1UEByF32GzWfKSh8X
         nJfgcjt70yS3luFwCMkudKuqtmq+LFcYhdeuzo0GzHWCF5EjQzbLaYulv0h/+yGFia+F
         SwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558747; x=1688150747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hC6HqyLjuwyvhLu0LLpZSDlo2wvGtic/KhURRPHCg0=;
        b=Fg82dOh5r+lbBULCn1ST1f3vfDgzNo27ooW9D5zqTIwnPSzG+JDyKUhYTRGVL+PNbu
         zhr4Smac2stXRpyj2iZDRywvHrstVFIhBsnthn5rc3FznBlM0EfSZXOL3z+YzrwKz0Ry
         GA7367PfRLM+XcGoG9J+cwTMSoJuZudfWISUaBsZQ3NkHTlYvFumlWSfnNlRlPsKeup/
         3zVhjt7Fm2O6IFlNaK/ICa3eMuvbRZSln70QmjD2JwYu5cSCHNdbNv0NaqI1jLVYzMHg
         XmfhzaoFOtSectwQzlVz0MBptkLjE0QIz0vJMFD1po/O7ZMoLj7KwCK3aj9N7Xptjhy/
         hQuw==
X-Gm-Message-State: AC+VfDwavjTiqDH9Z6kcbyHJaPxwAcyQ0cFjT9c1xoVHU6fxVI5VxEVN
	fNyDyGkSmapY3iBCMf1uBiO8TkUzO9kS06v4
X-Google-Smtp-Source: ACHHUZ7YNiSuU7zgD28FX0+SO2CrWaxkKMtctP4/TeRdnPfVJIgPbdq7d0+0qcqMq0JcHaRLVYEFDQ==
X-Received: by 2002:a5d:6a86:0:b0:30a:bd8b:b102 with SMTP id s6-20020a5d6a86000000b0030abd8bb102mr5479433wru.19.1685558746781;
        Wed, 31 May 2023 11:45:46 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-cafa-c8b1-7dfd-80ae.rev.sfr.net. [2a02:842a:2e:7001:cafa:c8b1:7dfd:80ae])
        by smtp.gmail.com with ESMTPSA id q7-20020adff507000000b0030add836194sm7723682wro.65.2023.05.31.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:45:46 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: f.lahoudere@technologyandstrategy.com,
	e.aubineau@technologyandstrategy.com,
	j.guignard@technologyandstrategy.com,
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [master][PATCH] fetch2: npm: Remove special caracters that casauses recipe tool to fail
Date: Wed, 31 May 2023 20:45:38 +0200
Message-Id: <20230531184538.32843-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 May 2023 18:45:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14820

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Packages like @(._.)/execute causes problems because they generate names
that are not supported by yocto

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npm.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e6d0598f5d..f83485ad85 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -44,9 +44,12 @@ def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
     # Scoped package names (with the @) use the same naming convention
     # as the 'npm pack' command.
-    if package.startswith("@"):
-        return re.sub("/", "-", package[1:])
-    return package
+    name = re.sub("/", "-", package)
+    name = name.lower()
+    name = re.sub(r"[^\-a-z0-9]", "", name)
+    name = name.strip("-")
+    return name
+
 
 def npm_filename(package, version):
     """Get the filename of a npm package"""
-- 
2.25.1


