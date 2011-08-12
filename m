Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qri4p-0001Re-KP
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 05:06:27 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Aug 2011 20:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,360,1309762800"; d="scan'208";a="37690810"
Received: from unknown (HELO [10.255.14.237]) ([10.255.14.237])
	by azsmga001.ch.intel.com with ESMTP; 11 Aug 2011 20:01:53 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 11 Aug 2011 20:01:47 -0700
In-Reply-To: <1313106078.14274.476.camel@rex>
References: <cover.1313025215.git.josh@linux.intel.com>
	<1313103490.2506.2.camel@vorpal.jf.intel.com>
	<1313106078.14274.476.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1313118113.4708.0.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Bug fixing and code clarity
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
X-List-Received-Date: Fri, 12 Aug 2011 03:06:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 00:41 +0100, Richard Purdie wrote:
> On Thu, 2011-08-11 at 15:58 -0700, Joshua Lock wrote:
> > On Wed, 2011-08-10 at 18:19 -0700, Joshua Lock wrote:
> > > The following series addresses some thinko/typo's I'd introduced to hob, by
> > > using variable names which are too similar, as well as adding some changes
> > > to increase clarity in various places.
> > 
> > This series rolled into a new series submitted just now, please ignore
> > this series.
> 
> I've actually already merged this series. Was there any change in the
> newer version I should be looking for?

None at all, I was just using the same branch to push the new changes so
included them in the new pull request.

Apologies for any confusion.

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



