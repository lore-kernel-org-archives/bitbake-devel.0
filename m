Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDmQX-0004BU-V8
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Mar 2012 02:44:22 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Mar 2012 17:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127161799"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 30 Mar 2012 17:35:15 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F75DAEE.7040103@linux.intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
	<28ccf8cd2d23a4cfc8e94fa1ad089dd68334bf35.1333108781.git.dongxiao.xu@intel.com>
	<4F75DAEE.7040103@linux.intel.com>
Date: Sat, 31 Mar 2012 08:32:52 +0800
Message-ID: <1333153972.27459.6.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/7] Revert "lib/bb/ui/crumbs/hig: fix layers_changed test"
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
X-List-Received-Date: Sat, 31 Mar 2012 00:44:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-30 at 09:10 -0700, Joshua Lock wrote:
> 
> On 30/03/12 05:01, Dongxiao Xu wrote:
> > We do not sort the layer list, therefore when response_cb, the ordering
> > is also not needed.
> >
> > This reverts commit 71c1de347eef07a2059fc4544dc3cae090181f44.
> 
> This only makes sense if 3/7 is merged, correct?

Yes, I should have made the comment more clear.

Thanks,
Dongxiao

> 
> Cheers,
> Joshua
> 
> > ---
> >   lib/bb/ui/crumbs/hig.py |    5 +----
> >   1 files changed, 1 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> > index 9a38bc0..0ac4496 100644
> > --- a/lib/bb/ui/crumbs/hig.py
> > +++ b/lib/bb/ui/crumbs/hig.py
> > @@ -958,10 +958,7 @@ class LayerSelectionDialog (CrumbsDialog):
> >               layers.append(model.get_value(it, 0))
> >               it = model.iter_next(it)
> >
> > -        orig_layers = sorted(self.layers)
> > -        layers.sort()
> > -
> > -        self.layers_changed = (orig_layers != layers)
> > +        self.layers_changed = (self.layers != layers)
> >           self.layers = layers
> >
> >       """
> 




