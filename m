Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy8s-0005AH-Qj
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:38:39 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28650733"
Received: from vorpal.jf.intel.com (HELO [10.7.199.57]) ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:34:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Koen Kooi <koen@dominion.thruhere.net>
Date: Thu, 21 Jul 2011 11:38:59 -0700
In-Reply-To: <C7884CFB-DBBE-4EB0-9C21-88BDE564DDB4@dominion.thruhere.net>
References: <cover.1310696828.git.liping.ke@intel.com>
	<6ac3109c3cf221687a96606685fb209cb5d68556.1310696828.git.liping.ke@intel.com>
	<C7884CFB-DBBE-4EB0-9C21-88BDE564DDB4@dominion.thruhere.net>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1311273539.2172.1.camel@vorpal.jf.intel.com>
Mime-Version: 1.0
Cc: yocto@yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [yocto] [PATCH 1/1][Image Creator] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 18:38:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2011-07-21 at 11:04 +0200, Koen Kooi wrote:
> Op 21 jul. 2011, om 07:50 heeft Ke Liping het volgende geschreven:
> 
> > From: Liping Ke <liping.ke@intel.com>
> > 
> > Since Hob only needes package dependency information, we can
> > create a new version of package information retrieving methods,
> > remove task dependency information, so that we can greatly
> > reduce data loading time for Hob
> 
> 
> Does this fix the bug where DEPENDS are leaking into the RDEPENDS list?
> If you select something like systemd the gui will list 'gtk' as a
> runtime dep for the image, while it's only a transitive buildtime one.
> 

It does not, 1263 filed.

http://bugzilla.pokylinux.org/show_bug.cgi?id=1263

Regards,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes Factotum"
        Intel Open Source Technology Centre



