Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S3VPF-0000BM-6y for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 17:32:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GO2E7002954;
	Fri, 2 Mar 2012 16:24:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02309-05; Fri,  2 Mar 2012 16:23:58 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GNpX0002948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2012 16:23:52 GMT
Message-ID: <1330705434.309.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andreas Oberritter <obi@opendreambox.org>
Date: Fri, 02 Mar 2012 16:23:54 +0000
In-Reply-To: <4F4D01A9.1010303@opendreambox.org>
References: <4F4CC00F.10608@opendreambox.org>
	<1330430595.9185.109.camel@ted> <4F4D01A9.1010303@opendreambox.org>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Git, AUTOREV and SSH
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
X-List-Received-Date: Fri, 02 Mar 2012 16:32:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-02-28 at 17:32 +0100, Andreas Oberritter wrote:
> On 28.02.2012 13:03, Richard Purdie wrote:
> > On Tue, 2012-02-28 at 12:52 +0100, Andreas Oberritter wrote:
> >> Hi,
> >>
> >> there's a problem with the Git fetcher when used with AUTOREV, at least
> >> with SSH URIs. "git ls-remote" may output warnings on stderr, e.g.:
> >>
> >> X11 forwarding request failed on channel 0
> >>
> >> When this happens, "X11" becomes the SRCREV and the fetcher subsequently
> >> fails. Certainly, other warnings by Git, SSH or a different SCM or
> >> transport could appear under other circumstances. Even localized strings
> >> may appear. Fetch2 merges stderr into stdout on purpose [1], so I'm not
> >> sure a proper fix should look like.
> >>
> >> Regards,
> >> Andreas
> >>
> >> [1] See runfetchcmd() in lib/bb/fetch2/__init__.py
> > 
> > Would the change in
> > http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-January/001771.html help?
> > 
> > I've still not had a chance to rebase and apply that patch :(
> 
> Yes, this patch did help. See below for a rebased version. Thanks!

Thanks very much, I applied this.

Cheers,

Richard



