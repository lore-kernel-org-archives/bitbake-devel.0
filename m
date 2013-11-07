Return-Path: <dvhart@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 67A306BE6E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 18:57:33 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 07 Nov 2013 10:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="405204407"
Received: from dvhart-mobl4.jf.intel.com (HELO [10.7.196.57]) ([10.7.196.57])
	by orsmga001.jf.intel.com with ESMTP; 07 Nov 2013 10:57:35 -0800
Message-ID: <1383850654.5378.55.camel@dvhart-mobl4.amr.corp.intel.com>
From: Darren Hart <dvhart@linux.intel.com>
To: Chris Morgan <chmorgan@gmail.com>
Date: Thu, 07 Nov 2013 10:57:34 -0800
In-Reply-To: <CAAPegz10UN90-vCTT9+OiiniJ6OXZ2ADw+NMd1HEFfCqnDLmuA@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<CALmOhgmJVjqnhUvQn=5hk3ZaM6r42PYWa+A2Xve34v6fEdc94w@mail.gmail.com>
	<CAAPegz10UN90-vCTT9+OiiniJ6OXZ2ADw+NMd1HEFfCqnDLmuA@mail.gmail.com>
Organization: Intel
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 07 Nov 2013 18:57:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-10-15 at 08:17 -0400, Chris Morgan wrote:
> >Chris,
> >
> >Are all of your developers working on creating the target's kernel,
> >rootfs, and/or bootloader? If most of the developers are only doing
> >target, user-space, application development then all they need is an
> >appropriate SDK (which only needs to be generated whenever any target
> >packages change). This means a huge build only needs to be done once,
> >and then everyone can use the results. In this scenario a
> >network-shared sstate can still be employed for further build-time
> >savings.
> 
> I suspect that we could get away with the appropriate sdk. I can see
> how this would work for the cross-compilation process, with an arm
> sdk, but if we had an x86-64 sdk for running things natively I'm not
> sure the libraries would be in sync enough for the applications to run
> on the developer's Linux machines. I'm thinking a mismatch in any
> library would prevent the executables from being run without going
> through the qemu approach.
> 
> I can certainly see that there is a path forward though and thank you
> for brining up the sdk idea. I had read about that but haven't gotten
> to trying it or trying to figure out where it best fits yet.
> 

I was also going to suggest the SDK for the app developers. In most
product groups I've met with using the Yocto Project, the developers
maintain their existing workflow through use of the SDK (which ensures
they are using the same compiler, libraries, etc) and the bitbake tasks
are owned by a small build team of 1 or 2 engineers.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel



