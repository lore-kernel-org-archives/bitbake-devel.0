Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TTrnA-0004AG-CE for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2012 11:14:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA1A0ntn007136
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Nov 2012 10:00:49 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15538-04 for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Nov 2012 10:00:45 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA19xtTR007105
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Nov 2012 10:00:42 GMT
Message-ID: <1351750475.6502.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 01 Nov 2012 06:14:35 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: 1.16 stable series
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
X-List-Received-Date: Thu, 01 Nov 2012 10:14:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

One of the issues with previous OE-Core and Poky releases has been
deciding which bitbake should be used used with them. There is a copy of
bitbake in poky denzil which is a now becoming a bit of a Frankenstein,
not corresponding to any particular bitbake release with various random
patches from master. This isn't necessarily a bad thing and users of
poky find it useful but I think we can do better.

This time around, for the danny series I made sure we had a bitbake
stable branch available to correspond with it (1.16). I'm planning to
use the 1.16 branch as a stable bitbake branch and directly include that
in poky-danny verbatim. So far I don't think there have been any
invasive changes on master so I might just push current master into the
1.16 branch. As development moves forward, we'd move to a model of
picking specific commits that make sense for the branch.

I really just wanted to let people know what I was intending here, I
doubt its too controversial and if people have specific things they want
to see in the stable branch, feel free to point them out!

Cheers,

Richard








