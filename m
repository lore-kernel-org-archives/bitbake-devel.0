Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TaTMl-00050f-F0 for bitbake-devel@lists.openembedded.org;
	Mon, 19 Nov 2012 16:34:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAJFKR0j028033;
	Mon, 19 Nov 2012 15:20:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26882-08; Mon, 19 Nov 2012 15:20:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAJFKJeb028027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2012 15:20:20 GMT
Message-ID: <1353338421.3709.171.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 19 Nov 2012 15:20:21 +0000
In-Reply-To: <20121119150931.GA3341@jama.jama.net>
References: <1353337280.3709.167.camel@ted>
	<20121119150931.GA3341@jama.jama.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] parse/cache/cooker: Preserve order in the file inclusion list
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
X-List-Received-Date: Mon, 19 Nov 2012 15:34:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-11-19 at 16:09 +0100, Martin Jansa wrote:
> On Mon, Nov 19, 2012 at 03:01:20PM +0000, Richard Purdie wrote:
> > The data returned by get_file_depends() may me used in contexts like
> > checksums where order is important. The current usage of sets means
> > that some of the checksums can change in circumstances they should not.
> > 
> > This patch changes to use lists, thereby removing the problem.
> 
> Should this cover also BBINCLUDED variable in parsing cache?
> 
> Sometimes I see all recipes reparsed without any reason (no change in
> metadata).
> 
> Comparing output of bitbake -p (with added patch to dump parse data,
> shows order of BBINCLUDED changing.

Yes, this is exactly why I'm proposing this patch.

Cheers,

Richard



