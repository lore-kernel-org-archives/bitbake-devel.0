Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1487C63702
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:56 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.10576.1649936421822938146
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 04:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=FChDVncX;
 spf=pass (domain: gmail.com, ip: 209.85.218.51,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id i27so9462091ejd.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNEcA3El1rodoVdKZu/EUp7dg6YhQmODNjd5KRCBVDo=;
        b=FChDVncXOigedr7YYlMeGf93FOOKad03Dc4R81rzaCD8M2TFoDWsR8T4ksFk3M6rOu
         qKD/5jUlVqAoSiRdtYmqrwqwvzbcQzXKh/zuVDGnd9TZXrG5kSa5f/9E3cF43vqhsoYi
         Y8n3mTQzHInNS7QT/djILmKoCCaCVbFr5w2JWrUVXWh+KWTRWa78wRJe0FWRUgQIaBCF
         ip4SkWEDh67KJQzizw4MVFjv5rctCchFepD9lB2UOYwiOlG5U/uYAmvH+FmBny19M62x
         TJeD9Chj9ZmFBQf4YLWZDzI7Wga2KHkqb/ZxkMEngPa1KM9Z6XeblMiMTsfmNdyg1zv8
         TE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNEcA3El1rodoVdKZu/EUp7dg6YhQmODNjd5KRCBVDo=;
        b=bENsvfkBo2/j5S+SYkHYw/+dTuYvgRxKW/RUlGBi2nVQiNtR52JVhj03uBzVrTzpAs
         igLx4n9Z4r/rxKjYFJhtGZzZDECf0vM7zHDsPos+CGkx2tG86MUs1dQtrza1MjnenLoj
         AEMdtmSXa2pFvAxTnctKM2L5NC1uLrkJk2+sndMXsW5kuhuBzrKOyiFolHRd3Rv3uSjV
         PLJwAD/nyVS1weFv4pNAs63qCw1BobRYIDCUMPqro3oI2j6jtXRM9U4Bp4tvCTKQ/K01
         +iam/ncW5Mgcrm6nzMh6MpGGZ9F/Jgbdw2angs+8VZuO1d8z0+BnkPTVLItd5f0eMpj9
         Catg==
X-Gm-Message-State: AOAM530A06m2F8eUA9p9nS37qAItXWE3X9qjqazlLKAbzrxFGxtHNwJU
	TQxwHFMvvGABsXtKGccLVTm2WpW/wZI=
X-Google-Smtp-Source: 
 ABdhPJz2mmTYumrFZRtYRwjKm2Whqhq9t6bOhKFT9OvHSpAvhnBjyuYnkTK1HN52xww20taAcLIRkg==
X-Received: by 2002:a17:907:728e:b0:6e8:9863:558a with SMTP id
 dt14-20020a170907728e00b006e89863558amr1908093ejc.205.1649936420266;
        Thu, 14 Apr 2022 04:40:20 -0700 (PDT)
Received: from Mariuss-Air.fritz.box
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 cb7-20020a170906a44700b006e879b4ba2dsm549412ejb.56.2022.04.14.04.40.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Apr 2022 04:40:19 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Subject: [PATCH] scriptutils: fix style to be more PEP8 compliant
Date: Thu, 14 Apr 2022 13:40:09 +0200
Message-Id: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13617

Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
---
 scripts/lib/scriptutils.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/scripts/lib/scriptutils.py b/scripts/lib/scriptutils.py
index adf81476f0..b265b5c838 100644
--- a/scripts/lib/scriptutils.py
+++ b/scripts/lib/scriptutils.py
@@ -5,7 +5,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import argparse
 import glob
 import logging
 import os
@@ -21,11 +20,12 @@ import importlib
 import importlib.machinery
 import importlib.util
 
+
 class KeepAliveStreamHandler(logging.StreamHandler):
     def __init__(self, keepalive=True, **kwargs):
         super().__init__(**kwargs)
         if keepalive is True:
-            keepalive = 5000 # default timeout
+            keepalive = 5000  # default timeout
         self._timeout = threading.Condition()
         self._stop = False
 
@@ -36,9 +36,9 @@ class KeepAliveStreamHandler(logging.StreamHandler):
                 with self._timeout:
                     if not self._timeout.wait(keepalive):
                         self.emit(logging.LogRecord("keepalive", logging.INFO,
-                            None, None, "Keepalive message", None, None))
+                                                    None, None, "Keepalive message", None, None))
 
-        self._thread = threading.Thread(target = thread, daemon = True)
+        self._thread = threading.Thread(target=thread, daemon=True)
         self._thread.start()
 
     def close(self):
@@ -56,6 +56,7 @@ class KeepAliveStreamHandler(logging.StreamHandler):
         with self._timeout:
             self._timeout.notify()
 
+
 def logger_create(name, stream=None, keepalive=None):
     logger = logging.getLogger(name)
     if keepalive is not None:
@@ -67,21 +68,21 @@ def logger_create(name, stream=None, keepalive=None):
     logger.setLevel(logging.INFO)
     return logger
 
+
 def logger_setup_color(logger, color='auto'):
     from bb.msg import BBLogFormatter
 
     for handler in logger.handlers:
         if (isinstance(handler, logging.StreamHandler) and
-            isinstance(handler.formatter, BBLogFormatter)):
+                isinstance(handler.formatter, BBLogFormatter)):
             if color == 'always' or (color == 'auto' and handler.stream.isatty()):
                 handler.formatter.enable_color()
 
 
 def load_plugins(logger, plugins, pluginpath):
-
     def load_plugin(name):
         logger.debug('Loading plugin %s' % name)
-        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
+        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath])
         if spec:
             mod = importlib.util.module_from_spec(spec)
             spec.loader.exec_module(mod)
@@ -112,6 +113,7 @@ def git_convert_standalone_clone(repodir):
             bb.process.run('git repack -a', cwd=repodir)
             os.remove(alternatesfile)
 
+
 def _get_temp_recipe_dir(d):
     # This is a little bit hacky but we need to find a place where we can put
     # the recipe so that bitbake can find it. We're going to delete it at the
@@ -128,12 +130,15 @@ def _get_temp_recipe_dir(d):
                     break
     return fetchrecipedir
 
+
 class FetchUrlFailure(Exception):
     def __init__(self, url):
         self.url = url
+
     def __str__(self):
         return "Failed to fetch URL %s" % self.url
 
+
 def fetch_url(tinfoil, srcuri, srcrev, destdir, logger, preserve_tmp=False, mirrors=False):
     """
     Fetch the specified URL using normal do_fetch and do_unpack tasks, i.e.
@@ -254,12 +259,13 @@ def run_editor(fn, logger=None):
 
     editor = os.getenv('VISUAL', os.getenv('EDITOR', 'vi'))
     try:
-        #print(shlex.split(editor) + files)
+        # print(shlex.split(editor) + files)
         return subprocess.check_call(shlex.split(editor) + files)
     except subprocess.CalledProcessError as exc:
         logger.error("Execution of '%s' failed: %s" % (editor, exc))
         return 1
 
+
 def is_src_url(param):
     """
     Check if a parameter is a URL and return True if so
@@ -273,6 +279,7 @@ def is_src_url(param):
         return True
     return False
 
+
 def filter_src_subdirs(pth):
     """
     Filter out subdirectories of initial unpacked source trees that we do not care about.
-- 
2.32.0 (Apple Git-132)


