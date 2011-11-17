Received: from mail-va3.bigfish.com ([216.32.180.10]
	helo=VA3EHSOBE009.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RR52Z-0002uc-9z
	for bitbake-devel@lists.openembedded.org;
	Thu, 17 Nov 2011 17:42:19 +0100
Received: from mail137-va3-R.bigfish.com (10.7.14.243) by
	VA3EHSOBE009.bigfish.com (10.7.40.29) with Microsoft SMTP Server id
	14.1.225.22; Thu, 17 Nov 2011 16:35:10 +0000
Received: from mail137-va3 (localhost [127.0.0.1])	by
	mail137-va3-R.bigfish.com (Postfix) with ESMTP id 96ADA480427;
	Thu, 17 Nov 2011 16:35:36 +0000 (UTC)
X-SpamScore: -12
X-BigFish: VS-12(zz9371K1432N98dKzz1202hzz8275dhz2dh2a8h668h839h8e2h8e3h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail137-va3 (localhost.localdomain [127.0.0.1]) by mail137-va3
	(MessageSwitch) id 1321547736257575_5167;
	Thu, 17 Nov 2011 16:35:36 +0000 (UTC)
Received: from VA3EHSMHS011.bigfish.com (unknown [10.7.14.235])	by
	mail137-va3.bigfish.com (Postfix) with ESMTP id 369E740044;
	Thu, 17 Nov 2011 16:35:36 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS011.bigfish.com
	(10.7.99.21) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Thu, 17 Nov 2011 16:35:08 +0000
Received: from 039-SN1MPN1-002.039d.mgd.msft.net ([169.254.2.83]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.01.0339.002; Thu, 17 Nov 2011 10:35:41 -0600
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [PATCH] siggen.py: Fix diffsigs output for
	filename comparisions
Thread-Index: AQHMpUbxLAfBQ4brhEyh3mARFfWPqw==
Date: Thu, 17 Nov 2011 16:35:41 +0000
Message-ID: <CAEsOVNf9gq7zmy2BmuT+PkBdZ7RnnYbCv5S1-2Eu7N9XoyGNSQ@mail.gmail.com>
References: <1321538526.27449.1.camel@ted>
In-Reply-To: <1321538526.27449.1.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.47.177.27]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen.py: Fix diffsigs output for filename comparisions
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 17 Nov 2011 16:42:19 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <74A37730B1FFBE4389D42D9FE184ECE6@freescale.net>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2011 at 8:02 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index 4ccfc7d..217f29b 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -236,6 +236,16 @@ def compare_sigfiles(a, b):
> =A0 =A0 =A0 =A0 removed =3D sb - sa
> =A0 =A0 =A0 =A0 return changed, added, removed
>
> + =A0 =A0def clean_basepaths(a):
> + =A0 =A0 =A0 =A0b =3D {}
> + =A0 =A0 =A0 =A0for x in a:
> + =A0 =A0 =A0 =A0 =A0 =A0if x.startswith("virtual:"):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D x.rsplit(":", 1)[0] + x.rsplit("/"=
, 1)[1]
> + =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y =3D x.rsplit("/", 1)[1]
> + =A0 =A0 =A0 =A0 =A0 =A0b[y] =3D a[x]
> + =A0 =A0 =A0 =A0return b
> +

So you are stripping off the full path leading up to the recipe name?
I added some stuff to strip off COREBASE at some point. Does this work
with layers in any location? I would think so.

> =A0 =A0 if 'basewhitelist' in a_data and a_data['basewhitelist'] !=3D b_d=
ata['basewhitelist']:
> =A0 =A0 =A0 =A0 print "basewhitelist changed from %s to %s" % (a_data['ba=
sewhitelist'], b_data['basewhitelist'])
>
> @@ -243,7 +253,7 @@ def compare_sigfiles(a, b):
> =A0 =A0 =A0 =A0 print "taskwhitelist changed from %s to %s" % (a_data['ta=
skwhitelist'], b_data['taskwhitelist'])
>
> =A0 =A0 if a_data['taskdeps'] !=3D b_data['taskdeps']:
> - =A0 =A0 =A0 =A0print "Task dependencies changed from %s to %s" % (sorte=
d(a_data['taskdeps']), sorted(b_data['taskdeps']))
> + =A0 =A0 =A0 =A0print "Task dependencies changed from:\n%s\nto:\n%s" % (=
sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
>
> =A0 =A0 if a_data['basehash'] !=3D b_data['basehash']:
> =A0 =A0 =A0 =A0 print "basehash changed from %s to %s" % (a_data['basehas=
h'], b_data['basehash'])
> @@ -266,7 +276,9 @@ def compare_sigfiles(a, b):
> =A0 =A0 =A0 =A0 =A0 =A0 print "Variable %s value changed from %s to %s" %=
 (dep, a_data['varvals'][dep], b_data['varvals'][dep])
>
> =A0 =A0 if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
> - =A0 =A0 =A0 =A0changed, added, removed =3D dict_diff(a_data['runtaskhas=
hes'], b_data['runtaskhashes'])
> + =A0 =A0 =A0 =A0a =3D clean_basepaths(a_data['runtaskhashes'])
> + =A0 =A0 =A0 =A0b =3D clean_basepaths(b_data['runtaskhashes'])
> + =A0 =A0 =A0 =A0changed, added, removed =3D dict_diff(a, b)
> =A0 =A0 =A0 =A0 if added:
> =A0 =A0 =A0 =A0 =A0 =A0 for dep in added:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "Dependency on task %s was added" %=
 (dep)
> @@ -275,7 +287,7 @@ def compare_sigfiles(a, b):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "Dependency on task %s was removed"=
 % (dep)
> =A0 =A0 =A0 =A0 if changed:
> =A0 =A0 =A0 =A0 =A0 =A0 for dep in changed:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "Hash for dependent task %s change=
d from %s to %s" % (dep, a_data['runtaskhashes'][dep], b_data['runtaskhashe=
s'][dep])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "Hash for dependent task %s change=
d from %s to %s" % (dep, a[dep], b[dep])
> =A0 =A0 elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sort=
ed(a_data['runtaskdeps']) !=3D sorted(b_data['runtaskdeps']):
> =A0 =A0 =A0 =A0 print "Tasks this task depends on changed from %s to %s" =
% (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
>

So now we get shown the tashhash is different even when the
paths/filenames are different? This is helpful for sure - took me a
bit to get to this realization.

Some other bitbake-diffsig improvements/comments:

1) For showing the difference between two sets, it would be helpful to
also show the symmetrical_difference to help see what is different
more easily.

2) For taskdeps, if the task depends is part of the same recipe, it
would be helpful to show that. For example if strace.bb.do_package
depends on strace.bb.do_install, can't we just show that instead?

3) Continuing on #2 it would be nice to import all sigs from a folder
and traverse down the task dependencies, and then even show whats
difference between two sets of sstate-cache. For example:

strace.bb.do_package -> strace.bb.do_install -> eglibc.bb.do_install
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0|-> foo.bb.do_install
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0|-> bar.bb.do_install

Showing the hash above as well. Then somehow do a diff between the two
trees... but even just showing this tree is a good first step. Maybe
there is a way to dump this without even involving sstate-cache but
just via bitbake?

Maybe there are easy ways to do these things already? Feedback welcome =3D)

-M=



