Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id CA3E56084B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 01:46:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s311kcCE029685
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 18:46:38 -0700 (PDT)
Received: from [128.224.162.226] (128.224.162.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Mon, 31 Mar 2014 18:46:38 -0700
Message-ID: <533A1A7C.8030509@windriver.com>
Date: Tue, 1 Apr 2014 09:46:36 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1396303640.14790.85.camel@ted>
In-Reply-To: <1396303640.14790.85.camel@ted>
Subject: Re: [PATCH] runqueue: Fix sstate task dependency problems
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
X-List-Received-Date: Tue, 01 Apr 2014 01:46:40 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Cool, it works well now.

Tested-by: Robert Yang <liezhi.yang@windriver.com>

// Robert


On 04/01/2014 06:07 AM, Richard Purdie wrote:
> If a setscene task has [depends], its possible they may still get executed out
> of order. The issue is that the dependencies are set to set() for all tasks
> involved. This patch adds back in explict dependencies within these chains
> to avoid the setscene task failures.
>
> [YOCTO #6069]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 42b6c48..1a19677 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1757,6 +1757,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>                       # Have to zero this to avoid circular dependencies
>                       sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
>
> +        for task in self.sq_harddeps:
> +             for dep in self.sq_harddeps[task]:
> +                 sq_revdeps_squash[dep].add(task)
> +
>           #for task in xrange(len(sq_revdeps_squash)):
>           #    realtask = self.rqdata.runq_setscene[task]
>           #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask) , sq_revdeps_squash[task]))
>
>

