Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SkDJJ-0005wt-UE; Thu, 28 Jun 2012 13:54:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5SBi40h024564;
	Thu, 28 Jun 2012 12:44:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22465-06; Thu, 28 Jun 2012 12:43:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5SBhrXa024558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2012 12:43:54 +0100
Message-ID: <1340883837.23146.103.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Thu, 28 Jun 2012 12:43:57 +0100
In-Reply-To: <lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <1340793253.23146.19.camel@ted>
	<1340808774-24884-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1340829332.23146.86.camel@ted>
	<lyr4t0e1bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [PATCH 20/20] fetch: allow regexps in mirror protocol
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
X-List-Received-Date: Thu, 28 Jun 2012 11:54:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-06-28 at 02:18 +0200, Enrico Scholz wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> 
> >>              # Principle of least surprise. We could end up with https matching against http and 
> >>              # generating "files://" urls if we use the regexp engine below.
> >> -            if i != uri_decoded[loc]:
> >> +            if not re.match(i, uri_decoded[loc]):
> >>                  return None
> >>              result_decoded[loc] = uri_replace_decoded[loc]
> >>          elif (re.match(i, uri_decoded[loc])):
> >
> > I'm not picking on you (Enrico) here, there is a problem with my change
> > and we probably should revert my change in this area.
> >
> > However the above patch fails "bitbake-selftest" and introduces a
> > regression.
> 
> selftest fails here in
> 
> | ERROR: test_gitfetch_premirror3 (bb.tests.fetch.FetcherTest)
> | CalledProcessError: Command 'git clone git://git.openembedded.org/bitbake /tmp/tmpt_dDVD/sourcemirror.git 2> /dev/null' returned non-zero exit status 128

I've pushed a fix for this issue. That one was a bug in the test code
(which needed a chdir adding since cwd from the previous test was
removed causing the error).

Cheers,

Richard




