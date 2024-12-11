Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF9E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 14:10:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.11721.1733926216875544652
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 06:10:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EaDXgE5B;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a742481aso58400885e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733926215; x=1734531015; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKuikyZcUyN2G1P+xRxV4yZsO28J1iesJRHMlQJ7Y1g=;
        b=EaDXgE5BgqwD8WncaM1upo5MHti94k1RBSFlsdHvEakg267eUZeycwZri429hFef5c
         k7uySAfBiOr9vcSm6creOmzYwwVYU0TRQQYHNRwgRrdoq8utjxYElt477BBS0q726N6r
         aXyR7zXk2jngE2sAi2yn3iSMhbNRFo689hBpZ6Xv5PT/sYugF8CYDBscy0BdnFd0M1f3
         PgqZFsshlMV0ymwkpw5A8fRpYmPusxQuTzL0LkocS7Rx9naJBz3+INuZjwfzed8xE3hz
         NdCfYIB4KAVEpMYiIGHkSzrJUXaFsYGRje1GexIvrE5vt111bcThTVTAXN4Ry9Uu93fH
         1HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926215; x=1734531015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKuikyZcUyN2G1P+xRxV4yZsO28J1iesJRHMlQJ7Y1g=;
        b=hF/SrCaiFDdF+ZHDopLPtESmwiAfkutwmP6vqQcCj0RJdFNgd1w9TOIFyI8n+nuMp6
         CpRpha4z0ONGLGAyLIK8O6TcFJJNK+oANSvXmMR5fE8ScrxVQQ8c6oJgQo5ZiVU4Xx6R
         iiO04qS9tGF3lBRDMnFPFzP5P88QXN1vXqaR1lln6xTWOA0XLDu9YMpS3FP/EAACPRhV
         Q98Rj1KXKp4cNpAoBC3Bf6KJ8Ov+JkT6aWatqXPho9y+315qmuf5s9QfDRhsE2ARZGIu
         KyqgU/Udnc3LnAn3E7Z5N/ILnt79Tr+/g5cbF15xsumJGhN8Xesb7IwbfdWWNR0iah1m
         Dc2Q==
X-Gm-Message-State: AOJu0YwdDeohGXx7O08wswvWQ/jI/ruAAhHRtAZGbLu3kEq60l516x/V
	Y2i7htoM6JzIKTJXllezllWbWIjIl6zZjIIrTrpXLIyNuekD3oWJyRFNMQ==
X-Gm-Gg: ASbGnctkSQrMCl2WgDwy6aGiiC1i3YoB/1abJRU5k+AGtxbtGWsq7oFv4m8RZf+d4gd
	Jj2SqIjNRIT9CYc5kJqMVBMUInYVN9BJ65tJPS04T1st9GoY4TMIxUqL1FKGTCbMA1pFv2CZV5P
	9RFWkygfP41C1VnSrPYpRFivd4Ry0qPLGDC+MDxrj6aBfBU/xpaWOzwL5sWyWnOlkG1Njhs9qYX
	oFOcg2gNzc4F4T/ouW661C3T059WzG/0ZKH5aHefwu/TCUZ9eGB4VTzxb3+WuBAayCRVr0cuMfx
	IdObVmIJn4AHI7k=
X-Google-Smtp-Source: AGHT+IGzI2TCNQxPiUdVcPRC82XhHYXaN7l8YI11elB0LWdPcjypHpJnU5f7Nr1GfKf4JV9vdjIayw==
X-Received: by 2002:a05:600c:c89:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-4361c3a67dbmr22853465e9.13.1733926214976;
        Wed, 11 Dec 2024 06:10:14 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361fbc1bd7sm13165885e9.33.2024.12.11.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:10:13 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-config-build: add an alias to bitbake-layers
Date: Wed, 11 Dec 2024 15:09:53 +0100
Message-Id: <20241211140953.2690563-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 14:10:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16909

From: Alexander Kanavin <alex@linutronix.de>

This alias is intended for managing specific local configs and it
is prompted by adding support for config fragments (in a separate
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


