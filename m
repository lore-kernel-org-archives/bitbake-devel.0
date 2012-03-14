Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S7uAL-0003eB-HK
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 20:47:21 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Mar 2012 12:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121044769"
Received: from unknown (HELO [10.7.198.50]) ([10.7.198.50])
	by orsmga002.jf.intel.com with ESMTP; 14 Mar 2012 12:38:03 -0700
Message-ID: <4F60F39A.5030304@linux.intel.com>
Date: Wed, 14 Mar 2012 12:38:02 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<479f95f339a42d2d63d652e96f6e1e9d63e9f60d.1331716896.git.dongxiao.xu@intel.com>
In-Reply-To: <479f95f339a42d2d63d652e96f6e1e9d63e9f60d.1331716896.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 01/11] Hob: add "Close" button to "BinbDialog"
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
X-List-Received-Date: Wed, 14 Mar 2012 19:47:22 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 02:26, Dongxiao Xu wrote:
> For certain distributions, like FC16, it doesn't have close button in
> sub-windows or dialogs. Therefore we need to add an "Close" button to
> "BinbDialog" to close the dialog.
>
> Besides, let BinbDialog inherits the CrumbsDialog instead of gtk.Dialog
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

I think we want to switch to persistent tooltips for this functionality 
but until that change is ready this is a good patch.

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/hig.py |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index e175a2a..28b7eef 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -94,13 +94,13 @@ class CrumbsMessageDialog(CrumbsDialog):
>   #
>   # Brought-in-by Dialog
>   #
> -class BinbDialog(gtk.Dialog):
> +class BinbDialog(CrumbsDialog):
>       """
>       A dialog widget to show "brought in by" info when a recipe/package is clicked.
>       """
>
>       def __init__(self, title, content, parent=None):
> -        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, None)
> +        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("Close", gtk.RESPONSE_CLOSE))
>
>           self.set_position(gtk.WIN_POS_MOUSE)
>           self.set_resizable(False)

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


