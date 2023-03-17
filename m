Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233BDC7618A
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 08:19:57 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.14339.1679041187919582364
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Mar 2023 01:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KPr3ufze;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id w11so1723876wmo.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679041186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urIUkXOviiJ2tcviX9xw4r0BPbg7agQh5pZ2+uOaYvw=;
        b=KPr3ufze+wVPbNZNOfapWQ7KI6alDBFU7ATklX41x/7itoqr2ElxFGYnsUfh+giUz2
         vxcxWRj4rSbhxubnOi6jTwtnoQTVkrNIkBi0ix8fb+SgZ3Of+E7x2wp5JjykboO00xvE
         /F6oD5VmZsh69oDFYsZBQ35WzSGTTEhpHkjZPbNp6TDj85uI9vONX6Vut+Eqks4YDqKc
         sZk21vt2I0hwWeektfMzwxvJpVBQPP2Nny0XhHt5ULyZKcBujLI5Kt5VU+JwEBE/wZtx
         9fUy7lITuK/l2pJX5td6FOSzBkIPLd5d4CoKEycbWO1RTAMYcICGfwSbZnROIEHT+6QK
         41+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urIUkXOviiJ2tcviX9xw4r0BPbg7agQh5pZ2+uOaYvw=;
        b=cP+QN0mn+PqOS8XUPl6AI/4TOhWKMCDtb10X69CXHJaUqiJly2jOg1AplyqrXYOOKN
         biQw5TkKnQCOaOSyY+9ZekPGR0WpBt/7GuDF8OiE/EeUtrQatDPS3GDdC8i2cj3QJgVN
         bqnfTd5k/WrWnNb12wkCw/XrSo0GoNnqdHCh4qiTEJ7Zm/gia8iYsqi0dZLsBI389Nxi
         asqB1bdd+r5zu+sjOcgaVr9JG7/0LfNRv8PznIHehy1NKQK7O5tqgkB094/zwvlwKZeP
         lJh+YXzYU/3fYT50r7K2pHOVDMsMCjOL5VrvgC2Jl8ubCRHx4bd0dPVxHzunijMpyEPU
         emtw==
X-Gm-Message-State: AO0yUKUlNphVJ40IWYSPsvK+trEOWTx+4a6HbmZxDjSqr+/3+bmmZOa5
	MbddEmZqWyKw3khI+NVGITtTe7+f+FM=
X-Google-Smtp-Source: AK7set98lE/JLZ32Z+quZ9qid9Ozid76xMpmOVMWtRli4rzaSc5EaD8x6PTPC97GU8Wdn53Lt9+MBQ==
X-Received: by 2002:a05:600c:a4c:b0:3e2:589:2512 with SMTP id c12-20020a05600c0a4c00b003e205892512mr23501002wmq.21.1679041186083;
        Fri, 17 Mar 2023 01:19:46 -0700 (PDT)
Received: from work-pc.. ([2a01:e0a:8d5:c6c0:7a1:ff32:1d50:1429])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b003e22508a343sm1293819wmr.12.2023.03.17.01.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:19:45 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [bitbake-devel][PATCH v2 2/3] crate.py: make checksum verification mandatory
Date: Fri, 17 Mar 2023 09:19:15 +0100
Message-Id: <20230317081916.1857201-2-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 08:19:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14603

From: Frederic Martinsons <frederic.martinsons@gmail.com>

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 lib/bb/fetch2/crate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f091200d..f8367ed3 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -33,7 +33,7 @@ class Crate(Wget):
         return ud.type in ['crate']
 
     def recommends_checksum(self, urldata):
-        return False
+        return True
 
     def urldata_init(self, ud, d):
         """
-- 
2.34.1


