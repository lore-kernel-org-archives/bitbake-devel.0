Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1hBu-0003n3-MH for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 19:15:34 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FH3cJq003636;
	Wed, 15 Aug 2012 18:03:38 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03563-01; Wed, 15 Aug 2012 18:03:33 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FH3V8q003629
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Aug 2012 18:03:32 +0100
Message-ID: <1345050211.14667.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Wed, 15 Aug 2012 18:03:31 +0100
In-Reply-To: <502BD4CE.3000102@windriver.com>
References: <1345049422.14667.11.camel@ted> <502BD4CE.3000102@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] knotty: Fold knotty2 into knotty and make it the default
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
X-List-Received-Date: Wed, 15 Aug 2012 17:15:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-08-15 at 11:56 -0500, Jason Wessel wrote:
> On 08/15/2012 11:50 AM, Richard Purdie wrote:
> > There is no good reason knotty2 shouldn't be the default now. If you need
> > the old behaviour, just pipe the output through cat as non-interactive
> > terminals get the old output.
> 
> 
> I didn't look at this in much detail to see if it is was a direct fold or if you made changes along the way.
> 
> I have a whole series of patches outstanding against knotty2 for
> fixing its behavior for the very annoying line wrapping problems and
> the like.  Certainly I can rebase the work done to this end, but these
> problems need to be addressed, preferably before you make this the
> default.

Have a look at the preceding patches ;-)

I've fixed the line wrapping and window resizing issues first. It was
based on some of your changes but I fixed various things (like having
progressbar chain the WINCH signal handlers instead of hacking around
it).

This doesn't add the interactive logging as I'm still not sure that
makes sense in master. If we do that I want to think more carefully
about the UI to it.

The interactive terminal stuff is also pending as I was pretty horrified
when I realised how you implemented it. What we need to do is issue an
event and have bitbake respond to that event where the event contains a
"command" parameter.

So I'm working through the patches but I think with the changes I just
posted, knotty2 should be ready for wider usage.

Cheers,

Richard



