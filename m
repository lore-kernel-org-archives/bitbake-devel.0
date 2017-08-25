Return-Path: <Ben.Guan@cn.bosch.com>
X-Greylist: delayed 389 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 25 Aug 2017 02:13:04 UTC
Received: from imta21.fe.bosch.de (imta21.fe.bosch.de [139.15.243.226])
	by mail.openembedded.org (Postfix) with ESMTP id E000277FEC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 02:13:04 +0000 (UTC)
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 865ECC0334
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 04:06:25 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id ADEEA1580108
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 04:06:22 +0200 (CEST)
Received: from FE-MBX1030.de.bosch.com (vsgw23.fe.internet.bosch.com
	[10.4.98.23])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 53E35A402B5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Aug 2017 04:06:34 +0200 (CEST)
Received: from SGPMBX1024.APAC.bosch.com (10.187.56.74) by
	FE-MBX1030.de.bosch.com (10.3.230.88) with Microsoft SMTP Server (TLS)
	id 15.0.1236.3; Fri, 25 Aug 2017 04:06:33 +0200
Received: from SGPMBX1024.APAC.bosch.com ([fe80::cc15:fcae:2d92:acc0]) by
	SGPMBX1024.APAC.bosch.com ([fe80::cc15:fcae:2d92:acc0%17]) with mapi id
	15.00.1236.000; Fri, 25 Aug 2017 10:06:31 +0800
From: "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan@cn.bosch.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: How to detect change on a repo manifest.git and rebuild the
	recipe with "repo://"
Thread-Index: AdMdRpJgLaK1+OXCQs+ZkOlDQcLekw==
Date: Fri, 25 Aug 2017 02:06:31 +0000
Message-ID: <3770d520be40403793f4021194082856@SGPMBX1024.APAC.bosch.com>
Accept-Language: en-US, en-SG
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.54.142.76]
MIME-Version: 1.0
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1679-8.0.0.1202-23278.006
X-TMASE-MatchedRID: Pl4fW27lo2+hrKvXX54quRwwumveFNQAUAjrAJWsTe9sLh/5lHek3ODG
	RKQQH0pi9i3FbmglsrkF8xZ8bU9ATV+Oee9yZTmgSEQN/D/3cG4F15s6prCIu4KwF4K/wIz9z5z
	AIum8OcQ3nVLgMAAeXxiDTUMT5RvxQ3rgNn7o6BWVSBCoZUyqbMDyPNek9e/aB4sIhfTjqIGM0v
	GtzEpWJSKGAlWs2eIFfQy9PJSV1p/3qcrPVgBfOYoLoibgjVEXMrX+p1uNztC/a2V+CepJRyrDB
	DV0at0sGBKpL8tPwnGaYVLgKsJNkLSYnj+K473Z/zHKAEIZbPQcDDLReGt4PfmUDxpFogQXo8WM
	kQWv6iXgT2zXYa9/nXsQ35Yt9gBIXapIzDHJ3dcvOmn5p0snt+SBi2Qh6fR8O3kxtRupks497jE
	pS02lVHd9FpmxUkkfu6g5KPgtThk416hTJja46x7WdmyNZJyxJs421rzWBfk=
Cc: "Jonas Mark \(ST-FIR/ENG1\)" <Mark.Jonas@de.bosch.com>
Subject: How to detect change on a repo manifest.git and rebuild the recipe with "repo://"
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
X-List-Received-Date: Fri, 25 Aug 2017 02:13:05 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3770d520be40403793f4021194082856SGPMBX1024APACboschcom_"

--_000_3770d520be40403793f4021194082856SGPMBX1024APACboschcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The source code of my SW consist of multiple components from different repo=
sitory, which is managed by a repo manifest repository. So I want to use "r=
epo://" for the repo manifest repository instead of multiple "git://" to in=
clude all repositories in the SRC_URI.

I add the following to MyRecipe_git.bb:
```
SRC_URI =3D "repo://git@<MY_HOST>/manifest.git;protocol=3Dssh;branch=3Dmast=
er"

S =3D "${WORKDIR}/repo/MyRecipe"
```

And in my local.conf, I add the following:
```
# Use this setting because I don't have internet connection to external And=
roid repo.git, I mirror one in the internal host
REPO_URL =3D "git@<My_HOST>/repo.git"
# Use "repo" command in the host
HOSTTOOLS +=3D "repo"
# Because the my Yocto meta-layers are managed by repo also, use a differen=
t directory for my recipe
REPODIR =3D "/home/benguan/projects/MyRecipeRepo"
```

Now I can build my recipe with Yocto, but there is an issue:  When there is=
 any change required in the repositories of my application, I will change t=
he code and update the tags in default.xml of manifest.git. I want Yocto co=
uld detect this change, fetch the change, them rebuild the recipe.

With "git://", it is easy to achieve via setting "${AUTOREV}" to "SRCREV". =
But the fetch2.repo doesn't support SRCREV. I have go through the existing =
recipe within meta-oe and oe-core, no recipe is using "repo://".

Does anybody have experience about it and help? Thank you in advance.


--_000_3770d520be40403793f4021194082856SGPMBX1024APACboschcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div>The source code of my SW consist of multiple components from different=
 repository, which is managed by a repo manifest repository. So I want to u=
se &#8220;repo://&#8221; for the repo manifest repository instead of multip=
le &#8220;git://&#8221; to include all repositories in the
SRC_URI.</div>
<div>&nbsp;</div>
<div>I add the following to MyRecipe_git.bb:</div>
<div>```</div>
<div>SRC_URI =3D &#8220;repo://git@&lt;MY_HOST&gt;/manifest.git;protocol=3D=
ssh;branch=3Dmaster&#8221;</div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div>S =3D &#8220;${WORKDIR}/repo/MyRecipe&#8221;</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">```<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">And =
in my local.conf, I add the following:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">```<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"># Us=
e this setting because I don&#8217;t have internet connection to external A=
ndroid repo.git, I mirror one in the internal host</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">REPO=
_URL =3D &#8220;git@&lt;My_HOST&gt;/repo.git&#8221;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"># Us=
e &#8220;repo&#8221; command in the host</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">HOST=
TOOLS &#43;=3D &#8220;repo&#8221;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"># Be=
cause the my Yocto meta-layers are managed by repo also, use a different di=
rectory for my recipe </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">REPO=
DIR =3D &#8220;/home/benguan/projects/MyRecipeRepo&#8221;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">```<=
/span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Now =
I can build my recipe with Yocto, but there is an issue:&nbsp; When there i=
s any change required in the repositories of my application, I will change =
the code and update the tags in default.xml
of manifest.git. I want Yocto could detect this change, fetch the change, t=
hem rebuild the recipe.&nbsp; </span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">With=
 &#8220;git://&#8221;, it is easy to achieve via setting &#8220;${AUTOREV}&=
#8221; to &#8220;SRCREV&#8221;. But the fetch2.repo doesn&#8217;t support S=
RCREV. I have go through the existing recipe within meta-oe and oe-core, no=
 recipe
is using &#8220;repo://&#8221;.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Does=
 anybody have experience about it and help? Thank you in advance.</span></f=
ont></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_3770d520be40403793f4021194082856SGPMBX1024APACboschcom_--
