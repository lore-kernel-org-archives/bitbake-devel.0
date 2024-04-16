Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838DC4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 21:54:16 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.34191.1713304446978755558
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Apr 2024 14:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=P5tFBCd8;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 816FBC0002;
	Tue, 16 Apr 2024 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713304445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEYlYhPEydiX1uEaqAz7U1fr2P6TVyzEzgqsm1WB6ig=;
	b=P5tFBCd8b/ORx55zHxSuZ702wOoEUQcLqhbXP6zNVLbNg7iodwurtfbW96W3CwPt/PyS1j
	pF2Uqp//i0CB4BKo20qdrh73D3h0OaZZ8U4mM3hPbUBx4BkcTrk732OYYsNBSW6pD/6g0D
	N8mWXHCkITutQJmHN0duX7uaijAFnFPhwAxQK+/E/ETXOKuplvYerFYsPRWNXok1gei6qZ
	qd+vR46HFAGnawbZIBpfPvm2nnfGmYBxoEB42G+HzkbfJqYB6axUhcogMPNa9UZlnTLVvD
	hsa9jnI0X8cxb8cUOhlP8KyD2IuhEHoJfwfM+JyO7Oo5LL12QqRPsZwsV11JaA==
Date: Tue, 16 Apr 2024 23:54:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rusty Howell <rustyhowell@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bitbake: bitbake-prserv: add nodaemon
 option
Message-ID: <202404162154017d2d756b@mail.local>
References: <20240327064332.3381069-1-rustyhowell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327064332.3381069-1-rustyhowell@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Apr 2024 21:54:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16102

Hello,

It doesn't apply on master anymore, can you rebase?

Thanks!

On 27/03/2024 00:43:32-0600, Rusty Howell wrote:
> Add a --nodaemon option to the prserver so it stays in the foreground
> and does not fork and exit.
> 
> There are several reasons why one would prefer to run the prserver in the
> foreground and not as a daemon.  Systemd documentation indicates that non-forking
> processes are preferred over forking/daemonized ones. Other use cases include
> running the prserver in a docker container and put in a k8s cluster.
> 
> Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
> ---
>  bin/bitbake-prserv |  4 ++++
>  lib/prserv/serv.py | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
> index 5be42f3c..0d755fcb 100755
> --- a/bin/bitbake-prserv
> +++ b/bin/bitbake-prserv
> @@ -32,6 +32,8 @@ def main():
>                        dest="logfile", type="string", default="prserv.log")
>      parser.add_option("--loglevel", help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
>                        action = "store", type="string", dest="loglevel", default = "INFO")
> +    parser.add_option("--nodaemon", help="Run prserver in foreground",
> +                      action="store_true", dest="nodaemon")
>      parser.add_option("--start", help="start daemon",
>                        action="store_true", dest="start")
>      parser.add_option("--stop", help="stop daemon",
> @@ -50,6 +52,8 @@ def main():
>          ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
>      elif options.stop:
>          ret=prserv.serv.stop_daemon(options.host, options.port)
> +    elif options.nodaemon:
> +        ret=prserv.serv.start_nodaemon(options.dbfile, options.host, options.port, options.read_only)
>      else:
>          ret=parser.print_help()
>      return ret
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 5fc8863f..111e6e9f 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -207,6 +207,22 @@ def run_as_daemon(func, pidfile, logfile):
>      os.remove(pidfile)
>      os._exit(0)
>  
> +
> +def start_nodaemon(dbfile, host, port, read_only=False):
> +    ip = socket.gethostbyname(host)
> +    dbfile = os.path.abspath(dbfile)
> +    # Ensure logging makes it to the logfile
> +    streamhandler = logging.StreamHandler()
> +    streamhandler.setLevel(logging.DEBUG)
> +    formatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
> +    streamhandler.setFormatter(formatter)
> +    logger.addHandler(streamhandler)
> +
> +    server = PRServer(dbfile, read_only=read_only)
> +    server.start_tcp_server(ip, port)
> +    server.serve_forever()
> +
> +
>  def start_daemon(dbfile, host, port, logfile, read_only=False):
>      ip = socket.gethostbyname(host)
>      pidfile = PIDPREFIX % (ip, port)
> -- 
> 2.25.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16016): https://lists.openembedded.org/g/bitbake-devel/message/16016
> Mute This Topic: https://lists.openembedded.org/mt/105172873/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

