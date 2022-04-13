Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA2C4743E
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.6801.1649859568753869550
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 07:19:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BotwtS7z;
 spf=pass (domain: gmail.com, ip: 209.85.128.41,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id r7so1190075wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNEcA3El1rodoVdKZu/EUp7dg6YhQmODNjd5KRCBVDo=;
        b=BotwtS7zLr8Xjf+LFDGIZKZMXo3p8AQEHQ5I9ENn/NaLSsvBC+tN6xh3qZrf2elnLy
         pjwIvT8EBQjAxH8UB8fvjtEBqTjpg6udnZZ+NzhSY8uDHtgepJ1+2O7F0Jeg1omYABrB
         ERUwW9bmsifYXqn5z9jBv7weQo68yAei9VzhC07e3JAL1k9VP+ITzDK9d7qeS+PFETBl
         lbajrZZNBy+GADFLMBpSfUfHrjvpuVmgzCV2Ud42zH8AZNVq6ESPHL2jqOU7Wx9PnJM+
         oTNzkFEf1ys65fXmq80UQ1kWxofNV4XVUQ8T21Xrp4lJ9dltNU49kJDc2x0pZBFfW1tF
         3yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNEcA3El1rodoVdKZu/EUp7dg6YhQmODNjd5KRCBVDo=;
        b=WVIn13vpu0Jd3OkQwNQ7thxwt1bHwIAIqtdg71j0iAccyb+Z7wUl7ZbCMbGxKXYJ4Y
         CJlt451OtDUeTdqz/1FvgxyXju4oJ2+sYQnpTEKbn7I06h6zJqmVmLhTTcS+vN276RRa
         KbfbzGUMG1Qnv53l7CZu7VKzbsxkmf5h0R/OgDWbrTmlRlOSOpHd8nCHAJIgb9u/HtuB
         SDZmEMwkfewwT+kS657pdVzpYKAJP9T36eVNBQr1cApW/GaFm6FmdIkY/yIOS6eURHSS
         Ys9WI/TpZiEACHayiN8ur3Uq2GMXO0zq5UuiflOx36ElwQaqWG/ZtlxbXuEr45EdbH1x
         L2/Q==
X-Gm-Message-State: AOAM530XjwjALbgj0vrFDNRDjgEErzpgRTM9/U6o2Og2JeEUxQfHpzBd
	fB8wezF1/iYT1SbYawn76kcAYUJYwIA=
X-Google-Smtp-Source: 
 ABdhPJxrw4JIlFsU6ww3JKArUI6NBtBCPSxV0aiAQq/vF5VNwArJM6/aU8MU1HHuYeW2sqlgU8sVjw==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id
 c4-20020a7bc844000000b0037bb9867726mr9275373wml.160.1649859567032;
        Wed, 13 Apr 2022 07:19:27 -0700 (PDT)
Received: from localhost.localdomain ([195.201.126.231])
        by smtp.gmail.com with ESMTPSA id
 o6-20020a05600002c600b00207a389117csm11155267wry.53.2022.04.13.07.19.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Apr 2022 07:19:26 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Subject: [PATCH] scriptutils: fix style to be more PEP8 compliant
Date: Wed, 13 Apr 2022 16:19:22 +0200
Message-Id: <20220413141922.41322-1-marius.kriegerowski@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Apr 2022 15:48:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13613

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


