Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94506C433FE
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 10:44:09 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.114763.1669632246583845110
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 02:44:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PPiw+xM3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id w15so2869594wrl.9
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=krP/M3dU5MVEJlViKHy5hkK2ec/oJ8WZXcH1q2XM3V4=;
        b=PPiw+xM3G1+MXPccYXjpAaTofCwGg8CBo+zHU3GI2vY1Me9YHIpIf3E4cRzJ2CVMXn
         CkNqsLn9wv8vPcWwsGT9+k4SNHaDdLUUILX01a6nJGJJ0Z6Ru5VncDZ2gWAjK2I3P62j
         F5p/zbC7r4v5VL5AVcGqUJaQa6gdCEQ6WM65c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krP/M3dU5MVEJlViKHy5hkK2ec/oJ8WZXcH1q2XM3V4=;
        b=dvSFLSco+mFlu/AVwZ0xtIxZxM1Sdp+lBFcF+lbtEGpTd7eh3vGUUtG00t+uhQptiT
         L6pYYL81kfasEpx5qbyDqBAASm3jvUeRgjYHBQKHA9ylseCsN48vefIuHjCf3tD4kuln
         4pGkb/50lbEACczXHJEm5RVzMNeVFIbQGJXR/tE0HtDzvpbICvb91vSON3MRqR/yDhtX
         96xJmJW6u/leFEj47otDS4MzBonWn82g0+4QUVyeVBmcT+2dNmasUMZjb6+54cqUUeUx
         /zWBbULULijwUREFKRHi2Tlm1IYA8UWdVFKi2LDkGM7+3E62kkBNJDPU+iPZvm8ibu5M
         ziOw==
X-Gm-Message-State: ANoB5pm/GPTISkTVYCHNQ0j0s65R1U4+KzBxuQi18ZWyCaTn3F12utGc
	rlHNb3Z+/jzHHoQ1dXeb93vNMDdtKvUj6Q==
X-Google-Smtp-Source: AA0mqf5UyMCo5AiWAhfkhNkNBWKq04b8MGtd91BnmAfyzoZ4IRbGqVNH8MFd4clVE3SWWRGiv7HW9Q==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id l17-20020a5d5611000000b00241cfa520d9mr24164933wrv.451.1669632244492;
        Mon, 28 Nov 2022 02:44:04 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1da4:7286:b644:a924])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b003c21ba7d7d6sm14547038wmr.44.2022.11.28.02.44.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:44:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Improve error message for missing multiconfig
Date: Mon, 28 Nov 2022 10:44:03 +0000
Message-Id: <20221128104403.617338-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 10:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14119

If you place a multiconfig which isn't enabled into an mcdepends you currently
get a traceback from runqueue. We can do better, add some code to tell the user
what happened in a more readable way without the traceback.

[YOCTO #14970]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2c1714da9d..cc36b84781 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -698,6 +698,8 @@ class RunQueueData:
                 frommc = mcdependency[1]
                 mcdep = mcdependency[2]
                 deptask = mcdependency[4]
+                if mcdep not in taskData:
+                    bb.fatal("Multiconfig '%s' is referenced in multiconfig dependency '%s' but not enabled in BBMULTICONFIG?" % (mcdep, dep))
                 if mc == frommc:
                     fn = taskData[mcdep].build_targets[pn][0]
                     newdep = '%s:%s' % (fn,deptask)
-- 
2.34.1


