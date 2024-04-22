Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B7C4345F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 17:17:10 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web10.1806.1713806226754829077
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Apr 2024 10:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=dl9pf@gmx.de header.s=s31663417 header.b=YH3Csbs7;
 spf=pass (domain: gmx.de, ip: 212.227.15.18, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713806223; x=1714411023; i=dl9pf@gmx.de;
	bh=rupiAsoawPXATmHVE5iPOKVaDP2dReak9SBmArVv5r4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YH3Csbs7JCtNaqeqHm5YMSZXuxEfGwcytFVlnm6ua4IddiPG0a5KxpVSDEbrWw6Q
	 Szv9bUtc5fPi16zxt9brBJ6jFolJquzVqPrLBIM4LHOAk5OEfY+S6Xe4Pa4KKMuKW
	 0oS5PlyGpaOe22AeIutb6/uNhIWTyMFog/y7X3dp5H4blaxAZQL3qtTVbmOhWEnhW
	 opqzSmjNoMTiR9Ii/3YalhhtQmNKFe8bGNO2eCo6D+evBb07QXeD5Glc5n0239513
	 dTguBRazm7JRS65uodg+Mk8nt5UcXrErWezojP2t9DD67QN0PVssU6B9QnjUHQzdn
	 OKR3BOSpEQe7k+PYsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from monster.localnet ([77.23.168.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1sbZlK19IT-00f8uB; Mon, 22
 Apr 2024 19:17:03 +0200
From: Jan-Simon Moeller <dl9pf@gmx.de>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: 
 Re: [bitbake-devel] bitbake-selftest losing sqlite3 database contents!
Date: Mon, 22 Apr 2024 19:17:02 +0200
Message-ID: <7682889.EvYhyI6sBW@monster>
In-Reply-To: 
 <CAJdd5GahxnL8ab7rh5bggOhh7CnT6ry8WzfT-aZEpvmMTmDE4Q@mail.gmail.com>
References: 
 <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <10108676.tdPhlSkOF2@arbeit>
 <CAJdd5GahxnL8ab7rh5bggOhh7CnT6ry8WzfT-aZEpvmMTmDE4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fp6/3/O+OVQYMnOQC/fCun+uPGFYlnWnkHg5E14YdmhGDdAoQIa
 BXRMFqpRZLYKxNL9hIUwR5vAsLRCTlGkS/lhZutsbqkxrbfRNlNfOwOfHBE8PfQy11/YLbh
 kzQsYU0ou356/CbbjhrpjuGveNXrKxiGe4fgOTI/xMh6sPUVjEvsDC3Aoclgy+UF1wevOAb
 k01L+4N9JWBWxen9dQ95Q==
UI-OutboundReport: notjunk:1;M01:P0:M+PnmUvVNds=;iZwEmOjXspNJgrlVLN3O3Idq7VR
 hEbQ8EYVr9C5oUpFUd08r65JWglxQqfadT1WdknZxH11PxvR76k7qI5/8RWqr3tpYYFBlAQbs
 6u86ioqFqTd8Z+PZztJkykjn4vqmafA8vlJrPmraRuy3LM4wzy1gcKp4ElKd6ZUKtpIvqc67N
 +3l5jKHVyBaEOl28QEEm1vBQ4D8pAG0EXZ0mY9d81IlT1RegL4X7Ma4hzt536joA4GwzVX8u9
 F/hSK+p4aKmQBjeP9Ai2BqaqaS72gQCwAbh8mhzG+9jsWkjDBWF1X4f+zYPm29gV6AcuuV9y4
 lnCf/Qbri3bmonLkIPqNneSTHigPvrxvNEYHCVJKDaD4s2c2n+4NKz5uSOMcpq8QBpuzZLVW2
 tytGTAhtdteQ8Tc2Aayn5GDcHdO9OBkL6XGRMn6W/bNs+83fI4FIfM204261y01b/GqdX2O+W
 ihVJJZSfUhun5/mxjhaqY3caEK4pOYSv2MzMk1mJbcsM5AIgNJYmXy64xRKIXT7LzOlhW+/LO
 S8Z4ZnZR9AEg7EnI7aWkxOcsDM/fOqgXwBt85a8lVILseMdSOglxpc62ZnCSDS3h33L//jtzp
 oya7R8TUtIbYgWAvH3wlH+zw0WdlphVYHPFc4lSFAymtkkLpKLIzI2mBYnbUSl1ctOTqdPpWb
 NOlkf0qgMubSvKX88bAwMRFqGQSM41+C93BnlK1yW6j3cshKoznp3BI+Mw0eokGuYhyBV34sg
 Dopi71kJntYyc6S3Q+BODro30xilPU1bP7tiFItPJOkQG/EXNsBfcWY6d1PfWsQMKRW2BEEeV
 bp3EAxZ9SKM/p94yYlOkUvFoIqDKczrjVpq6oy/1HVzIg=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Apr 2024 17:17:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16122

Sorry for highjacking the thread ... reply inline.

<snip>
Am Montag, 22. April 2024, 16:47:48 CEST schrieb Joshua Watt:
> On Mon, Apr 22, 2024 at 4:00=E2=80=AFAM Jan-Simon M=C3=B6ller <dl9pf@gmx.=
de> wrote:
> > Am Samstag, 20. April 2024, 22:35:33 CEST schrieb Joshua Watt via=20
lists.openembedded.org:
> > @Richard/Josh:
> > Let me add (yes, grumble a bit ;) ) : for me as *end user* of this, this
> > is all the same and would be best kept in one single server that I can
> > scale. Having it split into two just complicates things ... and now for
> > scarthgap, we need another instance of the hashserv due to the API
> > change. Please consider this from a user perspective working on multiple
> > branches and not just one master branch! The data might not be 'the sam=
e'
> > or not 'connected', but they are still linked in a way and moreover we
> > are exposing this to users to use and usage gets mandatory if we think =
of
> > speeding up builds and binary feeds. Don't get me wrong, this is good
> > stuff, but we make it hard for general use. Wrt scaling: - essentially
> > we're setting us up with scaling problems wrt prserv down the road when
> > it gets needed for binary feed. Heck, we're just solving this for
> > hashserv, so why not do this likewise right away - at best put both in
> > one server?
> Can you clarify what you mean by "both in one server"? There are a lot
> of different levels of varying complexity that could be done for that.
> For example, you could:
> 1) Run both servers as separate processes in e.g. a shared container
> 2) Run both servers in a shared script
> 3) Combine the API into a single server API
>=20
> These are generally more complex with more caveats as you go; #1 is
> the "easiest", #2 isn't possible until the PR server is completely
> asynchronous like the hashserver (otherwise it won't scale at all),
> and #3 is basically a completely new (breaking) API.

To be really honest, only #3 makes sense from my perspective  aka 'end user=
=20
perspective' .


#1 is what we do already for the existing pr+hashserv ...=20
excuse my language, but it s**ks. You need to care for multiple API revisio=
ns=20
aka double (pr+hash) the port numbers to punch through. Each breaking API=20
update needs us to start more server processes and punch through more ports=
=2E=20
This is such a maintenance pita.

#2 is no difference to #1 if you think of different branches being in use.

> My preference is #1 or #2, but #2 makes no sense until the PR server
> has all of the features of the hash server; this patch series adds
> websockets which is a good step, but it would also need the database
> backend re-written to be nonblocking like the hash server, otherwise
> it's just asking for scaling problems if you run them in the same
> process :)

Nack.
Just teach Hashserv to store/serv the additional values and be done ?
Thanks to your great work on scaling the hashserv, we're almost there wrt=20
deployments at scale. Why do that whole setup again for prserv ?
We'd have to duplicate also all the assets we use during scale-out ?

> Also keep in mind that one of the goals of the websockets server is to
> reduce the need for the "read-only" server, since you can have your CI
> authenticate with the hash server and get rw access, but anonymous
> users can be given read-only access.

Even better, then put it in one combined pr+hashserv, on one port, so we ca=
n=20
manage the whole thing easily.=20
Think of it ...  why would you want to deal with auth for 2 servers (pr+has=
h)?
This just leads to mismatches in auth (we all make mistakes during setup) a=
nd=20
having to deal with twice as much credentials ... why?
I can't think of a case where I'd r/w on one but r/o on the other. It makes=
 no=20
sense.
=20
> In short, there is space to make it a little easier to stand up the
> servers in some common ways, but I'm hesitant to force everyone to run
> the servers a specific way as I don't think there is a "one size fits
> all".
In the end: This is both 'metadata' that we want to store / reuse with=20
bitbake. And more so going forward. So keep it simple also for the users.
This is not PR data vs hashserv data. Both is metadata we want to keep.

One size - actually I think exactly that. This makes it easier to run a loc=
al=20
instance (just one - no mismatches possible). But also scale out if require=
d=20
and not doubling the infra (and cost!)  when doing so.


Best,
Jan-Simon




