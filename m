Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rEC-0003TJ-CW
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:38:28 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112980053"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:58 -0800
Message-ID: <4F4E98D6.5030608@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:58 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<706daef003dc2293e05fd03402ff74473a862fec.1330523904.git.shane.wang@intel.com>
In-Reply-To: <706daef003dc2293e05fd03402ff74473a862fec.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 25/32] Hob: Add an extra 50M space if zypper is selected
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
X-List-Received-Date: Wed, 29 Feb 2012 21:38:28 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> From: Dongxiao Xu<dongxiao.xu@intel.com>
>
> An workaround to judge if zypper is selected, we will add an extra
> 51200 KB to image size.

This sort of change sets alarms off, especially as we already have 
variables in the core metadata to affect image size (one of which is 
employed for this very reason) - are we not honouring those variables in 
hob?

Cheers,
Joshua
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> ---
>   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> index 5459743..89487c1 100755
> --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> @@ -180,6 +180,8 @@ class PackageSelectionPage (HobPage):
>           image_overhead_factor = self.builder.configuration.image_overhead_factor
>           image_rootfs_size = self.builder.configuration.image_rootfs_size
>           image_extra_size = self.builder.configuration.image_extra_size
> +        if "zypper" in self.builder.configuration.selected_packages:
> +            image_extra_size += 51200
>           base_size = image_overhead_factor * selected_packages_size
>           image_total_size = max(base_size, image_rootfs_size) + image_extra_size
>           image_total_size_str = self._size_to_string(image_total_size)

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


