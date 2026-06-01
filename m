Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2819CD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 13:55:40 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29337.1780322133445827791
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 06:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gLUUYM92;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso2775418f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780322132; x=1780926932; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=15TUzHFumJIJHYgiDifXsCqk64rl1pnegyU9W4n2qcI=;
        b=gLUUYM92CfM95O+Dw3gYaHTOT9xC5uP1s6wJGH9uSTBHJOa3frEOIA2Qb0a+C3bvfl
         36OYXEaWKSeiMfE8zLGiPG60DKx7KYRzP3/ryDRuwfCFESKqH/A9e3HSk9EEfU76u8WW
         PTHefFHd6NhsN5z4eG3OF6A7WUhO1e607exacscjxSF1UUKdvX2DeKELMa1xIb0s+wEj
         qoPSn1aAYdzZw/79y5BV8SOuftiVbl3HJd4tZWY0yScBkAgMmAOCwGB3vxI9q3LXnGIp
         6r7oqZiacDek5NqlVVP3otu0Uc98yNKe86uL8VySB25hUWmO8E3oSSmZNhrZeNEKjYc6
         U1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322132; x=1780926932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15TUzHFumJIJHYgiDifXsCqk64rl1pnegyU9W4n2qcI=;
        b=BUbOvFvSISXoMIXcThTDqDxOZRozQNsqn6lIvcWEwLfnsuxwfO3sjnht9NHpNS/jw3
         hwMJjunZjPQ/o5f4L3A+ESAwG0fsH/Fd5JY7NYYSRZHZZH6+UjcJ1qb48YiPpwojuxGz
         eQi32Yk2xE85UVsVMjIRWeNe+EaKeeDEKuy0V7zOeWiGqL64YACJLvIbLsqUoMd8zYlU
         9PBCJpVDvdzWMaorG5zoGPkx7J62LcbyeqiJDLt7cF8kx2pB70jbjtkpytKdCRt9ptxQ
         IGrKgZmDgzafg7D2Wr0iovN1Tx/79MHXZj9H6aCw5j0P6ATPBhLf6bgr50JYllsXu7QM
         /Txw==
X-Forwarded-Encrypted: i=1; AFNElJ8HFv+vblWXKvv1Dr5TSkq5atcSG2n8OsOy3tKU5N5W8hvdhfcCdkmi5vQRMPdFXHaEtErN9LLmgjNpNCUV@lists.openembedded.org
X-Gm-Message-State: AOJu0YyGmtzFnbi2ZwhuTELUNTdlWcw154aZwMqsDypBNo7id1OQco0T
	ofRlf3dRugHmo62EiSSgRqHLX4o2xlraO1p6R4D65RpI8MgGU6bTHdBW
X-Gm-Gg: Acq92OHVCiBp6hvrhqnrpGgGExxKLIgm38/NAMJaHsY66OxpU4p6Mgcr8ZtCivDYk0J
	v8icdmp0IL1a6eJFp+/AC47CNq+fECLy3/s+ayxn4928mXc4yOnYUewdUeiaVZb0+u1oMIoKPKh
	U9gHFg/TMOaISdTCeqJlGoSiW7YA5M2z7eLPAkaras8WfeinsPQ1qz9doUgWMCFLq0dCH6zN8dI
	cNIME/Lce0m8ZvfflSlxTGDRJ5tKlA8cYojFjfnpo12d0b6pxSwmY7qZaYhu68VT55HU7ua4jQX
	P58gtHdCL9l7rsCWU6bOO1WzJ2w3aZqBRJpNTTpeLm3jhLhLwYjYH0921gwnMyXyo5xayHt+TKb
	q+HMK5G6TNJw9BFAozQbYMG4cM09dCjzeDaVME7q0Ycuu+yFcYIq/T2z5BuVzo6aTU4oYBwqWsT
	ytND7k186bi4WI26+6nodb7yPzrQuxD2Ive2WmOgqfHDFMDDJfhU+ApN3qi/M5mrRAKvFR6l+fj
	2ZdA1bnItv68ifLhgosLzTWEH5XJFU+7bORsg==
X-Received: by 2002:a5d:60d2:0:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-45ef6b4f2bfmr16311628f8f.24.1780322131620;
        Mon, 01 Jun 2026 06:55:31 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm26303038f8f.5.2026.06.01.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:55:31 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:55:30 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Antonin Godard <antonin.godard@bootlin.com>, 
	bitbake-devel@lists.openembedded.org, Alexander Kanavin <alex@linutronix.de>, 
	docs@lists.yoctoproject.org, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
Message-ID: <3yo5dz6bcwiwkwzqe7ucg3u4lkfpgjhzgmwqnehllgehxrmopt@vtqynopxxjug>
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
 <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
 <3kgay5cukb3dd6ojc7ysbtd5jgglbe7i4shvcksa2wb3kh2zyc@3oegr7dacucw>
 <CANNYZj8+ToTjrpgXMzFfDB5k4Xc637ORzY7LdzW0Kn6fBGs_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj8+ToTjrpgXMzFfDB5k4Xc637ORzY7LdzW0Kn6fBGs_BA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 13:55:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19587

On Mon, Jun 01, 2026 at 03:30:48PM +0200, Alexander Kanavin wrote:
> On Mon, 1 Jun 2026 at 14:53, Ernest Van Hoecke via
> lists.openembedded.org
> <ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
> 
> > Yes, I tested with some newlines explicitly written and this worked fine.
> > Since it just comes from a json string and is passed to `f.write()` I
> > don't believe any special escaping is necessary, just "\n" is fine.
> >
> > My understanding is that the Python json library should handle this well
> > and converts it to a real newline in the python string.
> 
> I need to ask though: how practical and readable is it going to be,
> when written into the json? Notes are meant as multiple paragraphs of
> text, and it would be good to be able to write them that way, instead
> of some specially-formatted single string.
> 
> Alex
>

I considered this and agree, there's no true beautiful solution here.
The description field also has this issue, granted, that's meant to be
much shorter than notes.

Since json doesn't support multiline strings, the only alternative is
making this field a list of strings and concatenating them in code. I'm
certainly open to that and can send a v2 doing it that way (it'd look
like an extra "\n".join()).
 
Ernest


