Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70154C61DBD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4135.1787932787636007080
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YQ8/6+J4;
 spf=pass (domain: gmail.com, ip: 209.85.210.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1262566a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932787; x=1788537587; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNbp8ctbFzHX6aLs56BQ70pPObANvXVauMmYbwoHVoY=;
        b=YQ8/6+J41uEzw0KignzcymTyQBD3R1sdh3aCrT0lh4eu0PXIB45xx7iPC9X8MYctIK
         DhtB+3iq3MrMHl7oS6tnwEPaph35/gfS2D+EP8ycelpGumKVTYXPkAIoIQqv5/HTp5Nm
         k47HdqgX2x/f/GKGY97IuEwdEz5QY/Moe6ILnNaO4ehcu401OuPen78VBPxt2nWDpigi
         cMgo9nyKNhW2/BuRFlgHg9aVhHY3fL8RByi5Z7WgdUTzrIoEn2mbCOKvJy2rEQS4E9qG
         x1/+8hdfkt7n8ZxTgtLNlDvxzds1YwaoCFQnUcmcm5Of934kd5xGF+Y4UuIQ2WAYK722
         rSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932787; x=1788537587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jNbp8ctbFzHX6aLs56BQ70pPObANvXVauMmYbwoHVoY=;
        b=CvWajm1+Jv/SA19XBb+45sqAbIrYWuYL3L8JfwcmqHLVuL1SIUVnl4zQ4VHlMDbgK2
         swdhbN6g/LeOcopI8VY3xbeDNSYz1/OtmQ2/CHcJbGsU7jhys66aAdZmTptoCEAJDeTo
         AG7nW4IUodQXGrNsdhSDpLXztcD0sjvae6vUj6h6EPhUk+lrj/zYDpH+IOFk8iPoCzIg
         vsv9V85/zLx0eBF02MWkYzCsH0mi5FdikheKHOq5Vphwct0Evs9vYf6v1+o+SQibBbU1
         PUFeREmmI9xbYhtPxRpoad7YKth9CMbuMsJeoLCkoMykKm4HNOoGbUTczLTBDBLEtNkD
         0HEQ==
X-Gm-Message-State: AFuF++lIqWPTrUraSysfkxAa8E4G0gFXoPEkyat6xTEJtQR9jw2fzqN3
	J33RGIxHyxk2vnfEvaFcpPhDSmve4p3UZn3d0c9BDIvAqozpiByTbv9lKhQsng==
X-Gm-Gg: AR+sD12YQBMDSeP3kD2b8sAj7ypG09Rx1UPEldbP97U0Pw7l+qgWYTHedlu84VPBCAO
	jwbmBJgG40USGVGWrfo2melydN2KS57UHJ+ljpzyfA68g26mcl5IrY2GpQQyc1a4Pk0s3Jg5ufh
	N9Va2erojKpHbQoBfOcqsEAbVAJ6tpICCxp1P8PQM/lyNTZBHwpYzJdAm96EIpKGjRoRHeAwXKS
	cAxr7hXiOfImq7icF6A4q5en+8OGGkMYZ9JWPqP0pDW0gF3RbW8uOgnmFGW22OuujaTZlkWbek+
	uea881B+kjTwVZpQtC1r+T73hV0nYmCA/sM/pSMadWYwElWDZnLWMNWMqk9NvmVdVsaqEp7X8h6
	chcmHCVhbus+/R85SHXVj15FGn5Y04X2ZvJFBeTp8uYf5HXqwS0wn0tEVZutNkQW/KEFc57bDZG
	Ae3DxYVWh8gmd33XuTbtOMbCZByOnq5FO+ILYEMtNnOv0F7+vOq1zOrm0HWw==
X-Received: by 2002:a05:6830:439e:b0:7f4:d16e:45f9 with SMTP id 46e09a7af769-7f4f253ea8fmr8507966a34.7.1787932786694;
        Fri, 28 Aug 2026 08:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 02/11] asyncrpc: serv: Use Task Group
Date: Fri, 28 Aug 2026 09:58:09 -0600
Message-ID: <20260828155942.1219468-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20108

Uses a task group instead of asyncio.gather(). The task group ensures
that all tasks are canceled if an exception occurs, which
asyncio.gather() does not.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index bd1aded8d..d3b1c6c35 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -334,7 +334,7 @@ class AsyncServer(object):
             self.loop.add_signal_handler(signal.SIGQUIT, self.signal_handler)
             signal.pthread_sigmask(signal.SIG_UNBLOCK, [signal.SIGTERM])
 
-            self.loop.run_until_complete(asyncio.gather(*tasks))
+            self.loop.run_until_complete(bb.asyncrpc.TaskGroup.run(*tasks))
 
             self.logger.debug("Server shutting down")
         finally:
-- 
2.55.0


