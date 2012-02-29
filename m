Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDl-0003MQ-NZ
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:38:01 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979817"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:32 -0800
Message-ID: <4F4E98BC.6070001@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:32 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<8215fe641661f250180c87d726073c0450e191b7.1330523904.git.shane.wang@intel.com>
In-Reply-To: <8215fe641661f250180c87d726073c0450e191b7.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 30/32] Hob: Fix pressing "stop" build
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
X-List-Received-Date: Wed, 29 Feb 2012 21:38:02 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> This commit fixes the behavior of clicking stop build button, it will
> stay in the build detail screen and show build is failed.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/builder.py |   18 +++++++++++++-----
>   1 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
> index f41b6a4..a04d6fa 100755
> --- a/bitbake/lib/bb/ui/crumbs/builder.py
> +++ b/bitbake/lib/bb/ui/crumbs/builder.py
> @@ -193,7 +193,6 @@ class Builder(gtk.Window):
>           self.previous_step = None
>
>           self.stopping = False
> -        self.build_succeeded = True
>
>           # recipe model and package model
>           self.recipe_model = recipe_model
> @@ -533,8 +532,7 @@ class Builder(gtk.Window):
>           self.build_details_page.update_progress_bar("Build Started: ", fraction)
>           self.build_details_page.reset_issues()
>
> -    def handler_build_succeeded_cb(self, running_build):
> -        self.build_succeeded = True
> +    def build_succeeded(self):
>           if self.current_step == self.FAST_IMAGE_GENERATING:
>               fraction = 0.9
>           elif self.current_step == self.IMAGE_GENERATING:
> @@ -548,9 +546,9 @@ class Builder(gtk.Window):
>           elif self.current_step == self.PACKAGE_GENERATING:
>               fraction = 1.0
>           self.build_details_page.update_progress_bar("Build Completed: ", fraction)
> +        self.stopping = False
>
> -    def handler_build_failed_cb(self, running_build):
> -        self.build_succeeded = False
> +    def build_failed(self):
>           if self.current_step == self.FAST_IMAGE_GENERATING:
>               fraction = 0.9
>           elif self.current_step == self.IMAGE_GENERATING:
> @@ -563,6 +561,16 @@ class Builder(gtk.Window):
>           self.handler.build_failed_async()
>           self.stopping = False
>
> +    def handler_build_succeeded_cb(self, running_build):
> +        if not self.stopping:
> +            self.build_succeeded()
> +        else:
> +            self.build_failed()
> +
> +
> +    def handler_build_failed_cb(self, running_build):
> +        self.build_failed()
> +
>       def handler_task_started_cb(self, running_build, message):
>           fraction = message["current"] * 1.0/message["total"]
>           title = "Build packages"

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


