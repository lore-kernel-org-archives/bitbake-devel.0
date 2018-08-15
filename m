Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 51D147912A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 16:26:22 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so2900629oib.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=AQyG16g3sSii0dfVCF/omMTCAvVZ83ze9v4stpkQsbk=;
	b=eIbfLxmbXHOiResu+NoZ2z4w2NejS9HaPPpPl7oRy7WnQcsTXBYYVJXaQCuT0gCmrY
	WA+r/azad/iy22MaTiukvkxzaXk5fJhW0J1/Qjp/iUX0xkuhdITQ7E9oXae2FHxlFXus
	slQSHsCVvIWFFwp7CJ+ekryKNvRISc/Ue16K3P+j7ThwgkZeAbwbwcsW+vaZ885kMq9H
	eOoSdsFcZHU/zPiPlUM4EAiT2N7BxSAAxXKXou0Z9AOXN4WfNP1oBcT8gcE83ymXDQqG
	10nvomfCNak8WXlVp12ea+ce6vK7KY5WR8HcfJveEA/N5bxn6RQzdC2giyiqPrsz/gF4
	GfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=AQyG16g3sSii0dfVCF/omMTCAvVZ83ze9v4stpkQsbk=;
	b=gFnvCZDbxZb8dZo+nRNV68aWsD9B0g5mOpsNqo/Wg9R9dEXca/O0KDLUOivLmZvA2g
	tLF0DAO2OyqbC8tnKNBUb+z3cJl/zGponE7iJn7uB1NLrGrc/p9txHN2CZ2hCXYPWzWw
	PEkds0PnjgbG5F8Ad4XizmORIozm3meqE9vY+2K4V99WQzI4FSeMbVH71ZAU+iiRxejl
	u+KUdZtgjyaupVxJoq1e+vx+5W4juNLpiJ8FSWZlujhaIuDCh3Xaze6oPG+7Slcc7mar
	1HIqhG94N4J5SxPgAD7MtC/Dhk74Z2ACVdlglAvDPdVBRTR1oebmBfYbtq5+U+3axi2z
	wqoA==
X-Gm-Message-State: AOUpUlFzI0zFBwePBQ73KFuM0siicOUEAa98wjsgZE2YZymbqZJAG7Ay
	BUnQc0TkMG0lP/9B+VwWPo509jLdgB/f7iVLuKg=
X-Google-Smtp-Source: AA+uWPzr8O4fOkBOUEAjoqNgqUth68sbbVjQRAQSoUrXWdhJNhzS5HrhcTyym+KFy6+v9xAt684OrLQ/qpmbfSoeqKg=
X-Received: by 2002:aca:560d:: with SMTP id
	k13-v6mr26274032oib.190.1534350383278; 
	Wed, 15 Aug 2018 09:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 09:26:22
	-0700 (PDT)
In-Reply-To: <CALbNGRS7aavRtSSpj-JMKo6mTnWL7OGp+_Tnsjk3BLb=ooDHCA@mail.gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<CANNYZj-WM349ZX_j99upQ6JbopcMs_pA0G_6N7hHRbo-Yo2xoA@mail.gmail.com>
	<CANNYZj9usAVLe7guhH7h3XjXsvRjL+M8VnjM0cgFx3q-H0sqEA@mail.gmail.com>
	<CALbNGRS7aavRtSSpj-JMKo6mTnWL7OGp+_Tnsjk3BLb=ooDHCA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Aug 2018 18:26:22 +0200
Message-ID: <CANNYZj_7gr7m8TYqMmevHMnSLfoS5kZi7AVf3ziGn+uDRBD9wg@mail.gmail.com>
To: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Wed, 15 Aug 2018 16:26:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-08-15 17:01 GMT+02:00 Andreas M=C3=BCller <schnitzeltony@gmail.com>:
> 2. Quadratic explosion: I think it you should reduce number of
> parallel bitbake threads. From what I have seen: When running heavy
> compiles with -j =3D number-of-cores it takes only 2-3 do_compiles to
> have CPU load at constant ~100%. I think this should be independent of
> number of cores. Try 4-5 parallel bitbake threads - I bet that speeds
> up your builds and reduces swap floods.

What about the situations where bitbake is mostly busy with other
things than do_compile, or when do_compile takes only a small fraction
of the recipes build time? Particularly do_configure can be
notoriously slow and single-threaded, so I do want to run those with
all available cores.

Alex

