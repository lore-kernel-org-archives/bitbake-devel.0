Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SAWep-0007gk-37
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 02:17:39 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 21 Mar 2012 18:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121740020"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 18:08:43 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F6A7990.6060902@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
	<76678d0e7b33939ea902c26dd68a1279e293d3d7.1332288516.git.josh@linux.intel.com>
	<1332375865.1849.1.camel@dongxiao-osel>
	<4F6A7990.6060902@linux.intel.com>
Date: Thu, 22 Mar 2012 09:06:36 +0800
Message-ID: <1332378396.1849.2.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/5] ui/crumbs/hig: make the layer selection dialogue more closely match design
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
X-List-Received-Date: Thu, 22 Mar 2012 01:17:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-21 at 18:00 -0700, Joshua Lock wrote:
> On 21/03/12 17:24, Xu, Dongxiao wrote:
> > On Tue, 2012-03-20 at 17:15 -0700, Joshua Lock wrote:
> >> The layer dialogue design includes in-line remove/delete widgets next to
> >> the layer path in the tree view for all layers other than the meta layer as
> >> well as an in-line notice that the meta layer cannot be removed.
> >
> > Hi Josh,
> >
> > One thing just came to my mind is that, the meta-hob layer also could
> > not be removed since Hob GUI will use that.
> 
> Will Hob not work without the Hob layer? If that's the case I guess we 
> should disable removal of that also.
No, it won't work without meta-hob, it is a fundamental of building any
image. We need to disable the removal of that.

Thanks,
Dongxiao

> 
> Cheers,
> Joshua




