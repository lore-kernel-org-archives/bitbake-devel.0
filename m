Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E1C433FE
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:23 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web12.676.1652205979333931980
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=E+3Attjj;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id 204so12786675pfx.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k6uq1/hvG3gnz5PVSBkYD3f/A5maIEDVH4g5gUVaGOc=;
        b=E+3Attjji8zFAUxQbHXflGWd2nYfl3p3k39NHLtb9vBu8ZFvmXTRa/TDH/vBBOySR5
         FpeFQ/TSscn9/08Ztz0lzEhcGxImI9z4oslXMvcXxaDQkerPCtNF8DtUEVVxEo854J9y
         tFDJty3g8bW6P8t/ulLMyFOppFo7dYckjwO8fFuB9NQrX12JoKVFZDTonULOwqV2Ci9w
         VyyKOwoIwCqZly/ktxEWOKguYquaVKJe8ky+LSwDSiLmiV0dTy3zkAprHaVWkzMqMy49
         XPydu4GovtkSTxYsH3XrsSE/XNtXnWnbe/z1gdJGoLJK/8mMiXCY+xpr1W7WKakOUO8k
         d6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6uq1/hvG3gnz5PVSBkYD3f/A5maIEDVH4g5gUVaGOc=;
        b=dCZZwsvoygwiGDvtqyy9nb7NEDYlfKPzInQHFC08F79FspTKXFmGY1JP7RFbnjA27k
         FNTKylfZyF7uMmNUfi89qcbxOJ2q/ybBMsOMuLsjzELJJYzw13UxslPVTNyCWJigfsD6
         CBKIWRPVyO8KKkShBo95pQyLnDTztcKO23+0QqGjzvaldzG3S1RqF2ElqedA3Bd+6eiz
         nv1FSNW1vfBbOgv3xNhRD8gc/1wzS/7ZBZtGNazKf15MRJHQcMTT4iAfhexqYCu8jp0E
         ejJspF9d5t1DLQ9FgFk2GOoXVdIG34wbNu2RNH7N/WuJxS4N1y4k1Au1Z2/fIou5z61d
         Vxag==
X-Gm-Message-State: AOAM531JLayVEEj7u5cZFnYt6R9nC0ECvtkWyjp0zzBqoTKb1B0glf5W
	36UuUsUcLwvHcrmqdoSRNdnbRzh9zEgruVcJ
X-Google-Smtp-Source: 
 ABdhPJxpCnzTd8Q4dBXLwrga5DmHm8WBk7AIquFQarXJIPhxAJ42XBG+x6j/kcCWTVm2EKXFvCHJ0Q==
X-Received: by 2002:a63:2a0d:0:b0:3ab:392c:f45c with SMTP id
 q13-20020a632a0d000000b003ab392cf45cmr17807496pgq.575.1652205978154;
        Tue, 10 May 2022 11:06:18 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:17 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 07/18] buildinfohelper: Drop unused
 function
Date: Tue, 10 May 2022 08:05:32 -1000
Message-Id: 
 <2fce0e575f843099aa3a77cdadb9cdecc0a78ca4.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13687

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The function has a loop where the variable is never used which I was going
to fix but the entire function never seems to be called so remove it entirely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3bcb20f025907f4e88bbe3d14f5638d5f01010cb)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/buildinfohelper.py | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 9c4215f9..c4ca2677 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1062,27 +1062,6 @@ class BuildInfoHelper(object):
 
         return recipe_info
 
-    def _get_path_information(self, task_object):
-        self._ensure_build()
-
-        assert isinstance(task_object, Task)
-        build_stats_format = "{tmpdir}/buildstats/{buildname}/{package}/"
-        build_stats_path = []
-
-        for t in self.internal_state['targets']:
-            buildname = self.internal_state['build'].build_name
-            pe, pv = task_object.recipe.version.split(":",1)
-            if pe:
-                package = task_object.recipe.name + "-" + pe + "_" + pv
-            else:
-                package = task_object.recipe.name + "-" + pv
-
-            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir,
-                                                     buildname=buildname,
-                                                     package=package))
-
-        return build_stats_path
-
 
     ################################
     ## external available methods to store information
-- 
2.25.1


