Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rD0-0003FD-03
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:14 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Feb 2012 13:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979442"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:28:44 -0800
Message-ID: <4F4E988B.4060002@linux.intel.com>
Date: Wed, 29 Feb 2012 13:28:43 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<83dbb646ca0fd8e565633e06c477e19c498c7f8d.1330523904.git.shane.wang@intel.com>
In-Reply-To: <83dbb646ca0fd8e565633e06c477e19c498c7f8d.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 21/32] cooker.py: Fix a bug due to variable name
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:14 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> fnid is an outer variable and shouldn't be overrided, change the inner variable
> name from 'fnid' to 'id'.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/cooker.py |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 2e4a1ba..b23b569 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -501,8 +501,8 @@ class BBCooker:
>                       pn_provider = ""
>                       targetid = taskdata.getbuild_id(item)
>                       if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
> -                        fnid = taskdata.build_targets[targetid][0]
> -                        fn_provider = taskdata.fn_index[fnid]
> +                        id = taskdata.build_targets[targetid][0]
> +                        fn_provider = taskdata.fn_index[id]
>                           pn_provider = self.status.pkg_fn[fn_provider]
>                       else:
>                           pn_provider = item

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


