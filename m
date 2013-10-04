Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 747CF6B109
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 17:04:30 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 04 Oct 2013 10:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="303248461"
Received: from unknown (HELO helios.localnet) ([10.252.120.164])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Oct 2013 10:04:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 04 Oct 2013 18:04:20 +0100
Message-ID: <13030124.ISsAHLpZIV@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-31-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <6b322934d5cc34601098dc935400e0e8a6e7df1e.1380904913.git.paul.eggleton@linux.intel.com>
References: <cover.1380904913.git.paul.eggleton@linux.intel.com>
	<6b322934d5cc34601098dc935400e0e8a6e7df1e.1380904913.git.paul.eggleton@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] bitbake-diffsigs: handle if task name is specified without do_ prefix
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
X-List-Received-Date: Fri, 04 Oct 2013 17:04:30 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 04 October 2013 17:44:25 Paul Eggleton wrote:
> Warn the user and adjust the task name automatically if the -t option
> is specified with a task name that doesn't start with do_ (e.g.
> "configure" instead of "do_configure").
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bitbake/bin/bitbake-diffsigs | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
> index 3ce70da..6e4c44a 100755
> --- a/bitbake/bin/bitbake-diffsigs
> +++ b/bitbake/bin/bitbake-diffsigs
> @@ -39,6 +39,10 @@ def find_compare_task(bbhandler, pn, taskname):
>          logger.error('Metadata does not support finding signature data
> files') sys.exit(1)
> 
> +    if not taskname.startswith('do_'):
> +        logger.warn('Invalid task name "%s" - assuming you meant "do_%s"' %
> (taskname, taskname)) +        taskname = 'do_%s' % taskname
> +
>      filedates = bb.siggen.find_siginfo(pn, taskname, None,
> bbhandler.config_data) latestfiles = sorted(filedates.keys(), key=lambda f:
> filedates[f])[-2:] if not latestfiles:

I've dropped the warning message on the branch after discussion with Richard - 
the do_ prefix is really an internal detail and users are used to specifying 
these without the prefix when using bitbake -c.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

