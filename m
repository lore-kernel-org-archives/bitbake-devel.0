Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBztb-0004rI-Dy
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 04:42:59 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 25 Mar 2012 19:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145268868"
Received: from dongxiao-osel.sh.intel.com (HELO [10.239.36.11])
	([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2012 19:33:57 -0700
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
In-Reply-To: <20120325221346.0b452c4f@eb-e6520>
References: <20120325221346.0b452c4f@eb-e6520>
Date: Mon, 26 Mar 2012 10:31:43 +0800
Message-ID: <1332729103.1849.64.camel@dongxiao-osel>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: HOB2 : run image disabled
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
X-List-Received-Date: Mon, 26 Mar 2012 02:42:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2012-03-25 at 22:13 +0200, Eric Bénard wrote:
> Hi Dongxiao,
> 
> when the image is built (core-minimal for qemuarm machine) :
> - if I click on runimage : it ask for selecting an image
> - if I select and image (either ext3 or tar.bz2) the "run image" link
>   is disabled.
> is that behaviour expected ?

Hi Eric,

This is because we still have one pending patch not in oe-core master
now. You can refer to:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=dxu4/hob-bugfix-oecore&id=10968f8c0cf425011983ef7e0fe4c14b7da5ef74

Thanks,
Dongxiao



> 
> Thanks,
> Eric




