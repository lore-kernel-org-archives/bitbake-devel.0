Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tcv6m-00044g-4x; Mon, 26 Nov 2012 10:36:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLLjp6017817;
	Sun, 25 Nov 2012 21:21:45 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10739-04; Sun, 25 Nov 2012 21:21:41 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLLYUE017811
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 25 Nov 2012 21:21:35 GMT
Message-ID: <1353878494.21863.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Date: Sun, 25 Nov 2012 21:21:34 +0000
In-Reply-To: <CAP9ODKqQnj4ot2kF7FPYj2QxtT+hr5QTaD_UJhVQM6cSLP3cfg@mail.gmail.com>
References: <1353691611.1361.28.camel@ted>
	<CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
	<1353699909.7352.2.camel@ted>
	<CAP9ODKqQnj4ot2kF7FPYj2QxtT+hr5QTaD_UJhVQM6cSLP3cfg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Constantin Musca <constantinx.musca@intel.com>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] RFC: Versioning of git recipes (and incremental PR)
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
X-List-Received-Date: Mon, 26 Nov 2012 09:36:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-11-24 at 11:55 -0200, Otavio Salvador wrote:
> On Fri, Nov 23, 2012 at 5:45 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Fri, 2012-11-23 at 17:23 -0200, Otavio Salvador wrote:
> >> I like to idea of a single updating place. What I dislike is AUTOINC
> >> not being taken care in the fetcher.
> >>
> >> In this case any GIT revision changes, the AUTOINC won't bump as usual
> >> (without PR server)?
> >
> > Why do you need AUTOINC to bump? The only reason we have increments in
> > the fetcher is for package upgrading...
> 
> Yes but in this case the fetcher won't change AUTOINC and you'll have
> same revision even when changing SRCREVs. This will break the upgrade
> path for people not using PR server, no?

We're going to need the PR server for upgrade paths in future regardless
so that shouldn't be an issue.

Cheers,

Richard




