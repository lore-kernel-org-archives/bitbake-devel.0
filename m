Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SKzyr-0006h8-KS for bitbake-devel@lists.openembedded.org;
	Fri, 20 Apr 2012 00:37:37 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3JMS7xu019295;
	Thu, 19 Apr 2012 23:28:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18528-07; Thu, 19 Apr 2012 23:28:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3JMRvNF019289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2012 23:27:58 +0100
Message-ID: <1334874480.3028.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Daniel Lazzari <dlazzari@leapfrog.com>
Date: Thu, 19 Apr 2012 23:28:00 +0100
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0427C336@NAEMMAIL01.na.leapfrog.com>
	<671D7BD596E04EE1961D6EA1C734C816@gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427C5FA@NAEMMAIL01.na.leapfrog.com>
	<CABcZANn_xWLbxJRPK68Eu9iLjp6jjxkefPhe61UAcxzu91ZHwA@mail.gmail.com>
	<E7A9054A5ACABE48B0E540E46E862B0F0427CB32@NAEMMAIL01.na.leapfrog.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q3JMS7xu019295
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: python function used in variable expansion called multiple times per recipe
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
X-List-Received-Date: Thu, 19 Apr 2012 22:37:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-19 at 21:24 +0000, Daniel Lazzari wrote:
> >> I think immediate expansion is what I=E2=80=99ll need to use, thanks=
 for the tip.
> >> That at least brings the invocation down to once per run. Unfortunat=
ely, the
> >> variable doesn=E2=80=99t seem to get filled in when I change to imme=
diate
> >expansion.
> >>
> >> def testFunc(bb, d):
> >>                 print( bb.data.getVar("PN", d, True) )
> >>                 return "e1"
> >>
> >> EXTERNPV :=3D "${@testFunc(bb, d)}"
> >>
> >> Now only prints the package name once, but using =E2=80=93e, I don=E2=
=80=99t see the
> >> variable EXTERNPV at all.
> >
> >Don't know what to tell you. It does work, so it's something wrong on
> >your end. Either it's returning an empty string, which will result in
> >-e only showing the commented out definition, or it's raising an
> >exception, or something else in your setup. Aside: you don't need to
> >pass 'bb' in. That namespace is always accessible, even from def'd
> >python functions.
> >--
> >Christopher Larson
>=20
> Just thought I'd provide an update real quick on this. I discovered,
> to my dismay, that even doing an immediate expansion still ran the
> code before every task for that recipe. I switched to using an event
> handler, but the RecipeParsed event occurs before every task for that
> recipe. Eventually I discovered that the variable BB_WORKERCONTEXT is
> set for RecipeParsed events when they are occurring before a task, but
> not for the initial parse. Also, I discovered that setting a variable
> in the event handler would not necessarily keep it set through
> building the recipe. Thus I devised the below code to run the time
> intensive code during initial parse and cache the value in a file so
> it can be picked up again in later events. I'm leaving this here in
> case it helps someone else.

Just as a note, we have the persist_data code in bitbake which was
written for this kind of reason in relation to SRCREV and AUTOINC which
uses a sqlite backend as the storage. There isn't anything wrong with
what you're doing, I just thought I'd mention it.

Cheers,

Richard



