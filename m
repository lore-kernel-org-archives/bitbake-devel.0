Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 6FF9877219
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 00:20:02 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 28 Feb 2016 16:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,518,1449561600"; d="scan'208";a="754866257"
Received: from gtan23-mobl3.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.165.53])
	by orsmga003.jf.intel.com with ESMTP; 28 Feb 2016 16:20:01 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Brian Avery <brian.avery@intel.com>
Date: Mon, 29 Feb 2016 13:19:59 +1300
Message-ID: <1834496.nEVGTzEO0a@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.3.5-300.fc23.x86_64; KDE/4.14.17; x86_64; ;
	)
In-Reply-To: <c8247b2bbb3e6db288f2c6be6c1c777d7ddd599f.1456610242.git.avery.brian@gmail.com>
References: <cover.1456610242.git.avery.brian@gmail.com>
	<c8247b2bbb3e6db288f2c6be6c1c777d7ddd599f.1456610242.git.avery.brian@gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] hob: removal of hob ui and associated ui files
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Feb 2016 00:20:04 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Brian,

On Sat, 27 Feb 2016 14:00:52 brian avery wrote:
> From: bavery <brian.avery@intel.com>
> 
> Signed-off-by: bavery <brian.avery@intel.com>
> ---
>  lib/bb/ui/crumbs/builddetailspage.py           |  437 -------
>  lib/bb/ui/crumbs/builder.py                    | 1534
> ------------------------ lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
> |  341 ------
>  lib/bb/ui/crumbs/hig/deployimagedialog.py      |  219 ----
>  lib/bb/ui/crumbs/hig/imageselectiondialog.py   |  172 ---
>  lib/bb/ui/crumbs/hig/parsingwarningsdialog.py  |  163 ---
>  lib/bb/ui/crumbs/hig/proxydetailsdialog.py     |   90 --
>  lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   51 -
>  lib/bb/ui/crumbs/hig/saveimagedialog.py        |  159 ---
>  lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  891 --------------
>  lib/bb/ui/crumbs/hobeventhandler.py            |  645 ----------
>  lib/bb/ui/crumbs/hoblistmodel.py               |  903 --------------
>  lib/bb/ui/crumbs/hobpages.py                   |  128 --
>  lib/bb/ui/crumbs/imageconfigurationpage.py     |  561 ---------
>  lib/bb/ui/crumbs/imagedetailspage.py           |  705 -----------
>  lib/bb/ui/crumbs/packageselectionpage.py       |  355 ------
>  lib/bb/ui/crumbs/recipeselectionpage.py        |  335 ------
>  lib/bb/ui/crumbs/sanitycheckpage.py            |   85 --
>  lib/bb/ui/crumbs/utils.py                      |   34 -
>  lib/bb/ui/hob.py                               |  109 --
>  20 files changed, 7917 deletions(-)
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/builddetailspage.py
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/builder.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/parsingwarningsdialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/proxydetailsdialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hobeventhandler.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/hoblistmodel.py
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/hobpages.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
>  delete mode 100755 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/sanitycheckpage.py
>  delete mode 100644 bitbake/lib/bb/ui/crumbs/utils.py
>  delete mode 100755 bitbake/lib/bb/ui/hob.py

A couple of things:

1) Please add a commit message - feel free to cut and paste from my earlier 
email to the list regarding removing Hob.

2) bin/image-writer isn't removed by this and uses some of the modules in 
lib/bb/ui/crumbs/. I've sent a reply to the Hob removal thread with the 
details because it probably merits a wider discussion.

3) There are other bits we'd want to remove for a full cleanup (including some 
code in cooker and command.py) but we can do that separately.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

