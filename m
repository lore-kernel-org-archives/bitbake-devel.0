Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SG0IT-0007gM-OD
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Apr 2012 05:57:13 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Apr 2012 20:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="125885757"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 05 Apr 2012 20:47:59 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>
In-Reply-To: <CBA223C9.C4FB%belen.barros.pena@intel.com>
References: <CBA223C9.C4FB%belen.barros.pena@intel.com>
Date: Fri, 06 Apr 2012 11:45:24 +0800
Message-ID: <1333683924.12347.4.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 09/10] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Fri, 06 Apr 2012 03:57:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-04-04 at 23:21 +0800, Barros Pena, Belen wrote:
> Thanks for explaining, Shane. I now understand why you are doing it, but
> people using Hob will not have the benefit of your explanation. They will
> just see they selected a base image, made a small change to that base
> image and when they go back to the Image configuration screen, Hob has
> changed the base image they selected of its own accord.

Though the base image is changed to "Create your own image", however all
the contents in the base image (except those customized) are still
there. If user changes recipes/packages, actually they are trying to
create their own image not a base image.

> 
> Could the template have some "hidden" information indicating if a base
> image has been customised and therefore the default contents of the base
> image should be ignored and replaced with the remembered recipes and
> packages? This way the template would still work, but Hob users will still
> see their selected base image.

Base image is also a recipe, so we could not ignore its related recipes,
unless we switch to a new one whose dependency recipes/packages are
None. Otherwise, it will change the core base of the Hob logic.

Thanks,
Dongxiao

> 
> Belen
> 
> On 04/04/2012 13:58, "Wang, Shane" <shane.wang@intel.com> wrote:
> 
> >Barros Pena, Belen wrote on 2012-04-03:
> >
> >> From the design side of things, I am not sure this is a good idea. I've
> >> explicitly selected 'base image x'. If I then customise it, I still
> >>think
> >> I am working on 'base image x'. I might not understand why my selection
> >>of
> >> base image has been changed automatically. In general, it is not a good
> >> idea to have software that changes things I do of its own accord. Such
> >> behaviours undermine the sense of control users should have when
> >> interacting with software.
> >> 
> >> Cheers
> >> 
> >> Belen
> >> 
> >
> >What we want is to change the item in the base image combo. The target
> >image is still based on the base image the user selected plus delta.
> >We have the strict definition for the predefined base images. For
> >instance, sato includes 300 recipes.
> >An image including 299 recipes is not called sato but your own image
> >(say, sato-minus)
> >
> >The reason why we do that is because for templates, we will remember the
> >item in the image combo as the base image in some bb file, and we also
> >remember what we selected for the recipes and the packages. However, the
> >base image covers all of them by default and because of that, bitbake
> >can't recognize the delta and will include all (300 recipes), which
> >causes the wrong behavior.
> >
> >--
> >Shane
> 




