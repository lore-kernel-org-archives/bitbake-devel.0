Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S2xfL-0008PT-0u
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 05:30:55 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Feb 2012 20:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123518862"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2012 20:22:24 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F4E98CC.8010707@linux.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<79c20962f88a34c41344c8480aea6368f62c3241.1330523904.git.shane.wang@intel.com>
	<4F4E98CC.8010707@linux.intel.com>
Date: Thu, 01 Mar 2012 12:20:55 +0800
Message-ID: <1330575655.1785.59.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 27/32] Hob: add "OK" button to "BinbDialog"
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
X-List-Received-Date: Thu, 01 Mar 2012 04:30:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-29 at 13:29 -0800, Joshua Lock wrote:
> On 29/02/12 06:15, Shane Wang wrote:
> > From: Dongxiao Xu<dongxiao.xu@intel.com>
> >
> > For certain distributions, like FC16, it doesn't have close button in
> > sub-windows or dialogs. Therefore we need to add an "OK" button to
> > "BinbDialog" to close the dialog.
> 
> If it exists for closing the dialogue it should be a 'Close' button.

Thanks, it makes sense to use "close" button.

Thanks,
Dongxiao

> 
> Cheers,
> Joshua
> 
> >
> > Besides, let BinbDialog inherits the CrumbsDialog instead of gtk.Dialog
> >
> > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> > ---
> >   bitbake/lib/bb/ui/crumbs/hig.py |    4 ++--
> >   1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
> > index c5bd27a..20585b7 100644
> > --- a/bitbake/lib/bb/ui/crumbs/hig.py
> > +++ b/bitbake/lib/bb/ui/crumbs/hig.py
> > @@ -90,13 +90,13 @@ class CrumbsMessageDialog(CrumbsDialog):
> >   #
> >   # Brought-in-by Dialog
> >   #
> > -class BinbDialog(gtk.Dialog):
> > +class BinbDialog(CrumbsDialog):
> >       """
> >       A dialog widget to show "brought in by" info when a recipe/package is clicked.
> >       """
> >
> >       def __init__(self, title, content, parent=None):
> > -        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, None)
> > +        super(BinbDialog, self).__init__(title, parent, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT, ("OK", gtk.RESPONSE_OK))
> >
> >           self.set_position(gtk.WIN_POS_MOUSE)
> >           self.set_resizable(False)
> 




