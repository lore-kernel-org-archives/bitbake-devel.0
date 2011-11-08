Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RNmKD-0005HT-Py
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 15:06:54 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 08 Nov 2011 06:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.69,477,1315206000"; d="scan'208";a="82425405"
Received: from unknown (HELO helios.localnet) ([10.252.121.141])
	by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2011 06:00:37 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "George C. Huntington, III" <george.huntingtoniii@gmail.com>
Date: Tue, 08 Nov 2011 14:00:36 +0000
Message-ID: <1589523.33nZoy7sRG@helios>
Organization: Intel Corporation
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-generic-pae; KDE/4.7.2; i686; ; )
In-Reply-To: <CAFu+nvG9gLNyCOEcE9ZdCwCe8wtzn=4vxdd3fGz2mP_zBtAM_Q@mail.gmail.com>
References: <1320361692.20107.103.camel@ted>
	<CAFu+nvG9gLNyCOEcE9ZdCwCe8wtzn=4vxdd3fGz2mP_zBtAM_Q@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] Bitbake 1.14.0 released!
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
X-List-Received-Date: Tue, 08 Nov 2011 14:06:54 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 04 November 2011 10:05:57 George C. Huntington, III wrote:
> can the new bitbake be used on oe-classic, 2011.03-maintenance branch?

I think, as you pointed out, someone will need to go through the metadata and 
fix the comments in the middle of multi-line statements before it will work.

Cheers,
Paul


