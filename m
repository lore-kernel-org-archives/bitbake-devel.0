Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S2rDL-0003Hu-4E
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 22:37:35 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 13:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112979601"
Received: from unknown (HELO [10.255.15.102]) ([10.255.15.102])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 13:29:05 -0800
Message-ID: <4F4E98A1.8080707@linux.intel.com>
Date: Wed, 29 Feb 2012 13:29:05 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<e1a0da822720b804eb654572ae4cf470dbff3e63.1330523904.git.shane.wang@intel.com>
In-Reply-To: <e1a0da822720b804eb654572ae4cf470dbff3e63.1330523904.git.shane.wang@intel.com>
Subject: Re: [PATCH 08/32] Hob: image configuration page doesn't need dialogs any more
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
X-List-Received-Date: Wed, 29 Feb 2012 21:37:35 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/12 06:15, Shane Wang wrote:
> The dialog references are all in builder.py. We remove the useless "import" in image configuration page.
>
> Signed-off-by: Shane Wang<shane.wang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 ---
>   1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> index d3a9ffd..4083360 100644
> --- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> +++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
> @@ -28,9 +28,6 @@ from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox
>   from bb.ui.crumbs.hoblistmodel import RecipeListModel
>   from bb.ui.crumbs.hobpages import HobPage
>
> -from bb.ui.crumbs.hig import CrumbsDialog, BinbDialog, \
> -                             AdvancedSettingDialog, LayerSelectionDialog
> -
>   #
>   # ImageConfigurationPage
>   #

-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


