Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E37D68BFA
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 16:26:29 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.46127.1731947186167408446
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 08:26:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XtC2Wso9;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43158625112so20234705e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947184; x=1732551984; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=XtC2Wso93zPHePn7s8coq4WrwGbyu6PJAnuYdetC8AviGWiXjSdKPkeDSdzRUXxGJF
         1s/uA87SEZETe6VRrSbgpV83JEwxNC7mL9m/lwUTLwj3F6Y/EnheKFyJ24g2TUizkODF
         UAtJCXCOfsjiu5cLnkcvCqurSCsoTFQUtT+UrtUjdqJJvbrhC1VoTYo2VwAgV5Mgo9Nx
         lBghLUNDl/e1ixNkusFP1aWnZO5FqeL/lSHI9eBmf3tNU6DFGfqtcHivRT6TyOWrwCe3
         1fJNBAfmNeNTwU0BbDvqrfstuejXBnTZTMANHwNS1W5z46b9a+UNWfQ0X/24Y51R+h7M
         wh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947184; x=1732551984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=KGxgmu7FjmrbFNAbIjMA0JcqNhIbKOBuCKAiEanFv+eRSPKJLGrj388qwqagQZ+48z
         zg2YE6HT302srtEuydL++oy0W+mvyuFSpo7Ckd/whhcs2c6FQwX4Odxuc66xLsJxyLAz
         VkO2QGFNick//IzqSos4UXGu4NRtvSQAp6gyHg9i8VYtLhc9VANfragIOGKLuco6fdUj
         Bol0F+vBykysgRXSY2ri1CmJuM2jd0Uw8lXmYtF16NFvs2izrO72UxX36bTA29uDTIIt
         anr3hS9QOqKB4Issf0g8/wKfr/0+FslHXowMukzYVcQQ3HYSvV3TtJMORBSv6uIT3D/N
         NvNA==
X-Gm-Message-State: AOJu0YzVwl5RH/VcFShXDpgZnE/zd3wfpyo/ojcCrqUYC73i9Y37SmGs
	YpMHZrdLXxcRnZouM16aiaQzf1rnO/6t7ZVc6vDn7emXJPumZyN4CC/dlA==
X-Google-Smtp-Source: AGHT+IHeyVsShXgP6J5WSjkl5HAli71yDd8Q161aAZUkmxF4vY+SxYGjT+FuhqqIzrq/qCBoYxVlGA==
X-Received: by 2002:a05:600c:5129:b0:431:54f3:11af with SMTP id 5b1f17b1804b1-432df78fd98mr116121485e9.31.1731947184388;
        Mon, 18 Nov 2024 08:26:24 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48c731dsm109341455e9.2.2024.11.18.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:26:24 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3 2/4] parse/ConfHandler: allow / in variable flags
Date: Mon, 18 Nov 2024 17:26:08 +0100
Message-Id: <20241118162610.1423384-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118162610.1423384-1-alex.kanavin@gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 16:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16808

From: Alexander Kanavin <alex@linutronix.de>

This is beneficial for config fragments, as their names
are specified via flags, and those names can include slashes:

BB_CONF_FRAGMENT_SUMMARY[init/systemd] = "This fragment enables systemd as an init manager"

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 7826dee7d3d..27665443dd4 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
 
     \s* (
         (?P<colon>:=) |
-- 
2.39.5


