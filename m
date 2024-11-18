Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A569D44018
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 16:26:29 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.46129.1731947187362171890
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 08:26:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Cu6JJtdo;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431688d5127so36148605e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947186; x=1732551986; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO44fy+Ln/19pWtRnJ16qyrYZU4LFPNQ8vDOWAYE42Y=;
        b=Cu6JJtdoA53fL80GCGREXqdvzzZsy8v0TbRkX+h06Sv9gVaCOhXUKnSpAiIx6ZXiJp
         WQcTsQzP8budlDJBcjFkCDwsPhLuT96ys8VWMOYp2KDwzYKdBcNXjsrxTHSJhqWIpLnG
         vQZefVcivIcxDFk8NP9HR+6PZYJWFXET6BcK0TRfbmPZh0FfI/INCMaOaH/UqZyZbpZ8
         q104BgT742j0twCThTwKMP/yftXs2yVvx5DF2BJyAFN9ZA/VhD2UjAWNmEIVAlLceo5Y
         lfqf0cEYDfXUqK9cRhJ1Gs5zge0k+djHiXA3qBuoxm+0ZEp6asX0HgbjbEXt/vsgt0RZ
         eXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947186; x=1732551986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO44fy+Ln/19pWtRnJ16qyrYZU4LFPNQ8vDOWAYE42Y=;
        b=wVVx4EjFJLY8OBmtsA3pBGwvbETbGo1Esua/90V/hKvlV14YOQxNiFVL95pXXZu2xk
         uSF9/q7PIbZyuIuVRffvX3i1CAo4/180/T1kq2uL+ZQdqt8eWK4lB0vypBj9S5ZGetlc
         1WUb8btLzkevoAdfrAlzu2ib1EFWWonh3x4f9KyoZWFyTLg4D4H5cDxhwdMayR3G38zy
         iIe/Tgly1VVGnscsqJQC4xeIvYAD9P9OqfHHInjysvuBkDpa8cmcffGPbbeSVWl2dX/k
         RxsvT1gJtGjocGXE5y5160u2miqDoqD4BMxnD/tiXJZnQEJcIk4IE4JmT5XTykoL2rKE
         Y2jw==
X-Gm-Message-State: AOJu0YzcZN2fjsFUIKJvdeStxeW3x6McKWpRFquWfbOrm1lCfSozRTxv
	8JpPVhjXwItZieLaITuhP1YQ9a1Zups40nmbElcl/Nrufh95Q4kvskLc2w==
X-Google-Smtp-Source: AGHT+IFGquoNzjZRdY65PUVxZF9bixvMaUfYlQZmsVrb5IlpNF5DdDtA5PRo9PVcbBoZdOVL9JQQvw==
X-Received: by 2002:a05:600c:35d0:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-432df72aafdmr110842255e9.11.1731947185713;
        Mon, 18 Nov 2024 08:26:25 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48c731dsm109341455e9.2.2024.11.18.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:26:25 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3 4/4] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Mon, 18 Nov 2024 17:26:10 +0100
Message-Id: <20241118162610.1423384-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118162610.1423384-1-alex.kanavin@gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 16:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16810

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
index 613e675cb0d..f93d913a1da 100755
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


