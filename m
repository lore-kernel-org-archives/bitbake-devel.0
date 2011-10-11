Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RDiv9-0003es-CJ
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 22:27:27 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 11 Oct 2011 13:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="62252829"
Received: from unknown (HELO [10.255.15.64]) ([10.255.15.64])
	by orsmga002.jf.intel.com with ESMTP; 11 Oct 2011 13:21:44 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2011 13:21:39 -0700
In-Reply-To: <CAMKF1srRT6hOkzntfOWyTnEm4mBhx6sQu1UwZk74ESe8gayyxg@mail.gmail.com>
References: <cover.1318352470.git.josh@linux.intel.com>
	<74d583f1aeecf8d112a2b24d4c4a234fbadf8470.1318352470.git.josh@linux.intel.com>
	<CAMKF1srRT6hOkzntfOWyTnEm4mBhx6sQu1UwZk74ESe8gayyxg@mail.gmail.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1318364504.2277.5.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] fetch2: enable checksum definition as SRC_URI parameter
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
X-List-Received-Date: Tue, 11 Oct 2011 20:27:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-10-11 at 11:05 -0700, Khem Raj wrote:
> On Tue, Oct 11, 2011 at 10:07 AM, Joshua Lock <josh@linux.intel.com> wrote:
> > URI parameters should be able to be defined as a parameter of the SRC_URI,
> > this patch enables thus for checksums.
> >
> > An example;
> >
> > SRC_URI = "http://pkgconfig.freedesktop.org/releases/pkg-config-${PV}.tar.gz;md5sum=a3270bab3f4b69b7dc6dbdacbcae9745;sha256sum=3ba691ee2431f32ccb8efa131e59bf23e37f122dc66791309023ca6dcefcd10e"
> 
> this should go into manual/documentation as well.

Good point, I pushed an extra patch onto the branch for the manual:
https://github.com/incandescant/bitbake/commit/fcf17a39ce89b5911ffd9f89ff13505a7a7633fd

Regards,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



