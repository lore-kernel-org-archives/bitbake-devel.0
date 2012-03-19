Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9jAs-0002e4-8x
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 21:27:26 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Mar 2012 13:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119249095"
Received: from bbernhar-mobl.amr.corp.intel.com (HELO [10.7.198.147])
	([10.7.198.147])
	by orsmga001.jf.intel.com with ESMTP; 19 Mar 2012 13:18:36 -0700
Message-ID: <4F67949C.8090308@linux.intel.com>
Date: Mon, 19 Mar 2012 13:18:36 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331887394.git.dongxiao.xu@intel.com>
	<39f4956a5fee435a865ac48052aa1bb4808e3ec7.1331887394.git.dongxiao.xu@intel.com>
In-Reply-To: <39f4956a5fee435a865ac48052aa1bb4808e3ec7.1331887394.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 1/3] Hob: reset the selection if switch to a new base image
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
X-List-Received-Date: Mon, 19 Mar 2012 20:27:26 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/03/12 01:48, Dongxiao Xu wrote:
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/hoblistmodel.py |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
> index caf31bc..6e6983c 100644
> --- a/lib/bb/ui/crumbs/hoblistmodel.py
> +++ b/lib/bb/ui/crumbs/hoblistmodel.py
> @@ -715,6 +715,7 @@ class RecipeListModel(gtk.ListStore):
>       def set_selected_image(self, img):
>           if img == None:
>               return
> +        self.reset()
>           path = self.find_path_for_item(img)
>           self.include_item(item_path=path,
>                             binb="User Selected",

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


