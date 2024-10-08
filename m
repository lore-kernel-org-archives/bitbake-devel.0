Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0DCEF169
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.8049.1728390994558553320
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KzEnVyl7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d1eda8c7cso1479059f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390993; x=1728995793; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4tRqMJv/6wlwSREQXxvS+uKbWNYZ9T6lLDeSZX8qdI=;
        b=KzEnVyl71yviXRPmczKK0XrzHkH+nAoPqRcldnbOz8qrAV+w/EiCRKZ8adn04skBSz
         nHklKHwq7IWHSB78povRPa+x60+lrOETC54fBMJW7VJZU6T1CFm9FQ3GVSiU63Xt1SID
         CYRPbqQ1T2KkC3XXJKkefEdWureWxpWrs2VnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390993; x=1728995793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4tRqMJv/6wlwSREQXxvS+uKbWNYZ9T6lLDeSZX8qdI=;
        b=u82oZflZNVwsLXAZlvkXtwZz1p81IguluE8VmyV5IoFwumB/i6Am1XIhkiZ3JODV6B
         Mnz9WiBGwSWKOMPuVA7oCJOMzZ9XEgicp7+iM0BXvVO6fY38eKEEoQFAJEzfEIhcp/2P
         jymb1cuGdzmsmJvnUnm17K8+EaPX4ZFabDvoc5z8K3FEtuqv2uKADCJoZDh8w+sAFWAJ
         +/P9Fh76R12fqx0FpNXBOLtCjVl6LOiwSoK1sOIAYf4J7UY6z/5+ipmvhINN1cGHV9MR
         oULeh67i2RgZ6mwEA894r1gSgqDhap29T4u+t+GcGBZcNm3SmsZ5BA4/OkvWaPa+hj6T
         FVDg==
X-Gm-Message-State: AOJu0Yz5sO/TxpmVQU0bjn6qG9vf21WNKCwwtJo5y258kdINqv1aHeyo
	AtAyDbB1+zweTNWcILQFcJ3bQs0DJjf+zq6iX/wJ8tMV8ZGOHdpK2/XvhkISRI4h+wIf/WCYYQj
	O
X-Google-Smtp-Source: AGHT+IGwpu/hkMx3KBzH/VX+WQQZnB1dLglcVK94URn1STyuXxThXZHvuD31GBsC3RuxnrOzZCwbfg==
X-Received: by 2002:a5d:6e91:0:b0:37c:d344:8b42 with SMTP id ffacd0b85a97d-37d0e6f0dfemr8705042f8f.15.1728390992730;
        Tue, 08 Oct 2024 05:36:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/8] exceptions: Add hack to workaround python 3.13 failures
Date: Tue,  8 Oct 2024 13:36:25 +0100
Message-ID: <20241008123627.252307-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16659

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/exceptions.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index acf546de1d..60643bd642 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -47,7 +47,11 @@ def _get_frame_args(frame):
         cls = self.__class__.__name__
 
         arginfo.args.pop(0)
-        del arginfo.locals['self']
+        try:
+            del arginfo.locals['self']
+        except TypeError:
+            # FIXME - python 3.13 FrameLocalsProxy can't be modified
+            pass
     else:
         cls = None
 

