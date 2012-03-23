Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB36d-0008Nt-Vs
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 12:56:32 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 04:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132374964"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2012 04:47:34 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
In-Reply-To: <20120323091314.5b5d00a0@eb-e6520>
References: <20120322122219.0df320be@eb-e6520>
	<20120323091314.5b5d00a0@eb-e6520>
Date: Fri, 23 Mar 2012 19:45:24 +0800
Message-ID: <1332503125.1849.0.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Hob : IndexError: list index out of range
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
X-List-Received-Date: Fri, 23 Mar 2012 11:56:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2012-03-23 at 09:13 +0100, Eric Bénard wrote:
> Le Thu, 22 Mar 2012 12:22:19 +0100,
> Eric Bénard <eric@eukrea.com> a écrit :
> > while testing HOB, once the image appears to finish to build, got this error :
> > 
> > Traceback (most recent call last):
> >   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.py", line 431, in handler_command_succeeded_cb
> >     self.switch_page(self.IMAGE_GENERATED)
> >   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.py", line 339, in switch_page
> >     self.image_details_page.show_page(next_step)
> >   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/imagedetailspage.py", line 187, in show_page
> >     image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
> > IndexError: list index out of range
> > 
> is there anyone reproducing this or is this a local issue ?

Could you tell me your configuration to reproduce this issue?

Thanks,
Dongxiao

> 
> Thanks
> Eric
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




