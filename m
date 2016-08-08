Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 1A96E771C0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 16:24:50 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id cf3so24170757pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Aug 2016 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:from:in-reply-to:date:cc:message-id:references
	:to; bh=QjtqvMQJUUGGbOHTRBjWAvh+XNEMgElxZEBvTnDjd90=;
	b=xF9oCF5FLzDAocqZm1RcMOPQCSqMuw/EpE+rj2M+1UNSqukD7NJBQgI+kf/0KBRyqE
	YqXTOAQEpMFvieVYKU8GBTVm+dJILc8qPj8RLURuUeWpSA0M04hzbbJZi5kOq12A3p5s
	RdWaHb6KOqJgGKzgYIem5GYaZ/uJChmXaTB0LVL+KpZ8vpaQo5gblLsgaHZfOBWGIyw4
	NIBRxWoO2TSNrqV/Y16G9EeGQJ2FKky2/bAnsmX8pR93cMi4uA8OTXTvmJ9UXh73hZwB
	MDLD/Stl5tI3kLMNVo3aYTxKnVFScH5yO7ZkOO5Ww7+F2p8EtBbSvVX0HT7NIoFAq6Zn
	DD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=QjtqvMQJUUGGbOHTRBjWAvh+XNEMgElxZEBvTnDjd90=;
	b=k9knt0xT/eVaiUA4k70dJO+2B7D7ekD8tipEe7rIyl/Cf3sAn06+Im/UZAM9BLPQ6e
	IopQvZkWRWGukSHCapvLlJE3AwTt6yMlVmISgb4PZbGjZ4+86oNeMCsV8iPE6B8bDHh5
	hy/+hUrV+zZgqpiQhcGuK5HS2Ur1PQwpnW58bHjSgmamqj8pJmOobc30/2lWGU1oyg0D
	7hFHnOA9NgHnIUAWcq4OGVDwm70osYydMxPsUNp73ikxrDGOkdH8kG3XQEdCxG+752x/
	jwdu2NstjPhr3+I1FgVWhqUnNiSYbYuDh9+oFb7eacO5EhAfP9h+k4hu753MP7EKuVKf
	ONkQ==
X-Gm-Message-State: AEkoouuJsNLRTADSRjXRqVbxSptVk3Fjhgf4bIvXDrHcbLKvHPvKcd88CtMFR59VjFurrg==
X-Received: by 10.66.66.42 with SMTP id c10mr42127995pat.83.1470673491396;
	Mon, 08 Aug 2016 09:24:51 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:b8c:ddaa:6f66:32b4:378?
	([2601:646:8882:b8c:ddaa:6f66:32b4:378])
	by smtp.gmail.com with ESMTPSA id
	h125sm49278480pfg.54.2016.08.08.09.24.50
	(version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Aug 2016 09:24:50 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Pgp-Agent: GPGMail
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <1e5eb678-4e4f-837b-3ee7-f982affde91f@smile.fr>
Date: Mon, 8 Aug 2016 09:25:20 -0700
Message-Id: <532F52A2-335D-4123-B62E-A92055D6A81A@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<1e5eb678-4e4f-837b-3ee7-f982affde91f@smile.fr>
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
X-List-Received-Date: Mon, 08 Aug 2016 16:24:51 -0000
X-Groupsio-MsgNum: 7818
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BBD6DA20-6312-4CF2-B10B-85C577F05C41";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_BBD6DA20-6312-4CF2-B10B-85C577F05C41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


> On Aug 8, 2016, at 8:58 AM, J=E9r=E9my Rosen <jeremy.rosen@smile.fr> =
wrote:
>=20
>=20
>=20
> On 08/08/2016 17:35, Khem Raj wrote:
>>> On Aug 8, 2016, at 4:24 AM, J=E9r=E9my Rosen <jeremy.rosen@smile.fr> =
wrote:
>>>=20
>>>=20
>>> On 08/08/2016 11:55, Richard Purdie wrote:
>>>> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:
>>>>> Change made to enable building offline also with git tag =
references
>>>>> in SRC_URI.
>>>>>=20
>>>>> If BB_NO_NETWORK is set, fallback to search for tags and revisions
>>>>> in local DL_DIR / GITDIR in order to avoid network access.
>>>> I'm not sure I agree with this since you'd get different build =
results
>>>> depending on whether BB_NO_NETWORK is set or not.
>>>>=20
>>>> I think if BB_NO_NETWORK is set, its reasonable to assume that the
>>>> configuration should be locked down and that BB_NO_NETWORK should =
not
>>>> have other side effects like this.
>>>>=20
>>>> It would also make it very hard to detect unlocked configurations
>>>> during testing which currently are quite easily identified.
>>> To be honest, this is a real world problem I have on a regular =
basis...
>>>=20
>>> The problem we have is that our customers want to keep an archive =
for (very) long term support and they test offline mode.
>>>=20
>>> This problem means that we have to set all our SRC_URI to git SHA =
instead of the much more readable and easy to check git tags.
>>>=20
>>>=20
>>> you think to assume that a reference is a branch, but the real-life =
problem is when reference is a tag. Tag don't move so this is
>>> a case of locked configuration, but i'm not sure how to handle it.
>>>=20
>>> Is there a way to have the best of both world somehow ?
>> Don=92t use tags instead rely on SHA numbers in SRCREV and use
>> BB_GENERATE_MIRROR_TARBALLS like mentioned here
>>=20
>> =
https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_sour=
ce_download_mirror_.3F
>>=20
>> tags are floating types in git, you can not use them reliably.
>> You may tool in a method to automate updating the
>> recipes SRCREVs if you dont want to do it by hand.
>>=20
>> That should help hopefully
> I know... but the fact that NO_NETWORK can't work if any git uses a =
tag seems... not what I would expect. Especially if the tag is available =
locally. I understand what you say, but I think it breaks the purpose of =
NO_NETWORK

There is an assumption here you are making, which is that tags are fixed =
in git which is not true. However when you use
tags in your recipe you want folks to use that tag and it could be =
moved/displaced under the hood and user would not notice
some tags like =93last_good=94 =93last_sane_build=94 are moving tags the =
are practiced. Tags are in same category as AUTOREV

BB_NO_NETWORK means you need to ensure that metadata can operate on =
disconnected snapshot which is not true for tags.

>=20
> If a git reference is floating, then building twice won't produce the =
same result anyway... this sounds more like a QA problem to me than =
something that bitbake should enforce. But i'm really not a BB =
architect, it's just that this patch would solve one of our problem and =
i'd like to see if there is a way to do that without loosing other =
aspects of bitbake=85
>=20

We should be warning about this case as it does today and to make builds =
more predictable, this patch takes us in reverse direction.
otherwise soon folks have no idea what they are building every developer =
has his own snapshot think of supporting hundreds of developers
where you have no idea what combination they built to get into trouble =
that they are seeing. It turns into a nightmare very
quickly.

--Apple-Mail=_BBD6DA20-6312-4CF2-B10B-85C577F05C41
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAleosnUACgkQuwUzVZGdMxTeHACePrUoWwOZorXLOm42qa2HacmS
n10AnjvSSd7fOnLUytXT+0+vkpmay8kF
=jL3U
-----END PGP SIGNATURE-----

--Apple-Mail=_BBD6DA20-6312-4CF2-B10B-85C577F05C41--
