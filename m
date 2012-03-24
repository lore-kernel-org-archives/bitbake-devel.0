Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBEzU-0001Sq-8P
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:37:56 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2012 17:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121097296"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:28:57 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <dda67dfb43279c2f605ce88a84c0adb9a83f9dfd.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
	<dda67dfb43279c2f605ce88a84c0adb9a83f9dfd.1332545580.git.josh@linux.intel.com>
Date: Sat, 24 Mar 2012 08:26:47 +0800
Message-ID: <1332548807.1849.6.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/9] lib/bb/ui/crumbs/hig: sort layers in Layer Selection dialogue
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
X-List-Received-Date: Sat, 24 Mar 2012 00:37:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-23 at 17:22 -0700, Joshua Lock wrote:
> The two layers which cannot be removed, meta and meta-hob, should be the
> first two items in the tree view.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
Acked-by: Dongxiao Xu <dongxiao.xu@intel.com>

> ---
>  lib/bb/ui/crumbs/hig.py |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 1db93ea..3a66e7c 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -803,8 +803,14 @@ class LayerSelectionDialog (CrumbsDialog):
>          table_layer.attach(scroll, 0, 10, 0, 1)
>  
>          layer_store = gtk.ListStore(gobject.TYPE_STRING)
> +        core_iter = None
>          for layer in layers:
> -            layer_store.set(layer_store.append(), 0, layer)
> +            if layer.endswith("/meta"):
> +                core_iter = layer_store.prepend([layer])
> +            elif layer.endswith("/meta-hob") and core_iter:
> +                layer_store.insert_after(core_iter, [layer])
> +            else:
> +                layer_store.append([layer])
>  
>          col1 = gtk.TreeViewColumn('Enabled')
>          layer_tv.append_column(col1)




