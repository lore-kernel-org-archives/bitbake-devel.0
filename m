Return-Path: <nate@nexthop.ai>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF27CD8CA4
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 13:21:26 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.79703.1781011284911224541
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2026 06:21:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nexthop.ai header.s=google header.b=IInD45i9;
 spf=pass (domain: nexthop.ai, ip: 74.125.82.172, mailfrom: nate@nexthop.ai)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304df7ff4c2so3823639eec.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2026 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781011284; x=1781616084; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSDaUrU4k7l/bdidJGJ1xqK8Zkv18JXsdF7iQo0/trs=;
        b=IInD45i9XnO29WCPUImyBhC8aCbnayElC+BliLB3knt0hiQJGEUebtolyQp5ODJoKa
         MtTyC/9k3mdFSin8/2cC8qEMz/kaCg3XTO6j2CZ2t51XUyq/mrGmUaXDzQ+6fDIHwaZk
         mqLJWZiM7YmKkodRSxFz72dUkvCiATmxQE/aGyM3SZBvMzcOZmInU7V1yhtvIigjiKBx
         pAXue6+c2ILXVYKBfht4aAaRJvX9R+9ou8y8enqImA30Zi1FiRPrLsGmrmWLmKWoLb48
         k/30xi8XJ5wNj9Nkb/dFz9j4dqBfdG8ayT007It/fmHkzX0mHIpLQVhsudatuoeSzj5G
         9Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011284; x=1781616084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSDaUrU4k7l/bdidJGJ1xqK8Zkv18JXsdF7iQo0/trs=;
        b=cHhWjJaynBH7Xo1Ed8EBfAYjD5iI7kGSajAANG2NVKCaROCTgiXJS6TfYhKkFXQ6ZB
         03z1vZLa3VM6wP8t+6mpmH7fHs3WAGVw0zODe7blKq5ZdZAEzReP9hBc1/woTwW5+V1k
         J77yZ9CuajjyhlOPrjjQeCYjp9Aje1/Fs5wUQPqYJkxsM5F5If6faJY/UAfskKjMjs3E
         0wujUs/M7dYC+Xz6n51QuxJdYKw/783TuGrqgEH1XFP/r2zyhkygrKvuzylyZ71MAT+P
         yCf7nRBXlmVXYd943whXKpqhgGUOaLat6yepj22Mv/aWYNBE7ty8h/KhWMfJ37rQBKkP
         W/XQ==
X-Gm-Message-State: AOJu0YwGr+qvURWSc6Rj1Z/E12GRwTrRR5H6ufmDnlyfvt5uLwPr1IKy
	ZqSIQy5hTjTPALg3sHoP0T26kJksoJs+VmnGCmAFZI5Tz3dwZZi0qEBDgWxnWFnQJlCrsbKyRZ/
	2P6R5c7AdVw==
X-Gm-Gg: Acq92OG/DgZPAzV9imXIeZK3pyQBJDHM6IPhe0xBoChXiY2f6DWyyeyKnRLUSMccOfQ
	vQYqnYIsoHB9m/1WX4qkP9ydXUxCbZgAD18EMrT0J3yLgcywvjNuxfjgbAFgjAIOAxDfV/+SfVB
	TTYwpRNqG92DmJ35GdKpNYkS73Rqtkrw0lCqTesLPizp2tWxhBMZLKmCSoKOpV5VyvGxBPE3BQD
	vVq1rN3VWegpf6Q0UBe4Agx805NIchiPqWPn+8RB6WLGCvzX81rC6YWCE4SdLbzXyx6w+NeIliE
	u3m3cTKEIRYjITxpHBbJ/GY3yuBBBogXmdPI9k69AuSj3gpCdfAynpAAsrtlRObjRf1Dow5ZAKD
	9lMNIt8xiRUpJBrMtgBHV1cILjsPn59OD94LtRDigeAmv5ktTWltWnQyDi7U5i2OfGn5eyQGpLW
	R1MHDbtlV26CHCYgHdhc+1x2R8KHhHzqEvU7+yBUPaoyi5io7o0jXwrIry8MwmKlGV
X-Received: by 2002:a05:7301:fd07:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-3077fff04afmr6431190eec.15.1781011284218;
        Tue, 09 Jun 2026 06:21:24 -0700 (PDT)
Received: from nate-dev3.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm25316012eec.3.2026.06.09.06.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:21:23 -0700 (PDT)
From: Nate White <nate@nexthop.ai>
To: bitbake-devel@lists.openembedded.org
Cc: Nate White <nate@nexthop.ai>
Subject: [PATCH] fetch/s3: Fix number of format string arguments
Date: Tue,  9 Jun 2026 13:20:50 +0000
Message-ID: <20260609132050.519370-1-nate@nexthop.ai>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2026 13:21:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19635

basecmd was moved out of the format string args but was missed being
removed from the list of arguments resulting in a runtime error.

Remove the argument to fix this.

Signed-off-by: Nate White <nate@nexthop.ai>
---
 lib/bb/fetch2/s3.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 059351014..fdd450429 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -88,7 +88,7 @@ class S3(FetchMethod):
         Assumes localpath was called first
         """
 
-        cmd = ud.basecmd + ['cp', 's3://%s%s' % (ud.basecmd, ud.host, ud.path), ud.localpath]
+        cmd = ud.basecmd + ['cp', 's3://%s%s' % (ud.host, ud.path), ud.localpath]
         bb.fetch2.check_network_access(d, cmd, ud.url)
 
         progresshandler = S3ProgressHandler(d)
@@ -112,7 +112,7 @@ class S3(FetchMethod):
         Check the status of a URL
         """
 
-        cmd = ud.basecmd + ['ls', 's3://%s%s' % (ud.basecmd, ud.host, ud.path)]
+        cmd = ud.basecmd + ['ls', 's3://%s%s' % (ud.host, ud.path)]
         bb.fetch2.check_network_access(d, cmd, ud.url)
         output = runfetchcmd(cmd, d)
 
-- 
2.51.2


