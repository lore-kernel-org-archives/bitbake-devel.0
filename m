Return-Path: <WXbet@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E93C61DC7
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 10:02:04 +0000 (UTC)
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32663.1787824921689628122
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 03:02:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C25ILgOA;
 spf=pass (domain: gmail.com, ip: 74.125.225.65, mailfrom: wxbet.oe@gmail.com)
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fe3f552f0so585239f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787824920; x=1788429720; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WQQHKeIr1YkPbglnpJ/f0WWm/UFXTvPYYB3isIphgWk=;
        b=C25ILgOAxeTvMYCNGtmnt/V7InwTEY6Dv1+EBHe53tcR76kSYFEODC04ha1d3BSK/U
         Nkpap0lUWFokFjGdA0tCQWIaJriWAXz9MlU44J11mWh7gviPRyjnIh4WUpnoIMbd+4T3
         0/hbINLPfBxBy96Ze8pSGeROGR+VvG60TIn/5Rn2XjTZ9iqXF4U/gFQImkoD/A65rENr
         62nYxNKcbRbEDESH7EA2r/F9CPEXv7NKZ4i8DyYW8+bqYtkW2vMizR5gh6XNvcdvWzuZ
         JEgaF+yMHOBRaZkOdyrdRoZF7dh872aND9aqOKCdk0WUgE34iCdeN+NANlYWp3fL44Vq
         +Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824920; x=1788429720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WQQHKeIr1YkPbglnpJ/f0WWm/UFXTvPYYB3isIphgWk=;
        b=nldFCi34gYRD2rBD+eEC+lLPmDdIwpODvYsqKPb6xKzkNMN8yZ9scFi68s+alnaUVN
         lDpqa0+2ZRQse32tAQA4kz8zC432MOhOkw5BbcM+I78Q5x+7bsgMwdcd81ThxonJWVqY
         jzNudcqwJmKcSfQYnKs8qH1FCBhGwWcIdoeOkhxBn420HLTcvCaNgtWpQkd672vQpAXu
         A/2eb+ya8mHYHYP2cyDikoqU8ohM1IwaFl50S+u66K2Jz1TwZ9qsaAc+8CwdcQWK4g3l
         Dg5Qp0CbpiYV1TFII3dByGHKvhkMViYG0Sy1pR9Non26Ci/RSkgIJh8B69rsnxlBZ98e
         9PNw==
X-Gm-Message-State: AFuF++lp0zSuJCJPS0xWMaZMGhjfIdKq2NggHW2Vxs8/6/lsDQbANSmF
	+BCkGHPdm2PAs3Zk7oLC1Keuewo46aq9O0rbYn0y3LiPlSl1POONZr7ARukiYOXHh9m3ww==
X-Gm-Gg: AR+sD13RdW7FnE0iVSjTVOJMjW9N1iSTVCq/0wW90yZwOpLGV3lbdyrv28/4q/IhHbK
	f7rm5xP5bUNdDEKpGbKMfFJyZTWi6CNNXWwaxEqchWzyDvb30c5EwuHI6vZzRdYHNs16a0wLUx7
	JWnjak7gqQRUDjTfnxEAB/D9GALxqW3MW17Mx2mjRt/yOgwBHmZGjQLqoDOlXqbgq1JByWh31VV
	JzeEoKhUMqGwVajDRmPfNQv476VG6pPIvxi0J4rEGaH11Qj9aEDqWssjYS8jO3sCBMUyzeZuQFf
	i7g/dVvvYAAuNWpzYfBox3dT+zLdS6ENyFBN+geT56fbtPA4plKqdkCzW836b8noWWptO0CkD2v
	jxzCx/4NygLB3W7htTu+kpq/XVNl8F2v204y2/x5bXmt/uxQbyTRwRPRP33cC6SYA2vxYmfF97x
	L6xzlVvubcUVRs9kRhr9P2C0IuyHAIfIDj4BooypE7/PWNzXbFPucjDYhiqdrZE7Vbr+DdMwzBI
	XkoE+X46lCsjbC890o0+Mw=
X-Received: by 2002:adf:e002:0:10b0:482:e1ce:d45c with SMTP id ffacd0b85a97d-482e26fbe90mr13875476f8f.21.1787824919603;
        Thu, 27 Aug 2026 03:01:59 -0700 (PDT)
Received: from localhost.localdomain ([94.31.114.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc134sm7849687f8f.20.2026.08.27.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:01:58 -0700 (PDT)
From: WXbet <wxbet.oe@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: peter.kjellerstedt@axis.com,
	WXbet <wxbet.oe@gmail.com>
Subject: [PATCH v2] knotty: show elapsed time on the task progress bar
Date: Thu, 27 Aug 2026 12:01:46 +0200
Message-ID: <20260827100146.11256-1-wxbet.oe@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20260819093321.3451-1-wxbet.oe@gmail.com>
References: <20260819093321.3451-1-wxbet.oe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 10:02:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20064

The progress bar for the overall build shows a percentage and a bar but no
elapsed time, although a build easily runs for hours.

Add progressbar's Timer widget to it, which prints the same way as the bars
of the initialisation phase that stay on screen above it.

Signed-off-by: WXbet <wxbet.oe@gmail.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 15025e8dd..1a3198b5c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -354,7 +354,7 @@ class TerminalFilter(object):
                 msg = "Currently %2s running tasks (%s)" % (len(activetasks), cur_tasks)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
-                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
+                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar(), ' ', progressbar.Timer()]
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
                 self.main_progress.fd = self._footer_buf
                 self.main_progress.start(False)

