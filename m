Return-Path: <tdah@bang-olufsen.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B122C52D7C
	for <webhook@archiver.kernel.org>; Fri,  9 Aug 2024 11:50:25 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.82146.1723204221133648721
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Aug 2024 04:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Jyeov5Ry;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: troels.d.hoffmeyer@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a975fb47eso235131466b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Aug 2024 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723204219; x=1723809019; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUTNTWmKnEKgchVeg9AnRLZFuGRfGu5QIrrQwH2vjX8=;
        b=Jyeov5RyvlEkfgpNsKwuDCOIt+b7EiAiILdNXU+1JaKgFNR6CS0Q5ikfVhG7h3j3Zm
         EywW39Ok1fJ8k20r5B6A5mVrmgLSYL8Em99Tzcs4t7R3tYuMuBAJTf8g+UFIFPVKuDf0
         KUSTn0IhjFiR3YD8U7OxIAA8rkWgcvPIP3/+F+UV2ngXdbU1DtMVLcnzneUhdRweAECQ
         8T7wY9SbTo0tPLyUW2Sq/pY3uggpak/gXUcr6DMvFhVl5cjlDOKlMnHdWo10iaj4Oa1M
         StcH0/SCgVnC+3tnJoOftaakxcX29hkCT858QwJDLKtf3gny0dughDECAEb5y08IAr3d
         p0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723204219; x=1723809019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUTNTWmKnEKgchVeg9AnRLZFuGRfGu5QIrrQwH2vjX8=;
        b=l2pOMaCE/ft8qFHdI/w9Q7bOPuVSoUgVZCp0UPmox/oIjdK02PbLd1wjE1rk3b/XtJ
         Y8jYlALK1Jje3HD1Db0mW4B9UdQwpp9Fz71wLwXsdSYjG9c+x9FF4X8uocw1tQFZAEsu
         3csdhznfvTHZ/SJK1Ts2frdLA6+NaT1OQ2Mx3QQN9g7IHN4pz7JQ/k7CBU1ITH9yNKyo
         SfUgWkwJWrcUx01bCbWc24si2o3go6/nJM6fgrK4/astG/3dnhH0i9SHn15eLFFzftP7
         HSe3fl/pmBRdHUDZyLHMlhh+LjI/D1hHSwPYG51IUzEZ8gRo01MqRYnNn2DiPIHiUKOM
         lp8w==
X-Gm-Message-State: AOJu0YyDLqpYzBmI8wEz7MfFclFQFq6nrD1oXAcNunKF+7bKNjTnyzZw
	ke/I2M3DJuMCCTH7eZfGc/5rh28/1Mw/67OzynBRBMCHwPRYUqookhLNJA==
X-Google-Smtp-Source: AGHT+IGsCSEUop68Sz8iH8Is3iHD+t9LjNcgpfuiIqdku0OLzaATMbrCxQe4nTGKTX1So2rlyt3RSA==
X-Received: by 2002:a17:907:f14a:b0:a77:c9cc:f96f with SMTP id a640c23a62f3a-a80aa556817mr102867866b.7.1723204219118;
        Fri, 09 Aug 2024 04:50:19 -0700 (PDT)
Received: from WindowsXP.home58.bang-olufsen.dk ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc44sm831361166b.76.2024.08.09.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:50:18 -0700 (PDT)
From: Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
X-Google-Original-From: Troels Dalsgaard Hoffmeyer <tdah@bang-olufsen.dk>
To: bitbake-devel@lists.openembedded.org
Cc: Troels Dalsgaard Hoffmeyer <tdah@bang-olufsen.dk>
Subject: [PATCH 1/1] bb: Log str() instead of repr() for exceptions in build
Date: Fri,  9 Aug 2024 13:50:13 +0200
Message-Id: <20240809115013.17469-2-tdah@bang-olufsen.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240809115013.17469-1-tdah@bang-olufsen.dk>
References: <20240809115013.17469-1-tdah@bang-olufsen.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Aug 2024 11:50:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16461

When getting errors during build, they would be printed using repr(), which
doesnt have a lot of context in some cases.
For example FileNotFoundError(2, "file or directory not found"), would be
printed, without the path of the file not found.
This changes the build logging to use str() instead, which according to
the spec is fore human readable strings, whereas repr() is for string
representations that can be be used as valid python.

Signed-off-by: Troels Dalsgaard Hoffmeyer <tdah@bang-olufsen.dk>
---
 lib/bb/build.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ab8bce3d5..097730047 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -743,7 +743,7 @@ def _exec_task(fn, task, d, quieterr):
 
         if quieterr:
             if not handled:
-                logger.warning(repr(exc))
+                logger.warning(str(exc))
             event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
         else:
             errprinted = errchk.triggered
@@ -752,7 +752,7 @@ def _exec_task(fn, task, d, quieterr):
             if verboseStdoutLogging or handled:
                 errprinted = True
             if not handled:
-                logger.error(repr(exc))
+                logger.error(str(exc))
             event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
         return 1
 
-- 
2.40.1


