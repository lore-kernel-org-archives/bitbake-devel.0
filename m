Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SAOOn-0003Y4-By; Wed, 21 Mar 2012 17:28:33 +0100
Received: by wera1 with SMTP id a1so1106634wer.6
	for <multiple recipients>; Wed, 21 Mar 2012 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=VPz1TwJfGk/qR6eE6Xt0aVfOOsxqqUcaC7O0sa42aIc=;
	b=y80c/MSVJcLQWGKhBoVck9aiwHr5INuAfu8GsMy+S8CFW3gUqY0SvvSXPuH5G1On6U
	/GmqQg33DHnNZlD4IIQAYc6vVxS+M0+H9Re8cpAOKO4PI+xk9aTprQL+jZ7gONQszW5Y
	Xzp0QA2fl1XdwvFuNVER9z9y+aWRioTBqrh8YGVD7XeiGWPGr1FeXYWWVYvYRAguYnJF
	3TEtkrEqKLjUy6fDgbbZYpQUEoWzud0DaCuV4AFf+A7Snd0CjKZa45SvaBdfvhDsHfiW
	OD89x8J+cDq0TI+PeGBY1idtpamArJhxvSA2UlU0JoKvhKcfIRFOrSgAPQahOeuXru0K
	uXwg==
Received: by 10.216.131.34 with SMTP id l34mr2607659wei.54.1332346779442;
	Wed, 21 Mar 2012 09:19:39 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id d7sm9199402wiz.6.2012.03.21.09.19.36
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 21 Mar 2012 09:19:37 -0700 (PDT)
Date: Wed, 21 Mar 2012 17:19:36 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Koen Kooi <koen@dominion.thruhere.net>
Message-ID: <20120321161936.GA3659@jama.jama.net>
References: <1331852164.18586.166.camel@ted>
	<A4FAC08D-E547-40BF-9CAF-98D82B152CE9@dominion.thruhere.net>
MIME-Version: 1.0
In-Reply-To: <A4FAC08D-E547-40BF-9CAF-98D82B152CE9@dominion.thruhere.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] ui/knotty: Add a footer to the build output for interactive terminals
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
X-List-Received-Date: Wed, 21 Mar 2012 16:28:33 -0000
X-Groupsio-MsgNum: 1441
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline

--XF85m9dhOBO43t/C
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 01:24:00PM +0100, Koen Kooi wrote:
>=20
> Op 15 mrt. 2012, om 23:56 heeft Richard Purdie het volgende geschreven:
>=20
> > I've sent this before, this is an updated version with several bugfixes
> > and improvements. Its a major change but one I think people will like
> > overall as I hear a lot of complaints about the verbose console
> > messages. v0 never got complaints so I will merge this fairly quickly
> > unless there are objections.
> >=20
> > ---
> > On terminals which support it, add summary information to the end of the
> > build output about the number of tasks currently running and how many t=
asks
> > we've run so far.
> >=20
> > This provides a summary at a glace of what the current state of the bui=
ld is
> > and what the build is currently doing which is lacking in the current U=
I.
> >=20
> > Also disable echo of characters on stdin since this corrupts the disabl=
e,
> > particularly Crtl+C.
> >=20
> > The "waiting for X tasks" code can be merged into this code too since
> > that is only useful on interactive terminals and this improves the
> > readability of that output too.
> >=20
> > Improvements since v0:
> >=20
> > * The tasks are ordered in execution order.
> > * The display is only updated when the list of tasks changes or there
> >  is output above the footer.
> > * Errors early in the init process don't corrupt the terminal
> > * Running task x of y and package messages are suppressed from the cons=
ole
>=20
> I like it a lot, but there is one missing thing. Have a look at the follo=
wing output:

I like it too.

1) it doesn't break my usual use-case=20
bitbake foo | tee -a log.${MACHINE}

2) with more threads it was hard to see that task is on "background"

But as I often want to see if some particular task was already finished
then I've changed InteractConsoleLogFilter like this to keep
task Started/Succeeded messages above footer.

Cheers,
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-knotty-filter-only-Running-NOTEs.patch"
Content-Transfer-Encoding: quoted-printable

From dab4d382e9257d2493e36dccf67b9d1d056965bf Mon Sep 17 00:00:00 2001
From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 21 Mar 2012 17:09:45 +0100
Subject: [PATCH] knotty: filter only "Running" NOTEs

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/ui/knotty.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 4a7e6b9..61ff9dd 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -174,7 +174,7 @@ def main(server, eventHandler):
=20
     class InteractConsoleLogFilter(logging.Filter):
         def filter(self, record):
-            if record.levelno =3D=3D format.NOTE and (record.msg.startswit=
h("Running") or record.msg.startswith("package ")):
+            if record.levelno =3D=3D format.NOTE and record.msg.startswith=
("Running"):
                 return False
             clearFooter()
             return True
--=20
1.7.8.5


--CE+1k2dSO48ffgeK--

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9p/5gACgkQN1Ujt2V2gBxkCgCeO3Jl3P5lqz225RiPcL/5BfzG
ZRAAoLVWF58QM8kuZxIKmFo1Y4uZlsKf
=q1vy
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
