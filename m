Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tcv6g-00044g-Ov for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 10:36:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLcSwZ017932;
	Sun, 25 Nov 2012 21:38:28 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15876-04; Sun, 25 Nov 2012 21:38:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAPLcJPs017926
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 25 Nov 2012 21:38:21 GMT
Message-ID: <1353879499.21863.32.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sun, 25 Nov 2012 21:38:19 +0000
In-Reply-To: <alpine.DEB.2.02.1211240910580.934@oneiric>
References: <alpine.DEB.2.02.1211240910580.934@oneiric>
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
X-List-Received-Date: Mon, 26 Nov 2012 09:36:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-11-24 at 09:23 -0500, Robert P. J. Day wrote:
> preparing my own write-up on how bitbake processes combinations of
> overrides, _append and += and ran across an example in oe-core that is
> unnecessarily whitespacey, just wanted to make sure i was
> understanding this properly.
> 
>   in the current bitbake user manual, there's this example of mixing
> overrides, _append and +=:
> 
>   OVERRIDES = "foo"
>   A_foo_append = "X"
>   A_foo_append += "Y"
> 
>   This behaves as per the first case above, but the value of A would
>   be "X Y" instead of just "X".
> 
>   that, of course, makes sense as the "+=" operator automatically adds
> a leading space to what is being appended.  so for fun, i scanned all
> of oe-core looking for examples of "_append.*+=" for classroom demo
> purposes, and the *only* examples i found were in
> meta/recipes-devtools/python/python-smartpm_1.4.1.bb:
> 
> RDEPENDS_python-smartpm_append = " python-smartpm-backend-rpm python-codecs python-textutils python-xml"
> RDEPENDS_python-smartpm_append += " python-fcntl python-pickle python-crypt python-compression python-shell"
> RDEPENDS_python-smartpm_append += " python-resource python-netclient python-threading python-unixadmin"
> 
>   i can see that that first line *does* need an explicit leading space
> in the value being assigned, but the next two "+=" lines don't, do
> they?

No, they don't.

Cheers,

Richard



