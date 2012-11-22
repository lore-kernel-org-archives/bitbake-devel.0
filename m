Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TbNoc-0005mt-BM
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 04:51:02 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qAM3atED007657
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 21 Nov 2012 19:36:55 -0800 (PST)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 21 Nov 2012 19:36:54 -0800
Message-ID: <50AD9DD5.5000309@windriver.com>
Date: Thu, 22 Nov 2012 11:36:53 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:16.0) Gecko/20121011 Thunderbird/16.0.1
MIME-Version: 1.0
To: Seth Bollinger <seth.boll@gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
In-Reply-To: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 22 Nov 2012 03:51:02 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


I'm afraid that this patch doesn't work well, it will output chaotic message
after the "Ctrl-Z" and "fg":

On Fedora 17 64 bit
$ screen
$ bitbake xxx
$ C-Z
$ fg

then it will output like this:

(164 of 9052): 
                                                                          0: 
linux-libc-headers-3.4.3-r0 do_fetch (pid 10632) 
           Currently 4 running tasks (164 of 9052):
          0: linux-libc-headers-3.4.3-r0 do_fetch (pid 1Currently 4 running 
tasks (165 of 9052): 
 
0: linux-libc-headers-3.4.3-r0 do_fetch (pid 1Currently 5 running tasks (165 of 
9052): 
                                                                  0: 
linux-libc-headers-3.4.3-r0 do_fetch (pid 10632)
      Currently 4 running tasks (165 of 9052): 
 
                           0: linux-libc-headers-3.4.3-r0 do_fetch (pid 
1Currently 4 running tasks (166 of 9052): 
 
                      0: linux-libc-headers-3.4.3-r0 do_fetch (pid 1Currently 5 
running tasks (166 of 9052):
 
0: linux-libc-headers-3.4.3-r0 do_fetch (pid 10632) 
                    Currently 4 running tasks (166 of 9052): 
 
                                         0: linux-libc-headers-3.4.3-r0 do_fetch 
(pid 1Currently 4 running tasks (167 of 9052): 
 
                           0: linux-libc-headers-3.4.3-r0 do_fetch (pid 
1Currently 5 running tasks (167 of 9052):


Revert this patch would be OK.

// Robert

On 11/11/2012 11:17 PM, Seth Bollinger wrote:
> Add bold color output to log level name and standard color output to log msg
> when bitbake is run from an iteractive console.  Color output is only
> enabled
> if the terminal supports color.
>
> Signed-off-by: Seth Bollinger <seth.boll@gmail.com>
> ---
>   bitbake/lib/bb/msg.py       |   40 ++++++++++++++++++++++++++++++++++++++++
>   bitbake/lib/bb/ui/knotty.py |    6 +++++-
>   2 files changed, 45 insertions(+), 1 deletions(-)
>
> diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
> index 9b39325..68b2ad7 100644
> --- a/bitbake/lib/bb/msg.py
> +++ b/bitbake/lib/bb/msg.py
> @@ -55,6 +55,25 @@ class BBLogFormatter(logging.Formatter):
>           CRITICAL: 'ERROR',
>       }
>
> +    color_enabled = False
> +    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(30,38)
> +
> +    COLORS = {
> +        DEBUG3  : CYAN,
> +        DEBUG2  : CYAN,
> +        DEBUG   : CYAN,
> +        VERBOSE : WHITE,
> +        NOTE    : WHITE,
> +        PLAIN   : WHITE,
> +        WARNING : YELLOW,
> +        ERROR   : RED,
> +        CRITICAL: RED,
> +    }
> +
> +    BLD = '\033[1;%dm'
> +    STD = '\033[%dm'
> +    RST = '\033[0m'
> +
>       def getLevelName(self, levelno):
>           try:
>               return self.levelnames[levelno]
> @@ -67,6 +86,8 @@ class BBLogFormatter(logging.Formatter):
>           if record.levelno == self.PLAIN:
>               msg = record.getMessage()
>           else:
> +            if self.color_enabled:
> +                self.colorize(record)
>               msg = logging.Formatter.format(self, record)
>
>           if hasattr(record, 'bb_exc_info'):
> @@ -75,6 +96,25 @@ class BBLogFormatter(logging.Formatter):
>               msg += '\n' + ''.join(formatted)
>           return msg
>
> +    def colorize(self, record):
> +        color = self.COLORS[record.levelno]
> +        if self.color_enabled and color is not None:
> +            record.levelname = "".join([self.BLD % color,
> record.levelname, self.RST])
> +            record.msg = "".join([self.STD % color, record.msg, self.RST])
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
>   class BBLogFilter(object):
>       def __init__(self, handler, level, debug_domains):
>           self.stdlevel = level
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index b99a121..d9aa973 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -238,12 +238,16 @@ def main(server, eventHandler, tf = TerminalFilter):
>       helper = uihelper.BBUIHelper()
>
>       console = logging.StreamHandler(sys.stdout)
> -    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
> +    format_str = "%(levelname)s: %(message)s"
> +    format = bb.msg.BBLogFormatter(format_str)
> +    if interactive:
> +        format.enable_color()
>       bb.msg.addDefaultlogFilter(console)
>       console.setFormatter(format)
>       logger.addHandler(console)
>       if consolelogfile:
>           bb.utils.mkdirhier(os.path.dirname(consolelogfile))
> +        format = bb.msg.BBLogFormatter(format_str)
>           consolelog = logging.FileHandler(consolelogfile)
>           bb.msg.addDefaultlogFilter(consolelog)
>           consolelog.setFormatter(format)
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>


