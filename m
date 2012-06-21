Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Shimq-0002nX-J7 for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 16:55:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LEiEJq023424;
	Thu, 21 Jun 2012 15:44:14 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22780-06; Thu, 21 Jun 2012 15:44:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5LEi6eR023418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2012 15:44:07 +0100
Message-ID: <1340289848.1640.125.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Stenberg <bjst@enea.com>
Date: Thu, 21 Jun 2012 15:44:08 +0100
In-Reply-To: <20120621122637.GF7204@giant>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
	<1756623.6zWylpP7a0@helios> <20120621112555.GD7204@giant>
	<1778547.OMx1BrFPz0@helios> <20120621122637.GF7204@giant>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
X-MIME-Autoconverted: from 8bit to quoted-printable by tim.rpsys.net id
	q5LEiEJq023424
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: ensure -f causes dependent tasks to be re-run
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
X-List-Received-Date: Thu, 21 Jun 2012 14:55:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-21 at 14:26 +0200, Bj=C3=B6rn Stenberg wrote:
> Paul Eggleton wrote:
> > Why do you want it to be producing the same checksum for potentially
> > different contents?
>=20
> I don't. Sorry if that was unclear. I want:
>=20
> a) That we don't need an -f option at all, i.e. that we have
> dependency tracking pinned down so well that any changed input
> automatically causes a rebuild and changed hash. (A boy can dream,
> can't he? :-), or

For what its worth I share the dream and in many ways we are working
towards it. There are a few things we still need to figure out to make
that possible without totally destroying performance but we're closer
than we ever have been.

This is also a reason I fought hard not to have a "cleansstate" task.
What would be the point of it? I did give in and let it in whilst
various fixes were made to sstate but I'd like to think we can remove it
at some point.

Cheers,

Richard



