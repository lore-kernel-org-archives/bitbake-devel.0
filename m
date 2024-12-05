Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82027E77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 16:39:44 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.16084.1733416782382337723
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 08:39:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KD842q0L;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1639637so12189615e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733416781; x=1734021581; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsyHWR+7C2p9Is5Zgx7ReXXJAj65L5Vs+zIIl6m76JA=;
        b=KD842q0LNy1q1ARWvOk8AmZQnPVaK+IM0/WnFsLIHAvqSuzwrX0uI0C7ivn14d0/O5
         uKNCrnHkGGPEvh5ELQbb1Np+xvs0V6dw/sc+RTUgYd6TdfRKePfUS27b3XOS2iQIBUvG
         kvlxMCC3q+b4NG/hp89+/6YTiCC0VCEvDFfLuc66XsTWEaMg/m+4FRWa9c0jSZGJw52W
         l1jZc1GliIMcOuChdsLB3UWsgp+0iwWn+WQVTYMu9XSNqD4PuWq3xNtR45NuVipBHPg5
         pT2+oyBvS/vQQr7frPCXiFaHxjuQOqlWxW6zMjROShpq6zVOVf7rTf9M8kyUQ2f5LCa2
         O6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416781; x=1734021581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsyHWR+7C2p9Is5Zgx7ReXXJAj65L5Vs+zIIl6m76JA=;
        b=o3gbo57uoKi82UXJfu2rBAYfTYMvqAOOCiFr1/f2q/XU96Em4XrHMR4BxXRequHKII
         ubAZGt2cpI6cplt1Kt5vzmwd1CbVI5pT/Vcl3qQOu89KLIao1mD3A6OsZ6+A5stj1ln5
         Nxtb/xWI47AaKbB5N7irufUZBZh5B1F0Q+engXoi/v1rwIoavHBZ82iTIX1DvO7+VZkV
         Jx4XyCRa/5cOdpp0MkeP2le8fuCJfesByYLuk2jygeiaUWdpWYM7Xr1mpN4f9xYiwiZd
         IViw7WjZRdePdWaa01EqX4MYpScjrcTV/pbt8pxXqg2GldZRDSNIEhZENucsVKo4UxAE
         ruhw==
X-Gm-Message-State: AOJu0Yw6uwShlwoLHtZR8TJIGikMbPOL3+EbnlHWoKZVgnl6ASHBqmDF
	SDxr7rmKlscb4sDofzf3OHqKASBTyPlyFa2wKEQsjeXWX8lvOeX/iGW6/w==
X-Gm-Gg: ASbGnct2LGFwmAyTVYiKTV074ZSWPwpdp/sY8yYZZx6Zf+ifJ4kl5wERRzMyWyvQcec
	MANTUCrp2i3hc0lgobp9KFgYNnLoza7ZPs8QvCDX8n/Y78dEpQaXYQuZ/f2ZEFqM7oIlY/FiDiB
	8DyU0VALEHYgPheulIRUzvmWEUGOFOmSCXC54+NeMqSl1hyK2e78++80Qy+IURh4aWFcBNXuGoV
	e2xUfl0y/+TCak+JMAh0fdnpDr3Z1SYlNTAZc+4U8bU4zkd1CbQGyYFl2tXGtq24WQ2UK9XHocZ
	hZ8cDIVFzKE=
X-Google-Smtp-Source: AGHT+IGHQzDD7gPp/9Z20tQLOSr85BjGnkcfbhnpF9qA+CfaW8L/suTnrdkgyAldUUjryzKbT8UGeg==
X-Received: by 2002:a5d:6483:0:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-385fd378ddamr8923384f8f.0.1733416780542;
        Thu, 05 Dec 2024 08:39:40 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219095desm2338468f8f.64.2024.12.05.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:39:40 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v4 3/3] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Thu,  5 Dec 2024 17:39:32 +0100
Message-Id: <20241205163932.4049957-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205163932.4049957-1-alex.kanavin@gmail.com>
References: <20241205163932.4049957-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 16:39:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16882

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
 create mode 120000 bitbake/bin/bitbake-config-build

diff --git a/bin/bitbake-config-build b/bin/bitbake-config-build
new file mode 120000
index 00000000000..11e6df80c4b
--- /dev/null
+++ b/bin/bitbake-config-build
@@ -0,0 +1 @@
+bitbake-layers
\ No newline at end of file
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 7bd3ea20e47..341ecbcd971 100755
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
@@ -67,7 +68,8 @@ def main():
             bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
 
         for path in ([topdir] + bbpaths):
-            pluginpath = os.path.join(path, 'lib', 'bblayers')
+            pluginbasepath = {"bitbake-layers":'bblayers', 'bitbake-config-build':'bbconfigbuild'}[toolname]
+            pluginpath = os.path.join(path, 'lib', pluginbasepath)
             bb.utils.load_plugins(logger, plugins, pluginpath)
 
         registered = False
-- 
2.39.5


