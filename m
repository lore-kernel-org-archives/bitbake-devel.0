Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB55C64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 13:51:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.90516.1677505881947025799
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 05:51:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=FunpSLQy;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id bv17so6302453wrb.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StN0gDA5rhhUt/OKXIPjJFARBl44bdXRXusCvBApBto=;
        b=FunpSLQyfBfI8JJE2QffHrq4b+Q+Q3ElS/XTmVE9dPbg/iwg3F+4fijGNTRTuj/Ki3
         8wbfeepTnj8eSLrYzc+/xFXLgvb04Me955lvTowwOO9mUPpzjfvi3klC56E4y6pAyJp7
         zOIMt7unlq6woyWpwnZ9XlUxeIUrDR24JJz2seo/VdHvX/14+WeVJZhXCybLGOnd/6b5
         o3+Cxir76eD2PBpoVttbQiKw/+IfNMRj6JH3NUZynG3Vr1uBl/PVE9GkreytlbZd28yi
         cvMEGNTsbH8sKAhhrLA6Bkrfj7NH2tqSJi3rH8FH9VORT7YADTEGV7e/+uaajjcC/Uek
         bBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StN0gDA5rhhUt/OKXIPjJFARBl44bdXRXusCvBApBto=;
        b=WO0yUVwq6M5aBH8bCW8JXr+ADBZc+dLMT9eKpzwwgBWBLZbL/fprSpFGqyjOYrT7BM
         dlSXTMh2BEohxTLoyq1XW4acTjYo4cesR36+g7DIUG/RA2924YAho8G931wg79UQQlXc
         F++A/lI1x4w/bzFwuQ5CAbnNx6l3Sl/2vuLqhTIHE8b08n+9ZRpOO1O7Z37YxMkwkaLO
         Xc5SHPit6qmp3x7tU6hiMzSMmI07b3ShAczmR6aRH+obDXS/5afWMGNhaBVxION+euAK
         WsVJU3CyXHQ/dl1TrJsQbxsflfywBnBBzeLBRH2MZSmwAs4pZBgRTolKnvDUfklKhkET
         1hHw==
X-Gm-Message-State: AO0yUKX+9L5hi5UbVJYHGjN4oiPAPmRMWILJ4cTS/5ZKRUrTcLMUL+zT
	inXm+v6THsOPiFxb8HEdvecWcqVP51Tmv0eQ
X-Google-Smtp-Source: AK7set/0sTcFM4DYcqpvrt9vBr9VS8FUB31c52hjYnkenRilDdXnJWirAFK4F0w8MWe/olgjwNvzvA==
X-Received: by 2002:adf:de10:0:b0:2c9:6b87:962d with SMTP id b16-20020adfde10000000b002c96b87962dmr5666780wrm.15.1677505889290;
        Mon, 27 Feb 2023 05:51:29 -0800 (PST)
Received: from P-ASN-SCRUM.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b002c54e26bca5sm7201030wru.49.2023.02.27.05.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:51:29 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Fawzi KHABER <fawzi.khaber@smile.fr>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH v2 2/2] bitbake-user-manual: update Hello World example
Date: Mon, 27 Feb 2023 14:51:15 +0100
Message-Id: <20230227135115.29202-2-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230227135115.29202-1-fawzi.khaber@smile.fr>
References: <20230227135115.29202-1-fawzi.khaber@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 13:51:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14499

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


