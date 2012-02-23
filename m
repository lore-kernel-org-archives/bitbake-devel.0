Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZEX-0001Ez-Ja
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 15:01:22 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Feb 2012 05:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="111196132"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Feb 2012 05:52:58 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
In-Reply-To: <cover.1330004101.git.dongxiao.xu@intel.com>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
Date: Thu, 23 Feb 2012 21:51:41 +0800
Message-ID: <1330005101.8145.54.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Subject: Re: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Thu, 23 Feb 2012 14:01:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The [patch 1/1] exceeds the mailing list's limit.
Please directly visit
http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=dxu4/hob2&id=e60627675eb47a3605905921b5208f5840a21907
to see the change.

Thanks,
Dongxiao

On Thu, 2012-02-23 at 21:48 +0800, Dongxiao Xu wrote:
> Hi Richard,
> 
> This pull request is a new implementation for Human Oriented Builder, please help to review and pull.
> 
> Changes from previous pull requests:
>  - Re-implemented a lot of code according to Belen's new GUI design.
> 
> Note that this pull request depends on the following pull requests:
>  - hob2-bitbake-changes
>  - hob2-oecore-changes
> 
> Thanks,
> Dongxiao
> 
> 
> The following changes since commit cec8b6e6c33582be660dd35c6050efc3f28e6baa:
> 
>   runqueue: fire sceneQueueTaskStarted event when a setscene queue starts (2012-02-23 21:04:49 +0800)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib dxu4/hob2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2
> 
> Dongxiao Xu (1):
>   Hob: A new implemetation for Human Oriented Builder
> 
>  bitbake/lib/bb/ui/crumbs/builddetailspage.py       |  110 ++
>  bitbake/lib/bb/ui/crumbs/builder.py                |  873 +++++++++++++++
>  bitbake/lib/bb/ui/crumbs/hobcolor.py               |   35 +
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |  765 ++++++++++++++
>  bitbake/lib/bb/ui/crumbs/hobpages.py               |   87 ++
>  bitbake/lib/bb/ui/crumbs/hobwidget.py              |  805 ++++++++++++++
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |  358 +++++++
>  bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  294 +++++
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |  226 ++++
>  bitbake/lib/bb/ui/crumbs/progressbar.py            |   52 +
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |  221 ++++
>  bitbake/lib/bb/ui/crumbs/template.py               |  180 ++++
>  bitbake/lib/bb/ui/icons/images/images_display.png  |  Bin 0 -> 6898 bytes
>  bitbake/lib/bb/ui/icons/images/images_hover.png    |  Bin 0 -> 7051 bytes
>  bitbake/lib/bb/ui/icons/indicators/alert.png       |  Bin 0 -> 3954 bytes
>  .../lib/bb/ui/icons/indicators/confirmation.png    |  Bin 0 -> 5789 bytes
>  bitbake/lib/bb/ui/icons/indicators/denied.png      |  Bin 0 -> 3955 bytes
>  bitbake/lib/bb/ui/icons/indicators/error.png       |  Bin 0 -> 6482 bytes
>  bitbake/lib/bb/ui/icons/indicators/issues.png      |  Bin 0 -> 4549 bytes
>  bitbake/lib/bb/ui/icons/indicators/refresh.png     |  Bin 0 -> 5250 bytes
>  bitbake/lib/bb/ui/icons/indicators/tick.png        |  Bin 0 -> 4563 bytes
>  bitbake/lib/bb/ui/icons/info/info_display.png      |  Bin 0 -> 4760 bytes
>  bitbake/lib/bb/ui/icons/info/info_hover.png        |  Bin 0 -> 4847 bytes
>  bitbake/lib/bb/ui/icons/layers/layers_display.png  |  Bin 0 -> 5326 bytes
>  bitbake/lib/bb/ui/icons/layers/layers_hover.png    |  Bin 0 -> 5390 bytes
>  .../lib/bb/ui/icons/packages/packages_display.png  |  Bin 0 -> 7188 bytes
>  .../lib/bb/ui/icons/packages/packages_hover.png    |  Bin 0 -> 7308 bytes
>  bitbake/lib/bb/ui/icons/recipe/recipe_display.png  |  Bin 0 -> 4873 bytes
>  bitbake/lib/bb/ui/icons/recipe/recipe_hover.png    |  Bin 0 -> 5003 bytes
>  .../lib/bb/ui/icons/settings/settings_display.png  |  Bin 0 -> 6076 bytes
>  .../lib/bb/ui/icons/settings/settings_hover.png    |  Bin 0 -> 6269 bytes
>  .../bb/ui/icons/templates/templates_display.png    |  Bin 0 -> 5651 bytes
>  .../lib/bb/ui/icons/templates/templates_hover.png  |  Bin 0 -> 5791 bytes
>  lib/bb/ui/crumbs/configurator.py                   |  346 ------
>  lib/bb/ui/crumbs/hig.py                            |  589 ++++++++++-
>  lib/bb/ui/crumbs/hobeventhandler.py                |  586 ++++++----
>  lib/bb/ui/crumbs/hobprefs.py                       |  335 ------
>  lib/bb/ui/crumbs/layereditor.py                    |  153 ---
>  lib/bb/ui/crumbs/progress.py                       |   20 -
>  lib/bb/ui/crumbs/runningbuild.py                   |   55 +-
>  lib/bb/ui/crumbs/tasklistmodel.py                  |  620 -----------
>  lib/bb/ui/hob.py                                   | 1115 +-------------------
>  lib/bb/ui/uihelper.py                              |   42 +
>  43 files changed, 5065 insertions(+), 2802 deletions(-)
>  create mode 100755 bitbake/lib/bb/ui/crumbs/builddetailspage.py
>  create mode 100755 bitbake/lib/bb/ui/crumbs/builder.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/hobcolor.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/hoblistmodel.py
>  create mode 100755 bitbake/lib/bb/ui/crumbs/hobpages.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/hobwidget.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
>  create mode 100755 bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>  create mode 100755 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/progressbar.py
>  create mode 100755 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
>  create mode 100644 bitbake/lib/bb/ui/crumbs/template.py
>  create mode 100644 bitbake/lib/bb/ui/icons/images/images_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/images/images_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/alert.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/confirmation.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/denied.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/error.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/issues.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/refresh.png
>  create mode 100644 bitbake/lib/bb/ui/icons/indicators/tick.png
>  create mode 100644 bitbake/lib/bb/ui/icons/info/info_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/info/info_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/layers/layers_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/layers/layers_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/packages/packages_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/packages/packages_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/recipe/recipe_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/recipe/recipe_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/settings/settings_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/settings/settings_hover.png
>  create mode 100644 bitbake/lib/bb/ui/icons/templates/templates_display.png
>  create mode 100644 bitbake/lib/bb/ui/icons/templates/templates_hover.png
>  delete mode 100644 lib/bb/ui/crumbs/configurator.py
>  delete mode 100644 lib/bb/ui/crumbs/hobprefs.py
>  delete mode 100644 lib/bb/ui/crumbs/layereditor.py
>  delete mode 100644 lib/bb/ui/crumbs/progress.py
>  delete mode 100644 lib/bb/ui/crumbs/tasklistmodel.py
>  mode change 100644 => 100755 lib/bb/ui/hob.py
> 




