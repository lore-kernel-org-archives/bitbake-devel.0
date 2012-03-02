Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S3HOf-0000tv-0G
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 02:35:01 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 01 Mar 2012 17:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123959550"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 17:26:28 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
In-Reply-To: <1330615422.31767.13.camel@ted>
References: <cover.1330523904.git.shane.wang@intel.com>
	<93713faf8701668260d1822f9be8c8e6deaafc03.1330523904.git.shane.wang@intel.com>
	<1330615422.31767.13.camel@ted>
Date: Fri, 02 Mar 2012 09:24:58 +0800
Message-ID: <1330651498.5426.5.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 32/32] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Fri, 02 Mar 2012 01:35:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-01 at 15:23 +0000, Richard Purdie wrote:
> On Wed, 2012-02-29 at 22:15 +0800, Shane Wang wrote:
> > From: Dongxiao Xu <dongxiao.xu@intel.com>
> > 
> > Currently for non-x86 architecture, there are un-resolved dependency
> > issue when generate universe dependency tree. Therefore disable the
> > handling of "NoProvider" event in Hob to enable the build for non-x86
> > architectures. After we resolved the dependency for universe, we still
> > need to handle this event in Hob.
> > 
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++------------
> >  1 files changed, 20 insertions(+), 17 deletions(-)
> 
> Shouldn't you be using world and not universe for this?
> 
> I suspect world shouldn't show the NoProvider issues?

Unluckily world also has the same issue, since
core-image-minimal-initramfs and initramfs-live-install recipes are all
contained in world area.

Thanks,
Dongxiao

> 
> Cheers,
> 
> Richard
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




