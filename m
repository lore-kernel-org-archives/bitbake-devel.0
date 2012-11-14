Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TYmZG-0005wU-Oj for bitbake-devel@lists.openembedded.org;
	Thu, 15 Nov 2012 00:40:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAENQS2j012945;
	Wed, 14 Nov 2012 23:26:28 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12861-01; Wed, 14 Nov 2012 23:26:24 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAENQGWj012938
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Nov 2012 23:26:20 GMT
Message-ID: <1352935577.3709.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Seth Bollinger <seth.boll@gmail.com>
Date: Wed, 14 Nov 2012 23:26:17 +0000
In-Reply-To: <CA+JN8xMP_dhBBiFGJx2qjNs1mpWox98=BaKixPOtX_BBb3rO-g@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
	<1352820166.24487.136.camel@ted> <50A2CB5E.8030600@windriver.com>
	<CA+JN8xNDqbvnymb8pOpmEe=P5GV=WYtnLVskCNxmFPxYwkomvQ@mail.gmail.com>
	<1352899334.13332.0.camel@ted>
	<CA+JN8xMP_dhBBiFGJx2qjNs1mpWox98=BaKixPOtX_BBb3rO-g@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Wed, 14 Nov 2012 23:40:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-11-14 at 08:43 -0600, Seth Bollinger wrote:
> Add bold color output to log level name and standard color output to
> log msg
> when bitbake is run from an iteractive console.  Color output is only
> enabled
> if the terminal supports color.
>
> Used Jason Wessel's recommendation for transparency on verbose, note
> and plain.
> 
This works much better. I've realised the escape sequences are ending up
in logfiles like the cooker log though so some further tweaking is
needed...

Also, your patches are coming through linewrapped so I have to fix them
manually before applying.

Cheers,

Richard


> Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
> ---
>  bitbake/lib/bb/msg.py       |   40
> ++++++++++++++++++++++++++++++++++++++++
>  bitbake/lib/bb/ui/knotty.py |    6 +++++-
>  2 files changed, 45 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
> index 9b39325..68b2ad7 100644
> --- a/bitbake/lib/bb/msg.py
> +++ b/bitbake/lib/bb/msg.py
> @@ -55,6 +55,25 @@ class BBLogFormatter(logging.Formatter):
>          CRITICAL: 'ERROR',
>      }
>  
> +    color_enabled = False
> +    BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE
> = range(29,38)
> +
> +    COLORS = {
> +        DEBUG3  : CYAN,
> +        DEBUG2  : CYAN,
> +        DEBUG   : CYAN,
> +        VERBOSE : BASECOLOR,
> +        NOTE    : BASECOLOR,
> +        PLAIN   : BASECOLOR,
> +        WARNING : YELLOW,
> +        ERROR   : RED,
> +        CRITICAL: RED,
> +    }
> +
> +    BLD = '\033[1;%dm'
> +    STD = '\033[%dm'
> +    RST = '\033[0m'
> +
>      def getLevelName(self, levelno):
>          try:
>              return self.levelnames[levelno]
> @@ -67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):
>          if record.levelno == self.PLAIN:
>              msg = record.getMessage()
>          else:
> +            if self.color_enabled:
> +                self.colorize(record)
>              msg = logging.Formatter.format(self, record)
>  
>          if hasattr(record, 'bb_exc_info'):
> @@ -75,6 +96,25 @@ class BBLogFormatter(logging.Formatter):
>              msg += '\n' + ''.join(formatted)
>          return msg
>  
> +    def colorize(self, record):
> +        color = self.COLORS[record.levelno]
> +        if self.color_enabled and color is not None:
> +            record.levelname = "".join([self.BLD % color,
> record.levelname, self.RST])
> +            record.msg = "".join([self.STD % color, record.msg,
> self.RST])
> +
> +    def enable_color(self):
> +        import curses
> +        try:
> +            win = None
> +            win = curses.initscr()
> +            if curses.has_colors():
> +                self.color_enabled = True
> +        except:
> +            pass
> +        finally:
> +            if win is not None:
> +                curses.endwin()
> +
>  class BBLogFilter(object):
>      def __init__(self, handler, level, debug_domains):
>          self.stdlevel = level
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index b99a121..d9aa973 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -238,12 +238,16 @@ def main(server, eventHandler, tf =
> TerminalFilter):
>      helper = uihelper.BBUIHelper()
>  
>      console = logging.StreamHandler(sys.stdout)
> -    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
> +    format_str = "%(levelname)s: %(message)s"
> +    format = bb.msg.BBLogFormatter(format_str)
> +    if interactive:
> +        format.enable_color()
>      bb.msg.addDefaultlogFilter(console)
>      console.setFormatter(format)
>      logger.addHandler(console)
>      if consolelogfile:
>          bb.utils.mkdirhier(os.path.dirname(consolelogfile))
> +        format = bb.msg.BBLogFormatter(format_str)
>          consolelog = logging.FileHandler(consolelogfile)
>          bb.msg.addDefaultlogFilter(consolelog)
>          consolelog.setFormatter(format)
> -- 
> 1.7.2.5
> 
> 
> 
> 
> On Wed, Nov 14, 2012 at 7:22 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         On Wed, 2012-11-14 at 07:18 -0600, Seth Bollinger wrote:
>         > Thanks!  I've tested this and it works on my dark color
>         scheme (it's
>         > better actually :)).  I also tested on white and it looks
>         fine.  If
>         > Richard is ok with this solution, I'll make the changes and
>         submit
>         > another patch.
>         >
>         It sounds promising, I would like to try the patch...
>         
>         Cheers,
>         
>         Richard
>         
>         
>         
> 
> 




