Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92ECD6E57
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 14:09:50 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29555.1780322984778207726
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 07:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Xzsd8IXH;
 spf=pass (domain: gmail.com, ip: 209.85.221.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5873983d19eso8843169e0c.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 07:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780322984; cv=none;
        d=google.com; s=arc-20240605;
        b=VVSOv/OZjDajqJODcOe2Ye28QWPIjnJh0q/kQ/XXCp63rqNiH1aMRKfrKurZiuz41i
         DtPdc7EJ4Ro5RIPoBuvcxQe2MEb9qo5QwIM6iRr6HJ6sJSnaBNQsgoB0srL36rPwDtzU
         DKtWK7aHfowgtbR+cMCbU5GFABwK1xNlck3T1075UZvrv7nd7BvGbLWc5kQDmCywlbdb
         yWYnfXRdaF7Gk9sy1YTZJmoM5Lp2+hELWcocZKEuQ2kxWWUL0u/CNtkk6STEQGdGBLw0
         9vOkw9CjeC5KYV6y8esAWcvdTLut1dDFtNfRn0yAsa14C3QmAbfb6xfQwUMPR1V297tc
         a2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FrAxFsP4cW4T2VuKat6K3FjXZL/KR17AD9B4Ow5sk0M=;
        fh=6IxTdy6nKF7jRDjDTacz0d11gQJUFQbZp405S0bMMdY=;
        b=Dwq+0/R3GPz2S8H88qsP3RmpWwMdWNuCv+sRQNpm8arIAF65YCm248SkKLwpp81YA4
         hiVTFQ/2Bh9X1rEeH5z4CseYvgPxWTyCNCl28XM4MdSwmQuxt7ttFRjqVzTLNEgnKZ9r
         S++hfsx/2ChDzzG9qrQjQcmcJUWwZG/E7m9RGWZL1sp3SI6iQ2ax/tUSCVF8nPyBBLnJ
         ZoHa+CeZNIeSLodV3guh6yAAitHg2irCItxjjVG7z+eEpwFUltVfnsORPB0f8LQ3Wl/w
         X5a2wUogl6uPriqjUI5kxGmzNm2PaIbaxSlGqCjUwDIT1AOpXKFelg3IYvAis7hzOE7L
         Fl2Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780322984; x=1780927784; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FrAxFsP4cW4T2VuKat6K3FjXZL/KR17AD9B4Ow5sk0M=;
        b=Xzsd8IXH1SBYshaGWJjQrfbIaQ0y49C2ssI9oRsx2u24xT+hdqmxxaFv/NiBYKdgdH
         kaqgivTIWiLILDS5alpvS/n1sn24qIWjJ5tVP9qYoHhog8IEm3050hbtUGEoZVfduR5b
         oTfYz71gufjKwibupHgbgObt//xGUh1UEk5R9BSNUmctj+EN3eboEifGD4CrrS4zomv7
         kInU1j+qNZQ/6tpb6fgay7A19dCGrQLcvTw5mhp3RG4ScB6eRHDo+km1L591b8qtHEBv
         q/aQSR5MttyQx6GpICTMf47aiSb/dn6LnUg2eXdHPKR7GeCbuT+Tas/17khKZ/1Q1zin
         v2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322984; x=1780927784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrAxFsP4cW4T2VuKat6K3FjXZL/KR17AD9B4Ow5sk0M=;
        b=AzVMcepwNCBc7xVBpGxnnSWE9alYNxLD3BE0A5Lp5FYIUsxeRZPvo+U9BK4n3daZ5z
         lAJnGdVZHJzmjZ3EbpPFlPWWvuB7QxfVccPm+hO9bCXdAaNg0E9rrpu7jPFUIAuP2/tH
         O4OdBtaA5z8Bu+QwYb5zoXsxghBqs66DWfyeAwpFLi4w4TOvb2IallWLHMp69lw19VnZ
         8IGsL3sFaJpNWKtJkf7gaBtJhp82Aihv/93znqF59JPV879pujkSr/dVSClSwljPqgdE
         sSAuiTtI2icmfocJXxzg/MnseemYUamwZUpbzoD7CJtTNdhehuUMK5YHdQGU6UXICpkU
         rHNg==
X-Forwarded-Encrypted: i=1; AFNElJ9htX77u1/HvttzJlo12ZwJGXcQlZgPcY6UBffws61atn1GePkaW4L7/sQyONBy8zuzev/B3fFZHfgpuWT4@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz+7ck56j1p1jE+E63MdG0dMFmfvrGuxQ394s4PK13ePwtMy9PF
	HIEJYGFFPg1j6D2FWyAh52Fe4+ThUwzDx/3OLyxcAEK8rlXWTf0fgU46pYQRIGPVCRWZQLIkdmt
	WW5HU91wVTIDo6isvHiPhjbJ3RDyRGRU=
X-Gm-Gg: Acq92OHjxpsgS4bub20ccYt6hDbWOXcSEExAaVExCkRbuf4TbQkalS9N6aDtdjaC/Qe
	dvM+bMQIMdX1HZMzqu9E8av3TeeEpJxW4SPGQn7304viOvje2+QWrQafP164Hbk6k+uj/yXFQ8k
	ivL71T/GaXI/Z5nGS9kafmJ25fb12Dh7bX9bH93Eza+dTux4CVMCOGq8ahJILnyLf85aBr322rC
	UbAVxiN7PhgGoHBwKVSZOcjIaphZdSzMSPMu0R5IMn4863nzVnCe9EsjXTSbYylqGaqGja+ReUb
	TY6phXX9rlo5aQrtO9h/Yjb1mML2a/z4Oih58aC7SaofVavqT6EAp4Qp3WPer2w=
X-Received: by 2002:a05:6122:3a19:b0:5a3:1088:51c0 with SMTP id
 71dfb90a1353d-5a310885f41mr946740e0c.6.1780322983687; Mon, 01 Jun 2026
 07:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com> <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
 <3kgay5cukb3dd6ojc7ysbtd5jgglbe7i4shvcksa2wb3kh2zyc@3oegr7dacucw>
 <CANNYZj8+ToTjrpgXMzFfDB5k4Xc637ORzY7LdzW0Kn6fBGs_BA@mail.gmail.com> <3yo5dz6bcwiwkwzqe7ucg3u4lkfpgjhzgmwqnehllgehxrmopt@vtqynopxxjug>
In-Reply-To: <3yo5dz6bcwiwkwzqe7ucg3u4lkfpgjhzgmwqnehllgehxrmopt@vtqynopxxjug>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 1 Jun 2026 16:09:32 +0200
X-Gm-Features: AVHnY4L3N5XC4nNjRk0PEx4Kytq5uSlStZidfZU2OYTtMPuOFSSBSrcBbJR-hDQ
Message-ID: <CANNYZj_fQbdbKw2h5CAz83vPswpM25_oWoDpAL=+rEVJMtp_Ow@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Antonin Godard <antonin.godard@bootlin.com>, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 14:09:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19588

On Mon, 1 Jun 2026 at 15:55, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
> I considered this and agree, there's no true beautiful solution here.
> The description field also has this issue, granted, that's meant to be
> much shorter than notes.
>
> Since json doesn't support multiline strings, the only alternative is
> making this field a list of strings and concatenating them in code. I'm
> certainly open to that and can send a v2 doing it that way (it'd look
> like an extra "\n".join()).

Yes. We're basically restricted by json's original purpose of being a
data transfer format, and not a config file format. (the "no comments"
restriction is in the same vein). It's a lot more human friendly than
xml, but still not friendly enough, by modern standards.

It's tempting to make it a reference to an external file, but this
wouldn't work well when the config is fetched with http:
$ bitbake-setup init https://my.server/some-build.conf.json
would have to also fetch the notes file.

A list of strings isn't horrible, perhaps either can be supported?

Alex

