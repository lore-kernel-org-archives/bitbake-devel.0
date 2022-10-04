Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C3C433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:18 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.12291.1664898915909779205
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=0uOOvstT;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.41,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f41.google.com with SMTP id l12so13051620pjh.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=DLZEoSid4yGN20VnYLy6CeAOYQ19VXJJ/FawhZptvUk=;
        b=0uOOvstTnNDZC9Jy1dC/tnAyC+kbMwBg37tIQU42nCYdyRij+JQRAh6pqCl/UTy4I0
         o1KtyGfCI4a4DLZ26FfX/YMPZ0+Df25Ka25ihStMus06hUhaToxaokBOoDU937IHTiUr
         BdoN3auWMR+2MeL7ZJ8QE8+GEBY+0KgWS08xC8uODBFxNnQ19GJyNbRluVjtFGQ9an9Y
         KYMjyysEChVYtpSIChLhCwEr0+lF9VaWjkgP47EoJ10zdfFhNFd/Q1xI5N1W6L4GCu9T
         JusTySuY1S1+HaO0+XM0kY9hSYlAZo2NOh9imZTQ9vJeKRshxSLVaA1OGesOSgQE41AD
         FqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DLZEoSid4yGN20VnYLy6CeAOYQ19VXJJ/FawhZptvUk=;
        b=flNuOHT0Ut2oaT8wUuaavfNqwQj4DmEdzwl8T1wxQ1ZfpB0Kihk//Roi8Z2tmRoIx8
         4j473NNgXP8p5eKPx9BNpDSSswCrdw5Z4nzau9uDoU2jb3TcobaIVtmEEkUPwI4diucB
         2JzIVShdQulFlrEGpKCx7ubDzS8g09P6vA20FI++YarWuSkNhWGib+qeBqw2cP3ng5k4
         WupKEsk4m79ceZpFFDavMSmUo647jPxQkZXluQIkC6KKtvrsvzsYD46WOl6xePde4MCB
         7JUgos/u8ka1xJJepq9N+rttQ2OTBCVf/RNu6RUJ6f+UIOukboJX25Cr2lN18P1tS7B1
         JhDw==
X-Gm-Message-State: ACrzQf2NF3zAQpnJoEQvVJT3Rr/9aBvd1rGT9QNm2T9xzCKO3+d6GpQP
	0/XLnMIqMEhVil/jgwtQFzcbRLyxnptORXgI
X-Google-Smtp-Source: 
 AMsMyM75DWD02N/PYt8+YCNVfQrciQtEtI/g9LCkkRB5Vvrd1PkDKuAOAGBYx7n12AqNhUyozQ7E1Q==
X-Received: by 2002:a17:902:e74e:b0:178:b4c4:5ac4 with SMTP id
 p14-20020a170902e74e00b00178b4c45ac4mr27760862plf.11.1664898914985;
        Tue, 04 Oct 2022 08:55:14 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/8] runqueue: Ensure deferred tasks
 are sorted by multiconfig
Date: Tue,  4 Oct 2022 05:54:52 -1000
Message-Id: 
 <513bfd771d9095fcb6a8bf93806673dbf988a4de.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14016

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have to prefer one multiconfig over another when deferring tasks, else
we'll have cross-linked build trees and nothing will be able to build.

In the original population code, we sort like this but we don't after
rehashing. Ensure we have the same sorting after rehashing toa void
deadlocks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 27228c7f026acb8ae9e1211d0486ffb7338123a2)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 111dc0ee..a23f7a89 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2523,11 +2523,14 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
-            for tid in [t[0] for t in update_tasks]:
-                h = pending_hash_index(tid, self.rqdata)
-                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
-                    self.sq_deferred[tid] = self.sqdata.hashes[h]
-                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
+            for mc in sorted(self.sqdata.multiconfigs):
+                for tid in sorted([t[0] for t in update_tasks]):
+                    if mc_from_tid(tid) != mc:
+                        continue
+                    h = pending_hash_index(tid, self.rqdata)
+                    if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                        self.sq_deferred[tid] = self.sqdata.hashes[h]
+                        bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
-- 
2.25.1


