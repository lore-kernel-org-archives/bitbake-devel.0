Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF2BCCA471
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 08:49:27 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.29618.1759740563807631536
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 01:49:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y9Nisw42;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-796fe71deecso45836216d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759740563; x=1760345363; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2L9h405fNUWHshgae3kexTEMGpdKLv5qyOP3cw75nM=;
        b=Y9Nisw42CstGm7R8JAnjeLlpiK+bq+RB2t34K6Dod4g4hS04umwNDKMg53bF7X0L30
         A2+o31P7audOJUem/uv4PxzFxYKCGfkyoOt5F8c2mrMX/MQv33Q+Pjfpg705Jt+uhMoy
         PWP3zQQc3akW5J+O3Izpj0y/SkDe2IW1fQ1HdwRzC8T4HOYIIBrUvzo2dn981thgtBru
         JGgxi+bAUT98hnd2ZAI97N1HHO3zqxTF44aWxhhf/I1bK/HKeRUKtK9OrrdrlMxOPytG
         HaIgNShgib2e5plfOXYl2oBDqXJhgij5Mpmio5+bDyXQ4u19s0wuGh2c0IK9ET+9tAuj
         wo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759740563; x=1760345363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2L9h405fNUWHshgae3kexTEMGpdKLv5qyOP3cw75nM=;
        b=NVp5Lw//u4m54P+CFLdGMHvVpwL4HZFbL4+Exz+hOCsndsjczNl1Kr5rNgHek7fBkj
         fr7UK63jLlQ/Z+8BTtGQatmexZAjF5NHGM7ptCdt/VqxHj9nBmFKmfwoqcqSnFjh0JLG
         Ff8IOdwE2rq8czHTmw8pTQTr3xbm3dgMm7VfWcKV5YRQgxIl9Vh1uRQBPIKpu/zXMg8q
         JZ5xAHZ0G4m3LEtcTBkr3Yfd2gDPpvNpn5OI0FzjaLBzZUdx13lkGiQdQ4D7Wort4HAS
         EJmh07dlRO08b6as/kxiFVQbMHPl3pa1h/R6PveZF0BW45H0kCeT0ssOs0hLJlwnW/Su
         Kvgw==
X-Forwarded-Encrypted: i=1; AJvYcCVBuPbk7GJh0wR79USamIk0zMVt+/YP4NGFRoNWltqpmsQBKe7vd4upk8aTC4yHlumd8TLcZgAhXLkGGyfC@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyg82rt6GGcS+zMk4kzcIUsGI4x/gXJcjlpQKzlN3DTberwguvr
	odqd/GsanAB4hHe1WDlYg4zx9dyJ2xvyyYirkbrFwQRmf8uvEXAF/VKOfnVasROpydycw2IMQeV
	WP7p3b/To4cpqkjDeZ9X3XWjft/No9qE=
X-Gm-Gg: ASbGncvyIZxChLvnLLRqEeoYLaFIZji9bt2DR35I+vVqLknqEE5fptEHDISfYVFm1bw
	H9eU2RoDjqIQZuuPpn1xtcF7A8+v7SnB0sJma+NbWbKZslgbLTumrf17E8eURtIqDiaW3ZL0fQf
	QYYpAIUGwknmnS4XjhUfBBuPJTTVfq32M0EbxthznHZIRZCfg52Xw03oVtBjsZRaLhX43QDS6IS
	s050wXUbBYrBMLrfjjAM+Jz8p/k2CAkpa7IMkr3EIcvDM6lwL4hp18G/8LIuSOCCOch3tCpLBDS
	/U9s1W6iwC7e03N6Xjx9VKmtoTLUMI7Re9uFAZIgK2q6I7QqlS++tTlpFpxmpHrs
X-Google-Smtp-Source: AGHT+IHm6XbgLV2NxFsxM82rUejxUC25iD9f6qf/kYKIl16yFFkBFmPEvm9ru8LnCf8fuxjfHphqf4qJNO4+JjByAEQ=
X-Received: by 2002:a05:6214:2504:b0:80e:327d:be5b with SMTP id
 6a1803df08f44-879dc87f0afmr159581356d6.66.1759740562652; Mon, 06 Oct 2025
 01:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr>
 <8bf3234625affeee077859ea356928d64b7116b0.camel@linuxfoundation.org>
 <CAJdd5GYroEC5B599SVMpeJH8uvh12jafcR0WE3Cjdz-5NTNbew@mail.gmail.com> <CAMSfU+6ox4rHFhAPyFNZ6G0frwtD16i5go9OYxBP20a936O+=A@mail.gmail.com>
In-Reply-To: <CAMSfU+6ox4rHFhAPyFNZ6G0frwtD16i5go9OYxBP20a936O+=A@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 6 Oct 2025 10:49:10 +0200
X-Gm-Features: AS18NWBMgvd45lI9tBE8oKyMNbtyuVQQJMcYhEROHyph4QMaQ9odCanU19s9eRA
Message-ID: <CANNYZj8qYeBxCseqBGpadZ2gq5KWhVmyQfiYD8sk2ZLRZQSxDg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: yoann.congal@smile.fr
Cc: Joshua Watt <jpewhacker@gmail.com>, richard.purdie@linuxfoundation.org, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 08:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18136

On Sat, 4 Oct 2025 at 17:58, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:
>> Maybe just a "comment" property that gets ignored then? That's what
>> JSONschema uses (although it does "@comment"), and then it doesn't
>> violate any parsing? e.g.
>>
>> {
>>   "comment": "This is a comment",
>>   ...
>> }
>
>
> Yes, this is a possibility.
> I don't love it since it mixes data and comments.
> But, this is indeed pure JSON and the most low-hanging fruit to get comments (no external deps, little to no extra code)

Before we think of adding comments one way or another, we should first
consider if there's something that people put in comments that should
be part of the formal schema (which btw too needs to be defined
similar to meta/files/layers.schema.json).

How about two additional, optional fields, "notes" and "homepage"?
That would already address a lot of use cases for freeform comments.

Alex

