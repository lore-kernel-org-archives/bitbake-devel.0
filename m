Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <peter.kjellerstedt@axis.com>) id 1U1Cqb-0008LL-EB
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Feb 2013 10:24:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 3254919E45;
	Fri,  1 Feb 2013 09:58:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3OjQXCIq7Uum; Fri,  1 Feb 2013 09:58:17 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 6A82119E44;
	Fri,  1 Feb 2013 09:58:17 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id 2EFFD3422F;
	Fri,  1 Feb 2013 09:58:17 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Fri, 1 Feb 2013 09:58:17 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 1 Feb 2013 09:58:16 +0100
Thread-Topic: [bitbake-devel] [PATCH v2 0/6] fetch2: Updated SFTP fetcher
Thread-Index: Ac3/sLDAtuSsil34QVG+KN6X/wKhtQAqR8gQ
Message-ID: <A612847CFE53224C91B23E3A5B48BAC755FD2F5C40@xmail3.se.axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1359445811-6394-1-git-send-email-olof.johansson@axis.com>
	<20130130075555.GA7508@axis.com> <1359636205.14071.28.camel@ted>
In-Reply-To: <1359636205.14071.28.camel@ted>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Olof Johansson <olofjn@axis.com>
Subject: Re: [PATCH v2 0/6] fetch2: Updated SFTP fetcher
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
X-List-Received-Date: Fri, 01 Feb 2013 09:24:22 -0000
X-List-Received-Date: Fri, 01 Feb 2013 09:24:22 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 31 januari 2013 13:43
> To: Olof Johansson
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH v2 0/6] fetch2: Updated SFTP
> fetcher
>=20
> On Wed, 2013-01-30 at 08:55 +0100, Olof Johansson wrote:
> > Hi,
> >
> > On 2013-01-29 08:50, Olof Johansson wrote:
> > > Olof Johansson (6):
> > >   fetch2: Remove unused code in wget fetcher
> > >   fetch2: Add a class representing a generic URI
> > >   fetch2: unittests for bb.fetch2.URI class
> > >   fetch2: Adapt encode/decode url to use URI class
> > >   fetch2: Add editor modelines for bb.tests.*
> > >   fetch2: Add SFTP fetcher
> >
> > One thing I forgot to mention; after speaking with kergoth on IRC
> > last Friday, we found that there are some performance penelties
> > in using the URI class instead of encode/decodeurl. I tried to
> > profile and see if there were any obvious ways to get it down to
> > the level of the old encode/decodeurl, but nothing obvious.
> >
> > I did the performance evaluation by running the unittests.
> >
> > Forking and running the unittests in seperate processes shows no
> > change:
> >
> >  http://codepad.org/SYsVsckY
> >
> > However, running them in a single process with the timeit module
> > shows a pretty big (proportional) regression:
> >
> >  http://codepad.org/Vzu7Pqqw
> >
> > Is this significant? Running the tests 10000, each run creating
> > three URI objects, takes ~2 seconds.
>=20
> In the scheme of things and other bitbake overheads, I'd suspect its
> not significant although it is a good thing to check...
>=20
> What were the other changes between v1 and v2? In cases like this a 0/6
> summary email is helpful.
>=20
> Cheers,
>=20
> Richard

The list of changes between v1 and v2 were in the 0/6 mail that=20
Olof did send (the one he replied to above). I have included them=20
below:

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Olof Johansson
> Sent: den 29 januari 2013 08:50
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH v2 0/6] fetch2: Updated SFTP fetcher
>=20
> Changes since the first draft (thanks Martin Jansa for the feedback):
>=20
>  * Rebase against current master
>  * Regenerate diffs without git config diff.noprefix
>  * Support /~/ (home relative URIs) in SFTP fetcher
>  * Add an example section in the SFTP fetcher documentation
>  * Remove "checkstatus" method from SFTP fetcher (wasn't meant to be ther=
e)
>=20
> Olof Johansson (6):
>   fetch2: Remove unused code in wget fetcher
>  ...

//Peter



