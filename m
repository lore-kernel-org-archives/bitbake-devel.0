Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f49.google.com (mail-ee0-f49.google.com [74.125.83.49])
	by mail.openembedded.org (Postfix) with ESMTP id A87376E367
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:46:09 +0000 (UTC)
Received: by mail-ee0-f49.google.com with SMTP id d17so4427992eek.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 14:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=o+2C3FW55qJUVvKr81cvAhOMi8o0jBheoqNWYyrPUWg=;
	b=niSZvzNCgDaLy8nrIkLLkjDjAZstPUuDdQaecJ7xWUzP2NG7zvYB9perbKQ1RLjUHV
	y3Rjqj5O17UzolL7poEpMFeF+fTXw1MxNlq+pdcw2b66QE4l0wz0gIt9iBPpofqB67L3
	qFbsbo0EBJdZT8FOX7ibrao0NGq0n5Ez3R0hZhaIfRo41ml62fK+xCvJP+v0ZdgrHbqG
	Lc3MNDEpEwaqeLqpQoLRHuOEG2meezMO/7KtiOFYlgozX+E9nRPTUYZ7ES4dViEWtbkO
	rhfzYzdrysF3Kk44StRBD/iSN2vh5mKDRQ5IoWmejR0kAtFuL04M0sVzfT7cHL5MpF8b
	Kd2g==
X-Received: by 10.14.115.8 with SMTP id d8mr447501eeh.83.1390344370312;
	Tue, 21 Jan 2014 14:46:10 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id i2sm19801238eem.6.2014.01.21.14.46.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Jan 2014 14:46:09 -0800 (PST)
Date: Tue, 21 Jan 2014 23:46:09 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140121224609.GK4100@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted> <1390343853.874.130.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1390343853.874.130.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Jan 2014 22:46:11 -0000
X-Groupsio-MsgNum: 4359
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
Content-Disposition: inline

--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 10:37:33PM +0000, Richard Purdie wrote:
> On Wed, 2014-01-01 at 23:38 +0000, Richard Purdie wrote:
> > Nothing changed in the data -S writes out.=20
> >=20
> > Yes, it does currently crash in some cases which is obviously a bug
> > however assuming we fix that you can ignore what -S prints on the screen
> > or writes to a file or whatever we end up doing and just do what you're
> > doing now.
> >=20
> > On the other hand we have a huge hole in the current model when you
> > don't have the two environments to compare. You have the current build
> > and you want to know why the cache isn't being used. That is a valid
> > user question which shouldn't need another build to compare against.
> >=20
> > So can we find the "least delta" fast? Its not actually that hard
> > computationally or on resources, at least in the experiments I've made.
> > We know the hashes of the current target's tasks and we can quickly tell
> > which are in the cache and which are not (using the same function sstate
> > uses for that purpose).
> >=20
> > That gives you a set of delta points with the sstate cache but you also
> > know the recipe name and other details about the target of interest and
> > that they should have common parent tasks. Based on that information you
> > can come up with a list of possibilities of least difference and sort
> > those by date (which bitbake-diffsigs -t uses) or whatever other
> > mechanism we end up choosing to display the data.
> >=20
> > I agree its not always going to give useful information but its a start
> > in the right direction and my local tests suggest its perhaps good
> > enough to give the user the hints they want about cache reuse (or lack
> > of).
> >=20
> > I agree we're not there yet, equally, to be quite honest the current
> > debug of sstate sucks and we need to do something about it. Whilst you
> > and I may understand it and are able to debug issues, many users are
> > struggling with it :(.
>=20
> I appreciate its taken me a while to loop back around on this but I do
> now have an idea. What I'm proposing we do is add an optional parameter
> to -S. Without any parameter it would behave as it did classically.
>=20
> With a parameter, it could trigger the current "debug sstate" behaviour
> to stdout and it also allows it to trigger an sstate siggen specific
> behaviour as appripriate. I have some prototype code with writes out a
> "locked-sigs.inc" file for example, triggered from this same code block.
>=20
> I think this should let us do more creative things with sstate (even
> from the OE siggen class) yet also let it remain useful for different
> people.
>=20
> I don't have any code to do this yet but at least we have a plan
> assuming no strong objections.

I strongly support this plan :).

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLe+LEACgkQN1Ujt2V2gBxtbwCfbhiDVVMWEX9dkTmiNJ9DBJPr
7VoAn0ES5Yiy7xSQEqMTkBQoKrgwQwJs
=431h
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--
