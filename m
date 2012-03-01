Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S2xdy-0008MN-S5
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 05:29:31 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 20:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113293635"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 20:20:59 -0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F4E98D6.5030608@linux.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<706daef003dc2293e05fd03402ff74473a862fec.1330523904.git.shane.wang@intel.com>
	<4F4E98D6.5030608@linux.intel.com>
Date: Thu, 01 Mar 2012 12:19:31 +0800
Message-ID: <1330575571.1785.57.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 25/32] Hob: Add an extra 50M space if zypper is selected
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
X-List-Received-Date: Thu, 01 Mar 2012 04:29:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-02-29 at 13:29 -0800, Joshua Lock wrote:
> On 29/02/12 06:15, Shane Wang wrote:
> > From: Dongxiao Xu<dongxiao.xu@intel.com>
> >
> > An workaround to judge if zypper is selected, we will add an extra
> > 51200 KB to image size.
> 
> This sort of change sets alarms off, especially as we already have 
> variables in the core metadata to affect image size (one of which is 
> employed for this very reason) - are we not honouring those variables in 
> hob?

Thanks Josh for the suggestion.

The situation we are facing is that, Hob could only query the variable
values from bb.configuration.data, which doesn't include the
image_types.bbclass and rootfs_rpm.bbclass. Therefore it is not able to
get those variable's updated value in these classes.

Thanks,
Dongxiao

> 
> Cheers,
> Joshua
> >
> > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> > ---
> >   bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 ++
> >   1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> > index 5459743..89487c1 100755
> > --- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> > +++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
> > @@ -180,6 +180,8 @@ class PackageSelectionPage (HobPage):
> >           image_overhead_factor = self.builder.configuration.image_overhead_factor
> >           image_rootfs_size = self.builder.configuration.image_rootfs_size
> >           image_extra_size = self.builder.configuration.image_extra_size
> > +        if "zypper" in self.builder.configuration.selected_packages:
> > +            image_extra_size += 51200
> >           base_size = image_overhead_factor * selected_packages_size
> >           image_total_size = max(base_size, image_rootfs_size) + image_extra_size
> >           image_total_size_str = self._size_to_string(image_total_size)
> 




