Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs1R1-0007L5-Jd
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 01:46:39 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 12 Aug 2011 16:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="41021486"
Received: from unknown (HELO [10.255.15.3]) ([10.255.15.3])
	by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2011 16:42:05 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>
Date: Fri, 12 Aug 2011 16:42:00 -0700
In-Reply-To: <CABcZANki4ULpVxRYM9EPA05ZEWHY6g+Fnr_0ntQDjKPcZ_WSnQ@mail.gmail.com>
References: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
	<1313191795.2228.6.camel@scimitar>
	<CABcZANki4ULpVxRYM9EPA05ZEWHY6g+Fnr_0ntQDjKPcZ_WSnQ@mail.gmail.com>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1313192525.2228.8.camel@scimitar>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditional assignment broken
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
X-List-Received-Date: Fri, 12 Aug 2011 23:46:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 16:32 -0700, Chris Larson wrote:
> On Fri, Aug 12, 2011 at 4:29 PM, Joshua Lock <josh@linux.intel.com> wrote:
> > On Sat, 2011-08-13 at 06:50 +0800, James Limbouris wrote:
> >> Hi,
> >>
> >>  Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditional assignment
> >>  in all conf files. Previously, the environment was copied from a
> >> cleaned up os environment.
> >>  After the commit, a pristine environment is available in
> >> data['_data'], and will be copied to
> >>  data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
> >> Variables not conditionally
> >>  assigned will still be available from data['_data'], also in defiance
> >> of BB_ENV_EXTRAWHITE.
> >>
> >>  To verify, simply:
> >>
> >>  export RANDOMENV=42
> >>  bitbake -e | grep RANDOMENV
> >
> > Thanks for the report James, and apologies for the breakage. I'll try
> > and get a fix submitted and merged asap.
> >
> > I'm now wondering if we want the pristine environment, or the cleaned
> > environment, saved.
> 
> For things like devshell, I think it would be nice to retain a copy of
> the original, unmodified environment.

Agreed, that was one of the intended consumers. I guess I need to drink
more coffee and figure out the *right* fix then...

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



