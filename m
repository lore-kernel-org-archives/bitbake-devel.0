Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2D0CD6E55
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 09:45:00 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.12866.1697017493413586892
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Oct 2023 02:44:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ax9tlxll;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: bhstalel@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-307d20548adso6021937f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Oct 2023 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697017491; x=1697622291; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iM/yKlYYCPEzkqHrxHk47AiX1DNCn8KBEFofT9NFfQ0=;
        b=Ax9tlxllQSw1TKRJGCxqZ25XZnTnh85hM/H/Naa7DgKPe1uVm87GbrU/mOpP9OT2rX
         Kgwoe8z4hgkqY8Yes0Q7Qd+9h+4h1IAQ24GcGKp+SHNeJCAup8FQmBUsl/QDVar4NodO
         4B5c5gD0HaXblXtofP7wuON1r59nss+K/Ufh0OAM/1NAgnGwtd2fBD3ScIfL3KZ2wvJQ
         u1GI0gfQRIU07h0+7gORXvXyP9ekY8hyan+SDNbUJ1d1jrLGLg3rreNY7rr5F07WaFXr
         JjgIhJMnOEQIwmljGFEmYfd0GCrD34e3ac6xOGn+YZehk4MAj9omjbUq7W9tiZphxzNW
         dyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697017491; x=1697622291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iM/yKlYYCPEzkqHrxHk47AiX1DNCn8KBEFofT9NFfQ0=;
        b=ZbkeLTykkWnE5duM83QxBqW5/y0otaQEoV78ZSve80erEPzLCrAnQBlC8JhS3lKIky
         P7fgRc0JAQ+/ARfR3aOJNTUOVxI+SJug4o7zR4wBBvJnKex4Jc1TEuVQXRHjHEtHN66/
         I9Q5wAeb6yVhbCqrj5pBj69SZn9Lojd+ggzE4YRTuVeO5mOnzBJ1pPqRF5HAJQVTRqCP
         zR6sHILri8sjMMRPGAsG8OIoaSr+uey9g8Tzr3XxrnxLPdVy62jDsVsXmjBf1co9nQGt
         WvYx0y7sXACrYYieRn4F8paEmGPzA5aeYPSp2FhIowGCSz74bg9UqM0dVBDc5e1Xb+El
         /zwA==
X-Gm-Message-State: AOJu0YyJQxexDa/7WILkUmG4asgP7bBb7DH3JNJT6WQ3kgggm6FSNdEI
	p2TX3UT77by85d7K4HrGYNuDlCe3xxFFnxrH
X-Google-Smtp-Source: AGHT+IFSul6QEwNJkN1J+NL7tIvQh07NacJQGE2dE7A5vUeIWXbYGU9lMR0ZRRRbIFaUmaJ8ZM8kNQ==
X-Received: by 2002:adf:e8cc:0:b0:322:da1f:60d9 with SMTP id k12-20020adfe8cc000000b00322da1f60d9mr18945094wrn.47.1697017491428;
        Wed, 11 Oct 2023 02:44:51 -0700 (PDT)
Received: from talel.sofia.local ([193.95.99.58])
        by smtp.gmail.com with ESMTPSA id k23-20020a5d5257000000b003177074f830sm14943620wrc.59.2023.10.11.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 02:44:50 -0700 (PDT)
From: Talel BELHAJSALEM <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJSALEM <bhstalel@gmail.com>
Subject: [PATCH] Fix find_bbfiles string endswith call
Date: Wed, 11 Oct 2023 10:44:29 +0100
Message-Id: <20231011094429.987944-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Oct 2023 09:45:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15209

Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 599c7ddaa2..9a3e32ac1b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1787,7 +1787,7 @@ class CookerCollectFiles(object):
             for ignored in ('SCCS', 'CVS', '.svn'):
                 if ignored in dirs:
                     dirs.remove(ignored)
-            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
+            found += [os.path.join(dir, f) for f in files if (f.endswith(('.bb', '.bbappend')))]
 
         return found
 
-- 
2.25.1


