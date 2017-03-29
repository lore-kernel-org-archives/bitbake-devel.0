Return-Path: <pidge@toganlabs.com>
Received: from nov-007-i592.relay.mailchannels.net
	(nov-007-i592.relay.mailchannels.net [46.232.183.146])
	by mail.openembedded.org (Postfix) with ESMTP id 4CE5C60290
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Mar 2017 09:08:05 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7013D8A07E0;
	Wed, 29 Mar 2017 09:08:03 +0000 (UTC)
Received: from hp181.hostpapa.com (unknown [100.96.126.101])
	by relay.mailchannels.net (Postfix) with ESMTPA id C471D8A28B0;
	Wed, 29 Mar 2017 09:08:02 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from hp181.hostpapa.com (hp181.hostpapa.com [172.20.55.158])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.37); Wed, 29 Mar 2017 09:08:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|pidge@toganlabs.com
X-MailChannels-Auth-Id: hostpapa
X-Minister-Blushing: 2e15bda960ab1190_1490778483290_121908983
X-MC-Loop-Signature: 1490778483290:1866560494
X-MC-Ingress-Time: 1490778483289
Received: from [213.46.252.136] (port=39706 helo=[192.168.229.56])
	by hp181.hostpapa.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.87)
	(envelope-from <pidge@toganlabs.com>)
	id 1ct9aC-000OvL-M6; Wed, 29 Mar 2017 11:08:01 +0200
Message-ID: <1490778478.15543.10.camel@toganlabs.com>
From: Beth 'pidge' Flanagan <pidge@toganlabs.com>
Reply-To: pidge@toganlabs.com
To: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 29 Mar 2017 11:07:58 +0200
In-Reply-To: <CAJ86T=UYhwXiQ0EdVUxhT7wJXqwn-QDeTWrYruB-1go3Ak1FDg@mail.gmail.com>
References: <1490709894-31154-1-git-send-email-pidge@toganlabs.com>
	<CAJ86T=UYhwXiQ0EdVUxhT7wJXqwn-QDeTWrYruB-1go3Ak1FDg@mail.gmail.com>
Organization: toganlabs.com
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
X-OutGoing-Spam-Status: No, score=5.0
X-AuthUser: pidge@toganlabs.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCHv2] s3.py: Add support for fetching source mirrors/minor cleanup
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
X-List-Received-Date: Wed, 29 Mar 2017 09:08:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-03-28 at 09:30 -0700, Andre McCurdy wrote:
> On Tue, Mar 28, 2017 at 7:04 AM, Elizabeth 'pidge' Flanagan
> <pidge@toganlabs.com> wrote:
> >=20
> > This commits main purpose is to add support for fetching source
> > mirrors. In the current incarnation:
> >=20
> > SOURCE_MIRROR_URL ?=3D "s3://mybucket/downloads"
> >=20
> > will fail for two reasons. First, download doesn't support it,
> > but second, without aws included in HOSTTOOLS you'll end up
> > with aws not being found by bitbake (for either source mirrors or
> > sstate mirrors).
> >=20
> > Part of this is fixed with this commit. However, this will still
> > fail if HOSTTOOLS doesn't include 'aws' in bitbake.conf. I've
> > another
> > commit or two to fix that as well.
> >=20
> > I've also DRYed up some of the error handling, removed the
> > hardcoded
> > aws and added some logging.
> >=20
> > Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
> > ---
> > =C2=A0lib/bb/fetch2/s3.py | 22 ++++++++++++++++------
> > =C2=A01 file changed, 16 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
> > index 27993aa..791f3b2 100644
> > --- a/lib/bb/fetch2/s3.py
> > +++ b/lib/bb/fetch2/s3.py
> > @@ -34,6 +34,7 @@ import urllib.request, urllib.parse, urllib.error
> > =C2=A0from bb.fetch2 import FetchMethod
> > =C2=A0from bb.fetch2 import FetchError
> > =C2=A0from bb.fetch2 import runfetchcmd
> > +from bb.fetch2 import logger
> >=20
> > =C2=A0class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"""Class to fetch urls via 'aws s3'"""
> > @@ -48,6 +49,8 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return True
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def urldata_init(self, ud, d):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.basecmd =3D d.get=
Var("FETCHCMD_s3", True) or
> > "/usr/bin/env aws s3"
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 'downloadfil=
ename' in ud.parm:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0ud.basename =3D ud.parm['downloadfilename']
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> > @@ -60,8 +63,13 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Fetch urls
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Assumes localpa=
th was called first
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"""
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd =3D 'aws s3 cp s=
3://%s%s %s' % (ud.host, ud.path,
> > ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 'downloadfilename=
' in ud.parm:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0dldir =3D d.getVar("DL_DIR", True)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bb.utils.mkdirhier(os.path.dirname(dldir + os.sep +
> > ud.localfile))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0cmd =3D '%s cp s3://%s%s %s%s%s' % (ud.basecmd, ud.host,
> > ud.path, dldir, os.sep, ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0cmd =3D '%s cp s3://%s%s %s' % (ud.basecmd, ud.host,
> > ud.path, ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0logger.debug(2, "Fet=
ching %s using command '%s'" %
> > (ud.url, cmd))
> The intention is that "downloadfilename" is incorporated into
> ud.localfile by urldata_init(). Did you find a case where that
> doesn't
> work?
>=20

Well, out of the box, the fetcher doesn't work:

DEBUG: lzo-native-2.09-r0 do_fetch: Fetcher failure: Fetch command
export SSH_AGENT_PID=3D"26127"; export SSH_AUTH_SOCK=3D"/tmp/ssh-
3LoCAIBmY5WA/agent.26126"; export PATH=3D"/home/pidge/openembedded-
core/scripts/native-intercept:/home/pidge/openembedded-
core/scripts:/home/pidge/openembedded-core/build/tmp-glibc/work/x86_64-
linux/lzo-native/2.09-r0/recipe-sysroot-native/usr/bin/x86_64-
linux:/home/pidge/openembedded-core/build/tmp-glibc/work/x86_64-
linux/lzo-native/2.09-r0/recipe-sysroot-
native/usr/bin:/home/pidge/openembedded-core/build/tmp-
glibc/work/x86_64-linux/lzo-native/2.09-r0/recipe-sysroot-
native/usr/sbin:/home/pidge/openembedded-core/build/tmp-
glibc/work/x86_64-linux/lzo-native/2.09-r0/recipe-sysroot-
native/usr/bin:/home/pidge/openembedded-core/build/tmp-
glibc/work/x86_64-linux/lzo-native/2.09-r0/recipe-sysroot-
native/sbin:/home/pidge/openembedded-core/build/tmp-glibc/work/x86_64-
linux/lzo-native/2.09-r0/recipe-sysroot-
native/bin:/home/pidge/openembedded-
core/bitbake/bin:/home/pidge/openembedded-core/build/tmp-
glibc/hosttools"; export HOME=3D"/home/pidge"; aws s3 cp s3://lgi-onemw-
staging/beth-test/downloads/lzo-2.09.tar.gz /home/pidge/openembedded-
core/build/downloads/lzo-2.09.tar.gz failed with exit code 127, output:
/bin/sh: aws: command not found

I agree that part of the above isn't needed (I had pulled them in from
an older version of an s3 fetcher I wrote for krogoth last year).

Some of this however is needed/desired (like assigning the FETCHCMD and
using ud.basecmd). Aws also needs to be added to HOSTTOOLS_NONFATAL in
order to get past all this (which is really the core issue).

> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bb.fetch2.check=
_network_access(d, cmd, ud.url)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0runfetchcmd(cmd=
, d)
> >=20
> > @@ -70,11 +78,11 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# tool with a l=
ittle healthy suspicion).
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if not os.path.=
exists(ud.localpath):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The aws cp command returned success
> > for s3://%s%s but %s doesn't exist?!" % (ud.host, ud.path,
> > ud.localpath))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The command=C2=A0=C2=A0%s returned success but
> > %s doesn't exist?!" % (cmd, ud.localpath))
> This seems fairly arbitrary churn...
>=20

I wouldn't agree that it's arbitrary churn neccessarily. If FetchErrors
are raised, I'd want to know the exact command that was issued.

> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if os.path.gets=
ize(ud.localpath) =3D=3D 0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0os.remove(ud.localpath)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The aws cp command for s3://%s%s
> > resulted in a zero size file?! Deleting and failing since this
> > isn't right." % (ud.host, ud.path))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The command %s resulted in a zero
> > size file?! Deleting and failing since this isn't right." % (cmd))
> Ditto.
>=20
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return True
> >=20
> > @@ -83,7 +91,9 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Check the statu=
s of a URL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"""
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd =3D 'aws s3 ls s=
3://%s%s' % (ud.host, ud.path)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd =3D '%s ls s3://=
%s%s' % (ud.basecmd, ud.host, ud.path)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0logger.debug(2, "Che=
cking %s using command '%s'" %
> > (ud.url, cmd))
> runfetchcmd() will output basically the same thing, so this isn't
> really required.
>=20

Agreed.

> >=20
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bb.fetch2.check=
_network_access(d, cmd, ud.url)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0output =3D runf=
etchcmd(cmd, d)
> >=20
> > @@ -91,6 +101,6 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# is not found,=
 so check output of the command to confirm
> > success.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if not output:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The aws ls command for s3://%s%s
> > gave empty output" % (ud.host, ud.path))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0raise FetchError("The command %s gave empty output" %
> > (cmd))
> More churn for little obvious gain.
>=20
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return True
> > --
> > 1.9.1
> >=20
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel

