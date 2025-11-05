Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FD1CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17903.1762369603657175968
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=B+U3RDzQ;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4283be7df63so93649f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369602; x=1762974402; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6X0NzrMvAdH76unAbmRzJdzkqIvPNo3kGTofpqT23U=;
        b=B+U3RDzQKs6sYOQ9DMoTDz/4ZD5LY6+nNtjNUUwjKSybXTfE4+JcJlXGUUhnMaPYrl
         jYgwmv1eBvE2p2SdECumFwcdn9tVVfSaRZgApsvuQfESwgDV/gMHAPabfdlpokFZRZJj
         +AbVcy1NYYcz9T5ebAS6HyFMp1OI796khmuIR+IRAOgRfZ0DpgBFvbUD65fXpwu/bi6j
         LptRcKFsZ0bkNZV3hyPw2GSqA45svAdPxBunO4Wfnyx6oV7graKHur/mMYlUK0IQv/Vl
         zurgd9SVJPnCb7a+ljZfSSevaaavjkFYiV1AY6WIGWV4by1edSZrErIQbs/yyH21H0/k
         5hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369602; x=1762974402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6X0NzrMvAdH76unAbmRzJdzkqIvPNo3kGTofpqT23U=;
        b=v+2ij6u+QMrjHB1fK9g/y/7NQhU2dSpAQ5vgbB/kWRaenLSCDKaMqPMZ/pVvmuzZcs
         qPPbNvWOkebSm8PoTxxgmjP7Up47c/CdN1l0893MUwuTBDu5earnzdCUkxahGr8Li819
         NypPDwktk6EFt2V5uLtfXN8AJ4bmoj6VQPSgT+Mo2fecMONS1xNmdIMgmQ2VxeX+STm2
         2b6EYUJSCk4VCsmSQal2vaUa0pjZ6l7H/vGl4LdFBMNCwhVVzH16vnRx8l4I5Qxv7vD9
         S8QDn0K1Uhg6/Zjqm+2fejll9emNLn6dYIPMlG4xqjevw5937hqOhC2X2kk4xcWQDWJ1
         RKjg==
X-Gm-Message-State: AOJu0YyHZslLbsPucY5YmKMbtVsELVbd/5jOXudmmAMLdKTnL4UcDhr8
	1lnVLNuxt4J0vEASTCo2tvcci0bEEdHalJ4pPiJ0KyNaH70TNhbh9xWt7Wt/AQ==
X-Gm-Gg: ASbGncvNBX9j9YaN7U5I53TE0E3jGlX9uaDXnypwxoMmspxc/ToBjlw7gWDJieoAc6y
	yiDBOR+gKCygQK/lcuW7FmGITcPv0Jdqt8T64mS27JK5PCybQ6zMcycQUe9wrbvBfp2QhUPp6g4
	CSYwFFnmT5AXgTxLPr/jEonI0ZzjbRWMB7GczmVJzzeCljqxKpTuaJM7F0KNIIoA+s1558Y8KmP
	t4mx0LDWjY74Cb7JQ2KwRfJC4oT4K3aNjFtPHl6XoyFAtZQLtC+eWYEabqNXqVSXereRlOgr1hx
	NPYeF6gso7jDaSL44qVAhRd6Kv9Y9iOOMTCsFIBK2T/3cSuiW/ufj0bSRvQ6MsKlEQeaHzCKTKA
	BwVuyVc3V1xQO/778Qi2D/HsUOUeyfZ85+r9v/1LI33dR9Jb6WkHKOlXaaJVQCfo/STUy8RC2P2
	73d8VNJvnxOqU/Ay83BVWUge4y+favoEriQnMP
X-Google-Smtp-Source: AGHT+IHN/Y6G1OD9GKGPUdUjosqNU6MVSgq2HNVj9vydWRW8ytJih6jEGLJRlMX9PX9gszrNdxkpqg==
X-Received: by 2002:a05:6000:22c4:b0:429:927e:f2d with SMTP id ffacd0b85a97d-429e33056eemr3856589f8f.38.1762369601735;
        Wed, 05 Nov 2025 11:06:41 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:41 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 1/6] bitbake-setup: rename function 'default_settings_path' to 'topdir_settings_path'
Date: Wed,  5 Nov 2025 20:06:31 +0100
Message-Id: <20251105190636.679388-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18270

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Rename the function to align with the corresponding
'global_settings_path' function, and move it down just above the
later.

This is done to differentiate from the built-in default settings, and
to align with the other places in the code that use 'topdir_settings'
(or 'global_settings')

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3cd67805f..a9035e7c8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -634,9 +634,6 @@ def install_buildtools(top_dir, settings, args, d):
     print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
-def default_settings_path(top_dir):
-    return os.path.join(top_dir, 'settings.conf')
-
 def create_siteconf(top_dir, non_interactive=True):
     siteconfpath = os.path.join(top_dir, 'site.conf')
     print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
@@ -653,6 +650,9 @@ def create_siteconf(top_dir, non_interactive=True):
     with open(siteconfpath, 'w') as siteconffile:
         siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
 
+def topdir_settings_path(top_dir):
+    return os.path.join(top_dir, 'settings.conf')
+
 def global_settings_path(args):
     return os.path.abspath(args.global_settings) if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'settings.conf')
 
@@ -667,7 +667,7 @@ def change_setting(top_dir, args):
     if vars(args)['global']:
         settings_path = global_settings_path(args)
     else:
-        settings_path = default_settings_path(top_dir)
+        settings_path = topdir_settings_path(top_dir)
     settings = load_settings(settings_path)
 
     if args.subcommand == 'set':
@@ -709,7 +709,7 @@ def get_top_dir(args, settings):
     setup_dir_via_bbpath = get_setup_dir_via_bbpath()
     if setup_dir_via_bbpath:
         top_dir = os.path.dirname(setup_dir_via_bbpath)
-        if os.path.exists(default_settings_path(top_dir)):
+        if os.path.exists(topdir_settings_path(top_dir)):
             return top_dir
 
     if hasattr(args, 'setup_dir'):
@@ -720,10 +720,10 @@ def get_top_dir(args, settings):
     top_dir_name = settings['default']['top-dir-name']
     return os.path.join(top_dir_prefix, top_dir_name)
 
-def merge_settings(builtin_settings, global_settings, local_settings, cmdline_settings):
+def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_settings):
     all_settings = builtin_settings
 
-    for s in (global_settings, local_settings):
+    for s in (global_settings, topdir_settings):
         for section, section_settings in s.items():
             for setting, value in section_settings.items():
                 all_settings[section][setting] = value
@@ -841,7 +841,7 @@ def main():
         # This cannot be set with the rest of the builtin settings as top_dir needs to be determined first
         builtin_settings['default']['dl-dir'] = os.path.join(top_dir, '.bitbake-setup-downloads')
 
-        topdir_settings = load_settings(default_settings_path(top_dir))
+        topdir_settings = load_settings(topdir_settings_path(top_dir))
         all_settings = merge_settings(builtin_settings, global_settings, topdir_settings, args.cmdline_settings)
 
         if args.func == settings_func:
-- 
2.39.5


