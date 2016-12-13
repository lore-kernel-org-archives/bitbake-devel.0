Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BDC2C602D9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 01:59:43 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id uBD1xb1m026438
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 12 Dec 2016 17:59:37 -0800 (PST)
Received: from [128.224.162.160] (128.224.162.160) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Mon, 12 Dec 2016 17:59:36 -0800
To: Armin Kuster <akuster808@gmail.com>
References: <1481113881-3280-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <76a6f42f-b9b0-d8f0-1cca-faefe422d8e6@windriver.com>
Date: Tue, 13 Dec 2016 09:59:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1481113881-3280-1-git-send-email-richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: Fix world taskgraph generation issue
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
X-List-Received-Date: Tue, 13 Dec 2016 01:59:43 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Armin,

Morty also needs this fix, the reproducer is:

$ bitbake world -g

The pn-buildlist and *.dot are null,

// Robert

On 12/07/2016 08:31 PM, Richard Purdie wrote:
> The processing of the "do_" prefix to tasks is currently inconsistent
> and has resulted in "bitbake world -g" being broken as task prefixes
> don't get handled correctly.
>
> Make the "do_" task prefix handling consistent through various codepaths.
>
> [YOCTO #10651]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bitbake/lib/bb/cooker.py | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 4810fe3..1fe693c 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -657,6 +657,8 @@ class BBCooker:
>          # A task of None means use the default task
>          if task is None:
>              task = self.configuration.cmd
> +        if not task.startswith("do_"):
> +            task = "do_%s" % task
>
>          fulltargetlist = self.checkPackages(pkgs_to_build, task)
>          taskdata = {}
> @@ -715,6 +717,9 @@ class BBCooker:
>          Create a dependency graph of pkgs_to_build including reverse dependency
>          information.
>          """
> +        if not task.startswith("do_"):
> +            task = "do_%s" % task
> +
>          runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
>          rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
>          rq.rqdata.prepare()
> @@ -818,6 +823,9 @@ class BBCooker:
>          """
>          Create a dependency tree of pkgs_to_build, returning the data.
>          """
> +        if not task.startswith("do_"):
> +            task = "do_%s" % task
> +
>          _, taskdata = self.prepareTreeData(pkgs_to_build, task)
>
>          seen_fns = []
> @@ -1322,6 +1330,8 @@ class BBCooker:
>          # If we are told to do the None task then query the default task
>          if (task == None):
>              task = self.configuration.cmd
> +        if not task.startswith("do_"):
> +            task = "do_%s" % task
>
>          fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
>          fn = self.matchFile(fn)
> @@ -1358,8 +1368,6 @@ class BBCooker:
>          # Invalidate task for target if force mode active
>          if self.configuration.force:
>              logger.verbose("Invalidate task %s, %s", task, fn)
> -            if not task.startswith("do_"):
> -                task = "do_%s" % task
>              bb.parse.siggen.invalidate_task(task, self.recipecaches[mc], fn)
>
>          # Setup taskdata structure
> @@ -1371,8 +1379,6 @@ class BBCooker:
>          bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
>
>          # Execute the runqueue
> -        if not task.startswith("do_"):
> -            task = "do_%s" % task
>          runlist = [[mc, item, task, fn]]
>
>          rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
>

