Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ShjtM-0004PH-Pg for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 18:05:57 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LFtBbT024102;
	Thu, 21 Jun 2012 16:55:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23390-06; Thu, 21 Jun 2012 16:55:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LFt4eu024089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 16:55:05 +0100
Message-ID: <1340294106.1640.129.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Thu, 21 Jun 2012 16:55:06 +0100
In-Reply-To: <1339685898-24757-2-git-send-email-jason.wessel@windriver.com>
References: <1339685898-24757-1-git-send-email-jason.wessel@windriver.com>
	<1339685898-24757-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] process.py, build.py: Fix log truncation problems with flush()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Jun 2012 16:05:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-14 at 09:58 -0500, Jason Wessel wrote:
> There are two problems with the _logged_communicate that are both
> caused as a result of buffering I/O, instead of flushing it out to the
> log files as it arrives.
> 
> 1) log truncation when python dumps
>    I have seen the task logs missing data that was not flushed when
>    bitbake crashes.
> 
> 2) While a bitbake task is running it is impossible to see what is
>    going on if it is only writing a small incremental log that is
>    smaller than the buffer, or you get only a partial log, up until
>    the task exists.  It is worse in the case that stderr and stdout
>    are separate file handles, because previous code blocks on the read
>    of stdout and then stderr, serially.
> 
> The right approach is simply to use select() to determine if there is
> data available and then to flush the log buffers as they arrive.  This
> still makes use of buffering in the cases where there is more than 1
> byte of data, but the buffers are much more dynamic.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> ---
>  lib/bb/build.py   |    3 ++-
>  lib/bb/process.py |   29 +++++++++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)

For what its worth I'm seeing a small but consistent increase in real,
sys and user times with this patch which is why I'm pausing to look at
it a little further :(

Cheers,

Richard



> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index a9ba02d..7e9bb23 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -135,7 +135,8 @@ class LogTee(object):
>  
>      def __repr__(self):
>          return '<LogTee {0}>'.format(self.name)
> -
> +    def flush(self):
> +        self.outfile.flush()
>  
>  def exec_func(func, d, dirs = None):
>      """Execute an BB 'function'"""
> diff --git a/lib/bb/process.py b/lib/bb/process.py
> index b74cb18..9848fc3 100644
> --- a/lib/bb/process.py
> +++ b/lib/bb/process.py
> @@ -1,6 +1,9 @@
>  import logging
>  import signal
>  import subprocess
> +import fcntl
> +import errno
> +import select
>  
>  logger = logging.getLogger('BitBake.Process')
>  
> @@ -70,18 +73,40 @@ def _logged_communicate(pipe, log, input):
>  
>      bufsize = 512
>      outdata, errdata = [], []
> +    rin = []
> +
> +    if pipe.stdout is not None:
> +        fd = pipe.stdout.fileno()
> +        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
> +        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NONBLOCK)
> +        rin.append(pipe.stdout)
> +    if pipe.stderr is not None:
> +        fd = pipe.stderr.fileno()
> +        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
> +        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NONBLOCK)
> +        rin.append(pipe.stderr)
> +
>      while pipe.poll() is None:
> -        if pipe.stdout is not None:
> +        rlist = rin
> +        try:
> +            r,w,e = select.select (rlist, [], [])
> +        except OSError, e:
> +            if e.errno != errno.EINTR:
> +                raise
> +
> +        if pipe.stdout in r:
>              data = pipe.stdout.read(bufsize)
>              if data is not None:
>                  outdata.append(data)
>                  log.write(data)
> +                log.flush()
>  
> -        if pipe.stderr is not None:
> +        if pipe.stderr in r:
>              data = pipe.stderr.read(bufsize)
>              if data is not None:
>                  errdata.append(data)
>                  log.write(data)
> +                log.flush()
>      return ''.join(outdata), ''.join(errdata)
>  
>  def run(cmd, input=None, log=None, **options):




