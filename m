Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDq-0003MQ-0j
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:38:06 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979858"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:35 -0800
Message-ID: <4F4E98BF.6010901@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:35 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<fca75ff19b2b78363692006b85f2b0c71dcb54e5.1330523904.git.shane.wang@intel.com>
In-Reply-To: <fca75ff19b2b78363692006b85f2b0c71dcb54e5.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 31/32] runqueue.py: initialize rqexe at RunQueue's init function
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
X-List-Received-Date: Wed, 29 Feb 2012 21:38:06 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> Sometimes user stops the build before runqueue is established,
> for example, at the stage of running add_unresolved() function. This
> will cause RunQueue to use rqexe field in finish_runqeue() before
> initialized. This will cause endless print of "Running idle function"
> if use process server.
>
> This commit initialize rqexe variable in RunQueue's init function,
> and add a judgement in finish_runqueue().
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/runqueue.py |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index f08f93a..0615ab4 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -779,6 +779,8 @@ class RunQueue:
>           # For disk space monitor
>           self.dm = monitordisk.diskMonitor(cfgData)
>
> +        self.rqexe = None
> +
>       def check_stamps(self):
>           unchecked = {}
>           current = []
> @@ -996,6 +998,9 @@ class RunQueue:
>           return retval
>
>       def finish_runqueue(self, now = False):
> +        if not self.rqexe:
> +            return
> +
>           if now:
>               self.rqexe.finish_now()
>           else:

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


