Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF715C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 16:08:51 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.14553.1715270922210728820
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 May 2024 09:08:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=llYo13va;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fea3031c3so1450571e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 May 2024 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715270920; x=1715875720; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WR7VoIMdSrmrtY/XzX9KYieL3iHGpliwK1TZVMTZgME=;
        b=llYo13va5KQGsV55ZQ1WyO/witNkc/tuaP264MOn8zUbwtUSefHEhBJ6TbH6lHMrPw
         b31WeC3BbTWLx9cxI4FYU3lUQMKztIJ5HljG1FUfonjTooGWZoFnhCl8yupcXVaZS3tP
         1K4hkv+Aw7l+0WjuU5LJ11Lade2QU21gMhpnKDfclLl7J6xiU6OrgMjDFzNixX/Tw2iV
         fn4TQE6ogewoudqJqAzm3D6K/XEKH+niRvNCYeXAHn/GdWcKI0zW6hg6bd2OpQ90O57V
         9pABosS/QG9GG7knTDWwGSehD+S0sBmSBJQigwfd62PfP3V7RWQ9Wh3v5eY6AKLZ84+v
         XjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715270920; x=1715875720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WR7VoIMdSrmrtY/XzX9KYieL3iHGpliwK1TZVMTZgME=;
        b=T2ISluW3tX9L563AHNap+xDaPoFLvZL+rntZzLS9P2OipJOJ3xbgo9ikeWjaQd8a8J
         wjmu//MoGwAek/GT4lwtqAJ19BJ19IO4x8YUbBgTR3h4SAqX3hBOlma62q65uLCZDGTv
         qQWybJ3rWpQCwaNb6HCsgCsj36CqWq/9CD7BiKYBzqH/EcNJSlWtwG5Vv/JOaaAIO7vK
         vXUBN3JfBsJw4oRMc+gnsB1V/A9DhsJupLNgsExssoUQPfWTqf0wRMFHN/XoeVcN20XH
         rWN1+U2+atzmwCt1I6eMhgInZBiPrq7DufjY98CpjpT1rytj2VBWAPLx+WptJqR1GI4b
         pTpQ==
X-Gm-Message-State: AOJu0YzDLL3PM98RTkjFDalmy5DtrYn4IUVCDZQovTUM9wmVcqvcpIDE
	K46TkdpEl+6WByYk0MkFFfRCkHAQGsW10PXqtjd6ovE9h78ERKzlf94/HA==
X-Google-Smtp-Source: AGHT+IHpy45KxDDN+Stm2L6kjv0qLZN+M1HSg7BlAG8kjtm5EOWxSHLRmMDopHdfjPP6k+3Ni3Yegg==
X-Received: by 2002:ac2:5e70:0:b0:512:e02f:9fa7 with SMTP id 2adb3069b0e04-5217c374455mr4964770e87.1.1715270920064;
        Thu, 09 May 2024 09:08:40 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d40sm87212366b.75.2024.05.09.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:08:39 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Thu,  9 May 2024 18:08:31 +0200
Message-Id: <20240509160831.3283165-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 May 2024 16:08:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16197

From: Alexander Kanavin <alex@linutronix.de>

This was prompted by adding support for config fragments (in a separate
commit to oe-core); after some deliberation I concluded there should be
a separate tool, as bitbake-layers is already somewhat over-stuffed,
and this will give space for more build/conf/* operations in the future
that anyone can come up with (such as tweaking site-specific items
in site.conf etc.)

The alias completely reuses existing code via symlink and
the difference is in where it looks for plugins.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-config-build | 1 +
 bin/bitbake-layers       | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)
 create mode 120000 bin/bitbake-config-build

diff --git a/bin/bitbake-config-build b/bin/bitbake-config-build
new file mode 120000
index 00000000..11e6df80
--- /dev/null
+++ b/bin/bitbake-config-build
@@ -0,0 +1 @@
+bitbake-layers
\ No newline at end of file
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d4b1d1aa..ccda88e9 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -18,13 +18,14 @@ import warnings
 warnings.simplefilter("default")
 
 bindir = os.path.dirname(__file__)
+toolname = os.path.basename(__file__).split(".")[0]
 topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
 import bb.msg
 
-logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
+logger = bb.msg.logger_create(toolname, sys.stdout)
 
 def main():
     parser = argparse.ArgumentParser(
@@ -63,7 +64,8 @@ def main():
         tinfoil.prepare(True)
         for path in ([topdir] +
                     tinfoil.config_data.getVar('BBPATH').split(':')):
-            pluginpath = os.path.join(path, 'lib', 'bblayers')
+            pluginbasepath = {"bitbake-layers":'bblayers', 'bitbake-config-build':'bbconfigbuild'}[toolname]
+            pluginpath = os.path.join(path, 'lib', pluginbasepath)
             bb.utils.load_plugins(logger, plugins, pluginpath)
 
         registered = False
-- 
2.39.2


