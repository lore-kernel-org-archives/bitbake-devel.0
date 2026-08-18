Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F55C5DF82
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 18:33:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15704.1787078033305031560
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 11:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ayoaCanC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 110C03D81738;
	Tue, 18 Aug 2026 14:33:52 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id avAxXdH_b-46; Tue, 18 Aug 2026 14:33:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A99E33D81928;
	Tue, 18 Aug 2026 14:33:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A99E33D81928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1787078030; bh=pTXZuAvDWXjTS0VPCfCgGAx0ePP5KxAiGrWkocLQn7o=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ayoaCanCtrV0HQ3CRmyoHuVP33bmpipSwikYo6b6c/3TnPO4447zTY6tGE/CE/x61
	 no8BFxRmXSzNOL/vbvKF0q0FTGugMZGLj4bDqa28q0IVw0SogksWYF6bZZW5+YKcDA
	 eczDzle2PG4em/bDMFjtD32QsM3Za1M2m1BLOk74kDyQKm2l7v3/L/GNclm/nGoGJO
	 924L1d8j4a/fJWrL+L9t62csqM+nBsYuY/5+CNAnDKuWfOOLLJNfA9jYnBGbRA5JR8
	 FKTTuTj+WYNSI/ltMum8KrjZEZ28leh+hXVHTE2j6U8kCuYJMJwPu2lji3q09GuiJ7
	 YnUknUkmAReQw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id alH7Ka9KGgDJ; Tue, 18 Aug 2026 14:33:50 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 745203D81738;
	Tue, 18 Aug 2026 14:33:50 -0400 (EDT)
Date: Tue, 18 Aug 2026 14:33:50 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <515257189.1172159.1787078030404.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <8558d54fda8e977ea6e677693db0586b8e10e80a.camel@linuxfoundation.org>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com> <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org> <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com> <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org> <453789479.1044718.1786717890540.JavaMail.zimbra@savoirfairelinux.com> <2417b94a9c5734b9e9b54f9d1eb3133cab4c0ff1.camel@linuxfoundation.org> <1200355947.1128688.1786996086820.JavaMail.zimbra@savoirfairelinux.com> <8558d54fda8e977ea6e677693db0586b8e10e80a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.15_GA_0126 (ZimbraWebClient - FF153 (Linux)/10.1.15_GA_0126)
Thread-Topic: toaster: Add recipe variables view
Thread-Index: nE1LfSlb5RsGy1irLs6BQCrYX5l87g==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 18:33:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19982

Hi Richard,

> For example if the core metadata has:
>
> X = "${Y}"
> Y = "Z"
>
> then the recipe sets Y = "A", the variable history for X doesn't change
> but the value does.

You are right. My filtering happened before expansion and relied on
`VariableHistory`, which records direct operations but not changes caused by
references to other variables. It could therefore omit `X`, even though its
effective value had changed.

I removed this history-based filter. The implementation now iterates the
parsed recipe datastore and stores the expanded value of each included
variable. I added your example as a regression test, and the snapshot contains
both `X = "A"` and `Y = "A"`.

Variables marked as functions and explicit override keys are not stored.
Active overrides are represented under their logical variable names, and
non-function flags are stored as `VAR[flag]` entries. Values detected as
involving inline Python are also omitted to avoid expansion side effects.

On an `imx-image-core` build, Toaster persisted 598 recipe snapshots with an
average of 1663 entries, a minimum of 1627 and a maximum of 1944. The compressed
payload was about 86 MB in total, or 145 kB per recipe on average.

If you agree with the current scope and semantics, I will generate and send a
v3 of the series.

Thanks for pointing this out.

Cheers,
Paolo

----- Original Message -----
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Paolo Wattebled" <paolo.wattebled@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Monday, August 17, 2026 5:08:38 PM
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view

On Mon, 2026-08-17 at 15:48 -0400, Paolo Wattebled wrote:
> > The cache you've added is per parsed recipe, not per recipe used in the
> > build. Was the patch AI assisted?
> 
> The new `recipe_variables` field is collected in the recipe parse cache for
> every parsed recipe. `buildDependTree()` copies cache fields into the
> dependency graph only for recipes in the runqueue, and Toaster persists only
> those entries. Thus the cache is per parsed recipe, while persisted Toaster
> rows are runqueue-selected.
> 
> Yes, the patch was AI-assisted, as disclosed in the commit messages. I used
> AI tools to assist with code generation, but I reviewed and tested the
> changes, and I take responsibility for the design and the submitted commits.

Sorry, I did somehow miss the tag in the commit. Nonetheless, I am
worried that the changes here aren't quite right.

> > 33 differences per recipe seems very low as well.
> > 
> > bitbake -e bash | grep -v ^# > a
> > bitbake -e quilt | grep -v ^# > b
> > diff -u a b | grep ^-[A-Z] | grep -v : | wc
> > 
> > So I've filtered only variables not functions, nothing with an override
> > and I still get 132 differences.
> 
> > I think you're missing a lot of values.
> 
> The current code records only variables whose BitBake `VariableHistory` has an
> operation from the recipe, a matching `.bbappend`, or a recipe-owned `.inc`.
> It excludes class- and configuration-only values, functions, inactive
> overrides, and values that fail expansion.
> 
> Therefore the count reflects this source filter, not the complete effective
> recipe datastore. I agree that describing the result as a resolved recipe
> variable snapshot was misleading.
> 
> This raises a question about the intended scope of the feature. In your view,
> which variables should Toaster expose here? Should it provide the complete
> effective recipe datastore, including values inherited from configuration and
> classes and values selected through overrides, or should it expose a clearly
> defined subset? If you expect a subset, which inclusion or exclusion criteria
> would you consider useful and correct?

I'm not sure what the right answer is, but I don't think your current
criteria works as you think it does.

> > Ok, how does it use variable history for selection?
> 
> Variable history is used only as a provenance filter: it selects variables
> touched by recipe metadata. The stored value is then obtained separately from
> the parsed recipe datastore using `metadata.getVar(..., True)`. The history
> itself is not stored. The compressed snapshot is carried through the dependency
> graph for runqueue recipes and then stored in Toaster's `RecipeVariable` table.

For example if the core metadata has:

X = "${Y}"
Y = "Z"

then the recipe sets Y = "A", the variable history for X doesn't change
but the value does. That is a simple example, there are much more
complex ones.

Cheers,

Richard

