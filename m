Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442D6C4708B
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:42 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.21403.1648981312070901157
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U3W7ZdEb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id h4so10249855wrc.13
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OITC/9oS4D13Zcqn+s0//rTxraO4VvFWSDtzjU5SXp4=;
        b=U3W7ZdEbdQbgwbQWDl2wrFicSn4HwWvTXEnbCvNLBRAAFZk0ahqL/p2BOLfAGb8zJZ
         HCyVW4bTr07XXv4Tj13cDv7KZRmBVyqgq00VtUPKsN01GQlN8koqxxxVWwqPo0v/lpKo
         4AL/F0Ah+dw/FydQNEUBvLoin/uYBaVhr0iZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OITC/9oS4D13Zcqn+s0//rTxraO4VvFWSDtzjU5SXp4=;
        b=PuDEmMTBSmZKRkn8CVTvlpDG+8OlhwLxTMdPqh8u/TtKcyijO4xYOlhbnUuh/0FwB0
         D+a2LVHnZrxVegOF5DAM2dzRwQZH71B8o5l9/OuZuTLZHcLblR9N0OYbmsq3raJroOd0
         MatrxbbeIq8LiZEMRoTk3Mf+OIMHSBJ/CNdsQGzMFvRYnfPZgYmA6A7yeOQI9jl1gI2Z
         NelEofJP+M2dsPlBADatTIcqaXdXH+ey6M9Fkae3qU4UiNV1dq7NLbdiGb1ImsYvZPEr
         g7t+6LbjUmRrCztlbGh9sytqP+QDpfbIgJGdh4N3SoJr2dqWRAPodsOJhuwTOQL7fHrm
         zodQ==
X-Gm-Message-State: AOAM532KytpfPa1SsivR6P/hkBZl7aWvS9FE+8j3xFGg8vkjkHUI7c2s
	SOK6qLkxal37EpdtgBgi9naBaJOyGSOra0Xa
X-Google-Smtp-Source: 
 ABdhPJxyRKw/SO9BfWUepQ48NA1mDqnFTlCd6IobADij4ci//LzvLB8/JyfP02cAKRN96EINSfY2FQ==
X-Received: by 2002:adf:d1e3:0:b0:204:7e76:8a70 with SMTP id
 g3-20020adfd1e3000000b002047e768a70mr13964679wrd.580.1648981310375;
        Sun, 03 Apr 2022 03:21:50 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:819:f853:3436:28c4])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm6327981wma.21.2022.04.03.03.21.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:21:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/5] pyinotify: Handle potential latent bug
Date: Sun,  3 Apr 2022 11:21:44 +0100
Message-Id: <20220403102144.1679700-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
References: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13575

The kernel inotify code can set more than one of the bits in the mask,
fsnotify_change() in linux/fsnotify.h is quite clear that IN_ATTRIB,
IN_MODIFY and IN_ACCESS can arrive together. We don't care about two
of these from a bitbake perspective but it probably explains why in
real world builds, we've seen:

pyinotify.ProcessEventError: Unknown mask 0x00000006

This module code assumes only one mask bit can be present. Since we
don't care about two of these events, just mask them out for now.
The "upstream" code is unmainained since 2015.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/pyinotify.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 8c94b3e334..5c9b6d0fe2 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
@@ -603,6 +603,17 @@ class _ProcessEvent:
                                   unknown event.
         """
         stripped_mask = event.mask - (event.mask & IN_ISDIR)
+        # Bitbake hack - we see event masks of 0x6, IN_MODIFY & IN_ATTRIB
+        # The kernel inotify code can set more than one of the bits in the mask,
+        # fsnotify_change() in linux/fsnotify.h is quite clear that IN_ATTRIB,
+        # IN_MODIFY and IN_ACCESS can arrive together.
+        # This breaks the code below which assume only one mask bit is ever
+        # set in an event. We don't care about attrib or access in bitbake so drop those
+        if (stripped_mask & IN_MODIFY) and (stripped_mask & IN_ATTRIB):
+            stripped_mask = stripped_mask - (stripped_mask & IN_ATTRIB)
+        if (stripped_mask & IN_MODIFY) and (stripped_mask & IN_ACCESS):
+            stripped_mask = stripped_mask - (stripped_mask & IN_ACCESS)
+
         maskname = EventsCodes.ALL_VALUES.get(stripped_mask)
         if maskname is None:
             raise ProcessEventError("Unknown mask 0x%08x" % stripped_mask)
-- 
2.32.0


