Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id B8D156E8E1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 10:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 38FBE2E2B3;
	Fri, 21 Feb 2014 11:10:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id pjQmpV3t49Ls; Fri, 21 Feb 2014 11:10:01 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id DD3DA2E2AE;
	Fri, 21 Feb 2014 11:10:01 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id BD4CEBBD;
	Fri, 21 Feb 2014 11:10:01 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id B1FC41F9;
	Fri, 21 Feb 2014 11:10:01 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id B0C6A34049;
	Fri, 21 Feb 2014 11:10:01 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Fri, 21 Feb 2014 11:10:01 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 21 Feb 2014 11:10:01 +0100
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake: Disable pseudo in
	runfetchcmd()
Thread-Index: Ac8u7RQuUeMELNLAR2KswUeT0ZarXw==
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7A556AE5601@xmail3.se.axis.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Fri, 21 Feb 2014 10:10:11 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Mark Hatle
> Sent: den 20 februari 2014 16:43
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: Disable pseudo in
> runfetchcmd()
>=20
> On 2/20/14, 8:55 AM, Peter Kjellerstedt wrote:
> > If a fetcher, e.g., git, is run when pseudo is active it will think
> > it is running as root. If it in turn uses ssh (as git does), ssh too
> > will think it is running as root. This will cause it to try to read=20
> > root's ssh configuration from /root/.ssh which will fail. If ssh then=20
> > needs to ask for credentials it will hang indefinitely as there is=20
> > nowhere for it to ask the user for them (and even if there was it=20
> > would not access the correct private keys).
> >
> > The solution to the above is to temporarily disable pseudo while
> > executing any fetcher commands. There should be no reason for them=20
> > to be executed under pseudo anyway so this should not be a problem.
> >
> > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > ---
> >   bitbake/lib/bb/fetch2/__init__.py | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/=
__init__.py
> > index de95074..1c3ee4f 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -680,6 +680,9 @@ def runfetchcmd(cmd, d, quiet =3D False, cleanup =
=3D []):
> >           if val:
> >               cmd =3D 'export ' + var + '=3D\"%s\"; %s' % (val, cmd)
> >
> > +    # Disable pseudo as it may affect ssh, potentially causing it to h=
ang.
> > +    cmd =3D 'export PSEUDO_DISABLED=3D1; ' + cmd
> > +
>=20
> This may be a reasonable workaround... but is there any way we can
> identify the offending command and create a reproducer for pseudo?

Not sure what that means, but see below.

> It would be nice to identify what the actual problem is -- as=20
> something else in the system may encounter it.

So far the only time we have seen it is in get_machine_branch() in=20
kernel-yocto.bbclass which is called from do_patch(). We use our=20
own kernel which is retrieved from our Git server. The Git server=20
requires that one authenticates using a private key. However, when=20
ssh (as run by git ls-remote) is run under pseudo it tries to access=20
/root/.ssh which fails. As it can't find any keys it then asks for a=20
login password instead (I think, there is no prompt or anything from=20
ssh) and hangs indefinitely as there is no way to provide the=20
password. And even if there had been a way, it would not have worked=20
anyway as no such password exist.

The problem only manifests itself very rarely. Yesterday was my=20
third opportunity to debug it in a number of months, each time=20
getting a little further. Typically during debugging I have then=20
done something that makes bitbake continue past the hanging point=20
and after that it was no longer possible to trigger the problem.=20
However, yesterday I finally managed to create a test case which=20
consistently reproduces the problem. Try adding the following to a=20
recipe that retrieves from Git and that has a tag=3D in the SRC_URI:

fakeroot do_lockup() {
	foo=3D"${@ bb.fetch2.Fetch([], d)}"
}
do_lockup[nostamp] =3D "1"
addtask do_lockup

The second time I run "bitbake -c lockup <recipe>" it hangs, and=20
any time after that that I run it again.

> --Mark
>=20
> >       logger.debug(1, "Running %s", cmd)
> >
> >       success =3D False
> >

//Peter


