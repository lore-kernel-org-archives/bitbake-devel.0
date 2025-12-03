Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988CD12D60
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 13:38:17 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13134.1764761981163150198
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 03:39:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i/FI5pRM;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: swami310@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-299d40b0845so107140045ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764761980; x=1765366780; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbOvS2B0cJIaadZbPM9nRAylXDHbMN0sLXzQzgRjcYE=;
        b=i/FI5pRMfhLMGt211M1vv6V5RyGr8N5jXczgsEP3hsyoCIV1vOIZVO6mJjNSZ0wl7E
         iF4v0qW3NPVA4ouqSZ2pZVjIG99uBxKTr4Czvd5IQxihq4PbAvtW24vneOvPA8TEHHgi
         so0oSJmByTk1i/7ryBiqECme3RlS86mqC7IlhGrTZkfaw6ZXM+GKiBkkfeLkjCTLiHUx
         jfPG/cQrzYGmaJu50V17o1n7uITgCbBui+vV2rQLS4qtki10fM17EJCrwyjI/TQRwERB
         +1zAuDYSCH83qhP995WsM+/At97UPLDKNQeFC7rXzqXCIakFrZpNozVtRmIyZ1lyLobY
         9Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761980; x=1765366780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbOvS2B0cJIaadZbPM9nRAylXDHbMN0sLXzQzgRjcYE=;
        b=dEoU1jh5rUd73JCPChqjQjpywv1XS8023MA6JZT/vojv6auVXSv4J8N2Mvdf/VLJQj
         6ANtGLZS9XiRsmWvBWvFRyxMDVoL/3695f2RrA8f3iDz7RPu8T00XT2bFUGZvBZVOS71
         KYTnBWLZ7/EasvbWaR0MXyqNa5Fqpy6vzlJ1Oqd4Oco1SaBSANV0zEQRGk62Pwpw45wS
         vJv//mVIKJz0+TjFS95yGU9KmvVWlzFiGAqrgb9+x32/3EJAT5T19H58de+T8dRChG9I
         JU8QHYA+Gxon1dBhWJpNbEtZCW+OZVO8EikgOC40X5PmUetTMFJxzEL13+Csz/1v286h
         NBNA==
X-Gm-Message-State: AOJu0YxL5FQGfvycaGdRVH6v1mnflw4PJ6iOhrp1a6ojaztaEG03nuG0
	DVdmYJNXUV/DaSsTqUrx2RJSiDG8d7a4ChbC9Odmhs5NV4yWhgY4pG/4cNoYsiqC
X-Gm-Gg: ASbGncvuBvO2u8/LA/XkB1UfnHQWDrEMEtJHA/FdirNdGyNMZfMGSHE85yuRDMeItk3
	lx5QDluSUUSNH27hu3VlMI6wQcKDoxTWMvEUX4DsmnXOFtsyS0s1WlLy86MP+v300W0eMtRXkfV
	B90K5EPISMfcHm8RN67xwW6P8BeCqcbnfBtLl9u6i2b5S2pL+4BVBCtBGymwERE2YYWCZewMZzl
	1eX+/l2L4l3KrA+LAR0HTc6s54b5UK+2Dvwe05sQyeJSBkXzi4RZXFICtYV8ZEq0KLFjahtgLrd
	BU1hjjO2ieNY8E9g8YBwD1l5UQl2sYbcrMcR7WCdZGqT35OW2cbOGD7Mxzm4OhU/FlXWumokAWG
	2f2Vy8HxxtbjWRLitsbHWHCzJeMvhMsBrX/ecR/7vPpZaBrByC65ak3R4w0QoxtCTgnXt561At0
	kWoABZcMQiV2qgWqMOeeycajGw+H954ePkaNs=
X-Google-Smtp-Source: AGHT+IFqr2A24/sy6pdS3fJTN1ErXODDIgXYTlbM+5Eu0qrRDviMnUJ5+oHXCoMFOdNv+OaB+fuTKA==
X-Received: by 2002:a17:90b:2dc7:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-349128513b4mr1876199a91.32.1764761979853;
        Wed, 03 Dec 2025 03:39:39 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:f2ef:c7a:ed96:173f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912d00fffsm977312a91.4.2025.12.03.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:39:39 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH v4] bitbake-user-manual: Documenting BB_CMDLINE
Date: Wed,  3 Dec 2025 17:09:00 +0530
Message-ID: <20251203113900.31314-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 13:38:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18528

Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
Fixes [YOCTO #15746]
Signed-off-by: Swaminathan K <swami310@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..f49ce0f9f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+        :term:`BB_CMDLINE` is an internal variable and is read-only. It captures the exact
+        command line used for the current invocation of BitBake.
+      
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

