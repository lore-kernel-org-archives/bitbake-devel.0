Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03996C4332F
	for <webhook@archiver.kernel.org>; Sun,  1 Jan 2023 14:25:15 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.11889.1672583112626131588
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Jan 2023 06:25:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XCI7oeEo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id m3so9619128wmq.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Jan 2023 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pareiqcE51owkvy3KvDkCf6wm7o/KDIfHZbC0mn694s=;
        b=XCI7oeEogZgbvcWX3co8CVcX+/dJbqe1fy+6ZylsukEkdDOB7l+qgRcPDn9frCpQni
         7wNSBveAPeGvd7HBToEn2YAwelShWqHr0GbSG3HYS6hk88hv2WccuLP1DzlAKLHujpj7
         8sqzyaH6d/LMdQHLcTGuEmA1GoqLzb7Bp92Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pareiqcE51owkvy3KvDkCf6wm7o/KDIfHZbC0mn694s=;
        b=OKBJf7HyEaYqP6F6kCHywCIZ8BsvRrICdOnOgjObkzHkQoN4TlMRAOctGVfkC4oeI1
         Z4Y54S6EXk1cZh0SIrljKp5qS9Wm8refz+BMPuttJRSH6/bdrDm+1I5WJJNR8+vYkTHl
         8hv56jnh/FUuQQvOlc/L3gC5ZYisD3cewJ47SX96B+Bj4rSvZeXAkPL8GqT9phWPRk6H
         ptdneZljTOTQbU5Xpr/77JTsYwzq8HvlEx6yuNoDaN176+S0rbsDQ5/qS7yQ4Bq3OiBH
         wHv3F+OwbND5eORkZffiYtGupC6KYbX5/Crp/XJq5Xb6aaMfHV7Swj1WzWdCN+q7Z2nq
         Z+Eg==
X-Gm-Message-State: AFqh2koIlA2Dq6jF1KyKChRkIghCN3f0lrZ1HkX637ifeIMgcpUpI6fS
	kB+aQNWoFDnBXa/+NflHk72j17X1C+poQ7RQ
X-Google-Smtp-Source: AMrXdXsI4+T/89uM1diiDffbV4pF66GqAhqXKIN7gaqJ4lXBzgPtHMQrfxzizoEemG0DBTDTSZwiYA==
X-Received: by 2002:a7b:c39a:0:b0:3d2:640:c4e5 with SMTP id s26-20020a7bc39a000000b003d20640c4e5mr26066775wmj.8.1672583110521;
        Sun, 01 Jan 2023 06:25:10 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bb2:ac75:8ae6:46ed])
        by smtp.gmail.com with ESMTPSA id k2-20020a05600c1c8200b003d974076f13sm32332710wms.3.2023.01.01.06.25.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 06:25:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Fix cache/reparsing issue
Date: Sun,  1 Jan 2023 14:25:09 +0000
Message-Id: <20230101142509.1022073-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 01 Jan 2023 14:25:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14273

When setting the LAYERSERIES_COMPAT and LAYERSERIES_CORENAMES variables,
we need to be deterministic. The random ordering from the sets was causing
unexpected reparses.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index b4e0c4216b..8198f509e2 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -425,7 +425,7 @@ class CookerDataBuilder(object):
             data.delVar('LAYERDIR_RE')
             data.delVar('LAYERDIR')
             for c in compat_entries:
-                data.setVar("LAYERSERIES_COMPAT_%s" % c, compat_entries[c])
+                data.setVar("LAYERSERIES_COMPAT_%s" % c, sorted(compat_entries[c]))
 
             bbfiles_dynamic = (data.getVar('BBFILES_DYNAMIC') or "").split()
             collections = (data.getVar('BBFILE_COLLECTIONS') or "").split()
@@ -461,7 +461,7 @@ class CookerDataBuilder(object):
                 elif not compat and not data.getVar("BB_WORKERCONTEXT"):
                     bb.warn("Layer %s should set LAYERSERIES_COMPAT_%s in its conf/layer.conf file to list the core layer names it is compatible with." % (c, c))
 
-            data.setVar("LAYERSERIES_CORENAMES", " ".join(layerseries))
+            data.setVar("LAYERSERIES_CORENAMES", " ".join(sorted(layerseries)))
 
         if not data.getVar("BBPATH"):
             msg = "The BBPATH variable is not set"
-- 
2.37.2


