Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S83vf-0002wy-BG
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 07:12:51 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 14 Mar 2012 23:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="77767376"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 14 Mar 2012 23:04:03 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>
In-Reply-To: <4F60F38B.40506@linux.intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<c30b412003be68dd9c060e2d227f85232e4492ff.1331716896.git.dongxiao.xu@intel.com>
	<4F60F38B.40506@linux.intel.com>
Date: Thu, 15 Mar 2012 14:02:08 +0800
Message-ID: <1331791328.1855.21.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 04/11] Hob: Fix the image installation dependency
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
X-List-Received-Date: Thu, 15 Mar 2012 06:12:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-03-14 at 12:37 -0700, Joshua Lock wrote:
> 
> On 14/03/12 02:26, Dongxiao Xu wrote:
> > Get the image installation content from rdepends and rrecommends
> > variables.
> >
> > Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
> > ---
> >   lib/bb/ui/crumbs/hoblistmodel.py |    6 ++----
> >   1 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
> > index 0b7c0cb..0378828 100644
> > --- a/lib/bb/ui/crumbs/hoblistmodel.py
> > +++ b/lib/bb/ui/crumbs/hoblistmodel.py
> > @@ -546,9 +546,7 @@ class RecipeListModel(gtk.ListStore):
> >               group = event_model["pn"][item]["section"]
> >               install = []
> >
> > -            depends = event_model["depends"].get(item, [])
> > -            rdepends = event_model["rdepends-pn"].get(item, [])
> > -            depends = depends + rdepends
> > +            depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
> >
> >               if ('task-' in name):
> >                   if ('lib32-' in name or 'lib64-' in name):
> > @@ -557,7 +555,7 @@ class RecipeListModel(gtk.ListStore):
> >                       atype = 'task'
> >               elif ('-image-' in name):
> >                   atype = 'image'
> > -                install = rdepends
> > +                install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
> 
> rrecs should be recommendations, not requirements - are we making the 
> conscious decision to include all recommended packages when building 
> with Hob?

Per my understanding, RRECOMMENDS means that if the recommended package
do exists, then install it. Else if it doesn't, system will not report
error as missing dependency. (Correct me if it is wrong)

Here in Hob code, we will try to install both RDEPENDS and RRECOMMENDS
packages. But note that here the "install" variable is only used to make
selections in "Package Selection" page. Therefore if a recommended
package doesn't exists, it will not be included in the installation
list.

Thanks,
Dongxiao

> 
> >               elif ('meta-' in name):
> >                   atype = 'toolchain'
> >               elif (name == 'dummy-image' or name == 'dummy-toolchain'):
> 




