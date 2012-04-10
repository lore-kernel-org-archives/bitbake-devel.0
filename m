Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHhbM-0004EI-Dd for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 22:23:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AKEOjv032093;
	Tue, 10 Apr 2012 21:14:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31128-10; Tue, 10 Apr 2012 21:14:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AKEFio032086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 21:14:17 +0100
Message-ID: <1334088855.10826.36.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Khem Raj <raj.khem@gmail.com>
Date: Tue, 10 Apr 2012 21:14:15 +0100
In-Reply-To: <CAMKF1soNohu5iM9j3Sro+MeKPObUsObwzCyFFEsO30cZQ2qJyw@mail.gmail.com>
References: <4F82DE2E.30208@mlbassoc.com>
	<CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
	<4F845B40.2040302@mvista.com>
	<CABcZAN=4SzW-7b75_ydFfT67uQhb_xq643v6o4AbvVbGxatJVA@mail.gmail.com>
	<CAMKF1soNohu5iM9j3Sro+MeKPObUsObwzCyFFEsO30cZQ2qJyw@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org
Subject: Re: bblayers.conf is required?
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
X-List-Received-Date: Tue, 10 Apr 2012 20:23:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-04-10 at 09:54 -0700, Khem Raj wrote:
> > Yeah, bitbake itself doesn't require bblayers.conf.
> 
> right. I forgot about bitbake's life without OE :)

Its a backwards compatibility thing. When we implemented bblayers.conf
we left it backwards compatible with what went before. It will work if
BBPATH is set such that it can find a conf/bitbake.conf .

Cheers,

Richard





