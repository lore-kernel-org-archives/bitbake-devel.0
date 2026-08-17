Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077B4C5DF66
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 19:48:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3501.1786996090443856589
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 12:48:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=nGDq8O0P;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3D85D3D81886;
	Mon, 17 Aug 2026 15:48:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id kPmqQDUECTHF; Mon, 17 Aug 2026 15:48:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 41E673D8189F;
	Mon, 17 Aug 2026 15:48:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 41E673D8189F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786996087; bh=Ds+ImRH28uWoykBrWrA2c6K4YQx6zsneif9YytkBYQw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=nGDq8O0PG8+i3EjAu8x5AsiOI/NBaU7a6bnjkjXyb98r5AD8wULv3n+iMy6EUpF8Y
	 azWD5vt8fEHCe3uTtXAjLBZMUdTpYQG6T4tEtkTp5QffbayyCOrSwh+5NLvocV1FrC
	 3IuPEivLfO/OxNLZIUvbb/u1KaEQhQwBweHq5S8zyFejfMpAse2dyDHsvLStD3RVWA
	 BqRKh5xvkuT5meIOWD3D5gs0M+9h+6M+QJvNqizGe5QEeUki7uPd+dQK7/oHXSpiyc
	 l7Gz43Z1BBeIzCyOf1ft+5CT6aXPNw1xxTHpA47qf7uVhywzTdwhidAhm/MWRzrBkm
	 ++KiOBghHG12A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iq31I64lV7TA; Mon, 17 Aug 2026 15:48:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F1B683D81886;
	Mon, 17 Aug 2026 15:48:06 -0400 (EDT)
Date: Mon, 17 Aug 2026 15:48:06 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com> <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org> <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com> <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org> <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com> <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.15_GA_0126 (ZimbraWebClient - FF153 (Linux)/10.1.15_GA_0126)
Thread-Topic: toaster: Add recipe variables view
Thread-Index: 9ocwSebfxNC5rQVRjSjLjnIZIM7RXg==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 19:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19975

Hi,

> The cache you've added is per parsed recipe, not per recipe used in the
> build. Was the patch AI assisted?

The new `recipe_variables` field is collected in the recipe parse cache for
every parsed recipe. `buildDependTree()` copies cache fields into the
dependency graph only for recipes in the runqueue, and Toaster persists onl=
y
those entries. Thus the cache is per parsed recipe, while persisted Toaster
rows are runqueue-selected.

Yes, the patch was AI-assisted, as disclosed in the commit messages. I used
AI tools to assist with code generation, but I reviewed and tested the
changes, and I take responsibility for the design and the submitted commits=
.

> 33 differences per recipe seems very low as well.
>
> bitbake -e bash | grep -v ^# > a
> bitbake -e quilt | grep -v ^# > b
> diff -u a b | grep ^-[A-Z] | grep -v : | wc
>
> So I've filtered only variables not functions, nothing with an override
> and I still get 132 differences.

> I think you're missing a lot of values.

The current code records only variables whose BitBake `VariableHistory` has=
 an
operation from the recipe, a matching `.bbappend`, or a recipe-owned `.inc`=
.
It excludes class- and configuration-only values, functions, inactive
overrides, and values that fail expansion.

Therefore the count reflects this source filter, not the complete effective
recipe datastore. I agree that describing the result as a resolved recipe
variable snapshot was misleading.

This raises a question about the intended scope of the feature. In your vie=
w,
which variables should Toaster expose here? Should it provide the complete
effective recipe datastore, including values inherited from configuration a=
nd
classes and values selected through overrides, or should it expose a clearl=
y
defined subset? If you expect a subset, which inclusion or exclusion criter=
ia
would you consider useful and correct?

> Ok, how does it use variable history for selection?

Variable history is used only as a provenance filter: it selects variables
touched by recipe metadata. The stored value is then obtained separately fr=
om
the parsed recipe datastore using `metadata.getVar(..., True)`. The history
itself is not stored. The compressed snapshot is carried through the depend=
ency
graph for runqueue recipes and then stored in Toaster's `RecipeVariable` ta=
ble.


> > Our longer-term goal is to expose relevant recipe and global variables =
through
> > Toaster and MCP, together with selected layer configuration such as ker=
nel
> > defconfigs. This should give an agent enough build-specific context to =
produce
> > a more informed vulnerability assessment. For more information on VulnS=
cout:
> >
> > https://github.com/savoirfairelinux/vulnscout
> >
> > Thank you also for the encouragement regarding the Toaster use case. I =
will
> > prepare v2 as an incremental series, separating data collection, databa=
se
> > storage and the user interface.

> I'm not convinced you understand the implications of the code changes
> you're proposing and that is a significant problem :/

I understand the concern about broader metadata such as kernel defconfigs.
That was only an example of a possible future extension to Toaster, not a
specific feature I intend to implement as part of this series.

Have a good day,

Paolo


----- Original Message -----
From: "Richard Purdie via lists.openembedded.org" <richard.purdie=3Dlinuxfo=
undation.org@lists.openembedded.org>
To: "Paolo Wattebled" <paolo.wattebled@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Friday, August 14, 2026 4:56:45 PM
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view

On Fri, 2026-08-14 at 10:31 -0400, Paolo Wattebled wrote:
> Thanks for the feedback.
>=20
> The 598 figure is the number of recipes in that build, not the number of
> variables. Each recipe has its own build-specific snapshot, giving 19,756
> variable and flag entries in total=E2=80=94around 33 per recipe on averag=
e.

The cache you've added is per parsed recipe, not per recipe used in the
build. Was the patch AI assisted?

33 differences per recipe seems very low as well.=20

bitbake -e bash | grep -v ^# > a
bitbake -e quilt | grep -v ^# > b
diff -u a b | grep ^-[A-Z] | grep -v : | wc

So I've filtered only variables not functions, nothing with an override
and I still get 132 differences.

> Each snapshot contains the final resolved values specific to that recipe,
> including changes from its .bb, matching .bbappend and included .inc file=
s, as
> well as flags such as PACKAGECONFIG[...]. Values inherited unchanged from
> global configuration or classes are excluded, along with functions and in=
active
> overrides.

I think you're missing a lot of values.

> Screenshots of the linux-imx variables, bluez5 PACKAGECONFIG values and f=
lags,
> and variable counts in the recipes table are available here:
>=20
> https://imgur.com/a/u20rf3O
>=20
> Regarding history, the current implementation stores one resolved snapsho=
t per
> build. If build 1 resolves A to 1 and build 2 resolves it to 2, both buil=
ds
> retain their respective values. It uses BitBake variable history for sele=
ction,
> but does not persist the complete assignment and operation history.

Ok, how does it use variable history for selection?

> To provide a little more context, this work supports vulnerability assess=
ment
> in VulnScout through its new MCP functionality.

My concern is that it could well be based on flawed input data then :/.

> Build metadata and resolved variables provide useful context for producin=
g an
> accurate assessment. For example, PACKAGECONFIG can help identify the fea=
tures
> enabled in a recipe and the resulting attack surface.

Did I suggest otherwise?

> Our longer-term goal is to expose relevant recipe and global variables th=
rough
> Toaster and MCP, together with selected layer configuration such as kerne=
l
> defconfigs. This should give an agent enough build-specific context to pr=
oduce
> a more informed vulnerability assessment. For more information on VulnSco=
ut:
>=20
> https://github.com/savoirfairelinux/vulnscout
>=20
> Thank you also for the encouragement regarding the Toaster use case. I wi=
ll
> prepare v2 as an incremental series, separating data collection, database
> storage and the user interface.

I'm not convinced you understand the implications of the code changes
you're proposing and that is a significant problem :/

Cheers,

Richard


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#19947): https://lists.openembedded.org/g/bitbake-devel/=
message/19947
Mute This Topic: https://lists.openembedded.org/mt/120719031/10577327
Group Owner: bitbake-devel+owner@lists.openembedded.org
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paolo.wa=
ttebled@savoirfairelinux.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

