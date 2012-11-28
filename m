Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tde9o-0003Yg-RE for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 10:42:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAS9Rwj1011758;
	Wed, 28 Nov 2012 09:27:58 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11308-02; Wed, 28 Nov 2012 09:27:53 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAS9RoB7011751
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2012 09:27:52 GMT
Message-ID: <1354094869.21863.165.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 28 Nov 2012 09:27:49 +0000
In-Reply-To: <alpine.DEB.2.02.1211272138480.26903@oneiric>
References: <alpine.DEB.2.02.1211272138480.26903@oneiric>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: can "bitbake -s" be restricted to a given image?
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
X-List-Received-Date: Wed, 28 Nov 2012 09:42:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-11-27 at 21:40 -0500, Robert P. J. Day wrote:
> not sure if this is already possible, but when i run "bitbake -s",
> i'd prefer to restrict the output to just those recipes related to the
> image i'm interested in, such as core-image-minimal.
> 
>   is that already possible?  the help suggests not, but maybe i just
> missed it.

Its not possible right now, no. Its an interesting idea, perhaps file an
enhancement request bug in the yocto project bugzilla?

Cheers,

Richard



