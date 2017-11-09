Return-Path: <ngompa13@gmail.com>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id 4797D784FD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Nov 2017 03:53:51 +0000 (UTC)
Received: by mail-qk0-f179.google.com with SMTP id 2so5304573qkg.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Nov 2017 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ibGpD8I7tS+VbmU2ZDyNQdcjGYl7o6inlHo84BPgo/E=;
	b=LmzN0ZYuhZ+MqViq2oZKARxn7freYpyWerB50C0Nj3j69cPHn/o6I+U6SdFbQ3kYHU
	f1zoDDXEKg7WFbNLa4f5q55KeGhJElvLWvPgPahL2Cxh8+jlwfeKVFgNgrot7qfLOddU
	R9YHq1aeLquHUS80dlUot92afX5dk4iF7a+kh3obAhzejr/oRGmcm9Vawa7+wpaJ9mtu
	sFwNtXFhd7it82t2lJneZ0GR983kPysyoU87wb/ploglwagPw6+V/COJLlkMA+4TN3Yn
	+VfOKGGqtHtJYI0DJ9a+CV9zLI0tPGRfVQEwsikaPD98o+TxnL7Gki60bNYVgDvFiih0
	Dzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ibGpD8I7tS+VbmU2ZDyNQdcjGYl7o6inlHo84BPgo/E=;
	b=uIxqhaSVC382ZdX3Iyp5LEaidAnufBXpH1Q1jJLnaAQMsG3zrlVUPNE9MYR2eKl/2k
	S6/z3za0rQ49BaCBQNK/2xBJ7AMNR1jv183gI2VO7bEvRwVeQ05MUITWa+ShhBxXggyQ
	NWjc4b1BBRnOoDFlwWT9lmH0RMq8INNnVRB2ziX3Dl0WhkW2mhtuYF6yQgflghiRzhRR
	2cPKEXIVVM8a/k4GU9N/eL7o/hTr08CaymmhaNAbiUPRyBWO20LHiOd+CQG+0AALFX/v
	iTpIlgEpP2Twwh1f24IjMJ9oG1ZQdm36f+5ASXF7FNs6/3oJ81XNmVu4OLw+KjLOHhhw
	H/mg==
X-Gm-Message-State: AJaThX5KZKQzWhbudC5ytV9u5l4XxkH+JVKeSA2liAqDt4O0X7sLqVzJ
	aWmNxgv8S35IV5xmLi3YcNqYMXfKEyp1IhU8dLc=
X-Google-Smtp-Source: ABhQp+S8lN273yltOJ2SiS0TEn11tGb4prZYZFJGBK86Rm+XY0l1vOFPDE3OGTqNdo4SR7uvMv+/fRrUIIQhGt5PTWQ=
X-Received: by 10.55.179.198 with SMTP id c189mr4419941qkf.211.1510199632988; 
	Wed, 08 Nov 2017 19:53:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.41.130 with HTTP; Wed, 8 Nov 2017 19:53:12 -0800 (PST)
In-Reply-To: <8732517.rS9bQnFJfK@peggleto-mobl.ger.corp.intel.com>
References: <CAEg-Je9okCK9dEaV9Ytk6SvyzcCT=LeViP5o53F7B4oL+eR0vw@mail.gmail.com>
	<8732517.rS9bQnFJfK@peggleto-mobl.ger.corp.intel.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Wed, 8 Nov 2017 22:53:12 -0500
Message-ID: <CAEg-Je9hYNXunpv6wprTAZhnyRnu4yUFanY0aTd2C4-LSeV5vA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Releases of BitBake to package for Fedora?
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
X-List-Received-Date: Thu, 09 Nov 2017 03:53:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2017 at 10:48 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> Hi Neal,
>
> On Thursday, 9 November 2017 12:58:08 AM NZDT Neal Gompa wrote:
>> I'm looking reintroduce BitBake into Fedora, but it seems like there
>> hasn't been releases in two years. I also cannot identify anywhere
>> that provides tarballs of BitBake to package.
>>
>> The Fedora package previously referenced snapshot tarballs generated
>> by tagged releases in OE Git, but there haven't been new tagged
>> releases in two years.
>>
>> I'd previously asked this on oe-core ML and was redirected to
>> bitbake-devel, so apologies to cross-list subs. But it was also
>> pointed out there that apparently BitBake has moved to a model where
>> they don't have stable points of releases, which seems rather odd for
>> a tool that is used by more than OpenEmbedded.
>
> It's not that we don't have stable points - we do, it's that from the oth=
er
> side, each stable release of OE-Core is only tested with the correspondin=
g
> stable release of BitBake, so if people start using BitBake from their di=
stro
> we are probably going to have extra mismatch issues to deal with. We real=
ly
> ought to be tagging releases, not having done that is an oversight but it=
's
> reflective of the current typical usage.
>
> It would be nice to get some exposure of BitBake as a standalone tool, an=
d
> having it packaged by distros might be one way to help that, but my conce=
rn
> for OE usage would be that when this has been done in the past we have ha=
d
> situations where BitBake from the distro has been older than needed by OE=
-Core
> and users end up having to fetch it themselves anyway, so we'd have to ha=
ve a
> strategy for handling that.
>
> (This is not necessarily an official answer - I'd be interested to hear w=
hat
> RP and others have to say about it.)
>

For what it's worth, if you guys are regularly tagging BitBake, this
can be automatically tracked in Fedora infrastructure and I can update
BitBake relatively quickly after that.

Unlike most distributions, it's usually not a problem to update
relatively frequently in Fedora. But that doesn't mean you should
stress me out with tons of releases out the wazoo. :)



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

