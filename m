Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 8CF2C60125
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jul 2015 17:59:18 +0000 (UTC)
Received: by igr7 with SMTP id 7so83068770igr.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jul 2015 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=t4/VHSGViuW+JFs94U7D9ZgTREvhufKYdrNd1NRZMRc=;
	b=iI1ilDFMLLL2duRISATqRQwr9LGiOGA9jEH4MRFOXtqo/6dMqsisrV1OGluSZo5+rY
	rzReXmn8rUxP6VVQMpS2xG/157q3BHCk8ThfSlrPyegohCOW90swGAcd11b/kwtNi1t7
	uad29Q1Kz803kuRAC7AZ9i10tiBfTSXvupRWbLqnKF/74VHGWesCXn7nQ9/2EvLjai9X
	avZri8GzJXzGGfGN55A32opXtx3r9Wj3fH/Y18X6mGQEiYVv7Bf2wx3/DjXU2m5mLe4c
	IJw0BvWG1sIQPcWbQZkK23EvDf+h2LObX7LdRfpj+RLK1ZHnrbiTVtM16BsMRmE5XFZP
	qVxQ==
X-Received: by 10.107.47.26 with SMTP id j26mr45800423ioo.17.1438019958475;
	Mon, 27 Jul 2015 10:59:18 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Mon, 27 Jul 2015 10:58:59 -0700 (PDT)
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<CABcZANkHbT0R6HY5jtuCN+LLnJ2fVJV2nSVa5u_VCcTdzrct9w@mail.gmail.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2743@ORSMSX109.amr.corp.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 27 Jul 2015 10:58:59 -0700
X-Google-Sender-Auth: nv9hip11AeaP2ROaUQs2a1lswhY
Message-ID: <CABcZAN=pWRrz2NQ8=fChBo4MBgfZHjA=weY-=588HfQRgisdSw@mail.gmail.com>
To: "Bystricky, Juro" <juro.bystricky@intel.com>
Cc: "Purdie, Richard" <richard.purdie@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Mon, 27 Jul 2015 17:59:19 -0000
Content-Type: multipart/alternative; boundary=001a113513b6ce1481051bdf1c39

--001a113513b6ce1481051bdf1c39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 9:10 AM, Bystricky, Juro <juro.bystricky@intel.com>
wrote:

> I agree that a generic solution is preferable. I also I think it is only
> prudent to support all valid URLs.
>
> The situation is complicated by the fact that at present it may not be
> possible to determine how to interpret the =E2=80=98;=E2=80=99 in SRC_URI=
.
>
> It can be part of the URL or it can be a SRC_URI delimiter/separator.
>
> As I don=E2=80=99t suppose changing the delimiter character from semi-col=
on to
> something else (i.e. an unsafe URL character)
>
> is an option, some other changes to the SRC_URI syntax are needed, for
> example:
>
>
>
> 1.       Some form of escape sequence (i.e. =E2=80=98;;=E2=80=99 means tr=
eat as =E2=80=98;=E2=80=99) in
> URL, i.e.
>
> SRC_URI =3D "
> http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5dd47;download=
filename=3Dabc.tar
> "
>

This is probably the only sane bet to retain compatibility, at least as far
as I can tell, but perhaps someone else has an idea.

2.       Quoted string implementation, using one of the =E2=80=9Cunsafe=E2=
=80=9D URL
> characters such as =E2=80=98`=E2=80=99, to delimit  the URL
>
> SRC_URI =3D "=E2=80=99
> http://abc123.com/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47`;downloadf=
ilename=3Dabc.tar
> <http://abc123.com/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47;downloadf=
ilename=3Dabc.tar>
> "
>

Clearly this would be ideal, and is what we should have done, but it=E2=80=
=99s a
bit late now :) It=E2=80=99s not the only questionable choice we made in th=
e URL
handling back when we wrote the original fetcher (e.g. file:// rather than
file:, but afaik one should only use the former if there=E2=80=99s a netloc=
/host).
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113513b6ce1481051bdf1c39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jul 27, 2015 at 9:10 AM, Bystricky, Juro <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.bystricky@in=
tel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p class=3D=
"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif">I agree that a generic solution is preferable. I also I think =
it is only prudent to support all valid URLs.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">The situation is complicated by the fact that at pr=
esent it may not be possible to determine how to interpret the =E2=80=98;=
=E2=80=99 in SRC_URI.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">It can be part of the URL or it can be a SRC_URI de=
limiter/separator.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">As I don=E2=80=99t suppose changing the delimiter c=
haracter from semi-colon to something else (i.e. an unsafe URL character)<u=
></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">is an option, some other changes to the SRC_URI syn=
tax are needed, for example:<u></u><u></u></span></p>
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if"><u></u>=C2=A0<u></u></span></p>
<p><u></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif"><span>1.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span></span><u></u><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif">Some form of escape sequence (i.e. =E2=80=98;;=
=E2=80=99 means treat as =E2=80=98;=E2=80=99) in URL, i.e.<u></u><u></u></s=
pan></p>
<p>SRC_URI =3D &quot;<a href=3D"http://abc123.com/git/?p=3Dgcc/gcc.git;;a=
=3Dsnapshot;;h=3Da5dd47;downloadfilename=3Dabc.tar" target=3D"_blank">http:=
//abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5dd47;downloadfilenam=
e=3Dabc.tar</a>&quot;</p></blockquote><div><br></div><div>This is probably =
the only sane bet to retain compatibility, at least as far as I can tell, b=
ut perhaps someone else has an idea.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<p><u></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif"><span>2.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span></span></span><u></u><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif">Quoted string implementation, using one of the=
 =E2=80=9Cunsafe=E2=80=9D URL characters such as =E2=80=98`=E2=80=99, to de=
limit =C2=A0the URL<u></u><u></u></span></p>
<p>SRC_URI =3D &quot;=E2=80=99 <a href=3D"http://abc123.com/git/?p=3Dgcc/gc=
c.git;a=3Dsnapshot;h=3Da5dd47;downloadfilename=3Dabc.tar" target=3D"_blank"=
>http://abc123.com/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47`;downloadfi=
lename=3Dabc.tar</a>&quot;</p></blockquote><div><br></div><div>Clearly this=
 would be ideal, and is what we should have done, but it=E2=80=99s a bit la=
te now :) It=E2=80=99s not the only questionable choice we made in the URL =
handling back when we wrote the original fetcher (e.g. file:// rather than =
file:, but afaik one should only use the former if there=E2=80=99s a netloc=
/host).</div></div>-- <br><div class=3D"gmail_signature">Christopher Larson=
<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaur=
us<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113513b6ce1481051bdf1c39--
