Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CBC282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 13:55:19 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.11467.1741355702233806171
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 05:55:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=wD2opB8w;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff64550991so2991970a91.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741355701; x=1741960501; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PYdLohszhNbI+iRiz8oj88WoX5DPTVskhsI5Ioe/UQ=;
        b=wD2opB8wwcMVn6hQN9tDZy8OBn3qzLIyfxI7M+DjFuiKvKm9TSboqr6FegTgo4qC1v
         zYvO/ygEXHzhC+8PphJ2BkmonpaVv24n/CyECkpc14KlV3BHGTiG6tu17dfSBkV7UbKX
         EpsX3yuHLeFB6HlQczmKHIkm+1l5Kt3saEIn9IsWM4p0+WbQ1bPqtg4dTL675N/vYWWy
         Fjg/ovFdaYlkamxP1G8Im0vPbWYbaoCCA1N3rGnNKNRkRTNTu9NsTqvaGYUPTJCIi0A8
         G+BDJgiRov8xoMz7urhLvkPI3J+CDtpY92dtitO8E6jN4ltGZdnu/ZPveNK/AIF4BJim
         7jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355701; x=1741960501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PYdLohszhNbI+iRiz8oj88WoX5DPTVskhsI5Ioe/UQ=;
        b=OrJoe/38eCvLad6wwOOQfz2f70m00/bD7Q7g3ADa36xcJKgpDnAyJ3TD8KDRWjdEwg
         YufJrsk6U/t7WyLOjArOYsVID6UmBQaUVoARPGimOychcN0iVCGeLqrSYypYM0rFUCeM
         RBv5/mtEQ2jLvTkvRFYg48ziylR8s0Foxg8ZkGZsltxDoxK4OyClq8kLc/v2JV/zMGRW
         uRtesmnOTC299H5hcbiK5IqeH6c4gXDePJYnLXUh5AZpBiSsGF48dl2wpPooORzOP8Nx
         aH/m20OZu0TPngnZ/AISIEuN0jh/eIU95dqC0OvXAO1vRVK1FIsfauR/nqVZXGO4lRiz
         Ex6Q==
X-Gm-Message-State: AOJu0YwLANJLMhFGjjrqs9auxWHW1ntkzllkBr7U23ZLrIydcD3o2gOp
	Ae3zZe0wHinSzmKON+M+DC7q7mtox0NlzZ/csW3Q0MJoRsdK+ver+eNz8uLnnZ0z0T2vGqYmoj5
	w
X-Gm-Gg: ASbGncsc77IeFL10Ja8zoP49sYYK1vrwKg1k765fdoUiN+0gsS/Um5c1xlms3iy+XhI
	EPzzYnHpoHkrhsbG30hJezvuYBqlsNqYHhRgETnxett0ee76JraBnMm0gd21uEjK8J+dkWeA6BS
	G+Xbw0vEYC7JEOx8MRWekkQ6CDC/t5BmegWLSyvNTmvDCnIoaZO24OD5eW0HBxUF0mz6lF3rcTb
	K782IEc2PBBgZWSWy5xalbGwGn9T7rzinhFV36vNTPMWJKij+3fdXqU+AVSHMibURrvrmqNEQXb
	2//2l83WTgV1ovZXA0SU0Q8BhD31JRBgbjGA
X-Google-Smtp-Source: AGHT+IHZD8fi2bdmXPnMpvbkPFkv6YOjLmotwRNvjNy5gJqoGLW7ht1uJh35bm5AG/ivH/J+K1Nwug==
X-Received: by 2002:a17:90b:2e90:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-2ff7ce8e50amr6605386a91.12.1741355701417;
        Fri, 07 Mar 2025 05:55:01 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:cfcd:40b4:f918:b895])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm5488032a91.10.2025.03.07.05.55.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:55:01 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 1/4] utils: Print information about lock issue before exiting
Date: Fri,  7 Mar 2025 05:54:51 -0800
Message-ID: <bde34a174886161def6f9f2c5194870a4edfefb2.1741355508.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741355508.git.steve@sakoman.com>
References: <cover.1741355508.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 13:55:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17408

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cdf6c51a064f8f335c3262b7f102618996f1a229)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ebee65d3d..0dfe47dc5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1862,6 +1862,7 @@ def lock_timeout(lock):
     held = lock.acquire(timeout=5*60)
     try:
         if not held:
+            bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)
         yield held
     finally:
-- 
2.43.0


