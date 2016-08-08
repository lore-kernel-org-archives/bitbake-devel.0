Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 87D55731CB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 15:35:09 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id g202so25272664pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Aug 2016 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:from:in-reply-to:date:cc:message-id:references
	:to; bh=e36v07frsg8tHAtX57IY3xQniRULJ4dfd57PUetyS3U=;
	b=N838e51Pk2NhFfAnzfQrNfiRvqlAkxymi2JxbyPITA1Cv1+EEFLCZ5dYmYcvhXUdNN
	Vi4XkK/Ou48aTjEol34PF9YODHAd7pc6kAo8zqxIFiXS/yRpZJNsItd7bFuijMKiZdMZ
	qIgBq90zKYqFK/6F+Gwgrf0k2+3QppKH1Et/H/oRrWIGZmREFOCJVHuePsZuZzlH7UcY
	6r16FbKDu12vkG/DzHY/ZW7OHIXj5j13A4S4XkYm2AKDSTdvbTGHVHP9FY7h4knq+IKa
	jIrDR9/rRPdEX4zM1pNqTPx7SE0/LcAoEBOBoPE7AKh2A68fRZHKLdtZcqJpWrVhNAb5
	2mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=e36v07frsg8tHAtX57IY3xQniRULJ4dfd57PUetyS3U=;
	b=lUOQ5KN3ji2zqV+/UZleu2fDqgTeetLuMq7c5sGMqhj6Blvntni4iu9S2CX3nXCcF+
	7UNaOH58dnql/CPGTGokJNaWSWM/iPaFgKJwUEZ3oBCa9iuEZZrxkmnh/MMixOk5I9jh
	zwUIYJhdMSJ77D2yG95JIsztwBi4HPWcxbz13nle7PZrgvfZeE9lj+CMeuw8XcSLb5oc
	cQq9wK3rTKnMfrY8rynTUl6ycYnsk9DKx65yZOynz/evY3JSWi3j6tKnm4vC4CZSOT6h
	irG+XoW1qL0HTHS+XYoNaTIpxuOGzwAs1Y+Z9UcJyJsxgiFNFErGWvxOqeedjimRHvy/
	2oQg==
X-Gm-Message-State: AEkoouuWP2arj0ngDE/Z9nNo2pwfDqnYTwfLE30BdRTb/lGvuECKFZmhvrCjuKOhHTTbDw==
X-Received: by 10.98.15.145 with SMTP id 17mr163480909pfp.40.1470670509785;
	Mon, 08 Aug 2016 08:35:09 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:b8c:ddaa:6f66:32b4:378?
	([2601:646:8882:b8c:ddaa:6f66:32b4:378])
	by smtp.gmail.com with ESMTPSA id
	e72sm49067983pfb.49.2016.08.08.08.35.08
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Aug 2016 08:35:08 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Pgp-Agent: GPGMail
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <7a284480-47ae-674c-3073-5680e626f769@smile.fr>
Date: Mon, 8 Aug 2016 08:35:38 -0700
Message-Id: <C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
To: =?utf-8?Q?J=C3=A9r=C3=A9my_Rosen?= <jeremy.rosen@smile.fr>
X-Mailer: Apple Mail (2.3124)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Mon, 08 Aug 2016 15:35:11 -0000
X-Groupsio-MsgNum: 7816
Content-Type: multipart/signed;
	boundary="Apple-Mail=_735A30EA-6758-4A5C-8B2E-0ACFABE290C5";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_735A30EA-6758-4A5C-8B2E-0ACFABE290C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


> On Aug 8, 2016, at 4:24 AM, J=E9r=E9my Rosen <jeremy.rosen@smile.fr> =
wrote:
>=20
>=20
> On 08/08/2016 11:55, Richard Purdie wrote:
>> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:
>>> Change made to enable building offline also with git tag references
>>> in SRC_URI.
>>>=20
>>> If BB_NO_NETWORK is set, fallback to search for tags and revisions
>>> in local DL_DIR / GITDIR in order to avoid network access.
>> I'm not sure I agree with this since you'd get different build =
results
>> depending on whether BB_NO_NETWORK is set or not.
>>=20
>> I think if BB_NO_NETWORK is set, its reasonable to assume that the
>> configuration should be locked down and that BB_NO_NETWORK should not
>> have other side effects like this.
>>=20
>> It would also make it very hard to detect unlocked configurations
>> during testing which currently are quite easily identified.
>=20
> To be honest, this is a real world problem I have on a regular =
basis...
>=20
> The problem we have is that our customers want to keep an archive for =
(very) long term support and they test offline mode.
>=20
> This problem means that we have to set all our SRC_URI to git SHA =
instead of the much more readable and easy to check git tags.
>=20
>=20
> you think to assume that a reference is a branch, but the real-life =
problem is when reference is a tag. Tag don't move so this is
> a case of locked configuration, but i'm not sure how to handle it.
>=20
> Is there a way to have the best of both world somehow ?

Don=92t use tags instead rely on SHA numbers in SRCREV and use
BB_GENERATE_MIRROR_TARBALLS like mentioned here

=
https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_sour=
ce_download_mirror_.3F

tags are floating types in git, you can not use them reliably.
You may tool in a method to automate updating the
recipes SRCREVs if you dont want to do it by hand.

That should help hopefully

--Apple-Mail=_735A30EA-6758-4A5C-8B2E-0ACFABE290C5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAleops8ACgkQuwUzVZGdMxTX8gCfc3brtqrGeOlLgtYKQgyrGym+
+iAAn3OrGPGZRO2SGbbij9iSfjZJO+Zy
=DzEO
-----END PGP SIGNATURE-----

--Apple-Mail=_735A30EA-6758-4A5C-8B2E-0ACFABE290C5--
