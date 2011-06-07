Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QU4WX-0004Bn-CD
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Jun 2011 00:13:21 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 Jun 2011 15:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,334,1304319600"; d="scan'208";a="15205154"
Received: from scimitar.ch.intel.com (HELO [10.34.75.130]) ([10.34.75.130])
	by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2011 15:10:02 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 07 Jun 2011 15:10:03 -0700
In-Reply-To: <1306882804.27470.402.camel@rex>
References: <1306882804.27470.402.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-1.fc15) 
Message-ID: <1307484603.15327.16.camel@scimitar>
Mime-Version: 1.0
Subject: Re: RFC: Override expansion - changing the behaviour
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
X-List-Received-Date: Tue, 07 Jun 2011 22:13:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-06-01 at 00:00 +0100, Richard Purdie wrote:
> Currently if you do:
> 
> OVERRIDES = "z"
> DEPENDS_prepend = "a "
> DEPENDS = "b"
> DEPENDS_z = "c"
> 
> d.update_data()
> d.getVar("DEPENDS") gives "a c"
> d.update_data()
> d.getVar("DEPENDS") gives "c"
> 
> I'm proposing we should change the bitbake behaviour such that at the
> time bitbake expands the DEPENDS_z override, it removes "DEPENDS_z" from
> the data store.

FWIW I think this change is absolutely the right thing to do. The
current behaviour always catches me out (and I hope I'm not alone) and
changing it as suggested makes the behaviour much less surprising.

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Build System Monkey
        Intel Open Source Technology Centre



