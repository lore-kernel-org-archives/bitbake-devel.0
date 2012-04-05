Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SFlmm-0002w1-So for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 14:27:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35CIFvK025193;
	Thu, 5 Apr 2012 13:18:15 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25015-02; Thu,  5 Apr 2012 13:18:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35CI1Zv025186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 13:18:04 +0100
Message-ID: <1333628280.6300.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Lu, Lianhao" <lianhao.lu@intel.com>
Date: Thu, 05 Apr 2012 13:18:00 +0100
In-Reply-To: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
	<20120405062857.GK4181@jama.jama.net>
	<857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>,
	Martin Jansa <martin.jansa@gmail.com>
Subject: Re: bb.utils.vercmp() not consistent with debian rules
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
X-List-Received-Date: Thu, 05 Apr 2012 12:27:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-04-05 at 06:42 +0000, Lu, Lianhao wrote:
> Martin Jansa wrote on 2012-04-05:
> > On Thu, Apr 05, 2012 at 06:22:00AM +0000, Lu, Lianhao wrote:
> >> Hi guys,
> >> 
> >> When I'm looking at the Yocto bug#2233, I find that the function
> >> bb.utils.vercmp() is not consistent with the debian packaging
> >> rules(http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-
> >> Version).
> >> 
> >> According to debian rules, "r0" is earlier than "r0-dream", but the bb.utils.vercmp() thinks "r0" is later than "r0-dream".
> > 
> > And what about something like this:
> > 
> > Version: 3.2-r10
> > is older then
> > Version: 3.2-r2-oe0
> 
> I think this is exactly what the debian rules wants, "3.2-r10">"3.2-r2-oe0". And opkg follows that rule.
> 
> The problem is that bb.utils.vercmp thinks "3.2-r2">"3.2-r2-oe0" while opkg thinks "3.2-r2"<"3.2-r2-oe0".

All the version comparisons are meant to function the same way and the
debian sorting is meant to be used as a guide. If that patch does break
things, we should consider removing "-" as the separator and only use
".".

Cheers,

Richard



