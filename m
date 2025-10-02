Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0152CAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:35 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.4859.1759399774083172230
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OADDQ2yJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ece1102998so472606f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399772; x=1760004572; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA3jt0SERmtUjdQ/gu6d+4GoSJiB2FUCCLRBUF0MYU8=;
        b=OADDQ2yJg6KENMSYYm/kH0OGxj+xIsI8Yflp7AVJuHcVBpv9oQfVebU7ZUEfJ8FYNf
         ACr0sbJM+B8muNMSu15qsFUQX+Ws3Ea72nFiiVuwnQsYIMMvxTOW9UGghTif8foUyD+O
         WFl3h/rJCD9xcDy0oyJ+LQ9a5JKzD+32RvxYctkDAxmrDDXLmlQ4fB52iyquxW+1VtCO
         76iYz7iyPa+QjNToNqgyBl8zhSGwQvI3lEvGWSInOZ85890q0tnAjUea4G3D4aSBPiQY
         syWWf12dd7rvKKHcUXsqcwKIOdIutg1+lHzOjVQvAQ436gM5bhICq/a+cnCt8tAvnreT
         3Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399772; x=1760004572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA3jt0SERmtUjdQ/gu6d+4GoSJiB2FUCCLRBUF0MYU8=;
        b=rXlR8BcSy9s4EEQYGR74A0kORDKl8UelBdwJbNP5Me4CxRXOGokXxTLeGT1JqWPz1v
         s1bsTKbGAo/6DWqlfiPTRD3pZoHFEijjYBXIdpqSh70V9vuHN2b9RvT8x6YZCvXc6Qh/
         vVreNXPftmatvk2+CPAD8vW85nKqY5l+Dd/qnKj9kUSwCxUeuTMcVZ4kYPT7udm2mIKv
         xk6nzOcbDfXXmBFDWmXnudESf+aLi9DSPZE2ob8JQHCTvel2JoSPFmi//4eCMwpiEpsz
         IylJuAYj1Jl2u5NwnYfmoYToFkpqt2QGvXScgfCS+Jx1QIfpy3bq09cG/ob4YaZbeY5p
         847Q==
X-Gm-Message-State: AOJu0YyZ3+tuWbI2N8yd6hr+oGBg4MdTlE3pJwdw0g7louM2/wxA2kMm
	k5s2rpoNU42ynqJdhOryFuhWXp14jdYqX6uu6khK3TESiZIIP0kQOe115w/j3w==
X-Gm-Gg: ASbGncuOpSDeMGhqk0yiyYJoK20buOhAmXGo1JsNzpMvnSf4u+Awff43ZdWXaYjL747
	g4XsviUzNpHAB/Qj3bB/fj5euqUEgQWr2zqB6whMH75V6wIhyi5mC+Z7xuG++hnVHIjjH3GHqZD
	1RooaFEOX2cblK0yk4prwirlE9RGZRIGc1JjG3DgXI0X9bzTumHPjEPUffXSS0mzfXiQ9iZtjje
	aoxJK81jJzD/CMPQ5j0rbfUljiPnKYEavjYGvIrdez7VbWf7rgKgBgZ8e2kkh7luSp807LUhlZD
	oqhZe0MJJe95jQR58nRSoiqVvpHjpkAUdPmb+88CXyxPXxExeUS3GXAf2euQfy51I9McdqydoKu
	wjJrvgt13WgmEBDBXg7VTAq6x6y9b/IVQ0AOZm4qzJ5m1N0Eu5X2/1fVgx0E9Noacnd3KaL+bdN
	saaqwxUb0q/UB+AO6vtAcS98QguVZo32iSWlGDwp65OE8eWEBOAFa3bUPxz3ww+ePK+/igM2+Tx
	4m7r8ZS6A==
X-Google-Smtp-Source: AGHT+IFxxtDOSgq7dhzyktQhtTEwxeFhL8td756NmXGHBmiXPGSV0tJz8jvlMf3jqGcGpHtUim088w==
X-Received: by 2002:a05:6000:420a:b0:3ee:15d5:614f with SMTP id ffacd0b85a97d-4255781b050mr4763266f8f.46.1759399772379;
        Thu, 02 Oct 2025 03:09:32 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:32 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 2/7] bitbake-setup: dash support for init-build-env script
Date: Thu,  2 Oct 2025 12:09:24 +0200
Message-Id: <20251002100929.1054540-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18116

From: Yoann Congal <yoann.congal@smile.fr>

Being minimalist, dash does not support the (non-POSIX) feature of
passing an argument while sourcing a script. Like in
  . <some path>/oe-init-build-env <build dir>

With dash, one must use:
  set <build dir>       # puts <build dir> in $1
  cd <some path>
  . ./oe-init-build-env # can only be called from its directory in dash

To do this:
* Instead of a symlink to oe-init-build-env, keep a symlink to the
  directory containing it (called "oe-init-build-env-dir")
* Generate a init-build-env script that dash can source using the above
  snippet.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 51d9503c4..36a1bbd91 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -101,13 +101,13 @@ def checkout_layers(layers, layerdir, d):
 
         if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-setup-build')):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
-            oeinitbuildenv = os.path.join(layerdir, repodir, 'oe-init-build-env')
+            oeinitbuildenvdir = os.path.join(layerdir, repodir)
 
     print("        ")
     _write_layer_list(layerdir, repodirs)
 
     if oesetupbuild:
-        links = {'setup-build': oesetupbuild, 'oe-scripts': os.path.dirname(oesetupbuild), 'init-build-env': oeinitbuildenv}
+        links = {'setup-build': oesetupbuild, 'oe-scripts': os.path.dirname(oesetupbuild), 'oe-init-build-env-dir': oeinitbuildenvdir}
         for l,t in links.items():
             symlink = os.path.join(layerdir, l)
             if os.path.lexists(symlink):
@@ -145,8 +145,9 @@ def setup_bitbake_build(bitbake_config, layerdir, builddir):
         with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
             f.write("")
 
-    def _make_init_build_env(builddir, initbuildenv):
-        cmd = ". {} {}".format(initbuildenv, builddir)
+    def _make_init_build_env(builddir, oeinitbuildenvdir):
+        builddir = os.path.realpath(builddir)
+        cmd = "cd {}\nset {}\n. ./oe-init-build-env\n".format(oeinitbuildenvdir, builddir)
         initbuild_in_builddir = os.path.join(builddir, 'init-build-env')
         with open(initbuild_in_builddir, 'w') as f:
             f.write(cmd)
@@ -174,11 +175,11 @@ def setup_bitbake_build(bitbake_config, layerdir, builddir):
     if template:
         bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
     else:
-        initbuildenv = os.path.join(layerdir, 'init-build-env')
-        if not os.path.exists(initbuildenv):
+        oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
+        if not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
             print("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
             return
-        _make_init_build_env(bitbake_builddir, os.path.realpath(initbuildenv))
+        _make_init_build_env(bitbake_builddir, os.path.realpath(oeinitbuildenvdir))
 
     siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
     siteconf = os.path.normpath(os.path.join(builddir, '..', "site.conf"))
-- 
2.39.5


