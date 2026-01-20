Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5FD2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 12:30:15 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5342.1768912212911004345
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 04:30:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DlorHgQL;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-502a407dabaso34523731cf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 04:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912212; cv=none;
        d=google.com; s=arc-20240605;
        b=UQr845oFKseWh6vF9jkelqMi3yr9fMQljvkX4/kzFfsWgnaxXKp1n/y2XhQi1a0tlN
         3TFd38xo/IZGHYhqg5CzO7Nev8r+0wRfV9a97W0fw6G1Vx2gmrb7REQpHYmRtxjiSouE
         eNnvNGEVNqY70b5ltVdaV0WVdsdIf7kT2sd5zq+bpgFVg9obxl81uwZ5HOip1WkC6gMH
         unAuz+OVDeivCkblgRUCeQB2cqVTFcVNhQL4S+KTxNP/0saGiXYI0UGNyJBQNEVd6XYy
         PT4Me1IE8SsZ9xtXV5nIf7sgNvnZwvzZR35oPuigFM+/KQpV5j4RJcB37mQW++AyYzE6
         L7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PCJ5T7ag3jbSpx9QhjbrskqjHdUXn231fp7T6BGJR9M=;
        fh=4iyoqXWXzr419C+IQOwDq6Y51UQKhKZf37iVDBoh7vA=;
        b=LT4vRt7wVGfU4RiGtldhKL2tBujqNZolB36vL9yJTaMdqzBEBfhsCiRSM2Fwd9oI52
         WjZfy/9KrFfzqdXdRxZfhi9WNMIS/umStJ6oO89dwBmX7po6JnI1YH0ePdoRfQcnYPrn
         OlMo+UAYDLCoZX8S9OpJI6+X4w1Tp0K4iU91IiOjdLH0L++WNfsWPmrgCVoQ5JbH7jjU
         3g+qd6kSg1Tf847jusmjOqJ+3ZuHFX2lYyKVH4iIZkG7tPIj+nxunXLyjbldtSFw0O26
         mTzFJVwDxwhnZGXQvL3wLeSoU8TfUwoyjf0Z/Ed62AYghmT4gAEehldhE6fA8wToxN6s
         ncaQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768912212; x=1769517012; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCJ5T7ag3jbSpx9QhjbrskqjHdUXn231fp7T6BGJR9M=;
        b=DlorHgQLb0mtl69wCwskuLcWqtnBuKOHT9pBj/WqEEMqwrPCIpGXwEOS20VqTEQBHh
         A7cI1J0bCDq4nBETyrQaynj/c0NDn+YsmahSKFwGssQ9/6fogrSjF4U9iZnBEwHvRZjw
         p7UUXG2DfwdF4u+Gqt34R1QAy4OlM49wub1tLMnX002+JMY33f6nyiZ34c0wLFvIjnEM
         naLKLMZAynmLBexIoPyCbOMAVc6avjzyUkZI1i5kYD7zCJK+DPLk1frkklFqrp9cRInE
         7NKWIM7zhWSkfXSwpP7yxbDxm8A4l/xgFJ+DsnzzDUSl/CojKeQJ0VzHSmfgvQfDUhX1
         CkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912212; x=1769517012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCJ5T7ag3jbSpx9QhjbrskqjHdUXn231fp7T6BGJR9M=;
        b=meop8u/zNZ0c2FWCjhpV5qKTKkgk6JEWz3/ncexxNq5POU3lYy367qwv92WEt739hc
         hc2QMu8UJ8q5otHq2SVsfUj4N2qOPYIb5lozVDLlVWygKGfbpVIm27yI2cbyerHCwUAF
         xsCf0EU0uOcMJcl2JVzV84FzYH+eTmWUOJMsFJGaFEjRNyQx2vuGEL1+/2UURe4F1AF3
         tEeBbngD6GDZl2jbtEzNBVfdyBFmxaDwg1crXxsg/LOfaemBFD8OxW6rCDHHlTaIr4Wr
         rCJv7DZRpSqipLKm+QPiO9/icxeCg7AJplcPWJ226rz5C2vxk3nNelYiMTNvjjjwBId4
         O8Gw==
X-Gm-Message-State: AOJu0Yw2CCKiB9pR3pCKwIfAghvPuF/xFp/Uzamk9gSzPj6dR7EFTDjn
	MZ1U/AmKawIeLVCHnbYXUMaHZtZjHJKatDBxsvqtUhsbPaeJC+T824WbV8vUywuWmFbaEE4HlKO
	vnliatxJd27MTEgvBEI9fqUoKX3SiPLw=
X-Gm-Gg: AY/fxX7Y8TtHJWprzhT7fg8OLJsHZQfZAUEaMOhIceX45sgKFHnAOLnfcqBJOLHlqCJ
	U8A6Rbh8bYMcsLMfZxiPxLux/KSbKP3tLzUbZm8SgzIF0PNdug0q3ryijAEmBiVjDEsEd7sxlR/
	BUiuqaA4AZAU67tHOPop055OSlLuGu1izpbHbCM6//psAEdVzAIxTn38nmYsDTlTegsR07+Plh2
	pDXv4i6NEYyvJl+lq7c5Ir0fyQ+73BH7bnjqWCyiNDYnLvnTIPz347IyOjx52bNYOpMd/zuuH1v
	hgw+14m9336vUF4oUNoaxlaf3E/koA==
X-Received: by 2002:ac8:5f49:0:b0:502:a3b:f367 with SMTP id
 d75a77b69052e-502a16b31f7mr204203831cf.51.1768912211918; Tue, 20 Jan 2026
 04:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
 <20260120-bitbake-setup-choose-builtin-v2-1-ade604ff2351@bootlin.com>
In-Reply-To: <20260120-bitbake-setup-choose-builtin-v2-1-ade604ff2351@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Jan 2026 13:29:59 +0100
X-Gm-Features: AZwV_QjPGyE57kOsd0jehxyog_-Y-324e5duPToIWVlyOP4S5MCZi9Pp1yL8oL4
Message-ID: <CANNYZj_U61ArCom7N0+8ztW3gP5t+6MRHUyj7mV5PQ6VR0Vf8w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] bin/bitbake-setup: add
 descriptions for fragment choices
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 12:30:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18817

On Tue, 20 Jan 2026 at 09:57, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> -        choice = [o for o in v["options"] if o in parameters]
> +
> +        # options can be a list of strings or a list of dicts
> +        options = v["options"]
> +        descriptions = []
> +        if len(options) > 0 and isinstance(v["options"][0], dict):
> +            descriptions = [o["description"] for o in options]
> +            options = [o["name"] for o in options]

I think descriptions should not be a separate variable, just use list
comprehension to build up a full structure with empty descriptions:

if len(options) > 0 and isinstance(v["options"][0], str):
    options = [{'name':o, 'description':"" for o in v["options"]]
else:
    options = v["options"]

That requires tweaking the rest of the code that accesses options, but
I think the result will be cleaner, e.g. adjust:

> +        choice = [o for o in options if o in parameters]

to
choice = [o['name'] for o in options if o['name'] in parameters]

Alex

