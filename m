Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4193C83F34
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 09:07:31 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.16687.1752829641703479807
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 02:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dCz0H2lq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 772E441C93;
	Fri, 18 Jul 2025 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752829640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYFG1w1Pq4hOeRlwdAOBFjrkLRMV8v+mLJZ+5ByB2O8=;
	b=dCz0H2lqP6uTlQHdpG7FU6LaC6nf951mcAdn2I6UDlY+M9uF43kJ+piSIurkLdaCdhDu8M
	pleHoZXU07ogqQKbdo6LgGniuYcgS6dvQ37XHsdGayH5i8oHGpoSOhYsDwgE/J3jBmMqVZ
	HFFoK6H/7XqK6es8GiCpood+oAHmPlNXImv9jmvssE1zYaOlp4fmsjF6WE11T7HJ+Z68qg
	BY9H8P9PAe4dqG3JaATShVWd9+O/UOf9ynK/EGbnZW7DjBUbnPhkFtZOYEGlPOXsMxOFHo
	O/OCr6+UntYpFCnC3FOkBe+jJsR1kLdW7EYaI7zLNocfvg3yM+HXd0MUMUGiMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 11:07:18 +0200
Message-Id: <DBF28ZOAGB7T.4GNIDYSF76YE@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-fetching:
 update the Git fetcher tag description
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>,
 <bitbake-devel@lists.openembedded.org>
References: <20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com>
 <d278b11b-6ca6-4841-8a29-659632648678@cherry.de>
In-Reply-To: <d278b11b-6ca6-4841-8a29-659632648678@cherry.de>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifedthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvfhfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvjedtffetgfevkedvieelgeekveffjeeiffdvleduleegueevheevieelkefgleenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdhrvghpohdrphihpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggvpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvl
 heslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 09:07:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17792

On Thu Jul 17, 2025 at 2:42 PM CEST, Quentin Schulz wrote:
> Hi Antonin,
>
> On 7/17/25 2:23 PM, Antonin Godard via lists.openembedded.org wrote:
>> After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
>> update the description of the tag=3D parameter for the Git fetcher.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> index a2c2432db1..b3fc3ce72c 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> @@ -439,10 +439,11 @@ This fetcher supports the following parameters:
>>   -  *"rev":* The revision to use for the checkout. The default is
>>      "master".
>>  =20
>
> This seems... odd? I thought rev was supposed to be a full hash (though=
=20
> that probably is me remembering SRCREV instead?). There seems to be=20
> tests using it in bitbake/lib/bb/tests/fetch.py so I guess it is valid?=
=20
> Not a clue what this is supposed to do though or if master really is the=
=20
> default value?

I think it acts just like SRCREV as I understand it.
"master" seems odd indeed, maybe it was mistaken with 'branch'?

https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/repo.py#n39

>> --  *"tag":* Specifies a tag to use for the checkout. To correctly
>> -   resolve tags, BitBake must access the network. For that reason, tags
>> -   are often not used. As far as Git is concerned, the "tag" parameter
>> -   behaves effectively the same as the "rev" parameter.
>> +-  *"tag":* Specifies a tag to match against the supplied revision (``r=
ev=3D``).
>> +   This does not replace the ``rev`` parameter: the ``tag`` parameter s=
hould
>> +   only be specified if you want to verify that the tag commit SHA matc=
hes the
>> +   supplied ``rev`` SHA. The ``tag`` parameter is not mandatory to use,=
 but
>
> s/not mandatory to use/optional/ ?

Yes, thanks

>> +   strongly recommended.
>>  =20
>
> ok so I was clearly not aware of that change and got surprised by a few=
=20
> of the latest patches on the ML adding that parameter.
>
> 1) I've read on the ML that it is possible there may be a difference in=
=20
> behavior (or even an issue?) with annotated vs lightweight tags? Would=20
> be worth checking and specifying this limitation if it does exist.

From 136c06e251de ("fetch2/git: Handle srcrevs for annotated tags in tag
check"), this doesn't seem to be an issue: if rev is set to the revision of=
 the
annotated tag, it is resolved to the underlying commit sha and compared aga=
in.
If rev is set to the revision of the tag's underlying commit sha, it passes=
 the
first check.

NB: In any case, the tag in 'tag=3D' is always resolved to the underlying c=
ommit
sha.

> 2) Since this is a change in behavior, we should probably document that=
=20
> in the appropriate migration manual?

Yep, I'm on it. I came with this patch in the process of writing the releas=
e /
migration notes

>>   -  *"subpath":* Limits the checkout to a specific subpath of the tree.
>>      By default, the whole tree is checked out.
>>=20
>
> Finally, this is not alphabetically ordered so we could take this as an=
=20
> opportunity to fix that oversight :) mmmm but reading more than the git=
=20
> context shows that most aren't ordered in that fetcher so... maybe for=20
> another patch :)

True, I'd say send a patch if it bothers you too much hehe :)

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


