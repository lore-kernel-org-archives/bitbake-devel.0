Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>) id 1S9bCr-0005x8-Kz
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 12:56:57 +0100
Received: by wibhj13 with SMTP id hj13so3149206wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Mar 2012 04:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to:x-mailer
	:x-gm-message-state;
	bh=SY6aJf84waVY/GC/waHTnsiq16M4dTggvOZi25if/ms=;
	b=QgjXGkY8KDsU7UBKyGq+FtNvwsIuLQx9MVuJ1+nUKcSNO2cJDMPdM65WeRhpsyUC6x
	RKuEoI791WXeG60VjHxyDe5CvnpBv/87SDfmeyU/Yfm/sqTJuSq3M2rpVl2IuVaqmUUy
	7Ujgo1ZoN4KeELekph/Jc/3hmsWmZUF6/0GIPgzqVAz+9vM11bDS4RZXJPgrwVqO9Nht
	97ViXpo4GNf8IBLTyRSryruYjGR5TG6iG/jvCWawMgk2VVMYK3Cxfm2mfmb4YU16gwVz
	lHQrPB8hZhtNwzN7w5CjKSOSCJPaqaoInuER2z6OANHCchnR+HG5Gq0EuadsdibetJNb
	jY8w==
Received: by 10.216.139.229 with SMTP id c79mr8294349wej.16.1332157686298;
	Mon, 19 Mar 2012 04:48:06 -0700 (PDT)
Received: from [172.20.0.96] (ip545070eb.adsl-surfen.hetnet.nl.
	[84.80.112.235])
	by mx.google.com with ESMTPS id d7sm40369260wiz.6.2012.03.19.04.48.04
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 19 Mar 2012 04:48:05 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1257)
From: Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <1331852164.18586.166.camel@ted>
Date: Mon, 19 Mar 2012 12:48:02 +0100
Message-Id: <A1BEDA1D-66A7-4740-98FF-6FC0FBE9967C@dominion.thruhere.net>
References: <1331852164.18586.166.camel@ted>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
X-Mailer: Apple Mail (2.1257)
X-Gm-Message-State: ALoCoQlQSZLnQg0gGb7iqMQkr71vFlKiynpUZRgQmkND5JkvyOwIssVz73cIaWiMhjXz/3thdDob
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] ui/knotty: Add a footer to the build output for interactive terminals
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
X-List-Received-Date: Mon, 19 Mar 2012 11:56:57 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Op 15 mrt. 2012, om 23:56 heeft Richard Purdie het volgende geschreven:

> I've sent this before, this is an updated version with several =
bugfixes
> and improvements. Its a major change but one I think people will like
> overall as I hear a lot of complaints about the verbose console
> messages. v0 never got complaints so I will merge this fairly quickly
> unless there are objections.
>=20
> ---
> On terminals which support it, add summary information to the end of =
the
> build output about the number of tasks currently running and how many =
tasks
> we've run so far.
>=20
> This provides a summary at a glace of what the current state of the =
build is
> and what the build is currently doing which is lacking in the current =
UI.
>=20
> Also disable echo of characters on stdin since this corrupts the =
disable,
> particularly Crtl+C.
>=20
> The "waiting for X tasks" code can be merged into this code too since
> that is only useful on interactive terminals and this improves the
> readability of that output too.
>=20
> Improvements since v0:
>=20
> * The tasks are ordered in execution order.
> * The display is only updated when the list of tasks changes or there
>  is output above the footer.
> * Errors early in the init process don't corrupt the terminal
> * Running task x of y and package messages are suppressed from the =
console
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py

This doesn't apply for obvious reasons.=


