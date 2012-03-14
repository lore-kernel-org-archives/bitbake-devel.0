Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAL-0003eJ-8C
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:21 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044745"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:37:52 -0700
Message-ID: <4F60F38E.2040500@linux.intel.com>
Date: Wed, 14 Mar 2012 12:37:50 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<fc84bca12f1b86e02f2f956803ed448747442517.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <fc84bca12f1b86e02f2f956803ed448747442517.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 03/11] cooker: add package rdepends and rrecommends info
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:21 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> When calculating the image installation dependency, we need the
> rdepends and rrecommends information of certain packages.
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/cooker.py |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 78d8754..eada435 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -479,7 +479,6 @@ class BBCooker:
>                   depend_tree["pn"][pn]["license"] = lic
>                   depend_tree["pn"][pn]["section"] = section
>                   depend_tree["pn"][pn]["description"] = description
> -                depend_tree["pn"][pn]["packages"] = rdepends.keys()
>
>               if fnid not in seen_fnids:
>                   seen_fnids.append(fnid)
> @@ -510,6 +509,9 @@ class BBCooker:
>                           pn_rprovider = item
>                       depend_tree["rdepends-pn"][pn].append(pn_rprovider)
>
> +                depend_tree["rdepends-pkg"].update(rdepends)
> +                depend_tree["rrecs-pkg"].update(rrecs)
> +
>           return depend_tree
>
>       def generateDepTreeEvent(self, pkgs_to_build, task):

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


