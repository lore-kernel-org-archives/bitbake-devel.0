Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBP15-0002Xh-CU
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 12:20:16 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 24 Mar 2012 04:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132690070"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2012 04:11:16 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1332584459.9740.508.camel@ted>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
	<a8df5fb9f370eb9024df8ff73b23f9c963c18377.1332567775.git.dongxiao.xu@intel.com>
	<1332584459.9740.508.camel@ted>
Date: Sat, 24 Mar 2012 19:09:05 +0800
Message-ID: <1332587345.1849.40.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 8/8] Hob: Set empty DISTRO if "defaultsetup" is selected
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
X-List-Received-Date: Sat, 24 Mar 2012 11:20:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-03-24 at 10:20 +0000, Richard Purdie wrote:
> On Sat, 2012-03-24 at 13:47 +0800, Dongxiao Xu wrote:
> > In Hob advanced setting, if "defaultsetup" is selected, we need to set
> > empty to DISTRO variable in bitbake server.
> > 
> > Otherwise, defaultsetup.conf will be parsed twice, causing TMPDIR and
> > its related variables mess up.
> > 
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
> > index 4b8aabc..a98a0bb 100644
> > --- a/lib/bb/ui/crumbs/hobeventhandler.py
> > +++ b/lib/bb/ui/crumbs/hobeventhandler.py
> > @@ -274,6 +274,8 @@ class HobHandler(gobject.GObject):
> >          self.server.runCommand(["setVariable", "IMAGE_FSTYPES", " ".join(image_fstypes).lstrip(" ")])
> >  
> >      def set_distro(self, distro):
> > +        if distro == "defaultsetup":
> > +            distro = ""
> >          self.server.runCommand(["setVariable", "DISTRO", distro])
> >  
> >      def set_package_format(self, format):
> 
> This worries me a little since you're doing something different to what
> the usual case would be (DISTRO not set at all). Is there not a way we
> can not set DISTRO at all so we ensure we're consistent?
> 
> What I'd like to avoid is a set of "hob-only" bugs caused by doing
> things slightly differently.

The logic should be:

   def set_distro(self, distro):
       if distro != "defaultsetup":
           self.server.runCommand(["setVariable", "DISTRO", distro])

Do you think this is reasonable?

Thanks,
Dongxiao

> 
> Cheers,
> 
> Richard
> 
> 
> 




