Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD8C636D9
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:56 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web09.9497.1649927578169059409
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 02:12:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CVOMM1+9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 30F4FE0004;
	Thu, 14 Apr 2022 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1649927576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QksrJrmjFfJTSOVBbyAYOqs+kjjA5FHcDvukad5lNio=;
	b=CVOMM1+9GANUBTdGa9TDeD9h+bquY3iFdxDPLwAjQ0/A+54GgPEr4CIfikXQkdeMqcTJEK
	+pmNULsfwJKpOhoQ8Id+zTtT6ESreK76ux3nBokooD0fvnYEgqwAFnKRAJi3CI6OsX4gRQ
	wsZS2k8w+a3Y1KhYvaeJLNUi/c4XT1cQRoodAKwVg/2ofRctJHZfPe9ePCJzV+MDisEEve
	LtIWFVObRchrCzgujiGTZyUaIhbpK799Vh9MxkjbnyVrk/o1XqaiYEbtsZ9T2WN+QLwik+
	tR77u65GVOfn830mN4sHq/i/tQ2xuNif/vwa//Re+3ezZK3FsfeX63Fa/H4jDA==
Date: Thu, 14 Apr 2022 11:12:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Message-ID: <YlfllwA72TEcOCPX@mail.local>
References: <20220413141922.41322-1-marius.kriegerowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413141922.41322-1-marius.kriegerowski@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13616

Hello,

This doesn't apply on master, can you rebase?

Thanks!

On 13/04/2022 16:19:22+0200, Marius Kriegerowski wrote:
> Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
> ---
>  scripts/lib/scriptutils.py | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/lib/scriptutils.py b/scripts/lib/scriptutils.py
> index adf81476f0..b265b5c838 100644
> --- a/scripts/lib/scriptutils.py
> +++ b/scripts/lib/scriptutils.py
> @@ -5,7 +5,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  
> -import argparse
>  import glob
>  import logging
>  import os
> @@ -21,11 +20,12 @@ import importlib
>  import importlib.machinery
>  import importlib.util
>  
> +
>  class KeepAliveStreamHandler(logging.StreamHandler):
>      def __init__(self, keepalive=True, **kwargs):
>          super().__init__(**kwargs)
>          if keepalive is True:
> -            keepalive = 5000 # default timeout
> +            keepalive = 5000  # default timeout
>          self._timeout = threading.Condition()
>          self._stop = False
>  
> @@ -36,9 +36,9 @@ class KeepAliveStreamHandler(logging.StreamHandler):
>                  with self._timeout:
>                      if not self._timeout.wait(keepalive):
>                          self.emit(logging.LogRecord("keepalive", logging.INFO,
> -                            None, None, "Keepalive message", None, None))
> +                                                    None, None, "Keepalive message", None, None))
>  
> -        self._thread = threading.Thread(target = thread, daemon = True)
> +        self._thread = threading.Thread(target=thread, daemon=True)
>          self._thread.start()
>  
>      def close(self):
> @@ -56,6 +56,7 @@ class KeepAliveStreamHandler(logging.StreamHandler):
>          with self._timeout:
>              self._timeout.notify()
>  
> +
>  def logger_create(name, stream=None, keepalive=None):
>      logger = logging.getLogger(name)
>      if keepalive is not None:
> @@ -67,21 +68,21 @@ def logger_create(name, stream=None, keepalive=None):
>      logger.setLevel(logging.INFO)
>      return logger
>  
> +
>  def logger_setup_color(logger, color='auto'):
>      from bb.msg import BBLogFormatter
>  
>      for handler in logger.handlers:
>          if (isinstance(handler, logging.StreamHandler) and
> -            isinstance(handler.formatter, BBLogFormatter)):
> +                isinstance(handler.formatter, BBLogFormatter)):
>              if color == 'always' or (color == 'auto' and handler.stream.isatty()):
>                  handler.formatter.enable_color()
>  
>  
>  def load_plugins(logger, plugins, pluginpath):
> -
>      def load_plugin(name):
>          logger.debug('Loading plugin %s' % name)
> -        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
> +        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath])
>          if spec:
>              mod = importlib.util.module_from_spec(spec)
>              spec.loader.exec_module(mod)
> @@ -112,6 +113,7 @@ def git_convert_standalone_clone(repodir):
>              bb.process.run('git repack -a', cwd=repodir)
>              os.remove(alternatesfile)
>  
> +
>  def _get_temp_recipe_dir(d):
>      # This is a little bit hacky but we need to find a place where we can put
>      # the recipe so that bitbake can find it. We're going to delete it at the
> @@ -128,12 +130,15 @@ def _get_temp_recipe_dir(d):
>                      break
>      return fetchrecipedir
>  
> +
>  class FetchUrlFailure(Exception):
>      def __init__(self, url):
>          self.url = url
> +
>      def __str__(self):
>          return "Failed to fetch URL %s" % self.url
>  
> +
>  def fetch_url(tinfoil, srcuri, srcrev, destdir, logger, preserve_tmp=False, mirrors=False):
>      """
>      Fetch the specified URL using normal do_fetch and do_unpack tasks, i.e.
> @@ -254,12 +259,13 @@ def run_editor(fn, logger=None):
>  
>      editor = os.getenv('VISUAL', os.getenv('EDITOR', 'vi'))
>      try:
> -        #print(shlex.split(editor) + files)
> +        # print(shlex.split(editor) + files)
>          return subprocess.check_call(shlex.split(editor) + files)
>      except subprocess.CalledProcessError as exc:
>          logger.error("Execution of '%s' failed: %s" % (editor, exc))
>          return 1
>  
> +
>  def is_src_url(param):
>      """
>      Check if a parameter is a URL and return True if so
> @@ -273,6 +279,7 @@ def is_src_url(param):
>          return True
>      return False
>  
> +
>  def filter_src_subdirs(pth):
>      """
>      Filter out subdirectories of initial unpacked source trees that we do not care about.
> -- 
> 2.32.0 (Apple Git-132)
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13613): https://lists.openembedded.org/g/bitbake-devel/message/13613
> Mute This Topic: https://lists.openembedded.org/mt/90441542/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

