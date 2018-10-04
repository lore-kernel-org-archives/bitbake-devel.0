Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EC10C74AFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 08:57:15 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w948vEjo005817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 4 Oct 2018 09:57:15 +0100
Message-ID: <675086deaafea11489a53cdb9dc693d16a0f50d4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 04 Oct 2018 09:57:14 +0100
In-Reply-To: <20181002013719.97783-1-mark.hatle@windriver.com>
References: <20181002013719.97783-1-mark.hatle@windriver.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] bitbake-worker: Add DryRun event
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
X-List-Received-Date: Thu, 04 Oct 2018 08:57:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-10-01 at 21:37 -0400, Mark Hatle wrote:
> There may be actions that a user wants to take, but the information
> is only available during task execution.  Using the DryRun event you
> can prevent the actual task execution, but get access to the
> associated data stores.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  bin/bitbake-worker | 2 ++
>  lib/bb/event.py    | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index e925054b..e27fe7ac 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -268,6 +268,8 @@ def fork_off_task(cfg, data, databuilder,
> workerdata, fn, task, taskname, append
>                  os._exit(1)
>              try:
>                  if dry_run:
> +                    localdata = bb.build._task_data(fn, taskname,
> the_data)
> +                    bb.event.fire(bb.event.DryRun(), localdata)
>                      return 0
>                  return bb.build.exec_task(fn, taskname, the_data,
> cfg.profile)
>              except:
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 5b1b094a..c03541a1 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -832,3 +832,8 @@ class FindSigInfoResult(Event):
>      def __init__(self, result):
>          Event.__init__(self)
>          self.result = result
> +
> +class DryRun(Event):
> +    """
> +    Event to fire during a dry run
> +    """

I think we can add something like this but the DryRun event should
really be in build.py and subclass TaskBase, called something like
TaskDryRun?

I'm hoping that doesn't upset some of the other code that looks at
TaskBase events but its certainly logically where the dryrun event
belongs.

We may want to pass dry_run into exec_task as a parameter and put this
code at the top of exec_task to make things cleaner across the files?

Cheers,

Richard


