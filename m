Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id BF21F60602
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Oct 2016 09:09:33 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP; 14 Oct 2016 02:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,344,1473145200"; d="scan'208";a="179764472"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2016 02:09:35 -0700
Received: from linux.intel.com (vmed.fi.intel.com [10.237.72.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTP id 1EA346A4006;
	Fri, 14 Oct 2016 02:09:01 -0700 (PDT)
Date: Fri, 14 Oct 2016 11:44:08 +0300
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: =?iso-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>
Message-ID: <20161014084408.GA392@linux.intel.com>
Reply-To: ed.bartosh@linux.intel.com
References: <1476400294-17333-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1476400294-17333-1-git-send-email-anibal.limon@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: benjamin.esquivel@intel.com, brian.avery@intel.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.event: fix infinite loop on print_ui_queue
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
X-List-Received-Date: Fri, 14 Oct 2016 09:09:33 -0000
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 13, 2016 at 06:11:34PM -0500, Aníbal Limón wrote:
> If bitbake ends before _uiready and bb.event.LogHandler was add
> to the bitbake logger it causes an infinite loop when logging
> something.
> 
> The scenario is print_ui_queue is called at exit and executes
> the log handlers [2] one of them is bb.event.LogHandler this handler
> appends the same entry to ui_queue causing the inifine loop [3].
> 
> In order to fix we need to keep track of events already handled to
> avoid the infinite loop.
> 
> [YOCTO #10399]
> 
> [1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=10399#c0
> [2] http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=41d9cd41d40b04746c82b4a940dca47df02514fc#n156
> [3]
> http://git.openembedded.org/bitbake/tree/lib/bb/event.py?id=41d9cd41d40b04746c82b4a940dca47df02514fc#n164
> 
> Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
> ---
>  lib/bb/event.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index c5a5f94..8464e06 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -139,7 +139,11 @@ def print_ui_queue():
>  
>          # First check to see if we have any proper messages
>          msgprint = False
> +        events_handled = []
>          for event in ui_queue:
> +            if event in events_handled:
> +                continue
> +
>              if isinstance(event, logging.LogRecord):
>                  if event.levelno > logging.DEBUG:
>                      if event.levelno >= logging.WARNING:
> @@ -148,14 +152,20 @@ def print_ui_queue():
>                          logger.addHandler(stdout)
>                      logger.handle(event)
>                      msgprint = True
> +            events_handled.append(event)
>          if msgprint:
>              return
>  
>          # Nope, so just print all of the messages we have (including debug messages)
>          logger.addHandler(stdout)
> +        events_handled = []
>          for event in ui_queue:
> +            if event in events_handled:
> +                continue
> +
>              if isinstance(event, logging.LogRecord):
>                  logger.handle(event)
> +            events_handled.append(event)
>  
>  def fire_ui_handlers(event, d):
>      global _thread_lock

Would using full slice of ui_queue work the same way?

@@ -139,7 +139,7 @@ def print_ui_queue():

         # First check to see if we have any proper messages
         msgprint = False
-        for event in ui_queue:
+        for event in ui_queue[:]:
             if isinstance(event, logging.LogRecord):
                 if event.levelno > logging.DEBUG:
                     if event.levelno >= logging.WARNING:


--
Regards,
Ed

