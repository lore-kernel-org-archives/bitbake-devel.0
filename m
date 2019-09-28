Return-Path: <grzegorz.heldt@gmail.com>
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
	[209.85.217.45])
	by mail.openembedded.org (Postfix) with ESMTP id 8F34E7F280
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Sep 2019 04:04:10 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id w195so3234040vsw.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=HDqbY4QCfodYu3ISZGs2jYSW2+VH5pnncZkXaVgTRZY=;
	b=irXHOdYQ6Acc2tsXOkGhMKpwquIX0+c1cQiqsE/oXr43J+2/y+qdpbuml8AMq7Vr6O
	thrwfPSvb5CtwHIYAW5Jt6j6/qB27fMHIwe0HtUyEWq6a/a4ycHpQTmS+DmhesgfhkBl
	B3W8OXkoC4UPikVfn/bbkQWiaDPDRJ+dgJ3QmFtC+lExTyhN5sIUPlCVo/ZlkhtBSRex
	MF+nkdgAbN1T3IJeYCpNKneKJIS2DcA/5eVLkHf9w674U62TEym9YCaqK4EBr0G2ibiq
	J0kdMCaawzWrExG74V6fNtIZCjYCWI7peWn6551C0zj/YbZ0bMMNQK2YV6kiRYd8jtyo
	GlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=HDqbY4QCfodYu3ISZGs2jYSW2+VH5pnncZkXaVgTRZY=;
	b=GMT4oQZjb8Fjp3+zDckgy0JBVU85PaIJh/TPmbwG/IMSLFHyCgDrFYbDcCUVWru+GU
	5Rkft2ha5T0ZgBAYvshQLuTxccHYL2neILbeZJIv5T2jQwOVYzF3ZlmAbz+u0RcszlvV
	avWBROh5ztOqf9RS9JibVfeLBYC14WIr9kEZuQgCLRGvmzzAgbmOMa0+BMRF0UUTXy4C
	ZPcxkk8tOAEXhChTCJNiakql2UHo7K9BKf7vl+SdjTKDELh4hFJNL9Ij9Bpe0U+389cy
	Y1Tf9l7JcE95vQumG75eFL9Jaddu8fBs8NJfKYxR8yAA1A4Tj1tGaCA3hnQyw7iUM8/W
	3mKg==
X-Gm-Message-State: APjAAAWmnOM/l2w5XkcTZNXDyfazMQ77k2n566QqW6Qy+0pbjVgbpQn3
	J3kG7V2yZopSvabcP3QB9JoPYktyuYBc9NMmiE99vNX2
X-Google-Smtp-Source: APXvYqw8LWFYcKiNN2YxZJseyPEWjRq9/LN1Gue1xrSWZ4uE1PQQL2wXrcvUxD60DJa9W2138BhcJvvCtDqBzKEr0jc=
X-Received: by 2002:a67:6404:: with SMTP id y4mr4371671vsb.120.1569643451020; 
	Fri, 27 Sep 2019 21:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
	<d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
	<9022a7bc-7f91-dddb-5bfc-530b42a2d1bf@kernel.crashing.org>
	<625be95c-9f8f-adcc-2c27-179733423b59@mvista.com>
	<d7e77675-23ff-ed76-026a-e7c842a0f8bb@mvista.com>
In-Reply-To: <d7e77675-23ff-ed76-026a-e7c842a0f8bb@mvista.com>
From: Grzegorz Heldt <grzegorz.heldt@gmail.com>
Date: Sat, 28 Sep 2019 06:03:59 +0200
Message-ID: <CAK5ws+EXCgv_wJKv3epebvyuJe6WXrUY+2R=2W2jAitYGBp-VQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Mon, 30 Sep 2019 09:00:29 +0000
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Sat, 28 Sep 2019 04:04:10 -0000
Content-Type: multipart/alternative; boundary="00000000000052777b059395185c"

--00000000000052777b059395185c
Content-Type: text/plain; charset="UTF-8"

>
>
> Yeah the its still the same with warrior. You just need to reorder adds,
> if doing it one at a time. However, you
> are correct you can add them at the same time on the same line.
>
> --
> Jeremy A. Puhlman
> jpuhlman@mvista.com
>
>
I have learnt three things:

1. Dependencies are checked during "bitbake-layers add-layer", I thought it
only adds layer to bblayers.conf
2. I can add many layers using single "bitbake-layers add-layer" command.
3. bitbake-devel group is very friendly and helpful.

Best Regards
Grzegorz Heldt.

--00000000000052777b059395185c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
Yeah the its still the same with warrior. You just need to reorder adds, <b=
r>
if doing it one at a time. However, you<br>
are correct you can add them at the same time on the same line.<br>
<br>
-- <br>
Jeremy A. Puhlman<br>
<a href=3D"mailto:jpuhlman@mvista.com" target=3D"_blank">jpuhlman@mvista.co=
m</a><br>
<br>
</blockquote></div><br clear=3D"all"><div>I have learnt three things:</div>=
<div><br></div><div>1. Dependencies are checked during &quot;bitbake-layers=
 add-layer&quot;, I thought=C2=A0it only adds layer to bblayers.conf</div><=
div>2. I can add many layers using single &quot;bitbake-layers add-layer&qu=
ot; command.</div><div>3. bitbake-devel group is very friendly and helpful.=
</div><div><br></div><div>Best Regards</div><div>Grzegorz Heldt.</div><div>=
<br></div><div><br></div><br></div>

--00000000000052777b059395185c--
