Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SKAQ1-00024E-7v
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 17:34:13 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 17 Apr 2012 08:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="90052992"
Received: from unknown (HELO [10.255.12.138]) ([10.255.12.138])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Apr 2012 08:24:45 -0700
Message-ID: <4F8D8B3D.6040001@linux.intel.com>
Date: Tue, 17 Apr 2012 08:24:45 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Joshua Lock <josh@linux.intel.com>
References: <1334675945-11802-1-git-send-email-josh@linux.intel.com>
In-Reply-To: <1334675945-11802-1-git-send-email-josh@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] lib/bb/ui/crumbs/recipeselectionpage: fix type availabel->available
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
X-List-Received-Date: Tue, 17 Apr 2012 15:34:13 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes the typo raised in YOCTO #2229

https://bugzilla.yoctoproject.org/show_bug.cgi?id=2229

It would be great to merge this before any releases are tagged as this 
typo is visible in a tooltip.

Cheers,
Joshua

On 17/04/12 08:19, Joshua Lock wrote:
> Signed-off-by: Joshua Lock<josh@linux.intel.com>
> ---
>   lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
> index fff8a88..7336da9 100755
> --- a/lib/bb/ui/crumbs/recipeselectionpage.py
> +++ b/lib/bb/ui/crumbs/recipeselectionpage.py
> @@ -99,7 +99,7 @@ class RecipeSelectionPage (HobPage):
>                         }]
>           }, {
>            'name'    : 'Tasks',
> -         'tooltip' : 'All tasks availabel in the Yocto Project',
> +         'tooltip' : 'All tasks available in the Yocto Project',
>            'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
>            'columns' : [{
>                          'col_name' : 'Task name',

-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


