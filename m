Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0CC61DDE
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:56 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4136.1787932789290362855
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fW50jDk/;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee37dc91f5so632753a34.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932788; x=1788537588; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DoHa3ZUIiIR//1vZWiyeQap8laLQkHQfURKVV6sd7mY=;
        b=fW50jDk/ONJ1qrX//y81g3K+Y5c8l1Zsbpp5RD5UQLo53PLsr6ixULv0lHhTDkYMA4
         xwU6tfQUod9DAiN8uCCQq30fCn/7HWaOwnZqVab1F698w2Q7tuTumBKvAYkK6qU56BHE
         4tEL32TgvNu01jFHs6nedsjPzDxUijdIk8OEbeNWDvSSWYS3TfHhcnHQhPFmuc3V7fsW
         yMy7Mz3F5apSHr2K6mjJxdu9rRu7IFcf2zDbw5RMgsX3ZUWZanFUZiTEzBTKWwVysnUF
         7rEwYLyTE0M3kjBucTtItpF+xM+OhzSodHCl6sE0FY0/NDEaDVJyKpiK8umnYvE2YcMp
         7AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932788; x=1788537588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DoHa3ZUIiIR//1vZWiyeQap8laLQkHQfURKVV6sd7mY=;
        b=XUa+DYvBgbMvx0KJ4QmiJ0tv3VK1QI1FE6e0M+vnnAxB3BlIW66lU2xRpqOYB8hxMX
         TrSTQLtntd7slh2zFuzAjWq6AUq/FazxG+6eTA5fZ9S1yMeMFG31Dfa11yCqW5rS4OVT
         N3BqFxQpXLofVWxYs1u0hlUM0mOk83AmhTg57P8pZb1fTefek0u8BiR+ziHYqr7TDnsY
         9xZlSIxQ8VwVWSxq4bs706YduTyVuekkRF0ZYBwiSy7zvdZfzLJG5dWq/90AB7rR/iUT
         fJ/WXlI07+4fDi8+0m9R6ms6fSQVng7S2lB9v3901hG/b8wvIhcEOAUc2xZd8ga0pPTV
         /9AQ==
X-Gm-Message-State: AFuF++nhl1S89iytZ8lfzC7gJUAHj8XPFf9Yhp/2xNfJIZV3lrjujYDY
	OsjG/0xes/1zwVJwgVa9v1gKa1+GNHuNZaBiyaGcCMpNKHTa1MpxuL7jNz25SA==
X-Gm-Gg: AR+sD10iqobxrRVHk5/+GvwcIJtKx2le8l5+0fFIExhgwSQxJ8BkckAizJkcYjr4th9
	WLNl0AcXXAE6hT9a2/HxuyxDmfU3xTfic6t2MMjSosGgsTqQ3NmgkdLSymNCbJLwDJJqsS+XDoO
	eJXVUmjHuHNo4iLB8ChD0H3TsHZmZGOGZlTlUEaRUeZWEU6OXthKeWTmCW2awhbsxeAobDTPrkb
	e+1ZghS6WZyyXpXsBesxQMSUPfbCwbhN1l0SK3roTS3Z3iAEUhnMICo2Rq5NoZ4Y822ShdYURi3
	hEJOgozKdj3+819SLU9AehxYLosYxTf2cQVMcPrI8LvYGwMaiYkWkcu3iGQtVF9EdRPiONbC5ON
	2cidK5m2gsYFnXAM0p2L/iRcs0m/pVr2oImBcNXzUe3rMWCZR+GlddiLPvpRNTkj+pGrPZ4kbAE
	Yr4TwyipDDUlNcincWUJaTE7JS4WA2EN1LYy0l8pBDVdVsFkPw74KgCiynbjWC49pfAzmV
X-Received: by 2002:a05:6830:4118:b0:7f3:a8ac:45f7 with SMTP id 46e09a7af769-7f4f224178emr9021485a34.3.1787932788460;
        Fri, 28 Aug 2026 08:59:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 04/11] hashserv: tests: Improve test logging
Date: Fri, 28 Aug 2026 09:58:11 -0600
Message-ID: <20260828155942.1219468-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20110

Log client messages to a file to aid in test debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 7c736d6cc..551b9e298 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -30,7 +30,7 @@ BIN_DIR = THIS_DIR.parent.parent / "bin"
 
 def server_prefunc(server, idx):
     logging.basicConfig(level=logging.DEBUG, filename='bbhashserv-%d.log' % idx, filemode='w',
-                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s', force=True)
     server.logger.debug("Running server %d" % idx)
     sys.stdout = open('bbhashserv-stdout-%d.log' % idx, 'w')
     sys.stderr = sys.stdout
@@ -93,6 +93,8 @@ class HashEquivalenceTestSetup(object):
         return self.start_client(self.auth_server_address, user["username"], user["token"])
 
     def setUp(self):
+        logging.basicConfig(level=logging.DEBUG, filename='bbhashtest.log', filemode='w',
+                        format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
         self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
         self.addCleanup(self.temp_dir.cleanup)
 
-- 
2.55.0


