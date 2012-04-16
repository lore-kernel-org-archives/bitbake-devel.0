Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SJopP-0000xx-4X
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 18:30:59 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 16 Apr 2012 09:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="133085070"
Received: from unknown (HELO [10.7.198.151]) ([10.7.198.151])
	by orsmga002.jf.intel.com with ESMTP; 16 Apr 2012 09:21:33 -0700
Message-ID: <4F8C470C.9060409@linux.intel.com>
Date: Mon, 16 Apr 2012 09:21:32 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1334570665.git.limingx.l.an@intel.com>
	<cb025c92d54ad2f20abc15f81d89fb26bf7dd65c.1334570665.git.limingx.l.an@intel.com>
In-Reply-To: <cb025c92d54ad2f20abc15f81d89fb26bf7dd65c.1334570665.git.limingx.l.an@intel.com>
Subject: Re: [PATCH 1/1] Hob: fixed a little view issue about package selection page
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
X-List-Received-Date: Mon, 16 Apr 2012 16:30:59 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/12 03:09, Liming An wrote:
> In package selection page, treeview cell data callback function not cover the 'else' case, so parent item will render the pervious value.
>
> Signed-off-by: Liming An<limingx.l.an@intel.com>

Good catch, thanks!

Signed-off-by: Joshua Lock<josh@linux.intel.com>

> ---
>   bitbake/lib/bb/ui/crumbs/hobwidget.py |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> index a42cdec..8cbd6aa 100644
> --- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
> +++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
> @@ -175,7 +175,8 @@ class HobViewTable (gtk.VBox):
>           if binb:
>               bin = binb.split(', ')
>               cell.set_property('text', bin[0])
> -
> +        else:
> +            cell.set_property('text', "")
>           return True
>
>       def set_model(self, tree_model):

-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


