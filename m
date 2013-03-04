Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UCWT0-0002N0-Ak for bitbake-devel@lists.openembedded.org;
	Mon, 04 Mar 2013 15:34:14 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r24EPORb008528; Mon, 4 Mar 2013 14:25:24 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TUSMoyJntj7D; Mon,  4 Mar 2013 14:25:24 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r24EPHg5008521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 4 Mar 2013 14:25:20 GMT
Message-ID: <1362406644.29587.31.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrei Dinu <andrei.adrianx.dinu@intel.com>
Date: Mon, 04 Mar 2013 14:17:24 +0000
In-Reply-To: <1361531534-30884-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1361531534-30884-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] [HOB] replace tooltips with property windows
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
X-List-Received-Date: Mon, 04 Mar 2013 14:34:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-02-22 at 13:12 +0200, Andrei Dinu wrote:
> Yocto Bug #2248
> 
>  - extended cache_extra.py with the extra information needed in the
>  property windows.
>  - extended cooker.py so that the extra information in cache_extra.py could
>  be used.
>  - replaced in the builder.py the function that displayed the tooltips
>  with two functions that display property windows for recipes and packages
>  pages.
>  - advancedsettingsdialog.py : added information so that it would display
>  correctly in the information dialogs.
>  - propertydialog.py : new class aded for the property windows.
>    this covers functionality for : recipe selection page
>                                    package selection page
>                                    information dialogs
>  - simplesettingsdialog.py : added information so that it would display
>  correctly in the information dialogs.
>  - hoblistmodel.py : added information columns needed in order to display
>  the information in the property dialogs.
>  - hobwidget.py : added functionality for the information dialogs.
>  - imageconfigurationpage.py : added information so that it would display
>  correctly in the information dialogs.
>  - packageselectionpage.py : added event for the "All packages" tab and
>  passing the information needed to the function created in the builder.
>  - recipeselectionpage.py : added events for the "Package Groups" and "All
>  recipes" tabs and passing the information needed to the function created
>  in the builder.

Firstly, this is way too many changes in one patch. Please split them
out into a logical series. There is also a problem, I think, see below.

> Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
> ---
>  bitbake/lib/bb/cache_extra.py                      |    9 +
>  bitbake/lib/bb/cooker.py                           |    6 +
>  bitbake/lib/bb/ui/crumbs/builder.py                |   36 +-
>  .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 +-
>  bitbake/lib/bb/ui/crumbs/hig/propertydialog.py     |  347 ++++++++++++++++++++
>  .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   14 +-
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   23 +-
>  bitbake/lib/bb/ui/crumbs/hobwidget.py              |   26 +-
>  bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
>  bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   13 +-
>  bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   21 +-
>  11 files changed, 473 insertions(+), 36 deletions(-)
>  create mode 100644 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
> 
> diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
> index 40ba304..bf02bb7 100644
> --- a/bitbake/lib/bb/cache_extra.py
> +++ b/bitbake/lib/bb/cache_extra.py
> @@ -41,6 +41,9 @@ class HobRecipeInfo(RecipeInfoCommon):
>          self.license = self.getvar('LICENSE', metadata)
>          self.section = self.getvar('SECTION', metadata)
>          self.description = self.getvar('DESCRIPTION', metadata)
> +        self.homepage = self.getvar('HOMEPAGE', metadata)
> +        self.bugtracker = self.getvar('BUGTRACKER', metadata)
> +        self.prevision = self.getvar('PR', metadata)
>  
>      @classmethod
>      def init_cacheData(cls, cachedata):
> @@ -49,9 +52,15 @@ class HobRecipeInfo(RecipeInfoCommon):
>          cachedata.license = {}
>          cachedata.section = {}
>          cachedata.description = {}
> +        cachedata.homepage = {}
> +        cachedata.bugtracker = {}
> +        cachedata.prevision = {}
>  
>      def add_cacheData(self, cachedata, fn):
>          cachedata.summary[fn] = self.summary
>          cachedata.license[fn] = self.license
>          cachedata.section[fn] = self.section
>          cachedata.description[fn] = self.description
> +        cachedata.homepage[fn] = self.homepage
> +        cachedata.bugtracker[fn] = self.bugtracker
> +        cachedata.prevision[fn] = self.prevision


The above is all good, you're adding the data to an extra cache.

> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index f70a04f..f23eed0 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -571,8 +571,11 @@ class BBCooker:
>              lic = self.status.license[fn]
>              section = self.status.section[fn]
>              description = self.status.description[fn]
> +            homepage = self.status.homepage[fn]
> +            bugtracker = self.status.bugtracker[fn]
>              rdepends = self.status.rundeps[fn]
>              rrecs = self.status.runrecs[fn]
> +            prevision = self.status.prevision[fn]
>              inherits = self.status.inherits.get(fn, None)
>              if pn not in depend_tree["pn"]:
>                  depend_tree["pn"][pn] = {}
> @@ -583,6 +586,9 @@ class BBCooker:
>                  depend_tree["pn"][pn]["section"] = section
>                  depend_tree["pn"][pn]["description"] = description
>                  depend_tree["pn"][pn]["inherits"] = inherits
> +                depend_tree["pn"][pn]["homepage"] = homepage
> +                depend_tree["pn"][pn]["bugtracker"] = bugtracker
> +                depend_tree["pn"][pn]["revision"] = prevision
>  
>              if fnid not in seen_fnids:
>                  seen_fnids.append(fnid)

However in this function, you're assuming the extra cache is available.
I think this assumption has already been made by the code since
summary/homepage/description/license are in the extra cache too. Its not
documented however.

Can you please document that this function requires the extra cache to
be enabled?

Thanks,

Richard



