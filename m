Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TgxBe-0005kx-5F; Fri, 07 Dec 2012 13:37:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB7CNNe9005471;
	Fri, 7 Dec 2012 12:23:23 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01099-08; Fri,  7 Dec 2012 12:23:18 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qB7CNDeS005465
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Dec 2012 12:23:14 GMT
Message-ID: <1354882981.12928.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Fri, 07 Dec 2012 12:23:01 +0000
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
X-List-Received-Date: Fri, 07 Dec 2012 12:37:50 -0000
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
> | ERROR: calledvar=autotools_do_configure, vars=[['gitpkgv_do_configure', 'autotools_do_configure'], ['do_configure', 'gitpkgv_do_configure']], allvars=['do_configure', 'autotools_do_configure', 'gitpkgv_do_configure'], classes=[None, 'gitpkgv', 'autotools']
> 
> for such a recipe (note the 'gitpkgv_do_configure')
> 
> 
> For me, it seems that this depends on the (random) order in which recipes
> are read.  E.g. when a recipe using 'gitpkgv' is read first, the global
> 'classes' array will contain 'gitpkgv' and ExportFuncsNode() is constructed
> with it.
> 
> But when m4 is read before the first recipe using 'gitpkgv', it won't be
> contained in 'classes' and the corresponding ExportFuncsNode() will not
> create this variable.
> 
> 
> Does somebody know how to fix this?

Actually, I think I do have theory for what is happening. I think there
is some kind of exception happening in one of your recipes which is
perhaps causing it to be skipped/ignored and this is corrupting the
state of the parser.

I'm guessing the classes variable in BBConfHandler.py isn't getting
reset to [None, ] and hence the next recipe to be parsed sees "oddness"
due to the field not being reset.

This would happen in the classes.remove(__classname__) line never get
called, which would happen if statements.eval(d) or some other part of
the processing failed.

I would add some debug code into gitpkgv.bbclass around the functions
there, perhaps a try:/except: and see if there is some kind of uncaught
exception happening for one of your recipes. If that isn't it, I would
be intersted to understand what you have which is breaking out the
fetcher. It could be a SkipPackage exception under some circumstance for
example.

This would explain the cause, we then need to fix the parser state
engine so its properly reset each time...

Cheers,

Richard



