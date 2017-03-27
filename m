Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 78CA660685
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490634005; x=1522170005;
	h=message-id:subject:from:to:cc:date:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=LucTv65lG78NbSyUhwClhJFZABnbch9idkdPLX98pEQ=;
	b=fFSehN4q7bGp+M/pINYpO1ofIGYTbP6Nfw4nUeevfeM8VjRouM3V6PnX
	4XaduYhG90+vRMMfjz3Aj+LfIpsx7g==;
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Mar 2017 09:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,232,1486454400"; d="scan'208";a="1112621352"
Received: from lsandov1-mobl2.zpn.intel.com ([10.219.128.141])
	by orsmga001.jf.intel.com with ESMTP; 27 Mar 2017 09:59:49 -0700
Message-ID: <1490634472.28281.111.camel@linux.intel.com>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
To: Diana Thayer <garbados@gmail.com>
Date: Mon, 27 Mar 2017 11:07:52 -0600
In-Reply-To: <1490128025-7864-1-git-send-email-garbados@gmail.com>
References: <1490128025-7864-1-git-send-email-garbados@gmail.com>
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bug 9962: improve -v, -D documentation
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
X-List-Received-Date: Mon, 27 Mar 2017 17:00:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2017-03-21 at 13:27 -0700, Diana Thayer wrote:
> Per bug-9962, expanded and clarified documentation
> for -v, --verbose and -D, --debug.
> 
> Signed-off-by: Diana Thayer <garbados@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 16 +++++++++++++---
>  lib/bb/main.py                                        | 15 +++++++++++++--
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> index 7248a0b..5bbfc67 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> @@ -504,9 +504,19 @@
>                               Read the specified file before bitbake.conf.
>         -R POSTFILE, --postread=POSTFILE
>                               Read the specified file after bitbake.conf.
> -       -v, --verbose         Output more log message data to the terminal.
> -       -D, --debug           Increase the debug level. You can specify this more
> -                             than once.
> +       -v, --verbose         Enable tracing of shell tasks (with 'set -x').
> +                             Also print bb.note(...) messages to stdout (in
> +                             addition to writing them to ${T}/log.do_<task>).
> +       -D, --debug           Increase the debug level. You can specify this
> +                             more than once. -D sets the debug level to 1,
> +                             where only bb.debug(1, ...) messages are printed
> +                             to stdout; -DD sets the debug level to 2, where
> +                             both bb.debug(1, ...) and bb.debug(2, ...)
> +                             messages are printed; etc. Without -D, no debug
> +                             messages are printed. Note that -D only affects
> +                             output to stdout. All debug messages are written
> +                             to ${T}/log.do_taskname, regardless of the debug
> +                             level.

I think the description is fine for -D/--debug , but I am not sure if
this is the place to describe that level N includes N-1, etc.. This is
something standard, and describing here make it a bit verbose.

>         -n, --dry-run         Don't execute, just go through the motions.
>         -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
>                               Dump out the signature construction information, with
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index b3cd2cf..8c948c2 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -174,10 +174,21 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>                            help="Read the specified file after bitbake.conf.")
>  
>          parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
> -                          help="Output more log message data to the terminal.")
> +                          help="Enable tracing of shell tasks (with 'set -x'). "
> +                               "Also print bb.note(...) messages to stdout (in "
> +                               "addition to writing them to ${T}/log.do_<task>).")
>  
>          parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
> -                          help="Increase the debug level. You can specify this more than once.")
> +                          help="Increase the debug level. You can specify this "
> +                               "more than once. -D sets the debug level to 1, "
> +                               "where only bb.debug(1, ...) messages are printed "
> +                               "to stdout; -DD sets the debug level to 2, where "
> +                               "both bb.debug(1, ...) and bb.debug(2, ...) "
> +                               "messages are printed; etc. Without -D, no debug "
> +                               "messages are printed. Note that -D only affects "
> +                               "output to stdout. All debug messages are written "
> +                               "to ${T}/log.do_taskname, regardless of the debug "
> +                               "level.")
>  
>          parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
>                            help="Output less log message data to the terminal. You can specify this more than once.")
> -- 
> 2.7.4
> 



