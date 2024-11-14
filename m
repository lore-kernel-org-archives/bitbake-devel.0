Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA33D65C74
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:11:08 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.35225.1731582658181775159
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 03:10:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YMDLIy8t;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38207c86695so430577f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 03:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582656; x=1732187456; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tz/NE9R+0lJ91wLRy5mP3gfePpIPNAtFZRS3+M0iLvY=;
        b=YMDLIy8tkoJZvcikRMKC2ovJk7F7iO4WWHviETEnSXrk5j6LpfZuXtpT1FLRVycK+v
         wDC3bL89FdaMRR10hCQSgnJrHK/22Z2hB6T0xrnhvIdAp+X2yUutq/o+T+falHOaAVFg
         bPHR+o9lzvVM4NOiJtCxq8Ljzbz8Ub0DAWun+xWYeTupAUOLo1dQtaAwUZ/XIxkbjOxm
         hIuduNxq3x2thZ6QIrJcps3PSwIjvd5FDoeTSX93DOgFcIJgKTq9INYpYH4oZy6zplIA
         xLK+OyShrtIdi4qRQt6NYO7Le+uizXi0iN1iDdlAdn8QjAKq7KgDvMrYESWH4dSjZlu0
         V1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582656; x=1732187456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz/NE9R+0lJ91wLRy5mP3gfePpIPNAtFZRS3+M0iLvY=;
        b=AQg38RmUgcWCO1M8hAIMFJ0j6bfqYsn5roJHho8rq6fM94YU//qggzsjRIiYH+1UUk
         8kFqqTI2olFVzmxkahOYsnD/NMrIVgDE4mHoci0lMFqONyhlV4dNR9U+/hqvqSyXm3zE
         ubbgys375WXkYyw4FCF0t9PR/flx4KqNvDMM/7Z3w5YyAl+3OLcIfBgHxCcpl/vdcIgx
         yYM2OcxUT+Lc8rYDnKn5z4WK+CWkS4WHgLgVMF3XOFySna0CQos8lREtgYVKlvymleZG
         coOknMHQtl8l5U1hZ8R13mL/5I9fEMSfk7KwUOrKiHa7FX+BdB10Z4bttPvV7lz5gkJ2
         lz5w==
X-Gm-Message-State: AOJu0Yy8Peiq/OsSf2ph9kBqPFT9bnCEtA9Aca/phZNzOOPVsw26CgB1
	jZewssLAL9aFav3KC5feVyLTMXor9mMQ9Id4fr4xi9o8ZLgSLcScMeEwnQ==
X-Google-Smtp-Source: AGHT+IEhVFY5BFGKgvEhlezlJn4WnVcLRfkBBXK3mYObJjDk13hZ1bzsuNrX18VopPvdjEBOpdFQqA==
X-Received: by 2002:a5d:5983:0:b0:381:bdeb:1799 with SMTP id ffacd0b85a97d-381f186cd09mr21784231f8f.16.1731582656195;
        Thu, 14 Nov 2024 03:10:56 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada31b0sm1199051f8f.1.2024.11.14.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:10:55 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/3] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Thu, 14 Nov 2024 12:10:46 +0100
Message-Id: <20241114111048.2624711-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 11:11:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16797

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
index aebb5100c2c..3923c4db562 100755
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
     
     try: 
         for path in ([topdir] + bbpaths):
-            pluginpath = os.path.join(path, 'lib', 'bblayers')
+            pluginbasepath = {"bitbake-layers":'bblayers', 'bitbake-config-build':'bbconfigbuild'}[toolname]
+            pluginpath = os.path.join(path, 'lib', pluginbasepath)
             bb.utils.load_plugins(logger, plugins, pluginpath)
 
         registered = False
-- 
2.39.5


