Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RaVOO-0001em-To
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 17:39:49 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Dec 2011 08:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95686224"
Received: from unknown (HELO [10.255.12.215]) ([10.255.12.215])
	by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2011 08:31:43 -0800
Message-ID: <4EE77DEF.8040906@linux.intel.com>
Date: Tue, 13 Dec 2011 08:31:43 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<c964cfa4b7bcde985223d41f7bd00937544bc791.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <c964cfa4b7bcde985223d41f7bd00937544bc791.1323656120.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 03/10] cooker: user bb.configuration.data to inject events
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
X-List-Received-Date: Tue, 13 Dec 2011 16:39:49 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 11/12/11 18:20, Dongxiao Xu wrote:
> For buildTargets function, we use bb.configuration.data as parameter
> to inject events, since in hob environment, some variables are
> modified dynamically and bb.configuration.event_data may out of date.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>

I discussed this patch with Dongxiao when he worked on it so it has my ACK.

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>  lib/bb/cooker.py |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 2c02e28..6ddb38e 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1085,7 +1085,7 @@ class BBCooker:
>                  return False
>  
>              if not retval:
> -                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.event_data)
> +                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.data)
>                  self.command.finishAsyncCommand()
>                  return False
>              if retval is True:
> @@ -1095,7 +1095,7 @@ class BBCooker:
>          self.buildSetVars()
>  
>          buildname = self.configuration.data.getVar("BUILDNAME")
> -        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.event_data)
> +        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.data)
>  
>          localdata = data.createCopy(self.configuration.data)
>          bb.data.update_data(localdata)

-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


