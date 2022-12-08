Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA15C3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 12:21:46 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.12004.1670502100397095102
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 04:21:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=p70TUBFI;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so874397wmb.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0u3Dksn1m+/mRQceRJltyO2rlA4/mC+fROewRaJdd8=;
        b=p70TUBFIxl+faqDc3BMlBPMbkyo2CVzjqUI59G4DPx89A5E7WjsLi9Wz9ZVFvhJsdt
         SlRk14795x5PdNt0wJVBb4pAWDrrbsQZn0ZtRiBRLaUjVClFy4kReMpSd3eKrxIvixIp
         hBrz9/ivoILFGtxspGsZ+nSOYJybLPACTqAZ+fmYiv+kZZ0AcRUeN6ORGpWDha2/PnW/
         pl8e+LtwdHY8XFKjdjocK22eoQVvX6IG6SrjqS8MoQX69BfBVPYYtA90XDyPm2nI9eOB
         uJv2gxedHmLQiGxv2d8975QByCTCpaqwN+KYunm8pbp4zV2VAE4Mz6nlOYf/wDQliSTF
         3rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0u3Dksn1m+/mRQceRJltyO2rlA4/mC+fROewRaJdd8=;
        b=xbFZXqdRlfmnou6MScCtCyj2tth0wM9JnxjR76KbhXMjJNBar1l0NIP9f562chcbwk
         Z7smA0peb+uU0vDgLiT5tN/9j4WCNrDgtVKGPeNW4SrM5DuCvZc1OB1q5e7NyTn01gVA
         RyYDUkMSKfjPLjiEVLf02zEKQbcW/oQ5xaoTeAcsEX4WWao7d1oUZo6rzYwiXz82xM8l
         yy85m6pTeQvXZihiS/mq6yz8Ys00k2Nu6UtZ4RO4YcduE+ugqN5fTwSHIDOXxilFK7Ed
         6w0BYu86LSVGhTpDrUcCiP6ZH25LQMZGrqb47uglvYM4PCj1lSmgBJIOi1y+BeOzPYjE
         JETQ==
X-Gm-Message-State: ANoB5pkD9J9m+cWZJEj+7lgTwcpCkEBMxkOoKOLPHk4zTxWJR2YKOObb
	woN5t+Uy+cKgzJuOlQv7citaNWUjKcI=
X-Google-Smtp-Source: AA0mqf5d7gIWCZoQNhX/BljY2iq/oGCYHZ/qCo/5xp66WfCpE5EZXdVYrcjrwTDUqxtIoo+toDhT4w==
X-Received: by 2002:a05:600c:3b84:b0:3cf:b73f:c062 with SMTP id n4-20020a05600c3b8400b003cfb73fc062mr54842677wms.204.1670502098323;
        Thu, 08 Dec 2022 04:21:38 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003cfd4a50d5asm4893690wmq.34.2022.12.08.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 04:21:37 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch2/wget.py: correctly match versioned directories
Date: Thu,  8 Dec 2022 13:21:31 +0100
Message-Id: <20221208122131.2455528-1-alex@linutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 12:21:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14150

When obtaining latest upstream versions, the code needs
to check if the existing tarball is in a versioned directory
(e.g. component-name/x.y/component-name-x.y.z.tar.gz) and
if it is, it needs to first obtain the list of all
such versioned directories and then check all of them by going
one step up in the directory hierarchy.

Existing code was returning a correct match when the component
name did not have numbers, e.g. a check on 'source/epiphany/43/'
would return 43, but was stopping too soon when the component
name itself had numbers ('source/libxml2/2.10/' would return libxml2).

This change ensures the last match is taken instead of the first.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 821afa5b58..7ccea3ad89 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -644,10 +644,10 @@ class Wget(FetchMethod):
             # search for version matches on folders inside the path, like:
             # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
             dirver_regex = re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
-            m = dirver_regex.search(path)
+            m = dirver_regex.findall(path)
             if m:
                 pn = d.getVar('PN')
-                dirver = m.group('dirver')
+                dirver = m[-1][0]
 
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
-- 
2.30.2


