Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8858B6B389
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 11:09:40 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 20 Sep 2013 04:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,943,1371106800"; d="scan'208";a="398598702"
Received: from unknown (HELO helios.localnet) ([10.252.123.234])
	by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2013 04:09:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 20 Sep 2013 12:09:39 +0100
Message-ID: <3335435.nZ1M0MKWov@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-30-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1379672987.18603.139.camel@ted>
References: <1379672987.18603.139.camel@ted>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] build: Add BB_TASK_NICE_LEVEL to task code
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
X-List-Received-Date: Fri, 20 Sep 2013 11:09:41 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 20 September 2013 11:29:47 Richard Purdie wrote:
> On Linux its not possible for processes to regain a previous nice level
> after it has changed. Its therefore not possible to have a core low
> priority and then raise the priorities of individual tasks.
> 
> This variable allows us to do something like:
> 
> BB_TASK_NICE_LEVEL = "5"
> BB_TASK_NICE_LEVEL_task-testimage = "0"
> 
> to give priority to specific tasks which the BB_NICE_LEVEL functionality
> doesn't give us the option of.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 8aec699..9addd71 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -346,6 +346,13 @@ def _exec_task(fn, task, d, quieterr):
>      if not tempdir:
>          bb.fatal("T variable not set, unable to build")
> 
> +    # Change nice level if we're asked to
> +    nice = localdata.getVar("BB_TASK_NICE_LEVEL", True)
> +    if nice:
> +        curnice = os.nice(0)
> +        nice = int(nice) - curnice
> +        logger.debug(1, "Renice to %s " % os.nice(nice))

It's a matter of style to be sure, but I think it's better not to have debug 
statements that do more than just printing debug output - could the latter be 
split onto two lines? Then it's easy to tell what's being done.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

