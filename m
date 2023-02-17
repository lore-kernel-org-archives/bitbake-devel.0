Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D0C636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:40:53 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.5442.1676637646674636737
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:40:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=afJIOBlS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so2344623wmf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWlz5fHz1hUj93G114Qsb/OswNDyU3zmK2++CnEqBww=;
        b=afJIOBlSFXyHrNJZKFVl6bQqb8vmU6W1vM2tvBaYZtYaNyCi9P9qGxXweBAV6iipiW
         gscOaGZfz/oW8iuraTsE9HxILPFRpn+kzfL76/oxzSc4KrT472OKYZANF5xtpY4qiIVg
         YpvU9FsLPM07CNjUfu1wx+dHZDiPRUw29/uik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWlz5fHz1hUj93G114Qsb/OswNDyU3zmK2++CnEqBww=;
        b=w9m9sjFayBPSrKZ9p6M9nTZkk/EKARJm2ryjBEFBXxcKr6ifFy8zNkn1zoeglRdLVq
         ppPMqfYKn0B/9Q9b4pF0I1Rahc49WFrLilYq9YKPFqVwJHLOgV6qtfxNWogwuq4rgMzK
         fTMSjGyM2vDSBoEByG4xLqMARva2U+1mNmTZ1DuVj/sxYrED4tkiiYzaboyu52YzaAIv
         pKFFpSPu6hYvlsQmq22ZFB6Pc/1EzKXVTUfyhvkWAyecRItQYKxReN6bcPg14JYS0BPO
         naEbsmNKRB3CJCWIGfbH6VFoQH2BXNRh+cT97zEgdv7/L5oo+XzZFme16I7EoJkNiMK/
         1rDA==
X-Gm-Message-State: AO0yUKWRRZ4wJIHbiWd2ViMMKBlCqG3uYawKozlQj17Nm6BC0IjcyCJI
	S514VYJnX7NMxnXjR9Ee9IR/PeMZ0D2rYTRs
X-Google-Smtp-Source: AK7set8MH/UGvdDVvc7gngTnByM4Px/cce6/CiM78OsMVotG3zX9Rxy1wsjDjO1IhsgZOcNeMI8vHg==
X-Received: by 2002:a05:600c:4386:b0:3dc:19d1:3c1f with SMTP id e6-20020a05600c438600b003dc19d13c1fmr195745wmn.30.1676637644640;
        Fri, 17 Feb 2023 04:40:44 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c1ca500b003dffe312925sm1182289wms.15.2023.02.17.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:40:44 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] cookerdata: Drop dubious exception handling code
Date: Fri, 17 Feb 2023 12:40:43 +0000
Message-Id: <20230217124043.341990-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:40:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14453

This code appears to be dangerous, it swallows exceptions, turning them into
"handled" versions which then show no errors to the user. This is a pretty
poor user experience and I can't see why this code should be swallowing
such things. Drop the worst bits of code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 2d52ce4c8f..dc498c205a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -294,14 +294,9 @@ class CookerDataBuilder(object):
                 bb.event.fire(bb.event.MultiConfigParsed(mcdata), self.data)
 
             self.data_hash = data_hash.hexdigest()
-        except (SyntaxError, bb.BBHandledException):
-            raise bb.BBHandledException()
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
             raise bb.BBHandledException()
-        except Exception:
-            logger.exception("Error parsing configuration files")
-            raise bb.BBHandledException()
 
         bb.codeparser.update_module_dependencies(self.data)
 
-- 
2.37.2


