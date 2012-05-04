Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQJwr-0000jO-Sn for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 16:57:34 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44Elk5Q015094;
	Fri, 4 May 2012 15:47:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14351-07; Fri,  4 May 2012 15:47:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44EldZ7015088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 May 2012 15:47:40 +0100
Message-ID: <1336142863.23777.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Fri, 04 May 2012 15:47:43 +0100
In-Reply-To: <CABcZANm1yKZ3rj1YV7WXbWO3vwoWbK11iHKGMkRDmF8sFzXTgw@mail.gmail.com>
References: <1336140213.23777.4.camel@ted>
	<CABcZANm1yKZ3rj1YV7WXbWO3vwoWbK11iHKGMkRDmF8sFzXTgw@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/utils: Convert vercmp_string() to use vercmp internally
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
X-List-Received-Date: Fri, 04 May 2012 14:57:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-05-04 at 07:31 -0700, Chris Larson wrote:
> On Fri, May 4, 2012 at 7:03 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > Having two different version comparision algorithms in bitbake has never seemed
> > like a sensible idea. Worryingly, they also return different results to each other.
> >
> > The vercmp_string API is relatively unused with no users in OE-Core or BitBake
> > itself for example. This patch converts it to use vercmp internalls, bringing
> > consitency to the comparisions which is easy now we have other recently added
> > functions. Yes, this changes behaviour but in this case I'd prefer we were
> > consistent than having two different comparisions.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> This seems sane to me (aside: minor typo: internalls). I recall that
> we attempted this once in the past with regular OE and got bitten hard
> by the actual users in the metadata, but clearly that's no longer a
> concern.

There are a couple of lib.oe.utils() functions that do call this api but
those themselves don't seem to be used anywhere I could spot.

The way I've changed things is API compatible, it just behaves
consistently with the other version functions and differently to how it
did before in some cases. I think last time we tried this, we tried to
remove it so this approach should be ok...

Cheers,

Richard



