Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDeYB-0007Sb-LQ
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 18:19:43 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 Mar 2012 09:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83565414"
Received: from unknown (HELO [10.255.15.226]) ([10.255.15.226])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Mar 2012 09:10:22 -0700
Message-ID: <4F75DAEE.7040103@linux.intel.com>
Date: Fri, 30 Mar 2012 09:10:22 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120316 Thunderbird/11.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<28ccf8cd2d23a4cfc8e94fa1ad089dd68334bf35.1333108781.git.dongxiao.xu@intel.com>
In-Reply-To: <28ccf8cd2d23a4cfc8e94fa1ad089dd68334bf35.1333108781.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 4/7] Revert "lib/bb/ui/crumbs/hig: fix layers_changed test"
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
X-List-Received-Date: Fri, 30 Mar 2012 16:19:44 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/03/12 05:01, Dongxiao Xu wrote:
> We do not sort the layer list, therefore when response_cb, the ordering
> is also not needed.
>
> This reverts commit 71c1de347eef07a2059fc4544dc3cae090181f44.

This only makes sense if 3/7 is merged, correct?

Cheers,
Joshua

> ---
>   lib/bb/ui/crumbs/hig.py |    5 +----
>   1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 9a38bc0..0ac4496 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -958,10 +958,7 @@ class LayerSelectionDialog (CrumbsDialog):
>               layers.append(model.get_value(it, 0))
>               it = model.iter_next(it)
>
> -        orig_layers = sorted(self.layers)
> -        layers.sort()
> -
> -        self.layers_changed = (orig_layers != layers)
> +        self.layers_changed = (self.layers != layers)
>           self.layers = layers
>
>       """

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


