Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHk0E-0000on-8T for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 00:57:35 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMmBsk001437;
	Tue, 10 Apr 2012 23:48:11 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01063-06; Tue, 10 Apr 2012 23:48:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMm2K5001431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 23:48:04 +0100
Message-ID: <1334098082.10826.78.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Shane Wang <shane.wang@intel.com>
Date: Tue, 10 Apr 2012 23:48:02 +0100
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/21] [Resend] Hob fixes and cleanups
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
X-List-Received-Date: Tue, 10 Apr 2012 22:57:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-04-09 at 22:09 +0800, Shane Wang wrote:
> Those patches fix the following:
>   - the UI bug to fade out the entry in the "Included" page when it is removed
>   - add and correct tooltips reviewed by Scott
>   - clean up the code and maximize reusage, for exception handling
>   - misc
> 
> The following changes since commit 190f6d791d51aaa4cfb9f1cf932bc205ff674fb5:
> 
>   runqemu-internal: Add console=tty for qemuppc and NFS (2012-04-06 01:12:47 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib shane/hob-fixes-continue
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-continue
> 
> Liming An (4):
>   Hob: add fadeout display effection for recipe view include page
>   Hob: add fadeout display effection for package view include page
>   Hob: Add the tooltips for recipe view page as request
>   Hob:Fixed some incorrect values of Build configuration tab
> 
> Shane Wang (17):
>   Hob: fix version check - Hob can run on pygtk 2.21.0
>   Hob: correct indent
>   Hob: clean up and unify the steps for new build to call
>     initiate_new_build_async()
>   Hob: clean up and unify the steps for CONFIG_UPDATE to call
>     update_config_async()
>   Hob: clean up and unify the steps for RCPPKGINFO_POPULATING to call
>     populate_recipe_package_info_async()
>   Hob: clean up and unify the steps for PACKAGE_GENERATING and
>     FAST_IMAGE_GENERATING to call generate_packages_async() and
>     fast_generate_image_async()
>   Hob: clean up and unify the steps for IMAGE_GENERATING to call
>     generate_image_async()
>   Hob: clean up to call clear_busy() in hobeventhandler.py
>   Hob: clean up and unify get_parameters() to be get_parameters_sync()
>   Hob: clean up request_package_info_async()
>   Hob: clean up cancel_build()
>   Hob: clean up generate_configuration()
>   Hob: clean up and reword stop_parse()
>   Hob: tooltip change for "Build image" button
>   Hob: add tooltips into image details screen
>   Hob: forget selected_recipes and selected_packages after users change
>     the machine
>   Hob: show those appliable buttons on the image details page only

I've merged these apart from the version change for which I took
Joshua's patches.

I have to say that cleanups at this point in the cycle are less than
ideal, I've only taken them since they were unit tested with the rest of
this and I can't really take one without the other.

Also, there were patch rejects on the fadeout patches and I had to merge
things due to taking other patches so please check the final result.

Cheers,

Richard



