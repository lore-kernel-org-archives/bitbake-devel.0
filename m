Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A97C8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 11:49:03 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.16494.1751975333221425779
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 04:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=kw6OETVq;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DADB4421D;
	Tue,  8 Jul 2025 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751975331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlZZAXUYghrieWCs8zV6qcHYXlNw3hNlIifdsxZFy0U=;
	b=kw6OETVqzwiiRnP6jDWKv8B6k03tqHDrQfeYmdwj1ELjY7Dj8RQth0+e2sdQNBqRA+O6IX
	yjREs64RWLoLnXh8WOaUvSL3Mj2JTmMcPzLMQ5f/NpBiQNnrBMJLUEtxyvyI4C27g3qlth
	gJkD5HsJ2dEWnxqBvv1/oeKpb4rgZWlB9eDhy2NjOdyMfoW1k2lL9jafw6o28WrvZi4Ykq
	LRh0IECXS1Je9nUGSA+6elTyTQCZ5K2EkhKVJNGnmFo71ro4KWp8q4dw2bCt4/UEaFfiIo
	ArH20gumzxW1ygc5usvikJEi8X6DqDhHouN+QJc6jghiPOjRlphu9P/MOtAYuA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 13:48:50 +0200
Message-Id: <DB6NF7YH17U9.6HYVT80TCPK8@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [docs] [PATCH] Mention existence of three supported "classes"
 directories
Cc: "YP docs mailing list" <docs@lists.yoctoproject.org>, "BitBake developer
 list" <bitbake-devel@lists.openembedded.org>
References: <7f7b0bf4-2fdf-d216-6488-7576a79b19ed@crashcourse.ca>
 <DB6N6S3RH1TM.1HFNXT9E75TR8@bootlin.com>
 <f2ab85c5-e703-ebf2-7c97-9ebe1353f817@crashcourse.ca>
In-Reply-To: <f2ab85c5-e703-ebf2-7c97-9ebe1353f817@crashcourse.ca>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvehfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejveeuvedvieeuhfefleduvdfgvefhudekleehkeevhfegtedujedtvedukeetjeenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprhhpjhgurgihsegtrhgrshhhtghouhhrshgvrdgtrgdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtr
 dhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 11:49:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17758

On Tue Jul 8, 2025 at 1:42 PM CEST, Robert P. J. Day wrote:
> On Tue, 8 Jul 2025, Antonin Godard via lists.yoctoproject.org wrote:
>
>> On Tue Jul 8, 2025 at 1:29 PM CEST, Robert P. J. Day wrote:
>> >
>> > Early in Section 1, mention that BitBake supports three related
>> > classes directories.
>> >
>> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> >
>> > ---
>> >
>> >   I'm not thrilled with this explanation in terms of where it is, but
>> > it's better than not explaining this at all.
>> >
>> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> > index 539bb62d8..feab1df9d 100644
>> > --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
>> > @@ -206,6 +206,18 @@ installing (empty by default) and packaging (empt=
y by default). These
>> >  tasks are often overridden or extended by other classes added during =
the
>> >  project development process.
>> >
>> > +.. note::
>> > +
>> > +   While BitBake comes with just the one ``base.bbclass`` file in the
>> > +   ``classes`` directory, it supports class files also being installe=
d
>> > +   in related directories ``classes-global`` and ``classes-recipe`` a=
nd
>> > +   will automatically search all three directories for a selectd clas=
s
>>
>> s/selectd/selected/
>
>   already submitted that fix.
>
>> > +   file.
>> > +
>> > +   This means that, in this documentation, when you see a reference t=
o
>> > +   class files being in the ``classes`` directory, you can interpret =
that
>> > +   as meaning in any one of the above three directories.
>>
>> I don't think this is enough explanation on these directories, and as-is=
 it
>> would create confusion I think.
>>
>> There are some details about these directories here:
>> https://bootlin.com/doc/training/yocto/yocto-slides.pdf#19
>>
>> Maybe that can help you add the explanation?
>>
>> I would also explain the difference between these directories (classes,
>> classes-recipe and classes-global) in a paragraph of its own, not in a n=
ote.
>
>   Except that, once again, we would be going outside the bounds of
> BitBake. I totally agree that there should be a comprehensive
> explanation of these directories, but where does that belong?

I think that saying:

- classes-recipe is meant for recipes, and are inherited through the
  `inherit` directive
- classes-global is meant to be inherited through the `INHERIT` variable
- classes can be used in both context

should not be out-of-boundary.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


