Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61EFCD98D9
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:55 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45069.1781183510373867085
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nwbiu5OU;
 spf=pass (domain: smile.fr, ip: 209.85.221.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so6030452f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183509; x=1781788309; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv/H1P35AS67J8PRe85/IL92ZBNvEdqmnpHcjvdWzHM=;
        b=nwbiu5OUPLIqS+yFAsBLN3Ur56e/TRVvSXpS+dptXu1rE8ogM9Hzp4D+8QBHzddPir
         jZX/M2noaAvER6dHFq9zUGgHWRkuYJ6zUHUMzurE1tki960XUYEZhpsmKpJAKSex7iAf
         bImIcq4LTyySS7eBxFci9lUymBLAtk0OQh5d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183509; x=1781788309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mv/H1P35AS67J8PRe85/IL92ZBNvEdqmnpHcjvdWzHM=;
        b=KxRuzwQ9y/tgmwmuDORLlQArsLEKxRh+WzbPKCvSDah+Dcd5cZJ23AjSuHxCvNIFnn
         3zox5BIHGgk3WVG+BvWiTL2ch4Affj26lxFutf49wYqsm3YGdn9m54OLpJmp1eZvQO2u
         cWbjYLp4uOY3PeQEOrSCrkx5pbAmRHdTY0YtNiD6gLLZmv8w5qfW8K3Xh1q7FsF9n42h
         8kgOC8vP5lXszGwHKszOnjiOaJN1KVawBcnZPgQj29PIvoKhkFqbFc47O8ut1gWSfXzC
         9lJZR5svG4LWkGCGqAfdVoJNSmmGln1nhxJFGYbx/2cm8eG1707QtH0Dyl8Rcb1OFPCo
         vxCg==
X-Gm-Message-State: AOJu0Ywyp/S+jf8g+ByNqkxMnJFPMubsr/k0uQ8Au5G0jiodw/zO2wj7
	xChf3iMrCKq70Em8Ief/qDD1NZ+Kls8B2FpMZVLdXrf5r05Qe01T0kFMee/HvqWQpSc2llC0UBV
	oV9iw
X-Gm-Gg: Acq92OEfdFPT7evIDkmfgcsSBxa/EV5HgK5XTNZF8IX9Xd71G17WsfWXBUtT4iZpclQ
	zxDzNFIiq2Z9P+YfJxpD/jHMuivrAkRU1LzRSCDhoT4r/GKh9Vg8jWPFo8XacR9ly06DT9jVQ4e
	fbUd6Kz8jXh8XBLPP8mj/AbcHrr+M9mzJZv2iziME14MrxCKI6WzyfROb+9fOIwikC2jUZ5PHLG
	VkS/bV+4PArQ60OK3voK9swcD0FscyG2jjsSg+atKokdmELYG+l4vCaOrWbRUkiMjaoHt4a2Ujg
	PoA87ZZ4DIelQTT38o46X0S5PZjrI9MQAkXfBPy+shcN4iXYU+wf1+yc19BRnNX6REJlqiKe0ua
	7esFmB+O7YIF1URxaI3CxiAGSHry+S/2xXbpqwfeKTdk4AUBGyuLGbZiH018rX/IpSw9T42gceb
	f0y6Ow0TABPNc8i1Fn8p5k0Zq5AxDKNvjtaaextj5OrWOr4J92u6AIuOqc5zN2jz7Axis8bRgG/
	XgoEMRGzfu81rT6JA8jExkB2yevOqnhFMP0cpriGyUKmsuAew==
X-Received: by 2002:adf:ea51:0:b0:460:3210:4349 with SMTP id ffacd0b85a97d-46067800fcfmr3601092f8f.42.1781183508619;
        Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 4/8] fetch2/crate: skip yanked versions when reading cargo index
Date: Thu, 11 Jun 2026 15:11:26 +0200
Message-ID: <f457e8a4ba2b5b601c0eefa94072d69bae4d461b.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19664

From: Thomas Perrot <thomas.perrot@bootlin.com>

The cargo sparse index marks yanked crate versions with "yanked": true.
Treat those the same way as non-existing versions so that version
checking never promotes a yanked release as the latest one.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0d757e8dfff7c5d338a01437960d60312e9af490)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/crate.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b89817ab9..d84bae0bc 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -178,7 +178,8 @@ class Crate(Wget):
         response = self._fetch_index(ud.versionsurl, ud, d)
         for line in response.splitlines():
             data = json.loads(line)
-            versions.append((0, data["vers"], ""))
+            if not data.get("yanked", False):
+                versions.append((0, data["vers"], ""))
 
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "")

