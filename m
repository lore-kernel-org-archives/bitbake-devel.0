Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5639EC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 11:25:02 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.87793.1677497095323275061
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 03:24:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=WTNYCM6C;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id p26so3986342wmc.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 03:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StN0gDA5rhhUt/OKXIPjJFARBl44bdXRXusCvBApBto=;
        b=WTNYCM6CkSzePsaWU2ceNkNhj+MOlKFRGk6cikhQ/UeD1wNORSWoA8mpC1D79vgc/9
         QePOSDCtmDQdvS8IH4R7cyo9R0L7ZN4HQ1gfFu3jIwcE2XA0txntIpehqnO0+QprAuqM
         XSb+7kjz3RUQkcpdbS1Bs5oo0IFbMFIm+101B7LA7P0JpPle5wuBQJ0uL1DCCN81253J
         WemSZGkuaMJ+eJE510AtjawUPm0zzL+5DduwcjhrWpiinCEY/jIfIUovP7oJrlBaUhZa
         EzzAYZ4O7+Q45aJy93vNUxNssI08ps1cwmPoFD1ofPD1GSF/hBpQiE4BU+CrQiywlGzl
         FnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StN0gDA5rhhUt/OKXIPjJFARBl44bdXRXusCvBApBto=;
        b=30i/vizzUB+mAyTIup8eZ9cni1cMqjBCXQBdecoaZXIigPqTBF3GZ06ywBIo1C87mn
         ASCT3oaBq/OBY4/aUZFnszRoVVVwPFc/M1XP9TV85Rr+BS3efQDbLMkhZBDBMk7UJSUT
         oK+QUHYnP2G/nImeCclC+OC9dw9BgxanQimQDo6DE2PA87dKqnYiqhc3S0EFCp0YpbK+
         hSsaIlg2GxmxDznLF7Pv1S70A8rCair/hc0yOdGkfIjqPrqllwgHYsNjHfwmb+848vo5
         AdLC1PYOtVRGkmUOswbbiSo9MLhG6QJeY7CJmzw10Qw71PjUYBTnXA14oWG1edjx7VaE
         RaXg==
X-Gm-Message-State: AO0yUKXm8VKN1a23UTbXCe4tcBScKp0YrXfRuU5/EgaMcjYt7zFnaGHb
	Ma8/Guaiq6U4Hv8F0DnqmYKrXZpsUcBlCmmd
X-Google-Smtp-Source: AK7set8nXAzvAm2RVxFE9uaHN6AZbixlMkOYZtgZZ8VMlMUI5w32dsPFMxEr8Jti7CpemV/duG7vvQ==
X-Received: by 2002:a05:600c:929:b0:3df:3bd6:63e5 with SMTP id m41-20020a05600c092900b003df3bd663e5mr17854414wmp.12.1677497093495;
        Mon, 27 Feb 2023 03:24:53 -0800 (PST)
Received: from P-ASN-SCRUM.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003e20fa01a86sm9283106wms.13.2023.02.27.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:24:53 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Fawzi KHABER <fawzi.khaber@smile.fr>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH 2/2] bitbake-user-manual: update Hello World example
Date: Mon, 27 Feb 2023 12:24:47 +0100
Message-Id: <20230227112447.26871-2-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230227112447.26871-1-fawzi.khaber@smile.fr>
References: <20230227112447.26871-1-fawzi.khaber@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 11:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14496

Fix broken link "Obtaining bitbake".
Update documentation for the bitbake hello world example, the output was
outdated.
Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
Add proper formating for base.bbclass command.

Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
---
 .../bitbake-user-manual-hello.rst             | 53 +++++++------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 722dc5a2..0cf81ce4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -18,7 +18,7 @@ it.
 Obtaining BitBake
 =================
 
-See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
+See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
 information on how to obtain BitBake. Once you have the source code on
 your machine, the BitBake directory appears as follows::
 
@@ -52,7 +52,7 @@ directory to where your local BitBake files are and run the following
 command::
 
   $ ./bin/bitbake --version
-  BitBake Build Tool Core version 1.23.0, bitbake version 1.23.0
+  BitBake Build Tool Core version 2.3.1
 
 The console output tells you what version
 you are running.
@@ -130,23 +130,11 @@ Following is the complete "Hello World" example.
     directory. Run the ``bitbake`` command and see what it does::
 
        $ bitbake
-       The BBPATH variable is not set and bitbake did not
-       find a conf/bblayers.conf file in the expected location.
+       ERROR: The BBPATH variable is not set and bitbake did not find a conf/bblayers.conf file in the expected location.
        Maybe you accidentally invoked bitbake from the wrong directory?
-       DEBUG: Removed the following variables from the environment:
-       GNOME_DESKTOP_SESSION_ID, XDG_CURRENT_DESKTOP,
-       GNOME_KEYRING_CONTROL, DISPLAY, SSH_AGENT_PID, LANG, no_proxy,
-       XDG_SESSION_PATH, XAUTHORITY, SESSION_MANAGER, SHLVL,
-       MANDATORY_PATH, COMPIZ_CONFIG_PROFILE, WINDOWID, EDITOR,
-       GPG_AGENT_INFO, SSH_AUTH_SOCK, GDMSESSION, GNOME_KEYRING_PID,
-       XDG_SEAT_PATH, XDG_CONFIG_DIRS, LESSOPEN, DBUS_SESSION_BUS_ADDRESS,
-       _, XDG_SESSION_COOKIE, DESKTOP_SESSION, LESSCLOSE, DEFAULTS_PATH,
-       UBUNTU_MENUPROXY, OLDPWD, XDG_DATA_DIRS, COLORTERM, LS_COLORS
-
-    The majority of this output is specific to environment variables that
-    are not directly relevant to BitBake. However, the very first
-    message regarding the :term:`BBPATH` variable and the
-    ``conf/bblayers.conf`` file is relevant.
+
+
+   
 
     When you run BitBake, it begins looking for metadata files. The
     :term:`BBPATH` variable is what tells BitBake where
@@ -254,17 +242,6 @@ Following is the complete "Hello World" example.
     exists, you can run the ``bitbake`` command again::
 
        $ bitbake
-       ERROR: Traceback (most recent call last):
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
-           return func(fn, *args)
-         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 177, in _inherit
-           bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 92, in inherit
-           include(fn, file, lineno, d, "inherit")
-         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 100, in include
-           raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
-       ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
-
        ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
 
     In the sample output,
@@ -284,7 +261,10 @@ Following is the complete "Hello World" example.
       $ mkdir classes
 
     Move to the ``classes`` directory and then create the
-    ``base.bbclass`` file by inserting this single line: addtask build
+    ``base.bbclass`` file by inserting this single line::
+   
+      addtask build
+   
     The minimal task that BitBake runs is the ``do_build`` task. This is
     all the example needs in order to build the project. Of course, the
     ``base.bbclass`` can have much more depending on which build
@@ -328,10 +308,11 @@ Following is the complete "Hello World" example.
       BBFILES += "${LAYERDIR}/*.bb"
       BBFILE_COLLECTIONS += "mylayer"
       BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
+      LAYERSERIES_COMPAT_mylayer = "dunfell"
 
     For information on these variables, click on :term:`BBFILES`,
-    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
-    to go to the definitions in the glossary.
+    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS`, :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
+    or :term:`LAYERSERIES_COMPAT` to go to the definitions in the glossary.
 
     You need to create the recipe file next. Inside your layer at the
     top-level, use an editor and create a recipe file named
@@ -389,12 +370,14 @@ Following is the complete "Hello World" example.
     target::
 
        $ bitbake printhello
+       Loading cache: 100% |
+       Loaded 0 entries from dependency cache.
        Parsing recipes: 100% |##################################################################################|
-       Time: 00:00:00
        Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 skipped, 0 masked, 0 errors.
        NOTE: Resolving any missing task queue dependencies
-       NOTE: Preparing RunQueue
-       NOTE: Executing RunQueue Tasks
+       Initialising tasks: 100% |###############################################################################|
+       NOTE: No setscene tasks
+       NOTE: Executing Tasks
        ********************
        *                  *
        *  Hello, World!   *
-- 
2.39.2


