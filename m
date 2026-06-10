Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010B2CD98CC
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:29 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33444.1781132006152310255
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=huRuE5dF;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so185023f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132004; x=1781736804; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyhsjDUN8PXNd/hMzNzd8ynGnD4A6+mHqMiAuPQBC4c=;
        b=huRuE5dF7QDoJNpOIo9k64kbGaLRD/SywYRUTsme4ZsYQVUZ3vJYC0XQAS/qHFD7dY
         mI5UZceGMtQT/bQmpscpyoswK7g7xmgKTCGwqqChLmoeoiSBgkInFrO21Z86PNnHVDBt
         Q5+3w4rmq/YAyjniVnDWgsmhCxHkNHCzOw2To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132004; x=1781736804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyhsjDUN8PXNd/hMzNzd8ynGnD4A6+mHqMiAuPQBC4c=;
        b=ocpprLI+echCRV0TJtA/E0ezSlof06NoeO5i1trtGV5CwDosOqQDpYkA4u9YLH+D0h
         sGNb3drZWDI8jBVOboSVMf6rMKFMDBpcI6+Zz+uKWj6+xY1SU2IcyuoM9/rW6oiUDE7A
         /qGVqm5S7upwty/lOV/RSG9ed9RoE1L852oKPIfQxbnb1zZEoL3Ucd2lvanTNWltYTSl
         /1iH8wXXtC6zfN3tm4dMbU1iMO+HrMQJzL1jU/YNVqgsfhName71OaT2ivPEaAnQ+k7+
         AcWT3AcQVSZS3xLg9vWidwRiLwA2tzcANmlBbtoBbQL8Ychx4Sz5Xx8wJhn/T1n2Vz+4
         WltA==
X-Gm-Message-State: AOJu0YzFlS2cMLMP6Ve0LJqkis0O+b1oSPByDXst2QYBs+cQO9+z198k
	DyNV2h6BfKJ1FrSddDBVTTmVk9xP1FyaXnkUyPAYE/oLAcd1Unb031sSCB8VRpSAihF8aZsePoh
	yD9et
X-Gm-Gg: Acq92OFtHeFbrZbIdXm5HIE1UGL69FR/E9fl+h89kzBkvLyOvwESRGa/molHx7RtBMZ
	SfadL4o0WY/DBN0YDP5NBn7oqgiNLANNN29hlCbB/B50QKO23Fh/tl/ixwvrM3ybTR1mZCTl9RP
	N9rDQM6XSo54VThyxx9fz/1lHzQ5SDjNzRb0g1NHNIEb/gTXO38hY6qIH4tbRAGhWXYA/JKFdS7
	vvYQmQQfLgMBPRpaMlgKysQb+VVFKCP7MW9ZRVGRlTSsW64U9S4/E3dnvYZtUubcVN2wPsGgZTa
	1851FDhfALS8/GC/RYl2wGg6UjgDk1w9NOm5uAmx18g2GNFYYcAhRi3kz7pT4g/l9/+XVefPwbd
	bYDMpyW8sNhIJGfP1u6qeXpw261MHcT/AE3ZkgQ8SnmLwMBJ9/V0tG4MzcwAcQBVMMoq9EWC44h
	9KTKpebpkFGoYEFmipnAodq7XRVq7odTNkELr/tSfVXgUWXdx8L4dQlG2wuLDdky/0L3Mj/e1eo
	t7ADZoKeogOkx85blxF7p7yjyG3+2w83qCoDy0=
X-Received: by 2002:a05:6000:4615:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46067be6a45mr57251f8f.12.1781132004578;
        Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 5/6] fetch2/crate: guard against empty version list
Date: Thu, 11 Jun 2026 00:53:07 +0200
Message-ID: <317cdbef364202ea0a857516d65710c95c96bb1a.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19652

From: Thomas Perrot <thomas.perrot@bootlin.com>

Both latest_versionstring() and latest_versionstring_from_index() would
raise IndexError on versions[-1] if the fetched index returns no usable
versions.
Return ("", "") in that case, consistent with what callers expect when
no upstream version can be determined.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ffdc2a02693379d7ead0f7b940111340843d49a4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/crate.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index d84bae0bc..eb1fd5719 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -164,7 +164,7 @@ class Crate(Wget):
         versions = [(0, i["num"], "") for i in json_data["versions"]]
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
 
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")
 
     def latest_versionstring_from_index(self, ud, d):
         """
@@ -182,4 +182,4 @@ class Crate(Wget):
                 versions.append((0, data["vers"], ""))
 
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
-        return (versions[-1][1], "")
+        return (versions[-1][1], "") if versions else ("", "")

