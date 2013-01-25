Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TyrlH-00015R-2S
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 23:28:39 +0100
Received: by mail-wi0-f178.google.com with SMTP id hn3so2430wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 14:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=bHeD1jP45PuHEYEXzz2+ibBbASw1vOa5tdU9wr47+aI=;
	b=mYTwDDrB2MOw3DqAD06t7A8Iwjqc1L5+Jczw3xf10a/wHe/1mbUCjrvEzqvRWE9fO1
	SF8jbPJhOZuPjrPc3mt7mAEWCjokW8y70gnLnEMG2BHqoko5LEiT5j6RtSrPF9DOkZBF
	TMe/P05HBRZqoyGktBN0mWvMtFgoP3GCBSx674VJD+Vmml3HxPoz2FZx7BJWTZDwbUFR
	9t570dP1EYUpqF0zLhZ8GkNcgufoB8ipQ6ExpAEm6h9LdxzebFishzH55sZhSnf5u17i
	HPN5zIryn0BJ9qnMvZVSNFLKwUYSipNjF70/qKH8dXXTMneCpD8d43qMTAX7lFGr4ay+
	jlaQ==
MIME-Version: 1.0
X-Received: by 10.194.235.6 with SMTP id ui6mr11256060wjc.12.1359151984433;
	Fri, 25 Jan 2013 14:13:04 -0800 (PST)
Received: by 10.194.179.39 with HTTP; Fri, 25 Jan 2013 14:13:04 -0800 (PST)
In-Reply-To: <CABcZANmTSLLfC=AvKjocVAN+Fj6n3Q3ZRQ=vON0EBw=5ahEiMw@mail.gmail.com>
References: <1359142708-24667-1-git-send-email-Martin.Jansa@gmail.com>
	<CABcZANmTSLLfC=AvKjocVAN+Fj6n3Q3ZRQ=vON0EBw=5ahEiMw@mail.gmail.com>
Date: Fri, 25 Jan 2013 23:13:04 +0100
Message-ID: <CA+chaQdCwSfEm0V4WtAg1KhVaDjxquE6WDFUfgvmwChCBgyVug@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] world-image: add extra target
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Jan 2013 22:28:39 -0000
Content-Type: multipart/alternative; boundary=089e01493bd03a5b6b04d4243b6c

--089e01493bd03a5b6b04d4243b6c
Content-Type: text/plain; charset=UTF-8

Agreed, I've tried with handler added in world-image.bbclass (cumulating
all PACKAGES on RecipeParsed event) and failed, that's why this ended in
bitbake code, but I'm open to ideas how to hook it properly.


On Fri, Jan 25, 2013 at 10:45 PM, Chris Larson <clarson@kergoth.com> wrote:

>
> On Fri, Jan 25, 2013 at 12:38 PM, Martin Jansa <martin.jansa@gmail.com>wrote:
>
>> * similar to world target, but collects all PACKAGES
>> * recipes marked with EXCLUDE_FROM_WORLD are excluded from world as well
>>   as world-image
>> * recipes marked with EXCLUDE_FROM_WORLD_IMAGE are excluded completely
>>   from world-image, sometimes you can build 2 recipes in same sysroot,
>>   but cannot install them in the same image
>> * PACKAGES listed in EXCLUDE_PACKAGES_FROM_WORLD_IMAGE are also
>>   excluded. You can remove e.g. ${PN}-dbg, but keep all other PACKAGES.
>>
>> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
>>
>
> bitbake should have zero knowledge of what an image even is, much less
> hardcoding awareness of the IMAGE_INSTALL variable. Instead, we should
> provide a means to hook into bitbake's knowledge of the recipes included in
> the world image, and let a world-image recipe utilize that.
> --
> Christopher Larson
>

--089e01493bd03a5b6b04d4243b6c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Agreed, I&#39;ve tried with handler added in world-image.b=
bclass (cumulating all PACKAGES on RecipeParsed event) and failed, that&#39=
;s why this ended in bitbake code, but I&#39;m open to ideas how to hook it=
 properly.</div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Jan 2=
5, 2013 at 10:45 PM, Chris Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:c=
larson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra">=
<div class=3D"im"><br><div class=3D"gmail_quote">On Fri, Jan 25, 2013 at 12=
:38 PM, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D"mailto:martin.jansa@g=
mail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt;</span> wrote:<br=
>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>* similar to world target, but collects=
 all PACKAGES<br>
* recipes marked with EXCLUDE_FROM_WORLD are excluded from world as well<br=
>
=C2=A0 as world-image<br>
* recipes marked with EXCLUDE_FROM_WORLD_IMAGE are excluded completely<br>
=C2=A0 from world-image, sometimes you can build 2 recipes in same sysroot,=
<br>
=C2=A0 but cannot install them in the same image<br>
* PACKAGES listed in EXCLUDE_PACKAGES_FROM_WORLD_IMAGE are also<br>
=C2=A0 excluded. You can remove e.g. ${PN}-dbg, but keep all other PACKAGES=
.<br>
<br>
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com" t=
arget=3D"_blank">Martin.Jansa@gmail.com</a>&gt;</div></blockquote></div><br=
></div>bitbake should have zero knowledge of what an image even is, much le=
ss hardcoding awareness of the IMAGE_INSTALL variable. Instead, we should p=
rovide a means to hook into bitbake&#39;s knowledge of the recipes included=
 in the world image, and let a world-image recipe utilize that.<span class=
=3D"HOEnZb"><font color=3D"#888888"><br>


-- <br>Christopher Larson</font></span></div></div>
</blockquote></div><br></div>

--089e01493bd03a5b6b04d4243b6c--
