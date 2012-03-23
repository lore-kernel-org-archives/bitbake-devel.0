Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SAvYG-0005uY-Fw
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 04:52:32 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 Mar 2012 20:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="120750615"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 22 Mar 2012 20:43:34 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1332459199.9740.374.camel@ted>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
	<4F6A7956.1040400@linux.intel.com>
	<1332379299.1849.14.camel@dongxiao-osel>
	<4F6BA888.5090608@linux.intel.com>  <1332459199.9740.374.camel@ted>
Date: Fri, 23 Mar 2012 11:41:25 +0800
Message-ID: <1332474085.1765.3.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/17][PULL] Hob: Bunch of bug fixes
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
X-List-Received-Date: Fri, 23 Mar 2012 03:52:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-22 at 23:33 +0000, Richard Purdie wrote:
> On Thu, 2012-03-22 at 15:32 -0700, Joshua Lock wrote:
> > On 21/03/12 18:21, Xu, Dongxiao wrote:
> > > On Wed, 2012-03-21 at 17:59 -0700, Joshua Lock wrote:
> > >>
> > >> On 21/03/12 05:55, Dongxiao Xu wrote:
> > >>> Hi Richard,
> > >>>
> > >>> This pull request is Hob related bug fixes. Please help to review and pull.
> > >>>
> > >>> Thanks,
> > >>> Dongxiao
> > >>>
> > >>> The following changes since commit d595960fea0988df9004d927bc2ec3439540dd9c:
> > >>>
> > >>>     Hob: save CONF_VERSION and LCONF_VERSION into template (2012-03-20 14:39:45 +0000)
> > >>>
> > >>> are available in the git repository at:
> > >>>     git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
> > >>>     http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix
> > >>>
> > >>> Dongxiao Xu (14):
> > >>>     Hob: Still use initcmd != None as the if judgement
> > >>>     Hob: Remove split model in GTK Hob
> > >>>     cooker: terminate each process when quitting recipe parsing
> > >>>     Hob: change package classes selection GUI
> > >>>     Hob: Change template button name from "Template" to "Templates"
> > >>
> > >> These all look fine.
> > >>
> > >>>     command.py: Change parseConfigurationFiles API from async to sync
> > >>>     process.py: Increase the timeout value for polling commands
> > >>>     Hob: Change parseConfigurationFiles API usage
> > >>
> > >> Can you explain some of the reasoning behind this set of changes? If the
> > >> command truly belongs as an asynchronous one I'm not sure why we need to
> > >> increase the timeout duration specifically for it.
> > >>
> > >>>     Hob: Fix the workaround to get image types
> > >
> > > Hi Josh,
> > >
> > > Actually the above three patches are preparations for this commit: "Hob:
> > > Fix the workaround to get image types".
> > >
> > > The background is that, we need to add extra inherits of
> > > image_types.bbclass before parsing configuration files and getting
> > > variables values. Therefore the modified code piece is something like:
> > >
> > > def get_parameters(self):
> > >      self.init_cooker()
> > >      self.set_extra_inherits("image_types")
> > >      self.parse_config()
> > >
> > >      self.server.runCommand(["getVariable", "MACHINE"])
> > >      ...
> > >
> > > We can see from above code is that, the parse_config locates between two
> > > SYNC commands (set_extra_inherits and getVariable). Therefore we also
> > > need the parse_config to be a SYNC command.
> > >
> > > As far as I know the parseConfigurationFiles API doesn't cost too much
> > > time (should less than 1s), so that's the reason why I change it to SYNC
> > > mode.
> > >
> > > The increase of time duration for parseConfigurationFiles is that, the
> > > process server use pipe mode to pass object (function) from one to
> > > another. The original 0.5 second timeout isn't enough for transferring
> > > "parseConfigurationFiles" object, the phenomenon is that on certain
> > > machines, the runCommand result is messed up with wrong values. This
> > > issue doesn't exist with xmlrpc server.
> > 
> > OK, I understand what you're trying to achieve. I'm afraid I'm not 
> > convinced that we need to make such an invasive change though. Any 
> > reason we can't re-order the initialisation so that everything is done 
> > after the async parseConfigurationFiles?
> > 
> > I'm nervous of us pushing the 0.5s->1s change this late in the cycle. 
> > Have you any indication of whether it affects builds using knotty?
> > 
> > Just to be clear I think Richard needs to ack/nack this change to core 
> > BitBake. The Hob changes related to it are fine by me.
> 
> Having a sync command blocking the system for over 1 second isn't right.
> Sync commands are meant to be fast (say 0.01s max) and this obviously
> isn't.
> 
> I'm rather concerned about this and it suggests something is wrong with
> hob's init/state code to be honest.

The above case is not in current Hob code, I added it only after I
change parseConfigurationFiles to SYNC mode. There is no problem with
current Hob's init code.

> 
> My suggestion would be to add an extra parameter to self.parse_config()
> so you can set other classes to inherit (and variables to set). You will
> still have to then read MACHINE later but I think that is reasonable.

I will try to implement it in ASYNC mode. 

Thanks,
Dongxiao

> 
> Cheers,
> 
> Richard
> 
> 
> 




