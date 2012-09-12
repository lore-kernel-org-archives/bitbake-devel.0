Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TBoXn-0008Oj-F2 for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 17:07:59 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8CEtMLh020600;
	Wed, 12 Sep 2012 15:55:22 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19954-09; Wed, 12 Sep 2012 15:55:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8CEtEKJ020594
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Sep 2012 15:55:15 +0100
Message-ID: <1347461716.11710.45.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 12 Sep 2012 15:55:16 +0100
In-Reply-To: <1987076.DYWImTfRFL@helios>
References: <cover.1347382193.git.paul.eggleton@linux.intel.com>
	<2b9acb9c7fca686d4df885152458cae2e22f2cc5.1347382193.git.paul.eggleton@linux.intel.com>
	<CABcZAN=_7d0ovDP6nHBTYCWbrs+QGF8bcinsNSrzQLSe3w14Aw@mail.gmail.com>
	<1987076.DYWImTfRFL@helios>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] lib/bb/command.py: ensure setVariable only sets values as strings
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
X-List-Received-Date: Wed, 12 Sep 2012 15:07:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-12 at 13:29 +0100, Paul Eggleton wrote:
> On Tuesday 11 September 2012 15:57:24 Chris Larson wrote:
> > On Tue, Sep 11, 2012 at 9:52 AM, Paul Eggleton
> > <paul.eggleton@linux.intel.com> wrote:
> > > This is the interface Hob uses to set variable values in many instances,
> > > and at the moment it is possible that some of the values it passes are
> > > not strings. If a non-string value gets into the datastore it can
> > > trigger exceptions during parsing when we attempt to expand the variable
> > > and substitute in the non-string value.
> > > 
> > > This fixes using the meta-ti layer within Hob - it currently has a
> > > reference to BB_NUMBER_THREADS within a shell function and since this
> > > is a variable that Hob was setting from its configuration as an integer,
> > > due to the above this was triggering an ExpansionError.
> > 
> > This is probably a good change, but I think that failing expansion due
> > to a non-string value is a bad behavior in bitbake. I think it should
> > call str() on it as appropriate, as that's the most idiomatic
> > solution: Don't check if something is a string, don't require only
> > strings, but call str() to get your string
> 
> Hmm, I suppose so; I do still worry about existing python code assuming the 
> result of getVar() is either None or a string though. Richard tells me that we 
> have some non-string values mostly internal to BitBake that are considered 
> legal, so that obviously isn't always 100% true, but it's a fair assumption to 
> have made for most situations.

If its being used in variable expansion, it should be a string or
convertible to a string so I have to admit I was thinking we probably
should have a str() conversion in there as well. I'm hoping that doesn't
have much overhead for something that is already a string. I'd also be
concerned about turning None into "None" which is probably the biggest
worry.

Cheers,

Richard





