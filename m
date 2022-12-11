Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B0C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 17:33:54 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.21866.1670780028987867074
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 09:33:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G/3f1LwP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id q7so9787754wrr.8
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T4sQTHaYq4Kx9RcGsc0kbTW2xgLgQ5uRy03d3zNizs=;
        b=G/3f1LwP9nkOySTPh09XxNMwCBXtvyvxizq8AoH5yE55bbxWpdkHgP4b/IFZTPIdwO
         zhqhw7kidbOKf8+/0PflXksNyvXarV3groFY1hXjL4K3UE6mG6ZK0rtX75zIeFQhjSk0
         t1l6HzzR61KxHO68+JsLzA3dKk0yrpSpf3C5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2T4sQTHaYq4Kx9RcGsc0kbTW2xgLgQ5uRy03d3zNizs=;
        b=kZKMMdHjlYiwikUBAyNA4NSHcosLAwxL4lwsQNH5V3FqF1UKgA8L3qZz4YB5Kzh6tr
         v/OKr0lVIqruIsLGPNV1OxCGg+zYY3N8Jx0agh/xBol8rp0YzlVVMhI9izY8k7ONtczT
         UenUsJQSxL+jOMoHiXQBHx6FeLkItCJejbXfQhiM1dj0lBZ8mlBOTOlWSTiV50LsQCvP
         3urY838BETOgVJJX3/TSOij1I4FlbKNOzgu1CoBTl0OBhPuL+K/Lrycj+bEug7D8FkE3
         IsKlf0cAKCYXvnhLZ9SSB4UrY0diouyR2i4m9RYsuokZEDUzRcKLhPf1PIee/mtIElkT
         na1Q==
X-Gm-Message-State: ANoB5pkuzH/91pzf5/uavC/QAb6cBssQ5N3jj0v+wG5GobsrBH/RAGXh
	ztStBfz1NfKtddWiRB23oHnY3NjHyLLWIz6d
X-Google-Smtp-Source: AA0mqf68vBPTkM6eBONxhmsea+6EJ3LRALzUWuX2Pez73CBhoZru/riFtTD43qpAyq6r5F6COlUh8g==
X-Received: by 2002:a05:6000:137a:b0:242:4209:ea73 with SMTP id q26-20020a056000137a00b002424209ea73mr8680595wrz.28.1670780027137;
        Sun, 11 Dec 2022 09:33:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id bu26-20020a056000079a00b0024207ed4ce0sm6778200wrb.58.2022.12.11.09.33.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:33:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Bump minimum version requirement to 3.8
Date: Sun, 11 Dec 2022 17:33:45 +0000
Message-Id: <20221211173345.22120-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 17:33:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14175

Most of our older distros with python older than 3.8 already need buildtools
tarballs apart from Ubuntu 18.04. 3.8 allows us to fix a few things, tidy
code in places and is widely available or can be obtained with buildtools.
Therefore update our minimum version to 3.8.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 99cb5a0101..4e90964173 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -12,8 +12,8 @@
 __version__ = "2.2.0"
 
 import sys
-if sys.version_info < (3, 6, 0):
-    raise RuntimeError("Sorry, python 3.6.0 or later is required for this version of bitbake")
+if sys.version_info < (3, 8, 0):
+    raise RuntimeError("Sorry, python 3.8.0 or later is required for this version of bitbake")
 
 
 class BBHandledException(Exception):
-- 
2.37.2


