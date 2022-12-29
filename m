Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E0C4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.209994.1672333653060041532
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KDnEfr8C;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id j17so12539020wrr.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTIt7iC+xqzzIzNB9KBjbdM1LBnvFop5Z3l0vl0rOLo=;
        b=KDnEfr8Clo1+yNWHC0HF3HSVCEqz0s1ptOCywhr8iEnpeW3XolRpx50k0FPDugUJai
         UJWWOrb/PYxH2SJbVbWwpVhd59afDXMRszGWJzavYWRmcbCUYjeMSrIJMKZ4hd8mZ+6L
         KLCLM9Mrk545P3ltulSGxYL6APnHYJErNMH+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTIt7iC+xqzzIzNB9KBjbdM1LBnvFop5Z3l0vl0rOLo=;
        b=PxU7bBCXwcccnrTJ1hTJbxNvaEa38YVQgzFVBgq7HitJH3wvyssjAS5atoHOFr5emJ
         LG4WhzUj/5i5TDb85iaYbBM7n/Evzn3HUynYcGOGRcoDDbYUmIxzyktKMQeLO5KcOovv
         3h/mVNvSo2R2q4SfMW8jI3TC0liR9ntqnL1LfmRjTke2qUB/4FTp1ZzgucZSN1bDOQ+n
         EclULQG0URNHI3kql5PAeCDHZoU/QdBzy2GP+hCM38gGtuqBq1EL869rU2JnnLlKpUA+
         llaNAYGrsadvbgrwwkoPGWIi96O7gplHduPLdvP8h8fqecDZl0wLWOABoTwT9oGmMds9
         bSNg==
X-Gm-Message-State: AFqh2kqj9iiM8owzEmVTI+pAkfORX2Z12uzsv9CLV7IFw6EZyETdRD0g
	F/LAmdwOAVhjHc2DFt1Si8jVRqWRzHpps3zt
X-Google-Smtp-Source: AMrXdXsgI8MNlIceY8jz3knx7q4shD9smeRAT7O8RO8bKzh3VCdkw3z0YdJnHj/QcAO0rUFcn8w+tQ==
X-Received: by 2002:adf:eb02:0:b0:265:faec:7086 with SMTP id s2-20020adfeb02000000b00265faec7086mr19287207wrn.9.1672333651329;
        Thu, 29 Dec 2022 09:07:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 02/15] cooker: Ensure commands clean up any parser processes
Date: Thu, 29 Dec 2022 17:07:15 +0000
Message-Id: <20221229170728.880367-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14245

When finishing a command, we need to ensure any parsing processes that may have
been started are cleaned up before we reset the cooker state.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4e49b0e90b..df31a413d7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1768,6 +1768,9 @@ class BBCooker:
             self.parser.final_cleanup()
 
     def finishcommand(self):
+        if hasattr(self.parser, 'shutdown'):
+            self.parser.shutdown(clean=False)
+            self.parser.final_cleanup()
         self.state = state.initial
 
     def reset(self):
-- 
2.37.2


