Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tcv6e-00044g-6O for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 10:36:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLdipP017943;
	Sun, 25 Nov 2012 21:39:44 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10739-06; Sun, 25 Nov 2012 21:39:39 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLdX4c017937
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 25 Nov 2012 21:39:35 GMT
Message-ID: <1353879573.21863.33.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sun, 25 Nov 2012 21:39:33 +0000
In-Reply-To: <alpine.DEB.2.02.1211240938390.1166@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
	<alpine.DEB.2.02.1211240938390.1166@oneiric>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: wanting clarification on overrides, _append, += and combinations of those
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
X-List-Received-Date: Mon, 26 Nov 2012 09:36:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-11-24 at 09:42 -0500, Robert P. J. Day wrote:
> one more question, if i might ...
> 
> On Sat, 24 Nov 2012, Robert P. J. Day wrote:
> 
> > RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs python-textutils python-xml"
> > RDEPENDS_python-smartpm_append += " python-fcntl python-pickle python-crypt python-compression python-shell"
> > RDEPENDS_python-smartpm_append += " python-resource python-netclient python-threading python-unixadmin"
> 
>   is there a reason the above couldn't have been written as something
> like:
> 
> RDEPENDS_python-smartpm += "python-fcntl python-pickle python-crypt python-compression python-shell"
> RDEPENDS_python-smartpm += "python-resource python-netclient python-threading python-unixadmin"
> 
>   as i understand it, the purpose of "_append" is to give the
> developer control over being able to append something at the very end
> of the processing -- in other words, it's used when ordering is
> important.
> 
>   but is there any ordering issue when simply creating the value of
> RDEPENDS?  does it matter how the items are ordered there?  if not,
> then using "_append" seems like overkill.

In this case I'd agree, it does seem a little over the top.

Cheers,

Richard




