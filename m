Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T7MCX-0003Px-Ku for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 10:03:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7V0cdRA006205;
	Fri, 31 Aug 2012 01:38:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05116-06; Fri, 31 Aug 2012 01:38:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7V0cRn2006195
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 31 Aug 2012 01:38:29 +0100
Message-ID: <1346373507.16485.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 30 Aug 2012 17:38:27 -0700
In-Reply-To: <CAHUNapQsabEeNV7ZrpZfro8R8OKakS-862UJy1w1_5LmSZU8eQ@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
	<CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
	<CAHUNapQsabEeNV7ZrpZfro8R8OKakS-862UJy1w1_5LmSZU8eQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] clarify wording
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
X-List-Received-Date: Fri, 31 Aug 2012 08:03:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-08-25 at 06:43 -0400, Trevor Woerner wrote:
> On Fri, Aug 24, 2012 at 11:57 PM, Chris Larson <clarson@kergoth.com> wrote:
> > No, this is wrong. When committing to the bitbake repository, there's
> > no need to prefix it with 'bitbake:'.
> 
> I am new to bitbake-devel, but looking through several of the more
> recent commits would indicate the majority of them do have some sort
> of location identifier in the subject, some of which are just
> "bitbake:". One (e0f91faf195be63803d39fb42fcd115ad558c79f) even has
> "bin/bitbake:"; maybe I should use this for my patch?

I think in this case bin/bitbake: is the best prefix. The idea is it
gives a rough idea what changed and clearly in this case that is quite a
good summary.

Since this is such a simple patch, I've tweaked it and applied it. Also
in future please include a Signed-off-by: line.

Cheers,

Richard



