Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 4A5BE731DD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 17:47:25 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id iv1so38163543pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 May 2016 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=from:mime-version:in-reply-to:references:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=3t1dgZscdTgyGsJgnY1qE5dEElbni2DhBkAtRi+QHI4=;
	b=DjiyatpH6t2Z7hb3RcldLhhAoVRvTCk5sEyaXeAPB8tsuAFWx7QU4RZ6c+MlqywJAh
	CLZ3zY3LMzvBvzLJpfds2Xe+PBrfkjeTnNMHcOVOMDWc2FOQd4v6397+rjG8iuC56S7a
	fENurto/DLKA3/ukcynMdsgbxF0UemFIxEO4LZBzfUsE0igYFTMilcuQYuk8I+aMnZJL
	7Cy5H25H2muutTPsUtp2ewsxnUi/6faPr+HpHhXFLVkOS3WcUdZZXg1pSINH+9oSLZhP
	oWYwwyy+WSaPXlkdLVanPg/EHo864z43XC/LXG91JyHOWxjDzx3IJi1RoSo6bIJze2J1
	gyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=3t1dgZscdTgyGsJgnY1qE5dEElbni2DhBkAtRi+QHI4=;
	b=bYqeznF7d/m1ZomjAiklnAG+QlrgtvELdurysf3COqjuBmVnO/jbA8NopcHy26lfQF
	gXfS4vagG2yMTM27jlez7cilF7/EOIMO/mrowJzr6wkC6xN2IvBfxFXLNwe89/ISvxTX
	+WvUv01BgA71ITQopoGcmIvFHBnXzUSOQ2z4jkZdrvh4vxulX3htMhFS10x5PbsgphNv
	87UN8iGLlus3NoMgWblxH++/kSrh7orq4czMxlR4DyUY5Vrq9i3VmrKtq54Aslh2RnhH
	hOk5wWz3X0Ve5hQOgiFxGUB4hNjGueaSEaDxUoNMWkquxd23occYdm01AhbNFSY73rIS
	rxUQ==
X-Gm-Message-State: AOPr4FUt7nEH+Sl+TcfFcXQKe+ayJjUXQYWIVxLTSVNMUYfd4hVtfb8yhNghds+XHnMvMQ==
X-Received: by 10.67.13.144 with SMTP id ey16mr22246831pad.147.1462470446545; 
	Thu, 05 May 2016 10:47:26 -0700 (PDT)
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com.
	[209.85.220.42]) by smtp.gmail.com with ESMTPSA id
	xn3sm15189841pab.32.2016.05.05.10.47.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 May 2016 10:47:25 -0700 (PDT)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-pa0-f42.google.com with SMTP id r5so39295692pag.1;
	Thu, 05 May 2016 10:47:24 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.66.171.164 with SMTP id av4mr22388475pac.135.1462470444489; 
	Thu, 05 May 2016 10:47:24 -0700 (PDT)
Received: by 10.66.231.37 with HTTP; Thu, 5 May 2016 10:47:24 -0700 (PDT)
In-Reply-To: <9084039.ulb8Qqh204@elrond>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<cb3d3b05-4d43-dbdb-e905-c407ce6219ec@balister.org>
	<fce22d23-e66c-c692-f7d5-f1154081246a@windriver.com>
	<9084039.ulb8Qqh204@elrond>
Date: Thu, 5 May 2016 14:47:24 -0300
X-Gmail-Original-Message-ID: <CAP9ODKr=2OaRo63vFo=p9dTegONS==Z-3z6unActags4eEmUNw@mail.gmail.com>
Message-ID: <CAP9ODKr=2OaRo63vFo=p9dTegONS==Z-3z6unActags4eEmUNw@mail.gmail.com>
To: =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 17:47:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 5, 2016 at 2:29 PM, Jan-Simon M=C3=B6ller <dl9pf@gmx.de> wrote:
> Am Donnerstag, 5. Mai 2016, 10:13:21 schrieb Mark Hatle:
>> >> Question, do we need any type of identifier in layers to say they're
>> >> "python3" compatible or not?
>> >
>> > Layers that are python2 will need krogoth branches. I'd expect master
>> > branches to follow oe-core/master and jump to python3.
>>
>> I don't disagree, but my experience has been that branching is late or n=
ever
>> in a lot of layers.
>>
>> This might be a place where we need to plan to go through the layer inde=
x
>> and at least see if the layer parses -- and flag things that no longer
>> parse?  (I don't even know if this is something reasonable to attempt.)
>>
>> My fear is just we've already got a lot of "broken" (without defining th=
at)
>> layers in the index, and I think it will be worse once the python3 chang=
e
>> happens.  I'd really like to make sure we don't confuse people with vari=
ous
>> errors.
>>
>
> As it is a hard cut anyway, call it YP 3.0 (!) and start with an empty
> layerindex for 3.0 and only add layers that parse or are maintained.
> Legacy is 1.x/2.x and will be a separate page.

Due the move to Python 3, using 3.0 as version does make sense.


--=20
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

