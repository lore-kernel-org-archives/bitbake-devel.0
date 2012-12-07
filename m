Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Tgx2u-0005XO-AR; Fri, 07 Dec 2012 13:28:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB7CELiH005419;
	Fri, 7 Dec 2012 12:14:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32660-09; Fri,  7 Dec 2012 12:14:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB7CECP5005413
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Dec 2012 12:14:13 GMT
Message-ID: <1354882442.12928.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Fri, 07 Dec 2012 12:14:02 +0000
In-Reply-To: <lyfw3ii2ef.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyfw3ii2ef.fsf@ensc-virt.intern.sigma-chemnitz.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: Complete rebuilds due to random hashes
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
X-List-Received-Date: Fri, 07 Dec 2012 12:28:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-12-07 at 11:26 +0100, Enrico Scholz wrote:
> Hello,
> 
> I have encountered the problem the whole distribution gets rebuilt when
> I change a single, completely unrelated variable (e.g. BB_DISKMON_DIRS).
> 
> Dumping data in _build_data() (siggen.py) revealed that sometimes a
> gitpkgv_do_configure() (or _do_compile/install...) function is in the
> deps, sometimes not.  The recipes where this happens (e.g. m4) do not
> inherit gitpkgv and it is not included globally either.
> 
> Further debugging[1] shows
> 
> | ERROR: calledvar=autotools_do_configure,
> vars=[['gitpkgv_do_configure', 'autotools_do_configure'],
> ['do_configure', 'gitpkgv_do_configure']], allvars=['do_configure',
> 'autotools_do_configure', 'gitpkgv_do_configure'], classes=[None,
> 'gitpkgv', 'autotools']

I'm struggling to figure out how the code is doing this. The most
interesting piece here is:

classes=[None, 'gitpkgv', 'autotools']

and I cannot get a recipe locally to do this. classes is basically set
from BBConfHandler and its a relatively simple codepath. This would
imply the gitpkgv class is doing an "inherit autotools"?

Can you show how you're using gitpkgv in your code and what the bbclass
contains? I have the version from meta-oe but I'm failing to reproduce
or explain how this would get into there...

Are you doing anything interesting with EXPORT_FUNCTIONS anywhere in
your code?

Its very odd and any more information about your configuration would be
helpful in reproducing/debugging this.

Cheers,

Richard




