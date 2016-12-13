Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6DB0571A88
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 09:21:36 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP; 13 Dec 2016 01:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="39495802"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.0.210])
	by orsmga004.jf.intel.com with ESMTP; 13 Dec 2016 01:21:36 -0800
Message-ID: <1481620895.3593.1.camel@linux.intel.com>
From: Joshua Lock <joshua.g.lock@linux.intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 09:21:35 +0000
In-Reply-To: <e999fc0611f5e048953ade03cd2522b4d9d6c830.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
	<e999fc0611f5e048953ade03cd2522b4d9d6c830.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.22.2 (3.22.2-1.fc25) 
Mime-Version: 1.0
Subject: Re: [PATCH 02/15] knotty: make quiet option a level option
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
X-List-Received-Date: Tue, 13 Dec 2016 09:21:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2016-12-13 at 20:07 +1300, Paul Eggleton wrote:
> Allow you to specify -q / --quiet more than once to reduce the
> messages
> even further. It will now operate as follows:
> 
>  Level  Option  Result
>  -----  ------  ----------------------------------------
>  0              Print usual output
>  1      -q      Only show progress and warnings or above
>  2      -qq     Only show warnings or above
>  3+     -qqq    Only show errors

I like this change, can we document the levels somewhere other than the
commit message?

Thanks,

Joshua

> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/main.py      |  4 ++--
>  lib/bb/ui/knotty.py | 35 ++++++++++++++++++++++++++++-------
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index f2f59f6..a544c0a 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -179,8 +179,8 @@ class
> BitBakeConfigParameters(cookerdata.ConfigParameters):
>          parser.add_option("-D", "--debug", action="count",
> dest="debug", default=0,
>                            help="Increase the debug level. You can
> specify this more than once.")
>  
> -        parser.add_option("-q", "--quiet", action="store_true",
> dest="quiet", default=False,
> -                          help="Output less log message data to the
> terminal.")
> +        parser.add_option("-q", "--quiet", action="count",
> dest="quiet", default=0,
> +                          help="Output less log message data to the
> terminal. You can specify this more than once.")
>  
>          parser.add_option("-n", "--dry-run", action="store_true",
> dest="dry_run", default=False,
>                            help="Don't execute, just go through the
> motions.")
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 48e1223..3390eb7 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -284,7 +284,7 @@ class TerminalFilter(object):
>              content = self.main_progress.update(progress)
>              print('')
>          lines = 1 + int(len(content) / (self.columns + 1))
> -        if not self.quiet:
> +        if self.quiet == 0:
>              for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
>                  if isinstance(task, tuple):
>                      pbar, progress, rate, start_time = task
> @@ -353,10 +353,13 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>      errconsole = logging.StreamHandler(sys.stderr)
>      format_str = "%(levelname)s: %(message)s"
>      format = bb.msg.BBLogFormatter(format_str)
> -    if params.options.quiet:
> -        bb.msg.addDefaultlogFilter(console,
> bb.msg.BBLogFilterStdOut, bb.msg.BBLogFormatter.WARNING)
> +    if params.options.quiet == 0:
> +        forcelevel = None
> +    elif params.options.quiet > 2:
> +        forcelevel = bb.msg.BBLogFormatter.ERROR
>      else:
> -        bb.msg.addDefaultlogFilter(console,
> bb.msg.BBLogFilterStdOut)
> +        forcelevel = bb.msg.BBLogFormatter.WARNING
> +    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut,
> forcelevel)
>      bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
>      console.setFormatter(format)
>      errconsole.setFormatter(format)
> @@ -506,35 +509,47 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>                  logger.info(event._message)
>                  continue
>              if isinstance(event, bb.event.ParseStarted):
> +                if params.options.quiet > 1:
> +                    continue
>                  if event.total == 0:
>                      continue
>                  parseprogress = new_progress("Parsing recipes",
> event.total).start()
>                  continue
>              if isinstance(event, bb.event.ParseProgress):
> +                if params.options.quiet > 1:
> +                    continue
>                  if parseprogress:
>                      parseprogress.update(event.current)
>                  else:
>                      bb.warn("Got ParseProgress event for parsing
> that never started?")
>                  continue
>              if isinstance(event, bb.event.ParseCompleted):
> +                if params.options.quiet > 1:
> +                    continue
>                  if not parseprogress:
>                      continue
>                  parseprogress.finish()
>                  pasreprogress = None
> -                if not params.options.quiet:
> +                if params.options.quiet == 0:
>                      print(("Parsing of %d .bb files complete (%d
> cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
>                          % ( event.total, event.cached, event.parsed,
> event.virtuals, event.skipped, event.masked, event.errors)))
>                  continue
>  
>              if isinstance(event, bb.event.CacheLoadStarted):
> +                if params.options.quiet > 1:
> +                    continue
>                  cacheprogress = new_progress("Loading cache",
> event.total).start()
>                  continue
>              if isinstance(event, bb.event.CacheLoadProgress):
> +                if params.options.quiet > 1:
> +                    continue
>                  cacheprogress.update(event.current)
>                  continue
>              if isinstance(event, bb.event.CacheLoadCompleted):
> +                if params.options.quiet > 1:
> +                    continue
>                  cacheprogress.finish()
> -                if not params.options.quiet:
> +                if params.options.quiet == 0:
>                      print("Loaded %d entries from dependency cache."
> % event.num_entries)
>                  continue
>  
> @@ -620,16 +635,22 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>                  continue
>  
>              if isinstance(event, bb.event.ProcessStarted):
> +                if params.options.quiet > 1:
> +                    continue
>                  parseprogress = new_progress(event.processname,
> event.total)
>                  parseprogress.start(False)
>                  continue
>              if isinstance(event, bb.event.ProcessProgress):
> +                if params.options.quiet > 1:
> +                    continue
>                  if parseprogress:
>                      parseprogress.update(event.progress)
>                  else:
>                      bb.warn("Got ProcessProgress event for someting
> that never started?")
>                  continue
>              if isinstance(event, bb.event.ProcessFinished):
> +                if params.options.quiet > 1:
> +                    continue
>                  if parseprogress:
>                      parseprogress.finish()
>                  parseprogress = None
> @@ -701,7 +722,7 @@ def main(server, eventHandler, params, tf =
> TerminalFilter):
>          if return_value and errors:
>              summary += pluralise("\nSummary: There was %s ERROR
> message shown, returning a non-zero exit code.",
>                                   "\nSummary: There were %s ERROR
> messages shown, returning a non-zero exit code.", errors)
> -        if summary and not params.options.quiet:
> +        if summary and params.options.quiet == 0:
>              print(summary)
>  
>          if interrupted:
> -- 
> 2.5.5
> 

