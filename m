Return-Path: <jpewhacker@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id 56C8F78ED5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:19:31 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so15053118oib.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Sep 2018 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=oz3x3gud8Lei469CwV10Su7Nn+O6lbV9ZnMPioqaSCE=;
	b=kGutLfKu9S0mlLa3biS8xZcSe7xGFB4v4Dic+dvUeRKqMln8BczrU9UNrXbbFNPyp5
	VQCwvfzQ0wVNGEbRSCWDs7XFYh0cG9kwUgnU9dptmOGjYOejNI8K5GcYuGf2gltva1H0
	XV4aZ/36B6vMBTqcxsDf9SxIt6gFPyUjrB5rNZvbT1z1L5wZIKQhQH/xZMlGcJX1QRVf
	Is13gYBEi/U1oYDNUZ6l3Palh0RsgVJ1dttPMTWNhKWr1OXK6kX17NIqTWc2K/6L+oJ5
	3j685BVGde0LyIOCc5kYZN9ozdoLTVAJse30NyyPOW/NaKJAJrWQa5Awx5XjXyU+19KK
	UMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oz3x3gud8Lei469CwV10Su7Nn+O6lbV9ZnMPioqaSCE=;
	b=UX3FR36g5/yvQIN5TCRIEaPaXIwM6vdUBsVgJ3jDaUpuLGDpqdRSwe6PKs1+zM06YU
	1CyFRW2gsYwjMyg8AKMOqp/E3kW631mJsAUejjjJnYawFqE923V0JSt2Z/T2KIy3xPxu
	U/NBQXFQ+EhXSgku2FhcW39A6ls/xN5beVYVTFNg0QIOczVBMtKIssECcJwb3uzJZgdd
	RDBcnUWu3nqE3j5atejyprU1Ncodm1VgU+3EH1nvE6JArriJks45wXtigJH/3Ry09Q3I
	bJx9XIwUnpC5VooFVmsGx5cjgPmtvxNMbM8oZfuZymvPvSVUfYOiehDMHYe+7ZeGJJRH
	CXJw==
X-Gm-Message-State: APzg51ByVTJ1BVwcfZgewsVTLGUBZgx+PoSWBgZTlCdnXnJrmZQpXRtY
	/8GJkTlUVgp0DJsiusH56T0=
X-Google-Smtp-Source: ANB0VdYWKMb3Qz6xnyCS4bCOtqDYzqG+9NzNcFWCNDMUtz1mY/GaAk6COCPjvqVYYdCZ0QeXRIK7Iw==
X-Received: by 2002:aca:be56:: with SMTP id
	o83-v6mr31854348oif.301.1536167972218; 
	Wed, 05 Sep 2018 10:19:32 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	m4-v6sm1995796oic.34.2018.09.05.10.19.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Sep 2018 10:19:31 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <7d6334bd3220b7f6e660f4c161b46279c2205497.camel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 05 Sep 2018 12:19:31 -0500
In-Reply-To: <20180905170109.31505-1-richard.purdie@linuxfoundation.org>
References: <20180905170109.31505-1-richard.purdie@linuxfoundation.org>
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Subject: Re: [PATCH] server/process: Various server startup logging fixes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Sep 2018 17:19:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Looks good to me. I have a few (optional) suggestions.

On Wed, 2018-09-05 at 18:01 +0100, Richard Purdie wrote:
> There were various problems in the server startup loggin:
> 
> a) stdout/stderr were not being flushed before forking which could
> potentially
>    duplicate output
> 
> b) there were separate buffers for stdout/stderr leading to confusing
> logs
>    where the entries could be reordered. This was particularly
> confusing
>    due to the separator the logs use to idendify new messages
> 
> c) an fd wasn't being closed during server startup meaning if the
>    server failed to start, the closed fd wasn't detected as it was
> held
>    open by the other reference
> 
> d) If the pipe was detected as being closed, the code incorrectly
> retried
>    server startup
> 
> e) The event code would remap stdout/stderr without flushing them,
> leading
>    to lose log messages
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/daemonize.py      | 12 +++++++++---
>  lib/bb/event.py          |  3 +++
>  lib/bb/server/process.py | 20 ++++++++++----------
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
> index bf16793468..613fb35536 100644
> --- a/lib/bb/daemonize.py
> +++ b/lib/bb/daemonize.py
> @@ -16,6 +16,10 @@ def createDaemon(function, logfile):
>      background as a daemon, returning control to the caller.
>      """
>  
> +    # Ensure stdout/stderror are flushed before forking to avoid
> duplicate output
> +    sys.stdout.flush()
> +    sys.stderr.flush()
> +
>      try:
>          # Fork a child process so the parent can exit.  This returns
> control to
>          # the command-line or shell.  It also guarantees that the
> child will not
> @@ -66,12 +70,14 @@ def createDaemon(function, logfile):
>  
>      try:
>          so = open(logfile, 'a+')
> -        se = so
>          os.dup2(so.fileno(), sys.stdout.fileno())
> -        os.dup2(se.fileno(), sys.stderr.fileno())
> +        os.dup2(so.fileno(), sys.stderr.fileno())

I think so "leaks" here. Granted, it was doing that before so perhaps
it could be saved for a separate patch:

 with open(logfile, 'a+') as so:
     os.dup2(so.fileno(), sys.stdout.fileno())
     os.dup2(so.fileno(), sys.stderr.fileno())


>      except io.UnsupportedOperation:
>          sys.stdout = open(logfile, 'a+')
> -        sys.stderr = sys.stdout
> +
> +    # Have stdout and stderr be the same so log output matches
> chronologically
> +    # and there aren't two seperate buffers
> +    sys.stderr = sys.stdout
>  
>      try:
>          function()
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index c0ec605209..5b1b094a80 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -141,6 +141,9 @@ def print_ui_queue():
>      logger = logging.getLogger("BitBake")
>      if not _uiready:
>          from bb.msg import BBLogFormatter
> +        # Flush any existing buffered content
> +        sys.stdout.flush()
> +        sys.stderr.flush()
>          stdout = logging.StreamHandler(sys.stdout)
>          stderr = logging.StreamHandler(sys.stderr)
>          formatter = BBLogFormatter("%(levelname)s: %(message)s")
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 9e5e709f04..38b923fe2d 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -395,11 +395,16 @@ class BitBakeServer(object):
>          bb.daemonize.createDaemon(self._startServer, logfile)
>          self.sock.close()
>          self.bitbake_lock.close()
> +        os.close(self.readypipein)
>  
>          ready = ConnectionReader(self.readypipe)
>          r = ready.poll(30)
>          if r:
> -            r = ready.get()
> +            try:
> +                r = ready.get()
> +            except EOFError:
> +                # Trap the child exitting/closing the pipe and error
> out
> +                r = None
>          if not r or r != "ready":
>              ready.close()
>              bb.error("Unable to start bitbake server")
> @@ -425,21 +430,16 @@ class BitBakeServer(object):
>                          bb.error("Server log for this session
> (%s):\n%s" % (logfile, "".join(lines)))
>              raise SystemExit(1)
>          ready.close()
> -        os.close(self.readypipein)
>  
>      def _startServer(self):
>          print(self.start_log_format % (os.getpid(),
> datetime.datetime.now().strftime(self.start_log_datetime_format)))
>          server = ProcessServer(self.bitbake_lock, self.sock,
> self.sockname)
>          self.configuration.setServerRegIdleCallback(server.register_
> idle_function)
> +        os.close(self.readypipe)
>          writer = ConnectionWriter(self.readypipein)
> -        try:
> -            self.cooker = bb.cooker.BBCooker(self.configuration,
> self.featureset)
> -            writer.send("ready")
> -        except:
> -            writer.send("fail")
> -            raise
> -        finally:
> -            os.close(self.readypipein)
> +        self.cooker = bb.cooker.BBCooker(self.configuration,
> self.featureset)
> +        writer.send("ready")
> +        writer.close()

If we want to ensure that writer is always explicitly closed, would
this be better?

 import contextlib

 with contextlib.closing(ConnectionWriter(self.readypipein)) as writer:
     self.cooker = bb.cooker.BBCooker(...)
     writer.send("ready")

>          server.cooker = self.cooker
>          server.server_timeout = self.configuration.server_timeout
>          server.xmlrpcinterface = self.configuration.xmlrpcinterface
> -- 
> 2.17.1
> 
-- 
Joshua Watt <JPEWhacker@gmail.com>

