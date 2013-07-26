Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B4BEA6B3E1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2013 14:22:30 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2013 07:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,751,1367996400"; d="scan'208";a="377058930"
Received: from unknown (HELO helios.localnet) ([10.252.122.182])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2013 07:22:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Fri, 26 Jul 2013 15:22:29 +0100
Message-ID: <1411340.q3cuRxE77r@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1374752549-29471-4-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
	<1374752549-29471-4-git-send-email-cristiana.voicu@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH_V2 03/16] hob/bitbake: create a template (a .bb file) from hob through bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Jul 2013 14:22:30 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cristiana,

On Thursday 25 July 2013 14:42:16 Cristiana Voicu wrote:
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 49e6345..7d54ab1 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1100,16 +1100,29 @@ class BBCooker:
>  
>          self.configuration.server_register_idlecallback(buildTargetsIdle,
> rq) 
> -    def generateNewImage(self, image, base_image, package_queue):
> +    def ensureDir(self, d):
> +        if not os.path.exists(d):
> +            os.makedirs(d)

Could you use bb.utils.mkdirhier() rather than creating an additional function 
to do the same thing?

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

