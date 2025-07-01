Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C60EC8302F
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 11:59:43 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.8627.1751371180125815302
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jul 2025 04:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Lej3CC1I;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: michalwsieron@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso9393801a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751371178; x=1751975978; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbhY2NaaIwZ5+jMOdOS7lcwxkJSgKl90RaDpYMiBlno=;
        b=Lej3CC1I6aVyirMKu5styw+hAYBOBbSWq9O6b8yMFpvzZ3XZg2jO4QLe15jUohqkqR
         u3ZizYNT2zqFtD0WYgLVPYke9DP3AJTs5CCzEKBNVvbQa0owbOY2QrmTHYeIBUQXUgt4
         gXnF39wvU+s+HCAM8yfVMYpBw5n39A3gElt6IC8LRfXYT9bN7f7ryRpwN1idgRWbKTcT
         GWyGza61+p5gSm0ODO1h8mTbxsXtXjnIa4tQ9JJNDeVQ9IUD8M4Kca/AQ2+zO5j3t02K
         uwq0wbqAcq68oq2rF5j7PAjTFhjRESVYP+hiS+irID9MTh2NxuKd5jMy0mmFOaMLFNHP
         NBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371178; x=1751975978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbhY2NaaIwZ5+jMOdOS7lcwxkJSgKl90RaDpYMiBlno=;
        b=HMdgHGwo7k2Yi37mz6yrmwoytaLK3GK3x0DeLNhVfnDKtDTpCbyKM3b8zND1ZsJCEb
         Ip9I12YijJ9HV3mfjzfOr+aY+xNa4tM1PTKuefS5YcTLAbhJm0q9fyTVA5rA/8gMxb9S
         O1bIQ7lSVXrlWRUbAsLtweHQATEwYYPTfRWVlUi5LQBjtazKzekHBEyQb/9Cv4yLUzgR
         L7vh4RGbCamkazTMuDBrcfBOL8nhWw+XJ7/fMOODLlDJkFO6hjDDMrf8hD4kJ98Dch2g
         AEmdBDIK9lB1XTmh+tsYIeH+2Gaj4VC2j+zZrGLNiyCNXphIFqby/+LGsbVl38KhQ3Ri
         9IBA==
X-Gm-Message-State: AOJu0YxDQcu/+za8IINpuEFeFXWTa9Gtz2oiDR+roHx0v/wzTphFiVZ4
	YVsOcGURsEv2GZsfUaq/T8LNDBbFdCJMAJ4UDcSYqsPtMnIQV+WrS4zO4h886rwb
X-Gm-Gg: ASbGncswtaLidYmM0bdRQZwMLUT1VxHkFZW4zUPryawZQvONVexy1LJLRCIx1XwWJjB
	/d9RjvconXnY07NNyo6qTsO4tZeV/e8eHurMbkF5okfPRbECWOCdFr9yAOOSYbnEpfkhXj79MN1
	HomGL4M7qdBSbEQ6Gclf/gg7IH30XzV6o2Vi9LbD2ZO7sVO884kubfWyioE03w6+ROIyOLJQIWE
	zi3zuznkXh1L6lh3LiNNojo5q4Ker8HBKIz6BS7s7QNykphy24+A+twvOFtT/xwZWT65XxSoJGl
	Pv63a4AIbUqeI74G65TsZYny74qKPV5XgYNC17CSf0lBdV++zQD/Zw3PgubK
X-Google-Smtp-Source: AGHT+IG/lOG9HM2Q4kou6peOuvTirIFunDV4jQdDHaw2lyBu+jOGmRwqvPmfVL0BNMt5/bgv/fkxDw==
X-Received: by 2002:a17:907:1c07:b0:ad8:87a1:4da8 with SMTP id a640c23a62f3a-ae34fd60e03mr1644244366b.14.1751371177992;
        Tue, 01 Jul 2025 04:59:37 -0700 (PDT)
Received: from elitebook ([93.159.20.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a02csm853999066b.70.2025.07.01.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:59:37 -0700 (PDT)
From: Michal Sieron <michalwsieron@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michalwsieron@gmail.com>
Subject: [PATCH] fetch2: Make checkstatus respect try_premirror
Date: Tue,  1 Jul 2025 13:59:35 +0200
Message-ID: <20250701115935.23596-1-michalwsieron@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 11:59:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17732

Otherwise we might be hitting premirrors for repos that exist only
locally.

Signed-off-by: Michal Sieron <michalwsieron@gmail.com>
---
 lib/bb/fetch2/__init__.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0ad987c59..b5e8bfac0 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1975,9 +1975,13 @@ class Fetch(object):
             ud.setup_localpath(self.d)
             m = ud.method
             logger.debug("Testing URL %s", u)
+
+            ret = False
             # First try checking uri, u, from PREMIRRORS
-            mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
-            ret = m.try_mirrors(self, ud, self.d, mirrors, True)
+            if m.try_premirror(ud, self.d):
+                mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
+                ret = m.try_mirrors(self, ud, self.d, mirrors, True)
+
             if not ret:
                 # Next try checking from the original uri, u
                 ret = m.checkstatus(self, ud, self.d)
-- 
2.50.0


