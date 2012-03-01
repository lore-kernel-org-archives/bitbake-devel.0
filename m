Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S38B0-0001OC-CP for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:44:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FWb3c018113;
	Thu, 1 Mar 2012 15:32:37 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17436-07; Thu,  1 Mar 2012 15:32:33 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q21FWTbM018107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Mar 2012 15:32:29 GMT
Message-ID: <1330615952.31767.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Thu, 01 Mar 2012 15:32:32 +0000
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Liming An <limingx.l.an@intel.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Thu, 01 Mar 2012 15:44:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-29 at 22:11 +0800, Shane Wang wrote:
> The following patches are going to fix the following problems:
> 
> * Enable HobNotebook to make notebook more like the design video;
> * Improve and enhance the GUI;
> * Rebase the patches Josh has sent out before with the title "Hob tweaks";
> * Address some tricky issues we found in the bitbake;
> * Revise Hob according to the comments on the previous patch set;
> * Fix some bugs we found when testing Hob;
> * and some temporary walkarounds we have to find a way to solve in Hob or in the bitbake later.
> 
> The following changes since commit 927bec5f72230be4f2452d9ef5a747b2c00cb781:
> 
>   bitbake.conf: Create a new filter variable BB_HASHCONFIG_WHITELIST (2012-02-27 20:10:41 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob2-v0.68
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.68
> 
> Dongxiao Xu (10):
>   command.py: remove the resolve parameter in generateTargetsTree
>   cooker.py: Fix a bug due to variable name
>   cooker: fix calculating of depends and rdepends
>   Hob(crumbs/hoblistmodel.py): Fix recipe's populate() function
>   Hob(crumbs/hoblistmodel.py): Add mapping for rprovides and pkg
>   **** Hob: Add an extra 50M space if zypper is selected
>   **** Hob: add "OK" button to "BinbDialog"
>   Hob: Fix pressing "stop" build
>   runqueue.py: initialize rqexe at RunQueue's init function
>   **** Hob: Disable the handling of "NoProvider" event
> 
> Shane Wang (22):
>   Hob: make HobViewTable more general in hob and make the image
>     selection dialog and the image details page reuse it.
>   Hob: avoid the image selection dialog to walk through all directories
>     and its sub-directories, when users click "My images".
>   Hob: cleanup those class methods in HobWidget
>   Hob: fixed the issue in the brought-in-by dialog.
>   Hob: include hddimg and iso into image types.
>   **** Hob: implement a self-defined notebook visual component for Hob
>   **** Hob: use HobNotebook to enable a notebook in build details page
>   Hob: image configuration page doesn't need dialogs any more
>   Hob: fix a bug in builder.configuration.curr_mach
>   **** Hob: add ignore_all_errors to avoid showing error dialog multiple
>     times
>   Hob: make the image configuration page not to flash the progress bar
>   Hob: enable indicators on the "Included" tab in the recipe selection
>     page and the package selection page
>   crumbs: Factor common dialogue configuration out
>   crumbs/builder: use the name Hob consistently
>   crumbs: move towards more standard dialogue spacing
>   crumbs: fix button order in several dialogues
>   hig: try to avoid setting explicit dialogue sizes
>   crumbs/hig: tweak UI and layout of LayerSelectionDialog
>   Hob(crumbs/builder.py): remove the code commented out in the
>     builder.py
>   Hob: fix a bug that the image size is shown incorrectly in the image
>     details page.
>   **** Hob: allow users to setup the proxy
>   Hob(crumbs/builder.py): adjust the main window's position and ignore
>     the case lower than 1024x768.

I pulled the above except where marked with "****". In those cases there
is feedback on the patches which needs discussion. 

I removed one piece of debug Joshua noticed and had to manually tweak
one patch to get it to apply due to other patches not being applied.
I'll expect an new pull request for the remaining patches.

Cheers,

Richard



