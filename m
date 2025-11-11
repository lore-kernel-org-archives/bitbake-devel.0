Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675FCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 17:25:20 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23184.1762881912447491535
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 09:25:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BNhhW9OB;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e3dac349easo2891158fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762881911; x=1763486711; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8XuUhFRLyLjw6TRCzSNt7QpBfGXiCEIkBpHHCvmwG4=;
        b=BNhhW9OBOVvzL08epvZb1v0Eg3e66/rBntknwfo1wrGc7owv3NZUVFBAZ3U+5OfCkN
         l5ZtERWi86K95HVBxfcEYS+G8QpnRruvngRfGIHVdDuoTbRqtCA3bJmkpuzE1CKtUv9b
         LijgZGsLAVybKuwDh9wxyKDl22AgBOM5FYLejtMuTdqXSGpLLBAO32cw1j1y4XDh/Abr
         q1vkQjNSGtSxYAg0W4vsSzVdSB2A99tjUbptdKbSbCKIzlCev3imrw2Z+wu5NFBXfYGQ
         y6sUEeIxfKNTiIgoCkWwwqjrh5MaiRO5hGVdx0i4R0J+2glN/fkqsr/sMJKWbYvk5n+x
         4+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881911; x=1763486711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8XuUhFRLyLjw6TRCzSNt7QpBfGXiCEIkBpHHCvmwG4=;
        b=l2hvHMHoDGt6RhHJUrBIrMxUUdEIb3xPQ9L3+xUJgaPoiB4NMwn+f/GwMH6dU5ydUe
         LeKQZK0j5mn8ZCOJwmpG+MQobVV6XymPodd/9SDfrlZ7QoW9OrOG/i+6ajnFI7+SAj2Y
         NBUbbVR+OO8+T4fVqHp3pSpUYbAm2rPj+PRZfwwAGq/pQ0ej1Ddde2xZmYsbMALFUvw9
         zE+6SN+J5xo1ZUn8cAsYB9k7MdvCboqA7E1Aisg4/nhshKYDQwWS3hZvKGoDiNz9UfWf
         LkEWi2vQIIUGxWXqhntpVojPv2EHn09unFC4eaHakVvBhdXDliavViZKrCzY36HSF3oC
         OS2w==
X-Gm-Message-State: AOJu0Yy9zVt5we+hlz3jGex+XqxWD1mZ8Fk4Owwm1N+ihq67kK70ec4v
	DvsAm9qF2tbJGj+DQCd6Cx/NamflXYTLo+n6m5Y8eWpSe2w4GDfKqsABgh8ASQ==
X-Gm-Gg: ASbGncvRCfVP0bEMEsCAeHtIswZDyZACmuUbSk/o06MDKOmkv75yn1s6oUpXZF9l9Wo
	wcp7LuSmI9jIJMxIIiY7CZ6oV1bgZsd2IOgoj99utNJbKsnnEDQ7hD7u+jx1toPQIsSNHFp2/UU
	N1BJEN3Zobn1gPpTOtY3EvUNOjTOy+ut6SBZhNSGoVPu3vWYJoihEPBuzckmL7ABfk9EPovyJXc
	DOWgyWGbRTXFYw1Hd8lpBeoZ55HooZQdjMYBvB74kjEZiA1/PDgc/8rRdmBNpZOZVAGGCz+YIij
	KTRXEWPWg6XPOBg685jzmq7EpNsoTBhf6YgM+PFvUJxz62/XHK4EcuAdF4i5CRNOQsyRJj04gPg
	2Vq8yQoNEyAnDC9cheXJvlmLmPC246vja0tpg+rN15OuH0/ANVjfQmAkca4CtX700AkQkk/v7JR
	rowc9YD6ng
X-Google-Smtp-Source: AGHT+IEXB+z3mYoFpe/L1LAfvllES42WlAN4vDROB5bDmtsojymESc/dlGrt8POw2HskLPsMAfX7Ig==
X-Received: by 2002:a05:6870:d414:b0:3d3:52b1:d73b with SMTP id 586e51a60fabf-3e7c255c00bmr8916755fac.10.1762881911315;
        Tue, 11 Nov 2025 09:25:11 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41ebb0fc6sm8372202fac.2.2025.11.11.09.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:25:10 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-setup: Do not override site.conf if it already exists
Date: Tue, 11 Nov 2025 10:25:05 -0700
Message-ID: <20251111172505.2838669-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 17:25:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18330

Overriding site.conf each time bitbake-setup is run is highly annoying
to users, since the intention is to have site specific configuration
that is common across all builds.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 86c556944..282fa82ff 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -672,19 +672,18 @@ def install_buildtools(top_dir, settings, args, d):
 
 def create_siteconf(top_dir, non_interactive=True):
     siteconfpath = os.path.join(top_dir, 'site.conf')
-    print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
-    if not non_interactive:
-        y_or_n = input('Proceed? (y/N): ')
-        if y_or_n != 'y':
-            exit()
-
-    os.makedirs(os.path.dirname(top_dir), exist_ok=True)
     if os.path.exists(siteconfpath):
-        backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
-        os.rename(siteconfpath, backup_siteconf)
-        print("Previous settings are in {}".format(backup_siteconf))
-    with open(siteconfpath, 'w') as siteconffile:
-        siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
+        print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
+    else:
+        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+        if not non_interactive:
+            y_or_n = input('Proceed? (y/N): ')
+            if y_or_n != 'y':
+                exit()
+
+        os.makedirs(os.path.dirname(top_dir), exist_ok=True)
+        with open(siteconfpath, 'w') as siteconffile:
+            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
 
 def topdir_settings_path(top_dir):
     return os.path.join(top_dir, 'settings.conf')
-- 
2.51.1


