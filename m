Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qy1jC-0001G1-GZ for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 15:18:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TDDKDk003161;
	Mon, 29 Aug 2011 14:13:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03060-03; Mon, 29 Aug 2011 14:13:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TDDD4f003155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Aug 2011 14:13:14 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
	<a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
	<1314622519.5939.286.camel@rex>
	<D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
Date: Mon, 29 Aug 2011 14:13:05 +0100
Message-ID: <1314623585.5939.295.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] data_smart.py: make use of expand cache in getVar()
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
X-List-Received-Date: Mon, 29 Aug 2011 13:18:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-29 at 21:07 +0800, Xu, Dongxiao wrote:
> Hi Richard,
> 
> > -----Original Message-----
> > From: Richard Purdie [mailto:richard.purdie@linuxfoundation.org]
> > Sent: Monday, August 29, 2011 8:55 PM
> > To: Xu, Dongxiao
> > Cc: bitbake-devel@lists.openembedded.org
> > Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of expand
> > cache in getVar()
> > 
> > On Mon, 2011-08-29 at 15:33 +0800, Dongxiao Xu wrote:
> > > Currently if passing expand=True to getVar() function, it will pass
> > > the handling to getVarFlag(), which doesn't get any benefit from the
> > > expand cache.
> > >
> > > Call the expand() function separately in getVar() to make use of the
> > > expand cache, which can decrease the parsing time by 40%.
> > > (from current 49s to 27s)
> > >
> > > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > > ---
> > >  lib/bb/data_smart.py |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py index
> > > 301f9e3..d8ba24f 100644
> > > --- a/lib/bb/data_smart.py
> > > +++ b/lib/bb/data_smart.py
> > > @@ -268,7 +268,12 @@ class DataSmart(MutableMapping):
> > >          self.dict[var]["content"] = value
> > >
> > >      def getVar(self, var, expand=False, noweakdefault=False):
> > > -        return self.getVarFlag(var, "content", expand, noweakdefault)
> > > +        value = self.getVarFlag(var, "content", False, noweakdefault)
> > > +
> > > +        # Call expand() separately to make use of the expand cache
> > > +        if expand and value:
> > > +            return self.expand(value, var)
> > > +        return value
> > >
> > 
> > Why can't we have getVarFlag use the expand cache?
> 
> For expand cache, the format is a list: expand_cache[varname].
> It doesn't contain information of flag values.

Good point.

I'm left wondering why we don't key that cache on the unexpanded value
rather than a specific variable name (or name+flag).

I'll take this patch but its something we should consider...

Cheers,

Richard





