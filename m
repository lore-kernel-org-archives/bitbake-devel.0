Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB5C6FD19
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:45:51 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.30859.1678481141269229011
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PN5PKgTL;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7007319wmb.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Conf+TDC0XsUvsiTqLoRskqAoimNbhMnt9hN5mXh/gQ=;
        b=PN5PKgTLMl+8nfFEBmiRQuQw66L0EJf23/e2wlUelBp/UAPbABFm5BX7Z5nYGeFqzt
         PjDCBTt4r+qN6ukxLZ1WJ4OCLxMJKeDFbYgb71/sorbnnTJm+fCGGV6eHoGOfdU7Puyv
         INd2e90X2t8nBSwVfF01FKUvuk1GGzuk4/fZESgrFpQ8/wN7IeGwglD8Vv3wR4SqinYo
         82eyopyPamvLyelDSYJvllzxEIFBNAIkbKanZCb6EmNvbNPY6r0+yPRE7HFQI03ijDgq
         zRTfTcKS2hkmBuJSd9vA7qNv57Bkr6FlaPRPeo+T9feKHi1nkL5PhBvFbFy3mSrT1Lk0
         o4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Conf+TDC0XsUvsiTqLoRskqAoimNbhMnt9hN5mXh/gQ=;
        b=6wAAn7OmZaZmECdsGY2yOzjzwdQZmP0ZV/q9Qu73y8uvvhIQUS264DCDcQnHxkxI+i
         DP2MNUxW9TBakD/nmZnmGGxUBwW4HIs+heof0eYas6I9zkpiBh9BYdzdj9uj+UhPIWyI
         cao2rPdMxU3h2DgdUXmlFPuat11eEOlX6gFItnRV7aPRg4s8JwvDbUPm7XCrXrSli0Aj
         kRR7HvbUT3n2RnIy4kohcipzsdRLNxbP1sRpvMg7pxBdIO72KmI8ySiyNrIWW5ndYSdb
         hPCnvvi0AdzWVm4Iq62XM45CIUooVPVTqTDryYbm6Bwk1lO7ojECSe8ECh2H55mqzDsS
         jqrw==
X-Gm-Message-State: AO0yUKUhNggrS8anXA+9is9/PXfXeyVeLdfbp66SM3FFaBAxWawssGGk
	GUIs/mEbmyNf8EBP4yq8yukkdFAKMLM=
X-Google-Smtp-Source: AK7set93ERBmZOWhHpW8mxzY+BJCxrQWORR/t7AUmGhJwku6LXGeBh4VC4iy3GVGvERJBPcBP9dtrg==
X-Received: by 2002:a05:600c:468e:b0:3e8:f27b:a92c with SMTP id p14-20020a05600c468e00b003e8f27ba92cmr4021702wmo.32.1678481139666;
        Fri, 10 Mar 2023 12:45:39 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c559626a50sm670976wrq.13.2023.03.10.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:45:39 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.2][PATCH 4/4] cookerdata: Drop dubious exception handling code
Date: Fri, 10 Mar 2023 21:45:19 +0100
Message-Id: <20230310204519.706973-4-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204519.706973-1-Martin.Jansa@gmail.com>
References: <20230310204519.706973-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:45:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14543

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This code appears to be dangerous, it swallows exceptions, turning them into
"handled" versions which then show no errors to the user. This is a pretty
poor user experience and I can't see why this code should be swallowing
such things. Drop the worst bits of code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 25eea827d..b4bfba335 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -294,14 +294,9 @@ class CookerDataBuilder(object):
                 bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
 
             self.data_hash = data_hash.hexdigest()
-        except (SyntaxError, bb.BBHandledException):
-            raise bb.BBHandledException()
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
             raise bb.BBHandledException()
-        except Exception:
-            logger.exception("Error parsing configuration files")
-            raise bb.BBHandledException()
 
 
         # Handle obsolete variable names
-- 
2.39.2


