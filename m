Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC1CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:07:29 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21248.1762877240541588866
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 08:07:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X8zazL/Y;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c6d13986f8so611851a34.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762877239; x=1763482039; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HYstiMKSHJgR37L13jHUmlba18a+Vvlr3q0KG+mr5Q=;
        b=X8zazL/YuVdfg4Iwun36DXpcnGVB8W15xp1zwBI+yAQOJyMhqqCsG3mvXmkPB0HWe8
         EkQMryoit+43j/umUImLuYQkztzPb/NBweX/b63u+P/ZZeAvaB9AuUbDFFwMCLKutfwZ
         eUMrP61AQrods5FoM5UTpEXhKrhSJWRSYnzHwrsQOi/HlXO9hjxGwL83bCBaNqu0PqaH
         2pbLsqZAOOca2SmgzNU36KNsaKHlCtwZd/CPDbWO90lHllK00I64W/njg7fLnUO+NxlU
         awz59NRwphxbjIXJ29+36vyMoI0p7HJhfgJvwJihEPS1xNSBc59i9ALGFrZ/BSBSzh7b
         4FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877239; x=1763482039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HYstiMKSHJgR37L13jHUmlba18a+Vvlr3q0KG+mr5Q=;
        b=GPCznDqQeRwM/nIXCLBkXfbTwFrnX//4WHkt2r6gO17lWDhMxMRuIXvpWM+cW2yomJ
         DVcOncSmde1PI0P0Yknp/aHK0rCkO8ftvgxENmYv5xSttP0NQjIXlGWkhxhMvusqCdOD
         sf04JBctb8LgVqT7IItORurZb0Evk+vJMhfiLhR0quaB2WsJMrYzg6TSrhcpo7HsfheS
         S2EiBGRIl3GnGBQrEOMbxB+yL0ehMNn0w35MWa8vAP5vz7csIrVtYZ01n0V8gs+J4iJ2
         YVunGC6D10PImGP81om/hxGX7FMeY6Ab1uvXwaLiUk7Z4TrJfzfdBznxa1kK60eAkv8r
         K/3Q==
X-Gm-Message-State: AOJu0YysZV/4DaAmC2Uikz1w6yQiALFazNMw0rwfZx6BF0oHsbm4AEPn
	MfgRC6Z+fYXq73/MWithGMFont67P3qfrfibSG8tXFQ6lCwaOKQhHU+o5Bs/lg==
X-Gm-Gg: ASbGnctNtzvKRB0GT7SPelqqBYQ00UxKfuVYw4qBlGwm7VenifGOdOfWCmpKDp8NwfO
	Q95ii++r9819c3dLEPiaJcpwxoG+Z0rxf5Kr9EUD0vr0QUl0sLrrNmXo65fO03XrIZr0XUwWuN9
	QGqCO7Cu4ElnecbJdxBu6ogFSlBap7HJWs57D9eh2IrlfrqaAhAxl/4WZB2raOfFwHahatZkhmM
	FpL0owbqy6zNixWghRAkdSoCuYMirND2nh12xsl8UE1SfpEyHFeeo42SWloMkjqQbtSplc6lf/m
	6kt+KhlW2Pu2KlnPa2iHMilQgltHqH1NgaN0QEXUw+VOK+HO2L1rsIktRn53oyQ3Fty5LUrBSn/
	enOayxRJ2ke2L8z981vXf2NCZJaRGAOWASTlhpxaquAPsCV2DzO+q2BRA90QJr9tJIuu2/6clUW
	kwBgARebrE
X-Google-Smtp-Source: AGHT+IFLVSoGLNZHekky2FUOq3xJVhzA6KXkZnXTdRHunROx9IoYsqHM+FbKBGd//ZipChGdmVoOxQ==
X-Received: by 2002:a05:6830:19f7:b0:7c6:cbd2:4b56 with SMTP id 46e09a7af769-7c720a2523cmr1474688a34.2.1762877239230;
        Tue, 11 Nov 2025 08:07:19 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c708604bb9sm3939211a34.31.2025.11.11.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:07:18 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-setup: Only set top-dir-prefix and top-dir-name in global settings
Date: Tue, 11 Nov 2025 09:07:12 -0700
Message-ID: <20251111160712.2818289-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 16:07:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18327

top-dir-prefix and top-dir-name only make sense to be set in the global
settings file, so if they are specified force them to the global
settings file, and warn the user that this is happening.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index caec990c2..c32381e50 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -30,6 +30,12 @@ import bb.process
 
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
+# These settings can only be set in the global context
+GLOBAL_ONLY_SETTINGS = (
+    "top-dir-prefix",
+    "top-dir-name",
+)
+
 def cache_dir(top_dir):
     return os.path.join(top_dir, '.bitbake-setup-cache')
 
@@ -685,6 +691,9 @@ def load_settings(settings_path):
 def change_setting(top_dir, args):
     if vars(args)['global']:
         settings_path = global_settings_path(args)
+    elif args.setting in GLOBAL_ONLY_SETTINGS:
+        print(f"{args.setting} can only be set in the global config; '--global' is implied")
+        settings_path = global_settings_path(args)
     else:
         settings_path = topdir_settings_path(top_dir)
     settings = load_settings(settings_path)
-- 
2.51.1


