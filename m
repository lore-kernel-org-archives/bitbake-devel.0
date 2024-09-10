Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9655EDE99F
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 15:46:45 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.26842.1725983204374039005
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Sep 2024 08:46:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BZ6cGNQG;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53568ffc525so1229374e87.0;
        Tue, 10 Sep 2024 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725983202; x=1726588002; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0MSMWnmP+T5Ss4Xj20EDXF5+M0r6/dXXNJoOGq5Yxw=;
        b=BZ6cGNQGdajq5KbCdm+y69JyDHR4gSKxka3P2cIXEucCARNi1G++qyoXZIvL2a8NjL
         iTvv1r3S4aLxflZxTxDfvekqbDk2fzWH7Md9sV32Q8UhKEnPiMi4byOhmewaVse4pzzz
         t+etNg8Pn9BLEKjcK9J934G/VO1KG9Va6uWeq28V2xlkvB10eU++gX/PhcBzJwdjrpQS
         hL/meExz5aXpcnf7CT1hyYChqt+OxbvO+LOihX3Bvr3O/MIsii8Ktgeg6NZ8+PMbFvVI
         mYyKfvNallC3NsiEMUNiS44i9kP7XxSiBg0nlG8r47oivGPrIhh0y5nXkdMyZuymhr8t
         Moew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983202; x=1726588002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0MSMWnmP+T5Ss4Xj20EDXF5+M0r6/dXXNJoOGq5Yxw=;
        b=deP+EaoZ9fhDxHisddSgLR8xjHvcSLm+NkOr+Yn6Zx7RMRN3m7BpdoObsIlHHdnZvF
         STyS5BppoFasY/p1yFsTY45wNYm4zf0SX77irOxYw+yAkr24sntZSndb114LDL96gbBZ
         Fxt51ARbrCYi5IidtPstz6v9qz+FXEIh3C1ARdbUUALGQ03V5qgeV/JVCmUwU8RKF5Md
         ykbNg4mFx8Z+IWpMVGu5BhjJALinJs5SvBnBy9QpWyc8MbNVIob0AoqaEHInj1Xq7JmU
         DZY9GtgFHATDiBV4AspdoMiK59/zrxGPkz7V5nCYEfprSGhRw/ihYWCiZiBYOpRsuCMh
         3auw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVjOyJ/g5SGd8I9vlx2/8wYwIV4zUvGU1Zbwn3RcTHw3wtfstgzBmwgepN5FNdg6ebPG1VpHJ4L5nkWB2QtxF9EVPvRbmNo+q@lists.openembedded.org
X-Gm-Message-State: AOJu0YwIB+0M+LbmaaLuD0Jh/64XH6L52yA1ZjVvokJfGZQupFNxo/Dl
	56c+NREqv7STFzQ02XgvZQSCEyP5NVlsCLfpa+CzROBBoNqe9J4mkxsOS3/6KfdQawyKDRSlXO2
	/gUycDAG2ajq1PWbEmdlSFcrY1zo=
X-Google-Smtp-Source: AGHT+IEvvacJ7YfB+jBjOYVc7WG7eS7cn4qe30z4YBXmZzjS1/dF7pPAJ2zTNN0zgeUSMGcBG4TPLiidO5Ku+jmig/A=
X-Received: by 2002:a05:6512:ea6:b0:52e:9c69:b25b with SMTP id
 2adb3069b0e04-536587b4390mr8748771e87.28.1725983201675; Tue, 10 Sep 2024
 08:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
 <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com> <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
 <fa52a7f7-d025-418a-b022-9d3e813ad2de@ti.com>
In-Reply-To: <fa52a7f7-d025-418a-b022-9d3e813ad2de@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 10 Sep 2024 17:46:30 +0200
Message-ID: <CANNYZj9komRYgFeGb3tqoMoR3HWZrDsB+KVGW_2BYMtQcLV7wA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Ryan Eatmon <reatmon@ti.com>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 15:46:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16551

On Tue, 10 Sept 2024 at 17:02, Ryan Eatmon <reatmon@ti.com> wrote:
> You are correct.  I assumed that the string was the same format as the
> SRC_URI.  This might be a little confusing for users as that means we
> have two different interpretations for repo strings.

> Then what good is the key value for?  The current patch does not use
> r_name except to look up the value under layers.  Should we just make
> the JSON have this as an array of repos instead of a named hash?
>
> Or is there some planned thing coming later that might make use of this key?

Please keep in mind that the format for the set of layers in the
'sources' section follows precisely the json format used by layer
setup tooling, which was discussed to death, and agreed with great
difficulty quite some time ago, and then implemented in
'bitbake-layers create-layer-setup' that writes it out and
oe-setup-layers that consumes it and pulls the layers from the
network.

Then there's an additional ['configuration']['bitbake-setup'] section,
which is new, and specifies what to do after checking out the layers.

This answers both of these points: 'sources' should list git repos in
a way that can be given directly to git (so that we don't lock people
into bitbake's git fetcher if they don't want to use that). And the
key is used by oe-setup-layers as a 'name' of an entry to tell the
user what is going on (bitbake-setup could do the same to hide the
noisy git output, especially if we bolt on a nice interactive ncurses
UI to it).


> Ideally this would be locked to oe-core as that is what is intended.
> But I'm not sure how best to do that.

Indeed. Anyone can mimic oe-core in their rogue layer and be selected
instead of the real oe-core.

> Side topic, would it make sense to allow for the existence of a config
> file in the repos that would allow them to "register" features that can
> processed by bitbake-setup to configure various things that the layer
> requires/offers?  Right now we do this kind of thing for the
> oe-setup-build script.  But I could see the framework being useful for
> this kind of thing.

I suppose you are talking about config fragments, which are discussed
in a separate thread, and have their own prototype. Bitbake-setup will
certainly gain support for those, but they need to be agreed on and
implemented first.

As for allowing config entries that would direct bitbake-setup to run
freeform shell scripts, I lean towards not supporting that. You can
put them into 'targets' if you absolutely have to. We're trying to
move away from custom and usually undocumented scripts with this
effort.

Alex

