Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QvFu5-0008CX-7x for bitbake-devel@lists.openembedded.org;
	Sun, 21 Aug 2011 23:50:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7LLjDMH014003;
	Sun, 21 Aug 2011 22:45:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02329-10; Sun, 21 Aug 2011 22:45:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7LLixfb013981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Aug 2011 22:45:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
In-Reply-To: <alpine.DEB.2.02.1108191305430.5421@localhost6.localdomain6>
References: <alpine.DEB.2.02.1108191305430.5421@localhost6.localdomain6>
Date: Sun, 21 Aug 2011 10:40:45 -0700
Message-ID: <1313948445.5939.2.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	p7LLjDMH014003
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: docs on git fetcher don't match actual code
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
X-List-Received-Date: Sun, 21 Aug 2011 21:50:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-08-19 at 13:11 -0400, Robert P. J. Day wrote:
> perusing the bitbake user manual earlier and the section on the git
> fetch module doesn't sync up with the code.  from the user manual:
>=20
> "The parameters are tag, protocol and scmdata. tag is a Git tag, the
> default is =E2=80=98master=E2=80=99. protocol is the Git protocol to us=
e and defaults
> to =E2=80=98rsync=E2=80=99."
>=20
>   however, in fetch2/git.py, one reads:
>=20
> - protocol
>    The method to use to access the repository. Common options are
>    "git", "http", "file" and "rsync". The default is "git"
>=20
>=20
>   and, finally, further down, there's the actual check for a valid
> protocol:
>=20
>     if not ud.proto in ('git', 'file', 'ssh', 'http', 'https'):
>         raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
>=20
> which says nothing about "rsync" but lists "https" as a valid protocol
> that's not mentioned higher up.  someone way higher up the food chain
> is welcome to decide what should be clarified here.

Thanks, I've pushed a couple of commits which should clarify the
situation.

Cheers,

Richard



