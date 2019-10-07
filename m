Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 5E08B6011A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Oct 2019 12:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 113B89C01F2;
	Mon,  7 Oct 2019 08:25:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 9oWc4VL0MAN0; Mon,  7 Oct 2019 08:25:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C17499C01F8;
	Mon,  7 Oct 2019 08:25:34 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id fGRkjaH5Sb0v; Mon,  7 Oct 2019 08:25:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 968379C01F2;
	Mon,  7 Oct 2019 08:25:34 -0400 (EDT)
Date: Mon, 7 Oct 2019 08:25:34 -0400 (EDT)
From: Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
To: =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Message-ID: <694178254.8695156.1570451134583.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ae8379b3-c784-9b4c-da19-3f8d9f279030@pr.hu>
References: <1518388275-4589-1-git-send-email-mvader@victronenergy.com>
	<82bcf115-965e-60fb-ed35-a116cabce937@pr.hu>
	<2b4588c7-adff-5a12-2cb7-c1b3be1eeb74@pr.hu>
	<144607162.8615467.1570174931312.JavaMail.zimbra@savoirfairelinux.com>
	<ae8379b3-c784-9b4c-da19-3f8d9f279030@pr.hu>
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC77 (Linux)/8.8.11_GA_3737)
Thread-Topic: fetch2/npm: fix parsing multiple matching packages
Thread-Index: EbTSG86sJKA6+F2or/YAPXszCeAjgg==
Cc: Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Mon, 07 Oct 2019 12:25:39 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zolt=C3=A1n,

I am working on the master branch for now. I have several fixes which are u=
nder development. When this work will be done, I will consider backporting =
all of these fixes.

Best regards,
Jean-Marie

----- Mail original -----
> De: "B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n" <zboszor@pr.hu>
> =C3=80: "Jean-marie Lemetayer" <jean-marie.lemetayer@savoirfairelinux.com=
>
> Cc: "mpvader" <mvader@victronenergy.com>, "bitbake-devel" <bitbake-devel@=
lists.openembedded.org>
> Envoy=C3=A9: Samedi 5 Octobre 2019 08:47:09
> Objet: Re: [bitbake-devel] [PATCH] fetch2/npm: fix parsing multiple match=
ing packages

> Hi,
>=20
> 2019. 10. 04. 9:42 keltez=C3=A9ssel, Jean-marie Lemetayer =C3=ADrta:
>> Hi Zolt=C3=A1n,
>>=20
>> It seems that this issue have already been fixed by this patch:
>> https://git.openembedded.org/bitbake/commit/?id=3D3d319c79981811d3cfd473=
2885057db4fd5afcc2
>>=20
>> Not the same implementation as yours, but it fixes the same issue.
>=20
> The implementation is not mine, I just tested it back then with Yocto 2.5=
.
>=20
> Will your patch backported to older major versions of Bitbake?
> The issue is present in older Yocto versions.
>=20
>>=20
>> Best regards,
>> Jean-Marie Lemetayer
>>=20
>> ----- Mail original -----
>> De: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
>> =C3=80: "mpvader" <mvader@victronenergy.com>, "bitbake-devel"
>> <bitbake-devel@lists.openembedded.org>
>> Envoy=C3=A9: Vendredi 4 Octobre 2019 07:58:56
>> Objet: Re: [bitbake-devel] [PATCH] fetch2/npm: fix parsing multiple matc=
hing
>> packages
>>=20
>> Hi Bitbake devs!
>>=20
>> The exception with the below "devtool add ..." command still occurs with
>> bvitbake 1.42.0 used in Yocto 2.7 and is fixed with the patch.
>>=20
>> Please consider applying/backporting it.
>>=20
>> Best regards,
>> Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
>>=20
>> 2018. 02. 19. 9:55 keltez=C3=A9ssel, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=
=A1n =C3=ADrta:
>>> 2018-02-11 23:31 keltez=C3=A9ssel, mpvader =C3=ADrta:
>>>> Replace the self-implemented parser with loading the complete json and=
 then
>>>> taking the last element from it.
>>>>
>>>> This fixes an error fetching the lex-parser package, as a dependency o=
f, for
>>>> example, jison. Reproduce the error with this command:
>>>>
>>>> devtool add "npm://registry.npmjs.org;name=3Djison;version=3D0.4.18"
>>>>
>>>> _parse_view() didn't properly parse the npm view result [1], resulting=
 in
>>>> an Exception in the subsequent json.loads() function:
>>>> Exception: ValueError: Extra data: line 57 column 4 - line 296 column =
2 (char
>>>> 5874 - 29698)
>>>
>>> I can confirm this problem exists in Bitbake 1.36 and goes away with th=
e patch.
>>>
>>> Also tested the patch for the handful of node module recipes
>>> I have and they still build properly.
>>>
>>>>
>>>> [1] npm view lex-parser@'0.1.x' --json --registry http://registry.npmj=
s.org
>>>>
>>>> Signed-off-by: mpvader <mvader@victronenergy.com>
>>>
>>> Tested-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
>>>
>>>> ---
>>>>  =C2=A0 lib/bb/fetch2/npm.py | 29 ++++++++---------------------
>>>>  =C2=A0 1 file changed, 8 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>>>> index b5f148c..e257355 100644
>>>> --- a/lib/bb/fetch2/npm.py
>>>> +++ b/lib/bb/fetch2/npm.py
>>>> @@ -146,25 +146,6 @@ class Npm(FetchMethod):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._unpackde=
p(ud, ud.pkgname, workobj, unpackdir, dldir, d)
>>>> -=C2=A0=C2=A0=C2=A0 def _parse_view(self, output):
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Parse the output of npm vi=
ew --json; the last JSON result
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is assumed to be the one t=
hat we're interested in.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D None
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outdeps =3D {}
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 datalines =3D []
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bracelevel =3D 0
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for line in output.splitli=
nes():
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 bracelevel:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines.append(line)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
if '{' in line:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines =3D []
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 datalines.append(line)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
acelevel =3D bracelevel + line.count('{') - line.count('}')
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if datalines:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd=
ata =3D json.loads('\n'.join(datalines))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pdata
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _getdependencies(self, pkg, data, =
version, d, ud, optional=3DFalse,
>>>> fetchedlist=3DNone):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fetchedlist=
 is None:
>>>> @@ -175,9 +156,15 @@ class Npm(FetchMethod):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug(2=
, "Calling getdeps on %s" % pkg)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd =3D "=
npm view %s --json --registry %s" % (pkgfullname, ud.registry)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output =3D run=
fetchcmd(fetchcmd, d, True)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D self._parse_view=
(output)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not pdata:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not output:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 raise FetchError("The command '%s' returned no output" % fetchcmd=
)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdata =3D json.loads(outpu=
t)
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # npm registry will return=
 multiple dicts in a list when there is more
>>>> than one
>>>> matching
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # version. Take the last o=
ne.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if isinstance(pdata, list)=
:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd=
ata =3D pdata[-1]
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if optional:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 pkg_os =3D pdata.get('os', None)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if pkg_os:
>>>>
>>>

