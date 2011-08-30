Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QyVe1-0002ML-2r for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 23:14:53 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UL9vgc001341;
	Tue, 30 Aug 2011 22:09:57 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20955-10; Tue, 30 Aug 2011 22:09:53 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UL9nEm001325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Aug 2011 22:09:49 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9FC@shsmsx501.ccr.corp.intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
	<a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
	<1314622519.5939.286.camel@rex>
	<D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9C7@shsmsx501.ccr.corp.intel.com>
	<1314623585.5939.295.camel@rex>
	<D5AB6E638E5A3E4B8F4406B113A5A19A12D735D9FC@shsmsx501.ccr.corp.intel.com>
Date: Tue, 30 Aug 2011 22:09:38 +0100
Message-ID: <1314738578.5939.425.camel@rex>
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
X-List-Received-Date: Tue, 30 Aug 2011 21:14:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-29 at 22:21 +0800, Xu, Dongxiao wrote:
> > -----Original Message-----
> > From: Xu, Dongxiao
> > Sent: Monday, August 29, 2011 9:16 PM
> > To: Richard Purdie
> > Cc: bitbake-devel@lists.openembedded.org
> > Subject: RE: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of expand
> > cache in getVar()
> > 
> > > -----Original Message-----
> > > From: Richard Purdie [mailto:richard.purdie@linuxfoundation.org]
> > > Sent: Monday, August 29, 2011 9:13 PM
> > > To: Xu, Dongxiao
> > > Cc: bitbake-devel@lists.openembedded.org
> > > Subject: RE: [bitbake-devel] [PATCH 1/1] data_smart.py: make use of
> > > expand cache in getVar()
> > >
> > >
> > > I'm left wondering why we don't key that cache on the unexpanded value
> > > rather than a specific variable name (or name+flag).
> > >
> > > I'll take this patch but its something we should consider...
> > 
> > Thanks, I will step into this point further and see if (name+flag) type of cache
> > could benefit us more.
> 
> Sorry I must misunderstand your point just now...
> 
> For caching of unexpanded value, there are too many/uncertainty of types, like:
> 
> ${TUNE_ARCH}
> ${@bb.parse.BBHandler.vars_from_file(bb.data.getVar('FILE',d),d)[0] or 'defaultpkgname'}
> ${@bb.utils.contains("TUNE_FEATURES", "m32", "${X86ARCH32}", "" ,d)}${@bb.utils.contains("TUNE_FEATURES", "mx32", "${X86ARCH64}", "" ,d)}${@bb.utils.contains("TUNE_FEATURES", "m64", "${X86ARCH64}", "" ,d)}
> 
> For simple variables, it is easy to cache, however for the expressions, it may not suitable to cache.

It shouldn't really matter what the expression is, we should just be
able to cache the value it evaluates to. We invalidate the cache upon
any write to the data store that can potentially change a variables
contents.

This shouldn't really be any different to the current behaviour of the
code (where caching doesn't cause a problem).

Cheers,

Richard



