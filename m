Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwBf0-0004eh-Ql for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 14:07:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICpeuP008968;
	Fri, 18 Jan 2013 12:51:40 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05510-04; Fri, 18 Jan 2013 12:51:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0ICpUCS008962
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 12:51:31 GMT
Message-ID: <1358513490.27799.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Fri, 18 Jan 2013 12:51:30 +0000
In-Reply-To: <CANge7vVSFKAxDYyXh40bFP-uEpu+Otwbhdx69QrX0YgTaGhNjg@mail.gmail.com>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
	<1355507217.32519.33.camel@ted>
	<CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
	<CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
	<CABcZANmUyaCd0kx0FSq5Ye=OXKiKdziGfAyiy3dH9BxrJtEh6g@mail.gmail.com>
	<CANge7vVSFKAxDYyXh40bFP-uEpu+Otwbhdx69QrX0YgTaGhNjg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Chris Larson <clarson@kergoth.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hg fetcher failures for SRCREV set to a tag
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
X-List-Received-Date: Fri, 18 Jan 2013 13:07:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-12-22 at 12:36 -0500, Jon Szymaniak wrote:
> >> Hi Richard,
> >>
> >> Thanks for pinging back on this. (Sorry I just double-sent this to
> >> you. Forgot to include the list! :P)
> >>
> >> I think a fairly simple solution might be to just clone the entire
> >> repo by not adding "-r REV" to options[] for an 'hg clone' invocation.
> >> The 'hg update' that follows on lines 142-147 should set the repo to
> >> the desired revision.
> >
> >
> > This does sound like the best bet, to me.
> > --
> > Christopher Larson
> 
> Hi all,
> 
> Just wanted to touch base on this issue. I didn't hear anything back
> on the little patch I posted...not sure if that's a silent rejection,
> if I didn't include the right info in the subject line, or if folks
> haven't had a chance to test it. If there's something I screwed up,
> please do let me know for future reference. :)
> 
> http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-December/003962.html

Sorry about the delay, vacation and lots of other distractions. The
patch was find and I've merged it now, thanks. I did have trouble
applying it as it appeared the whitespace was messed up. I fixed it up
manually this time though.

Cheers,

Richard



