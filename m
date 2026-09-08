Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B06FC79F82
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 21:20:59 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.263.1788902451577557117
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2026 14:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ojd9UUzZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484392e3d33so3650689f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Sep 2026 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788902450; x=1789507250; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Be/6q+FJfMkQAW3B+ArlISS9Pakcf65fKhPuB70Rrnc=;
        b=Ojd9UUzZ3z/sxhbL0b4BzibvWgJobrImmL1VL6Of3c+as0AZTelMn8nNa1d97GE1gm
         gNitXFaJXFI6Ex0sm76s2aPXDT8KWIcNNf9DYmrbBWHsPDjWnNSLS0qeW/DlmFxOMMAm
         i+jY4wI67CrR1T2ykgAplNin/3r052HQgk7BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902450; x=1789507250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Be/6q+FJfMkQAW3B+ArlISS9Pakcf65fKhPuB70Rrnc=;
        b=H7sJfv0jFesC8hw6YZKIIcbgXzdn2L9Jsw7xDsb860zw4W/PS43TRQxQL8/oEE6lcb
         VPIxoKvn2OGhYnjoLmkNyt1gw0+cxlipwxvm2d6IJH6wv8cj8fQe3VMi/dDZHbfjzhtQ
         CiZzbKXotNe69JRKpMcBaSKjKCHo+cun0z0R/WANt/3Gz2QwQF50twTJCxXBI/07iBnN
         57fUKAN4P4HHX6vR+21ov8QP48w3LI7q6KC9k6zeuvFy5R1S/fje8uJoTsSdcIJJGPGP
         6QwPoT6I4X+091McXJevMx/5PXaQwiP9Ymg312O5nugh1S9+5PeSeZ6PWpCOmB0owAXy
         HnWw==
X-Gm-Message-State: AFuF++n2ME+ZoOhtQ1D+VMRNPqsqNW/wZeEqbc21atcTx8oSAGzreSiq
	4EGm96oHzt+AGvrWTtSQDVL/shNyXXurXnuIwM0Z8szKReFFF4Ex3QAjrfeBxI4q0GymXXOPSuo
	UW0BJ+Og=
X-Gm-Gg: AYBFou1WGI++fOrD15HdaKUtp4slK5qGwuGY7Mg8Pk5zfnve500fpIQDcQUwLgEXj1/
	FipPG59OdHkQ+efv/PZqbkuRp6GfHRVJKNSEterD4iEKinx7Ru5NWOT+zkjh0wP8uJG4p+S5GRd
	LH+Gd7qwQr4qXr1ZAGxDPIxQRqiELtuXSzfY3tKO8ip7gCyncoNBnvnUdBdWRBeWoh2TPlAKsyo
	LSujIqumQYBlvLus1AXViL/ZGKtqGRmILG38/VeDYwOwDTQSn5F9LJ+elz6QyGpRz1IJFf4smY3
	/wxVjfEldpESDYlKDKPOrX2O/muySRcrVAQpijAa6EmEOImVRfaCoulRe4wZ6FGikGkWTY7VZU/
	voXVCZ66/RlPLVoHGuzZQr7ybD3nE4mnsyFpQJsqmnV+j3uaBg0PTITBpHEvOHZFwB8ABCf3VPA
	DM52effKRBHaSlX9tf++nrw32YAFn5h4WesUGOQQj5XRsOUOUIsG2epLan53dhzanPbjy5r/dop
	Ng1Er/d/eCrxbR+UO/X+ysVbs3J
X-Received: by 2002:a05:6000:2584:b0:482:b813:8315 with SMTP id ffacd0b85a97d-485872ac3b1mr35592273f8f.21.1788902449829;
        Tue, 08 Sep 2026 14:20:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3b52:472d:bd88:cdf3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm40285771f8f.4.2026.09.08.14.20.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:20:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] asyncrpc/serv: Add missing import
Date: Tue,  8 Sep 2026 22:20:47 +0100
Message-ID: <20260908212047.1788760-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908212047.1788760-1-richard.purdie@linuxfoundation.org>
References: <20260908212047.1788760-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Sep 2026 21:20:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20171

Add missing import of bb since the code references it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/asyncrpc/serv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index dd77ed0a43b..67fdc44dbf6 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -11,6 +11,7 @@ import os
 import signal
 import socket
 import sys
+import bb
 from bb import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection

