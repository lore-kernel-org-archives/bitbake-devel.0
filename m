Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C21C25B4F
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 08:48:42 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.8333.1715330921285224271
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 May 2024 01:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X8Jd49NP;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso13417675e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 May 2024 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715330919; x=1715935719; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3He/PmAExLl+oOdGz6AN3eZ/BD4kIrZHyIIcO976PTE=;
        b=X8Jd49NP0Q87Jn2tGek0GHfQTPxrEzdvMxUmYuJeuPrm5F6XYlkL31GHXQokfCCU36
         pmVJA/8+wGW7eiJ31ftkQGGtLZgLelJs3gSapLDHrxIhNCBvF083tDhsa/+xZouFAguV
         uBavUTdAmtrR60Ixaw0wqETSMDKSoRFu/V0dmgshVNIL7aqsKdMv2SU6SRPRWgRl/Cvf
         Opd/4wdJBeXKvpPCCduy99NcwCu+7YPpQJAx+2SRhTaN+ti3Wagq1kMUxjhf001lxW3i
         4U2qL5mmY2yb62xF5kUGWl2S3/H8FXvezCUA/Mxle300jID9CeI9czk7P/ijKXK6teUJ
         I3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330919; x=1715935719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3He/PmAExLl+oOdGz6AN3eZ/BD4kIrZHyIIcO976PTE=;
        b=TxEHL93/Pyxz9DRZTwk8Yh6m+doEuA+DS+K1jov8hsqrI8zeNVNISb5arRP3q1L9jz
         PY3vQ/lYuq4qUzQL+/fM1E5ZGSoU9aXjOU+Bbqa6b/lTzvp90Yb8eQShU7LIQU7bpx/W
         68IyikANRSFu15P9NlKwxgvIPsY1+ub0S/PZ8NlXqDmZ0k3azZWdR+ul5llZVw/jzfBY
         1xegNG9hwIiQ3pm3qU4DGHN3N5f74IsVh7TOu0OLJpytmtYqw/0XZb8B4VMZXQR+VA5n
         w0Dnip00d/UZH+53aJNejGLSPxF+9AKy9y5g2ENoKGoAfXs0dEjvEpwlp/hsuX8QHeu/
         V5+Q==
X-Gm-Message-State: AOJu0YxPl7mz9MT6NRoxxAtaoQuNRhxR4oxk27iaXVdTq+UfebHPzMth
	k5A5f2/ydkElY/an5rPQi0ZhuWCH3GLKis+40PsP2NtstQ8eHgZEWhgIeA==
X-Google-Smtp-Source: AGHT+IGCnVJ6kih9cD3Fc0IBSQyuqF14PLLjEJFmeGcFiUnwIoUf9FVlG0FCYdzaoTzor30V8xeJAg==
X-Received: by 2002:a05:600c:314e:b0:418:3eb7:e8c6 with SMTP id 5b1f17b1804b1-41fea927e69mr17095845e9.5.1715330919323;
        Fri, 10 May 2024 01:48:39 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110fedsm90749455e9.31.2024.05.10.01.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:48:39 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] bitbake-config-build: add an alias to bitbake-layers intended for managing specific local configs
Date: Fri, 10 May 2024 10:48:32 +0200
Message-Id: <20240510084832.4098810-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 May 2024 08:48:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16198

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
index aebb5100..3923c4db 100755
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
2.39.2


