Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
	[209.85.220.178])
	by mail.openembedded.org (Postfix) with ESMTP id 982F973710
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 20:21:25 +0000 (UTC)
Received: by qkbp125 with SMTP id p125so214436281qkb.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=PapbrV0zNj6vLPCrz4r2eud2znuDuWfxJj1iQtYidY0=;
	b=G+ZPC5ybjEx9HpBnwY8wqHl0Fp/cdLOd3DuU4Was+6C/rXhx3ikYVLXgdzwFMwFZf+
	ZoYHgRg+k51dVxZ/Ab3oI8b4TS83THoRd78OLxh48xaKlJj9XgKAU86xpzumI3DZ6BK8
	J+5DDQQnrNFNzDvgXosf5ExmVzdzDJQgiX1zBuPVCDW82Dq7LfEzRZKLCBT/WBenjTwz
	/hvaP8+bLnOX4WVLvlaB19AglvQomS1C1rMDav8MA2ndAlDimbXKNRXumE4Dww4FQ2qP
	vqSMC5iXjrxu3imHbW2HXGB5cRq60FauMLTVKLRdPm9eTsslRB+N30lUOds2qvBQe90y
	sDXg==
X-Received: by 10.55.22.161 with SMTP id 33mr36446919qkw.11.1436559684799;
	Fri, 10 Jul 2015 13:21:24 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.55 with HTTP; Fri, 10 Jul 2015 13:21:05 -0700 (PDT)
In-Reply-To: <55A02839.9040907@linux.intel.com>
References: <1436546684-30539-1-git-send-email-anibal.limon@linux.intel.com>
	<1436547305.3310.13.camel@linuxfoundation.org>
	<55A02839.9040907@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 10 Jul 2015 13:21:05 -0700
X-Google-Sender-Auth: cQDb7URrACJIybaHt_G0E-UIYcY
Message-ID: <CABcZANnNQUyjSt6TGJe49bkN0SVxzY3PVW_Co8bgi6tRuYAP2Q@mail.gmail.com>
To: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] parse/ast.py: MethodNode fix character mapping error
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
X-List-Received-Date: Fri, 10 Jul 2015 20:21:30 -0000
Content-Type: multipart/alternative; boundary=001a11496cbcb614bb051a8b1dd2

--001a11496cbcb614bb051a8b1dd2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

%s already converts the arguments to strings, last I checked. Am I missing
someting here?

On Fri, Jul 10, 2015 at 1:16 PM, An=C3=ADbal Lim=C3=B3n <anibal.limon@linux=
.intel.com>
wrote:

> Hi Richard,
>
> Sorry it was my mistake in my code because i'm loading a recipe file usin=
g
> bb.cache.Cache.loadDataFull
> passing an unicode filepath this causes the error but i think it need to
> be sanitized? to avoid this kind of
> problems.
>
> Cheers,
>     alimon
>
>
> On 10/07/15 11:55, Richard Purdie wrote:
>
>> On Fri, 2015-07-10 at 11:44 -0500, An=C3=ADbal Lim=C3=B3n wrote:
>>
>>> When found an anonymous function the func name is made by filename
>>> and lineno, the filename need to be converted to string before using
>>> translation because produces an error of encoding.
>>>
>> Could you explain a little about why we don't hit this error in general?
>>
>> Cheers,
>>
>> Richard
>>
>>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11496cbcb614bb051a8b1dd2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">%s already converts the arguments to strings, last I check=
ed. Am I missing someting here?<br><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Fri, Jul 10, 2015 at 1:16 PM, An=C3=ADbal Lim=C3=B3n <=
span dir=3D"ltr">&lt;<a href=3D"mailto:anibal.limon@linux.intel.com" target=
=3D"_blank">anibal.limon@linux.intel.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Hi Richard,<br>
<br>
Sorry it was my mistake in my code because i&#39;m loading a recipe file us=
ing bb.cache.Cache.loadDataFull<br>
passing an unicode filepath this causes the error but i think it need to be=
 sanitized? to avoid this kind of<br>
problems.<br>
<br>
Cheers,<br>
=C2=A0 =C2=A0 alimon<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 10/07/15 11:55, Richard Purdie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, 2015-07-10 at 11:44 -0500, An=C3=ADbal Lim=C3=B3n wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
When found an anonymous function the func name is made by filename<br>
and lineno, the filename need to be converted to string before using<br>
translation because produces an error of encoding.<br>
</blockquote>
Could you explain a little about why we don&#39;t hit this error in general=
?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot=
 com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<b=
r>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a11496cbcb614bb051a8b1dd2--
