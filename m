Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED6C98338
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:58 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32879.1790495200622547802
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YuxCbs+O;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so15248835e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495199; x=1791099999; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iHmQFGMaEGMRESwF+ByREQaQNnpah9YBaROXn1EILho=;
        b=YuxCbs+O786bhRSRzG51mCGODu/jwQs5ZBBc0i46HlPyT82SfbH1lWZ6BAC12e9B3M
         Ho2xeEl9bjoM4JZCHutNhU73jwKLdSsp27qxGXhKZtObplkRH4QKiJ4joz1y0oGlDUCJ
         7cfEtWI7IGxox+HdBZ+yUIfy3FlUwXxcEPjD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495199; x=1791099999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iHmQFGMaEGMRESwF+ByREQaQNnpah9YBaROXn1EILho=;
        b=RcpHvtR6l3LJ0hAeKqLhDgWMaAqwoCw6BoNh3LPbIrNA0waaaV4D1Er7lP66F6Bc6D
         Ho51X/aumA7DjniWK8rp0CaeINKF9LbqmYc3R8jnak1VQsA3juLZ9pV6baLoOrQlodDt
         x/KreRduh+54uPmh4nolilUdHtFDS9q59wZJjWypg4ATIWPymK8peR6y8wJ8fErLvkTC
         85tzP4Yq0ja8rLHJctkZkawufUrVHQhHgQEuCYyGDOrdjbf2zmQCaVw8JLqcGvLGSDdX
         ufuUGn9gmuZow//ePdqRlxZX3n2tsPLIICDQNPsJkv9mnC0EQev45WYT9bnW0R2GBf+H
         Iy6A==
X-Gm-Message-State: AFuF++kBIXY8LwVaTczprw9ijTGo1IVvHeznA5OiIcNzHYN4xknJ3Xgq
	Ac7uqoyDmWb5iFYMz2o+wENUgT+/RHfoj73qFMGBj2MWrw4jZ/gSUZCKiVnn8udnrTyaXuFax4c
	GZgD3rs8=
X-Gm-Gg: AYBFou2xSFzoEy5sbetuit9Ej3OIsgTYArKLA3B9au4Oxd9evzIBHzvRK1dFx1Sonln
	czMRBKTBmyJKcJn68QCMVQ3rdWt1wqh1T31yRpgKOFJXvcSGHVRaVnyRdS4ZDM3OMlSDCqD9V+v
	qDqtqQJnS7TJ8KpZ7gu93XIMlKKBcjezv6bom/kO70NPQvlOT3Oig3117KldJsP5wp21w7D4LGn
	DZQRlYx6/G/T3M/4wNkqiavOKWpVZSz++ffAZRdHG7OsTHgu/SAVZGYs/r9VJHZMBCEvqlR8L5c
	4TnpH0GlWE90elmVBURYPDJtN4ATdoVijyTBPIecXZZFUCEdRv2FJYCTUCt6bga5iUCP7xUxRN2
	6Dz39OhgtH79tT8ghPSJHEeu56ViZrZrhiv76FlZZIvUodcymnGNX2G3lOo5Cna5dRC8IZNkMvv
	DHz0+xDJHs50CwdKYDL8GHxrOxB25GX0C2pC58k7wllCLsePxlGtsQVzud6T/Ezvb/TFC5wXMAl
	BemJAh4I6rvO7aoU/lROloh7w2QxEBFprY5fs39KHPPeqpq9I2IS83EI1yOPVLH9aRT76Zlng==
X-Received: by 2002:a05:600c:34c6:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49fe66f4dc9mr210656105e9.29.1790495198895;
        Sun, 27 Sep 2026 00:46:38 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/6] runqueue: fix bad check in process_possible_migrations
Date: Sun, 27 Sep 2026 09:46:31 +0200
Message-ID: <021043086fdb0e69d9ef543807edb845006a5604.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20261

From: Chris Laplante <chris.laplante@agilent.com>

This was probably a copy-paste error from above. Detected by PyCharm's
code analysis (Local variable p might be referenced before assignment).

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7f24c51c049bde59d28d28bc83dad2a769ec1eb5)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 544081053..ff8ecdf81 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2610,7 +2610,7 @@ class RunQueueExecute:
             next = set()
             ready = {}
             for tid in current:
-                if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                if self.rqdata.runtaskentries[tid].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 # get_taskhash for a given tid *must* be called before get_unihash* below
                 ready[tid] = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)

