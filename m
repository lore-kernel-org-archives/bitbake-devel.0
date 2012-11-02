Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TULdH-0003Y7-6q for bitbake-devel@lists.openembedded.org;
	Fri, 02 Nov 2012 19:06:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA2HqUVK026028;
	Fri, 2 Nov 2012 17:52:30 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25868-02; Fri,  2 Nov 2012 17:52:26 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA2HqKpr026022
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2012 17:52:22 GMT
Message-ID: <1351878740.6502.78.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Fri, 02 Nov 2012 17:52:20 +0000
In-Reply-To: <70CC66F5C30A414DADDA6973E4CA391A74834D@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1351750475.6502.11.camel@ted>
	<70CC66F5C30A414DADDA6973E4CA391A74834D@039-SN1MPN1-001.039d.mgd.msft.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Scott Garman <scott.a.garman@intel.com>
Subject: Re: 1.16 stable series
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
X-List-Received-Date: Fri, 02 Nov 2012 18:06:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-11-01 at 22:08 +0000, McClintock Matthew-B29882 wrote:
> On Thu, Nov 1, 2012 at 1:14 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > One of the issues with previous OE-Core and Poky releases has been
> > deciding which bitbake should be used used with them. There is a copy of
> > bitbake in poky denzil which is a now becoming a bit of a Frankenstein,
> > not corresponding to any particular bitbake release with various random
> > patches from master. This isn't necessarily a bad thing and users of
> > poky find it useful but I think we can do better.
> >
> > This time around, for the danny series I made sure we had a bitbake
> > stable branch available to correspond with it (1.16). I'm planning to
> > use the 1.16 branch as a stable bitbake branch and directly include that
> > in poky-danny verbatim. So far I don't think there have been any
> > invasive changes on master so I might just push current master into the
> > 1.16 branch. As development moves forward, we'd move to a model of
> > picking specific commits that make sense for the branch.
> >
> > I really just wanted to let people know what I was intending here, I
> > doubt its too controversial and if people have specific things they want
> > to see in the stable branch, feel free to point them out!
> 
> For denzil then should we apply straight to poky? Or should we try to
> create something for denzil as well? Does one of the branches already
> serve this purpose?

I'll probably just continue applying things to denzil at this point. We
probably could create a branch that corresponds to it but its not
something I feel is a priority right now...

Cheers,

Richard



