Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-pg0-f47.google.com (mail-pg0-f47.google.com [74.125.83.47])
	by mail.openembedded.org (Postfix) with ESMTP id BBA6960796
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 01:03:04 +0000 (UTC)
Received: by mail-pg0-f47.google.com with SMTP id 14so1143079pgg.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Jan 2017 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=subject:to:references:from:organization:message-id:date:user-agent
	:mime-version:in-reply-to;
	bh=fS0Ijigoe5ciIuUKpoPFNjwxQGvYrXnH4pRweFxRhLE=;
	b=GKPnZyG3rQBIL8ZIw0FgqvLHWh5N0OM7Lj6p17E0Y3LF4RmbtT9R/6B3bHsIfj5WED
	iP27lihaKt5B/+5yIrHQqhSTWXe/rH8devpwNU1Zm4hgH9WwECRFBm0yN/g4xySrjrQg
	fnRv0yoRIAYBtA2lFzyH9ITaQv+xiNtaj+kZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=fS0Ijigoe5ciIuUKpoPFNjwxQGvYrXnH4pRweFxRhLE=;
	b=H0hlAXuO7R/TonSphaHacbjfVUcculLmRwAeTg78r96e6EZVUf6J32uJaYZ22n830E
	Y1FeftK+qmzXl7WFh+1KSNqNeEKppAEYkCa2H+MEO8nrg3Dsw+i+neLqQiB1upxaHs0M
	FJT6s+7WkzKAgqQwdsXFblYMTnTzAU2GFnZgq3o8zwpIs/rR/PBxULcS81n9dDfwLa5u
	m2kHq52/jduNPn2UIovr0b6ZuVEdQZgfyiFpIqPOjNptsYSNZ6upV4xfMP447wfgS7iQ
	zW4i0XSuJSk++tDQUDzQCq+lDYFdz/M+rGrxlK3wyV+Jz/CZO/rin/BagJFUXAMC5WZY
	iYCw==
X-Gm-Message-State: AIkVDXJyPgJ++7pPDiy8Urkvzl2DI1dU6MOXM8s8popknif7SWeq5UP9ZBmIR1hfQIhrmseG
X-Received: by 10.98.57.154 with SMTP id u26mr2582552pfj.136.1483664584739;
	Thu, 05 Jan 2017 17:03:04 -0800 (PST)
Received: from yct-lpt.lan (c-50-137-129-203.hsd1.or.comcast.net.
	[50.137.129.203]) by smtp.gmail.com with ESMTPSA id
	w125sm155847438pfb.8.2017.01.05.17.03.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 Jan 2017 17:03:03 -0800 (PST)
To: bitbake-devel@lists.openembedded.org,
	Scott Rifenbark <srifenbark@gmail.com>
References: <F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthrex.local>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Organization: Linux Foundation
Message-ID: <b28aa897-1b0b-766e-3364-dacc1dfc9c56@linuxfoundation.org>
Date: Thu, 5 Jan 2017 17:03:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthrex.local>
Subject: Re: Corrupted Link in BitBake User manual
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
X-List-Received-Date: Fri, 06 Jan 2017 01:03:04 -0000
X-Groupsio-MsgNum: 8333
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Aw4u9Cr69qRmF39LStJ6WfAr25o0IspjS"

--Aw4u9Cr69qRmF39LStJ6WfAr25o0IspjS
Content-Type: multipart/mixed; boundary="9Tl7Xtqtbuv57i2HPHcfW9aPbaETlUNA8";
 protected-headers="v1"
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org,
 Scott Rifenbark <srifenbark@gmail.com>
Message-ID: <b28aa897-1b0b-766e-3364-dacc1dfc9c56@linuxfoundation.org>
Subject: Re: [bitbake-devel] Corrupted Link in BitBake User manual
References: <F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthrex.local>
In-Reply-To: <F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthrex.local>

--9Tl7Xtqtbuv57i2HPHcfW9aPbaETlUNA8
Content-Type: multipart/alternative;
 boundary="------------31C204A5A3B9936FD0BE7EF3"

--------------31C204A5A3B9936FD0BE7EF3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I have replaced all the links to hambedded with links to archive.org's
copies from March 19th when the site was still up. The change is
complete in all the HTML versions of the Bitbake manual. The PDF
versions aren't as simple to change.

This should mitigate the issue until a permanent solution can be decided =
on.

Scott, if you push new versions of the docs it will overwrite my changes
so check in with me before you do.

On 01/05/2017 02:06 PM, Paul Wintz wrote:
>
> Two  links in the BitBake user manual
> <https://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user=
-manual.html>
> that point to =93Hambedded Linux blog post - From Bitbake Hello World t=
o
> an Image=94 now lead to a page a titled =93sunny leone Sex video downlo=
ad
> aunty f*** desi xxx porn=94. I did not let the page load, but I assume
> that the contents are pornographic, so I assume you=92ll want to fix
> that quickly.
>
> =20
>
> Best regards,
>
> Paul
>
> =20
>
>
> This e-mail and any files transmitted with it are the property of
> Arthrex, Inc. and/or its affiliates, are confidential, and are
> intended solely for the use of the individual or entity to whom this
> e-mail is addressed. If you are not one of the named recipient(s) or
> otherwise have reason to believe that you have received this message
> in error, please notify the sender at 239-643-5553 and delete this
> message immediately from your computer. Any other use, retention,
> dissemination forwarding, printing or copying of this e-mail is
> strictly prohibited. Please note that any views or opinions presented
> in this email are solely those of the author and do not necessarily
> represent those of the company. Finally, while Arthrex uses virus
> protection, the recipient should check this email and any attachments
> for the presence of viruses. The company accepts no liability for any
> damage caused by any virus transmitted by this email.   =AD=AD =20
>
>

--=20
Michael Halstead
Linux Foundation / SysAdmin


--------------31C204A5A3B9936FD0BE7EF3
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>I have replaced all the links to hambedded with links to
      archive.org's copies from March 19th when the site was still up.
      The change is complete in all the HTML versions of the Bitbake
      manual. The PDF versions aren't as simple to change. <br>
    </p>
    <p>This should mitigate the issue until a permanent solution can be
      decided on.<br>
    </p>
    Scott, if you push new versions of the docs it will overwrite my
    changes so check in with me before you do.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 01/05/2017 02:06 PM, Paul Wintz
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthre=
x.local"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
=2EMsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">Two =A0links in the <a
            moz-do-not-send=3D"true"
href=3D"https://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake=
-user-manual.html">BitBake
            user manual</a> that point to =93Hambedded Linux blog post -
          From Bitbake Hello World to an Image=94 now lead to a page a
          titled =93sunny leone Sex video download aunty f*** desi xxx
          porn=94. I did not let the page load, but I assume that the
          contents are pornographic, so I assume you=92ll want to fix tha=
t
          quickly. <o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
        <p class=3D"MsoNormal">Paul<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
      </div>
      <br>
      This e-mail and any files transmitted with it are the property of
      Arthrex, Inc. and/or its affiliates, are confidential, and are
      intended solely for the use of the individual or entity to whom
      this e-mail is addressed. If you are not one of the named
      recipient(s) or otherwise have reason to believe that you have
      received this message in error, please notify the sender at
      239-643-5553 and delete this message immediately from your
      computer. Any other use, retention, dissemination forwarding,
      printing or copying of this e-mail is strictly prohibited. Please
      note that any views or opinions presented in this email are solely
      those of the author and do not necessarily represent those of the
      company. Finally, while Arthrex uses virus protection, the
      recipient should check this email and any attachments for the
      presence of viruses. The company accepts no liability for any
      damage caused by any virus transmitted by this email.
      =A0=A0=AD=AD=A0=A0
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Michael Halstead
Linux Foundation / SysAdmin
</pre>
  </body>
</html>

--------------31C204A5A3B9936FD0BE7EF3--

--9Tl7Xtqtbuv57i2HPHcfW9aPbaETlUNA8--

--Aw4u9Cr69qRmF39LStJ6WfAr25o0IspjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbuzFAAoJEGpkljW6QlqVRWMP/2XTfT0XMxs7rTzjSHVYCGnZ
Pb7/H61qZuV0TrcoLx6RvdOFq25hjBeEA7HKmpvEQNdQMdD9tWERGSU6tYd8KU6Q
lvIaiwTdKdETe8lv1naYpN4841hl4FAdVXtltlqSqj8zAPBvI06OZUtQhndI9BtD
wIpiPlpWERjSattAz0fBcbt92iOgT6vysUiGieLxIHCe1opv9JHBELMHVAsJJ/1x
TmBBDWeb1DcYkRF+3e/etSYaCdXELgSsGQqGcyBmkuimx3Ks4W1WdZA3tN57aD8X
rO6TXcEaD8KYSDaegc5jAHUuM4RVsDYOi3+EoVptWgHtucn1WhhO8kD75+s6iEEv
LuJoLTZ4MNIzHjzaA7NfMBtJIRhrH4HTnHYQI1K6aADi2N14Cw9j98Fp4PxbJs8A
dXmQxT60md3urzWG36BPUSjHKoM5Usr12vvFJk40/LpQXyaswOg09Eb1KC2qsvY/
IWUrCBUen8hbm25CgZOZMo9ohjAdMoPhL2O9UzRVbRHsRo9AgXz6XjngDOZXLmgK
4uJGbqR59SiTL+CdLySSkcOnju4XPLZ/3JaaYUIIlIZKEDotRr+ezNdPYw0Hgr0H
duU3jq446+s4I2B+rAGrhOxB6Fk8yUYjL1KjeRACp8WrHHMBDMV0SBCNtyd/fGM1
fZIjXy7gXrvVEDXDDLJu
=U1L3
-----END PGP SIGNATURE-----

--Aw4u9Cr69qRmF39LStJ6WfAr25o0IspjS--
