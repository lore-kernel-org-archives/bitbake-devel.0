Received: from mail.cvg.de ([62.153.82.30])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <enrico.scholz@sigma-chemnitz.de>) id 1SmT4F-0003a2-VC
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jul 2012 19:08:44 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id q64GvatI029036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 18:57:37 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.76) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1SmStT-0006O0-Vm; Wed, 04 Jul 2012 18:57:36 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1341136320-6242-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
	<1341409510.3906.28.camel@ted>
Date: Wed, 04 Jul 2012 18:57:35 +0200
In-Reply-To: <1341409510.3906.28.camel@ted> (Richard Purdie's message of "Wed, 
	04 Jul 2012 14:45:10 +0100")
Message-ID: <lyobnvqxa8.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.97 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.85
X-Spam-Score: -5.3
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,SPF_NEUTRAL,T_RP_MATCHES_RCVD,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: try PREMIRRORS when calculating latest_revision
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
X-List-Received-Date: Wed, 04 Jul 2012 17:08:44 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

>> Since support for native git mirrors was added in recent bitbake, it
>> is possible to use local mirrors for calculating ${AUTOREV}.
>
> I'm torn over this one. If you want to refer to local changes wouldn't
> it make more sense just to totally override SRC_URI in cases

Modifying SRC_URI is a pain (split it into components, find the matching
one and replace it with the new one; managing the .bbappend file with
this code).  A declarative syntax like for PREMIRRORS is much easier too
handle and maintain.

Before native git mirrors were supported I solved it by 'url.<new>.insteadOf'
config option. But, this requires either a very recent git to set the '-c'
option in FETCHCMD_git, or the modification of global ~/.gitconfig (which
will cause conflicts and bad surprises when having multiple projects).


> I'm worried that here, upstream revisions may just get ignored for
> example with just a premirror copy being consulted and this wouldn't
> be the expected behaviour a user would want.

That's already the case with recent PREMIRRORs.  People will get the
version which is in PREMIRROR, not the upstream one.

Difference is that after applying my patch, the early recipe-parsing
will not fail when upstream unavailable.


Enrico


