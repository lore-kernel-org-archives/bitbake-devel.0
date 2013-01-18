Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TwArH-0002oP-HC for bitbake-devel@lists.openembedded.org;
	Fri, 18 Jan 2013 13:15:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IC0HBB008638;
	Fri, 18 Jan 2013 12:00:17 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05490-03; Fri, 18 Jan 2013 12:00:13 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id r0IC09t9008632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2013 12:00:10 GMT
Message-ID: <1358510410.27799.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: hallerHarry@gmx.de
Date: Fri, 18 Jan 2013 12:00:10 +0000
In-Reply-To: <20130117185045.24970@gmx.net>
References: <20130117185045.24970@gmx.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake DEPENDS problem
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
X-List-Received-Date: Fri, 18 Jan 2013 12:15:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-01-17 at 19:50 +0100, hallerHarry@gmx.de wrote:
> Hi,
> 
> I've got the below described minimalistic bitbake setup. There are two
> recipes where one recipe (mySecPkg.bb) DEPENDS on the other
> (myPkg.bb).
> According to the OpenEmbedded User Manual [1] and the Yocto Pokey
> Manual Section 2.3 [2] I would have expected if I run build against
> mySecPkg that bitbake obeys inter-package dependencies and also builds
> myPkg since mySecPkg DEPENDS on it.
> But this is not the case. Bitbake only builds mySecPkg. Is there
> something wrong with my assumption or setup? I would appreciate if
> someone could shed some light on that.
> 
> Thanks in advance for any assistance provided!

You've not added any information about what DEPENDS means. Try adding
something like:

do_build[deptask] = "do_build"

to myBaseClass.bbclass which will then cause it to look at DEPENDS for
the do_build task.

Cheers,

Richard



