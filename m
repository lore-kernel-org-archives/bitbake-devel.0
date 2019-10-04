Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
X-Greylist: delayed 567 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 04 Oct 2019 07:51:40 UTC
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 1285D7F260
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2019 07:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 99E589C0198;
	Fri,  4 Oct 2019 03:42:13 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id LoBRDAAzP0_I; Fri,  4 Oct 2019 03:42:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8BD359C02A4;
	Fri,  4 Oct 2019 03:42:12 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id sxIRoXFMBkzP; Fri,  4 Oct 2019 03:42:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 65D169C0198;
	Fri,  4 Oct 2019 03:42:12 -0400 (EDT)
Date: Fri, 4 Oct 2019 03:42:11 -0400 (EDT)
From: Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
To: =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Message-ID: <144607162.8615467.1570174931312.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <2b4588c7-adff-5a12-2cb7-c1b3be1eeb74@pr.hu>
References: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
	<82bcf115-965e-60fb-ed35-a116cabce937@pr.hu>
	<2b4588c7-adff-5a12-2cb7-c1b3be1eeb74@pr.hu>
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC77 (Linux)/8.8.11_GA_3737)
Thread-Topic: fetch2/npm: fix parsing multiple matching packages
Thread-Index: isoe3JiNpEXv+QxUBAs78D7CThWD2Q==
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/npm: fix parsing multiple matching packages
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
X-List-Received-Date: Fri, 04 Oct 2019 07:51:41 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zolt=C3=A1n,

It seems that this issue have already been fixed by this patch:
https://git.openembedded.org/bitbake/commit/?id=3D3d319c79981811d3cfd473288=
5057db4fd5afcc2

Not the same implementation as yours, but it fixes the same issue.

Best regards,
Jean-Marie Lemetayer

----- Mail original -----
De: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
=C3=80: "mpvader" <mvader@victronenergy.com>, "bitbake-devel" <bitbake-deve=
l@lists.openembedded.org>
Envoy=C3=A9: Vendredi 4 Octobre 2019 07:58:56
Objet: Re: [bitbake-devel] [PATCH] fetch2/npm: fix parsing multiple matchin=
g packages

Hi Bitbake devs!

The exception with the below "devtool add ..." command still occurs with
bvitbake 1.42.0 used in Yocto 2.7 and is fixed with the patch.

Please consider applying/backporting it.

Best regards,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

2018. 02. 19. 9:55 keltez=C3=A9ssel, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n=
 =C3=ADrta:
> 2018-02-11 23:31 keltez=C3=A9ssel, mpvader =C3=ADrta:
>> Replace the self-implemented parser with loading the complete json and t=
hen
>> taking the last element from it.
>>
>> This fixes an error fetching the lex-parser package, as a dependency of,=
 for
>> example, jison. Reproduce the error with this command:
>>
>> devtool add "npm://registry.npmjs.org;name=3Djison;version=3D0.4.18"
>>
>> _parse_view() didn't properly parse the npm view result [1], resulting i=
n
>> an Exception in the subsequent json.loads() function:
>> Exception: ValueError: Extra data: line 57 column 4 - line 296 column 2 =
(char 5874 - 29698)
>=20
> I can confirm this problem exists in Bitbake 1.36 and goes away with the =
patch.
>=20
> Also tested the patch for the handful of node module recipes
> I have and they still build properly.
>=20
>>
>> [1] npm view lex-parser@'0.1.x' --json --registry http://registry.npmjs.=
org
>>
>> Signed-off-by: mpvader <mvader@victronenergy.com>
>=20
> Tested-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
>=20
>> ---
>> =C2=A0 lib/bb/fetch2/npm.py | 29 ++++++++---------------------
>> =C2=A0 1 file changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index b5f148c..e257355 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -146,25 +146,6 @@ class Npm(FetchMethod):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._unpackdep(u=
d, ud.pkgname, workobj, unpackdir, dldir, d)
>> -=C2=A0=C2=A0=C2=A0 def _parse_view(self, output):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Parse the output of npm view=
 --json; the last JSON result
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is assumed to be the one tha=
t we're interested in.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D None
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outdeps =3D {}
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 datalines =3D []
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bracelevel =3D 0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for line in output.splitline=
s():
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if b=
racelevel:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines.append(line)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif=
 '{' in line:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines =3D []
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines.append(line)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brac=
elevel =3D bracelevel + line.count('{') - line.count('}')
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if datalines:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdat=
a =3D json.loads('\n'.join(datalines))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pdata
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _getdependencies(self, pkg, data, ver=
sion, d, ud, optional=3DFalse,=20
>> fetchedlist=3DNone):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fetchedlist is=
 None:
>> @@ -175,9 +156,15 @@ class Npm(FetchMethod):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug(2, "=
Calling getdeps on %s" % pkg)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D "npm=
 view %s --json --registry %s" % (pkgfullname, ud.registry)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output =3D runfet=
chcmd(fetchcmd, d, True)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D self._parse_view(o=
utput)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not pdata:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not output:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 raise FetchError("The command '%s' returned no output" % fetchcmd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D json.loads(output)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # npm registry will return m=
ultiple dicts in a list when there is more than one=20
>> matching
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # version. Take the last one=
.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if isinstance(pdata, list):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdat=
a =3D pdata[-1]
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if optional:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pkg_os =3D pdata.get('os', None)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if pkg_os:
>>
>=20

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

