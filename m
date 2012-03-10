Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6OOx-0003LP-UV for bitbake-devel@lists.openembedded.org;
	Sat, 10 Mar 2012 16:40:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2AFVS1u026581;
	Sat, 10 Mar 2012 15:31:28 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26543-01; Sat, 10 Mar 2012 15:31:24 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2AFVG6F026575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 Mar 2012 15:31:19 GMT
Message-ID: <1331393473.7996.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andreas Oberritter <obi@opendreambox.org>
Date: Sat, 10 Mar 2012 15:31:13 +0000
In-Reply-To: <4F54AE8A.2070403@opendreambox.org>
References: <1330833563.3949.1.camel@ted> <4F54AE8A.2070403@opendreambox.org>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: Convert getVar/getVarFlag(xxx, 1) -> (xxx, True)
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
X-List-Received-Date: Sat, 10 Mar 2012 15:40:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-05 at 13:16 +0100, Andreas Oberritter wrote:
> On 04.03.2012 04:59, Richard Purdie wrote:
> > Using "1" with getVar is bad coding style and "True" is preferred.
> 
> Slightly OT, but wouldn't it be more convenient, especially for external
> callers like OE, to make True the default for getVar? This would also
> make getVar somehow more symmetric to setVar.
> 
> A rough, inexact comparison between usage of True vs. False [1]:
> 
> bitbake: 214 times True, 25 times False
> openembedded-core: 1143 times True, 49 times False
> meta-openembedded: 93 times True, 1 time False

It would be convenient but would also change things in a way which would
introduce hard to detect subtle bugs. We're thought about it before and
concluded it would cause too much confusion/breakage.

Cheers,

Richard



