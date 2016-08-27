Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
	[209.85.218.43])
	by mail.openembedded.org (Postfix) with ESMTP id 5622A6E667
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Aug 2016 19:55:25 +0000 (UTC)
Received: by mail-oi0-f43.google.com with SMTP id j203so5497815oih.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 27 Aug 2016 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=Iyw6sr0fgEaTk1ORAjQI4GJGl7SK6l4SbtOqmOCL7HE=;
	b=GwodtDKYJ2gW5MKegakRvempKQPj/MRxz9vjS+8PmZIlwDT2Jq0ZMKKnjYezI+AUhF
	8KQtaC8+hfu00Yu5FzxzkhsNdov5dxuhVBUSBqmcQz6/09Gsi73pqv1IrTyNdFxMBOIq
	qcaezP6EVtl3IgzWYVJ+0UyMf94GyQYI3ibseIm3c115yFZ3PBdhcj36Kb//X0RGHbUF
	6Y8f+hplX8Ep8h82uCjSiUhuEoW07VZN5Y4ESPqiKF4hi2CTKkOVdcm+9Q0uuLCCrCkG
	Kuxmhn0rRduaTRk38i0Agbi0+Wyf/He7yeFkg57fJ8lI1T84ADXYTgN7CX8hAvXcQCZA
	56aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=Iyw6sr0fgEaTk1ORAjQI4GJGl7SK6l4SbtOqmOCL7HE=;
	b=LBmap+c+R4tvPKm5teS5U38zlUy98R6vyNy5A1YE7PD3lWlcCXy5qltTv0Fg+aMy7O
	LkvUBRIRzi9CfL6NeDSgoFhjrJtuG4rJRq5nhdMkM9iaNkmOENn3vz3uUKDdBmNMEEN0
	A3WEx7SW0z8wawtDZPVD+oyxGQFv0GKxpZgGhdz/kcf6IvSdZ6G9QElrYfUcwTp5bucL
	ABmbNJ1Cg23/CTp4f5wFIUbEbj1Zx4fHIninG8MKHcOOuuTcqCPcNizFAsLErq5bfBpQ
	8rd12jEwgzqVIFfbD8ym7ZRU9pqtptWQlgoNaGqcBedVywT1bgXOH4A8am9PJRVWg5Po
	UAYA==
X-Gm-Message-State: AE9vXwNGrrf9ZxwVUcHq/nN5uaG3qo7KBA8I7pSoaku3rxrwb/VOH7DSMnOsZq88TJBmuJWti0B91b+Qgl8t2w==
X-Received: by 10.202.105.139 with SMTP id e133mr7341781oic.33.1472327726381; 
	Sat, 27 Aug 2016 12:55:26 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.228 with HTTP; Sat, 27 Aug 2016 12:55:05 -0700 (PDT)
In-Reply-To: <77d61119-5b4f-d897-fa94-4490098219bc@126.com>
References: <1472189699-6646-1-git-send-email-zzs213@126.com>
	<CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
	<77d61119-5b4f-d897-fa94-4490098219bc@126.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 27 Aug 2016 12:55:05 -0700
X-Google-Sender-Auth: Wu2_riOWC9VrN_U85Gr0OgUEB5o
Message-ID: <CABcZANkpWPy6fxnyr4SQL1Zmcv-ckn6yW2Y=4mgMhm59W_Fegg@mail.gmail.com>
To: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] enable override for suffix just include digit and dot
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
X-List-Received-Date: Sat, 27 Aug 2016 19:55:26 -0000
Content-Type: multipart/alternative; boundary=001a114133bc1fc315053b13033a

--001a114133bc1fc315053b13033a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 27, 2016 at 12:32 AM, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.c=
om> wrote:

> Without this patch, if we write these in recipe test.bb <http://test.bb>:
>>>
>>>         NAME_1.1.7   =3D 'version is 1.1.7'
>>>         NAME_develop =3D 'version is develop'
>>>
>>> Use 'bitbake test -e' to observe 'NAME':
>>>         #
>>>         # $NAME [2 operations]
>>>         #   override[develop]:set .../test.bb:10 <http://test.bb:10>
>>>         #     "version is develop"
>>>         # pre-expansion value:
>>>         #   "version is develop"
>>>         NAME=3D"version is develop"
>>>
>>> Obviously, override for '1.1.7' missing.
>>>
>>
>> Dot is not allowed in variable names intentionally since its file
>> extension separator. I am not sure if its a good idea to allow it in
>> variable names
>>
>
> Since we can use the path delimeter '/' in override like 'virtual/kernel'=
.
> Why we can't use dot in override.
>
> And bitbkae would add 'PV'(which default to '1.0' in OE) to 'OVERRIDES'.
> So using dot in override may not be an issue.
>
> In bitbake manual, It said we can use BBVERSIONS and override to let sigl=
e
> recipe support multiple package version
>
> If we can't use dot in override, Howto use BBVERSIONS? Use embedded pytho=
n
> code to set var according version? But it is ugly tahn using override!


OVERRIDES .=3D ":pv-${@'${PV}'.replace('.', '_')}"
FOO_pv-1_1_7 =3D "bar"

It's worth noting that you're likely the first person to try using it since
I added the feature. oe-core moved to a policy where only one version of a
given recipe is kept in most cases, making it less useful.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114133bc1fc315053b13033a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Aug 27, 2016 at 12:32 AM, =E5=BC=A0=E5=BF=A0=E5=B1=B1 <span dir=3D"=
ltr">&lt;<a href=3D"mailto:zzs213@126.com" target=3D"_blank">zzs213@126.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Without this patch, if we writ=
e these in recipe <a href=3D"http://test.bb" rel=3D"noreferrer" target=3D"_=
blank">test.bb</a> &lt;<a href=3D"http://test.bb" rel=3D"noreferrer" target=
=3D"_blank">http://test.bb</a>&gt;:<span class=3D""><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME_1.1.7=C2=A0 =C2=A0=3D &#39;version is 1.1.=
7&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME_develop =3D &#39;version is develop&#39;<b=
r>
<br>
Use &#39;bitbake test -e&#39; to observe &#39;NAME&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # $NAME [2 operations]<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0override[develop]:set .../<a href=
=3D"http://test.bb:10" rel=3D"noreferrer" target=3D"_blank">test.bb:10</a> =
&lt;<a href=3D"http://test.bb:10" rel=3D"noreferrer" target=3D"_blank">http=
://test.bb:10</a>&gt;<span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&quot;version is develop&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pre-expansion value:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0&quot;version is develop&quot;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME=3D&quot;version is develop&quot;<br>
<br>
Obviously, override for &#39;1.1.7&#39; missing.<br>
</span></blockquote><span class=3D"">
<br>
Dot is not allowed in variable names intentionally since its file<br>
extension separator. I am not sure if its a good idea to allow it in<br>
variable names<br>
</span></blockquote>
<br>
Since we can use the path delimeter &#39;/&#39; in override like &#39;virtu=
al/kernel&#39;. Why we can&#39;t use dot in override.<br>
<br>
And bitbkae would add &#39;PV&#39;(which default to &#39;1.0&#39; in OE) to=
 &#39;OVERRIDES&#39;. So using dot in override may not be an issue.<br>
<br>
In bitbake manual, It said we can use BBVERSIONS and override to let sigle =
recipe support multiple package version<br>
<br>
If we can&#39;t use dot in override, Howto use BBVERSIONS? Use embedded pyt=
hon code to set var according version? But it is ugly tahn using override!<=
/blockquote></div><br>OVERRIDES .=3D &quot;:pv-${@&#39;${PV}&#39;.replace(&=
#39;.&#39;, &#39;_&#39;)}&quot;</div><div class=3D"gmail_extra">FOO_pv-1_1_=
7 =3D &quot;bar&quot;</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">It&#39;s worth noting that you&#39;re likely the first per=
son to try using it since I added the feature. oe-core moved to a policy wh=
ere only one version of a given recipe is kept in most cases, making it les=
s useful.<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - Bi=
tBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software En=
gineer, Mentor Graphics</div>
</div></div>

--001a114133bc1fc315053b13033a--
