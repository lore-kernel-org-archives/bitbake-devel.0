Return-Path: <kvserr@gmail.com>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id CB4CA61585
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Aug 2014 10:21:04 +0000 (UTC)
Received: by mail-ie0-f177.google.com with SMTP id at20so4146165iec.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Aug 2014 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=Ag30sHH4ozjWyKR7M1d/RPvN0ogNVrNCuXBgA3te20I=;
	b=Un+P0c7sDgHcZj7U9M4SEBYIe882g9DexYcO4NhQCRyF1vMBhcvClZsPkMUa/XT4wN
	PazpbiCje3XUhIYwOwPk38OTVH2y3QWUyF3trewzhmzcUEXMC0cfnH0EJjEc2JOQshVF
	iSUjRb6bWhoUA+dZ5+1pIUVpAimlVn1sgefgWLI+jKZejjSIsUMcvKE/pPQQuO+axyLE
	WBm1aV1hVz8mUi6jqKlVYAD7sLfByMKZlE5aU8MUFb42TSmldfdMs4nr1vN3P2OsZMCz
	s6JVswroCRNuE1qG/c9qz/spUtFiZmpVRCYg0fdWuPRML1ujr72AkxNry3ILNG6RAVWd
	/tiA==
X-Received: by 10.50.32.10 with SMTP id e10mr27398927igi.7.1407406865904; Thu,
	07 Aug 2014 03:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.38.172 with HTTP; Thu, 7 Aug 2014 03:20:45 -0700 (PDT)
From: Vitaliy Kharin <kvserr@gmail.com>
Date: Thu, 7 Aug 2014 14:20:45 +0400
Message-ID: <CAMCLREo7+RwEfZr-nqckPT9kEA71PVafGf+NiVkDTaaG_KdtwQ@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Need to clarify process of submitting and merging patches
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
X-List-Received-Date: Thu, 07 Aug 2014 10:21:07 -0000
Content-Type: multipart/alternative; boundary=047d7b11198f4c20d7050007722c

--047d7b11198f4c20d7050007722c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello bitbakers!
Some time ago I sent patch to this mail list
http://lists.openembedded.org/pipermail/bitbake-devel/2014-July/004886.html
Since then, the patch has not yet been accepted and merged into bitbake's
repo.
What should I do to get the patch accepted?

The patch's intent is to prevent find directory instead of a regular file.
=E2=80=8BFor example,
=E2=80=8BIn case =E2=80=8Bof `export PATH=3D=E2=80=8Bhome/icecc:/usr/bin/` =
bitbake's utils.which
function returns directory 'home/icecc' instead of executable file 'icecc'
in '/usr/bin/'


-----------------------
Best regards,
Vitaliy Kharin

--047d7b11198f4c20d7050007722c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:large">Hel=
lo bitbakers!</div><div class=3D"gmail_default" style=3D"font-size:large">S=
ome time ago I sent patch to this mail list =C2=A0<a href=3D"http://lists.o=
penembedded.org/pipermail/bitbake-devel/2014-July/004886.html">http://lists=
.openembedded.org/pipermail/bitbake-devel/2014-July/004886.html</a></div>

<div class=3D"gmail_default" style=3D"font-size:large">Since then, the patc=
h has not yet been accepted and merged into bitbake&#39;s repo.=C2=A0</div>=
<div class=3D"gmail_default" style=3D"font-size:large">What should=C2=A0I d=
o to get the patch accepted?<br>

</div>=C2=A0<div><div class=3D"gmail_default" style=3D"font-size:large">The=
 patch&#39;s intent is to prevent find directory instead of a regular file.=
</div><div class=3D"gmail_default" style=3D"font-size:large">=E2=80=8BFor e=
xample,</div><div class=3D"gmail_default" style=3D"font-size:large">

=E2=80=8BIn case =E2=80=8Bof `export PATH=3D=E2=80=8Bhome/icecc:/usr/bin/` =
bitbake&#39;s utils.which function returns directory &#39;home/icecc&#39; i=
nstead of executable file &#39;icecc&#39; in &#39;/usr/bin/&#39;<br></div><=
br></div><div><br>-----------------------<br>

Best regards,<br>Vitaliy Kharin
</div></div>

--047d7b11198f4c20d7050007722c--
