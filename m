Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E82C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 12:45:01 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.7024.1657802699060070270
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 05:44:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BVc5/emo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id bu1so2387179wrb.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnJSUGaqYgPCVJr/f9Gw0DA4pHyD99fYNe49FD4vF5g=;
        b=BVc5/emoqC5IpmcuBRiubDbBIHBhCtagZ1GqdkbiGnvAPCnwTUhol5hjHuDUniR5ad
         3OkMknr/3nS9b1KMc8Pk99/u+os+LjsrzUJ80u+42HclcjWRzIRfx5vFpPundIoAqT4G
         7YxqsU/kHuGRf0XeEQOUYRl/Tkq/pqiUyC+e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnJSUGaqYgPCVJr/f9Gw0DA4pHyD99fYNe49FD4vF5g=;
        b=SMu6yN7dnR2zqL2DnqimCJazDxzKm9ullkZiTM3toMS47AJYsDMt+am90ZJaWP6ByP
         AQor7ZvqK/lfOyG88Xkrx5CwTMD2VX3vMtLebIZ829QlJxsknxZr739bPyk0NvXQAc3I
         9+qM5zGYNurmLtrza3JjyKoVVhza+KrgLBtbq+W6C7Ht11iQk/3TV/MoRuVYbWSrPnbR
         z7mqJ+eBM7A41x5mmfk3m7V3FEtUDGWKTP+NzzcTzzv5AjE4yrN60uveSGQ9myx9G3L9
         Jc2ry3q4OgHPlmffSL2r0nCvTbs7ROCrwrrN21i7ziChXEp//bylygNkMpwpe9Y0Nrss
         ysEQ==
X-Gm-Message-State: AJIora8sU4VdPLRgPv9IxjTmXNVNO062aDnNgExBOGWiL9Te09v7x0uM
	8S2geTQQRl+PG4FUFVgrOgZPfikkCx5L2Q==
X-Google-Smtp-Source: 
 AGRyM1siJrykLmzwbPY/uXnbjebS+al+i1tB5dPXg08y4ki4QLF83Jxh5Dl7ntdIbKfBqxb89QHVLw==
X-Received: by 2002:a5d:404f:0:b0:21d:b690:92a0 with SMTP id
 w15-20020a5d404f000000b0021db69092a0mr8473756wrp.436.1657802697089;
        Thu, 14 Jul 2022 05:44:57 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c037:3be3:5ea0:9a64])
        by smtp.gmail.com with ESMTPSA id
 z18-20020a5d4c92000000b0021d6d18a9f8sm1389087wrs.76.2022.07.14.05.44.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:44:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Ensure directory exists before creating symlink
Date: Thu, 14 Jul 2022 13:44:55 +0100
Message-Id: <20220714124455.505815-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Jul 2022 12:45:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13828

If the mirrors code is trying to create a symlink and the
parent directory doesn't exist, as might be the case for sstate
mirrors where the fetch is into a subdir, it can silently fail.

Ensure the directory exists in this case to avoid issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f9c23681bc..e20d19ce4a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1097,6 +1097,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
 def ensure_symlink(target, link_name):
     if not os.path.exists(link_name):
+        dirname = os.path.dirname(link_name)
+        bb.utils.mkdirhier(dirname)
         if os.path.islink(link_name):
             # Broken symbolic link
             os.unlink(link_name)
-- 
2.34.1


