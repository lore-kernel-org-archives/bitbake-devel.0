Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43B8CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 20:02:35 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18891.1763409746360298208
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 12:02:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hW0YOr6c;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8824ce9812cso51977266d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409745; x=1764014545; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C9hEi4mLX28b1e+f/3PI6h93KhPZCEx0HHty9D+CgY=;
        b=hW0YOr6ceGlOIj07btSq2e8FBtJ61zG5J1bYT0HcJu3GfuoSmgCzjBJZLZFOuo7ouK
         SgX6BRwCQ57VpXtm+L4QZpMfmFAFKkTvN3djp0/8HBSvT1mItVZhmUE1BYuRGxaQ3KH4
         pe2BLZI1gJhJws70qL79jcPOOWf1nbqbSxDylgCRyY8Spb4n5p7ONZzONxDNUh8h/MTK
         n53x02m8AtM/ogJ1xF0drRwDcrEzCNySub3YpuoFZTVk3VB0dBuNjKIzOvspSQwcpRCy
         RMeNriOdd7jfimD165+d42QQHys+cZTizW3GkrWchtfZfzIPXJEgz8zU+XuVIRZIizFw
         Fnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409745; x=1764014545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C9hEi4mLX28b1e+f/3PI6h93KhPZCEx0HHty9D+CgY=;
        b=TyE0enmy4cF6j+7PsVjZHxnyD6LrwFuTcOL4MPgaKRjJyrjvNYL+Ed3l8PVzR41Tsq
         phIRAbw6jZcb5VCDSnQfctGQl1feFwfuNSq0GlsOCBW9xj1YZN+CM4a70swamkV51LiN
         QC8Hed/xi9uFze4nZLi9McgE37u03DYkSkRt6ThcPXZBljoPezxHhykCkJjiEcB87hR4
         a1hczyUkrRJUIRL1jRfslSxle99R5YVPX+7ewSZ/VD3kZjubBe01NDuXkdyUT/97Ts+F
         ze0Mx8oJvlPmZU4mXcLZKvVXVQx5xOVta3aWDWUcCbJh2ZxHBd8t7Q0gjgkqu+5nZL+T
         8BLw==
X-Gm-Message-State: AOJu0Yy4Ldd/Hc8Ez92/tCZRKWdcxvGMwD+Vitf5/+GD7bYi/jpO5khh
	JOV1MBrmaiAR86S+WJM/M2Q8WZsHajtXcpF8sDNJKUirvDMfWsjFf5Vbg43UCUyi77hYZkYNb6v
	a/1/WwNUl1PlSDJtLiU17qYG9/6RemtxL2w==
X-Gm-Gg: ASbGnctbASHLvx/K3mVBY72GCT9FtfARTVxAV6u08st7bHPi0YVRqzdJtDniWoC/aJS
	SuxVXlmcTMBcn3waAkYjSVUDZ9AL5HNvNfpLsKJd+JJCLFKvKVxuu97cGRp6fl7gyfd6N8MtNff
	5zqND0hb8Tluibuur803x7CjL6X5zRWJuOTm5b5iz3UIldF6rgFcDl406lPQXiA4DV0BH5L8p4B
	RXYX1CQ35jiyUCEENQWT+DlFhgq+FxFuAOhmrKRA7Zh3FD5xQ5O2gzTdQsjrPvZlHABDdiXDp9O
	+z+BFgJcEveFu5wi6d3ooNhhqmPAohYwnOmfZb2Z
X-Google-Smtp-Source: AGHT+IGHB8auJKfT9PYByrXTFOJwk6xC7G7LHAVAOrruKL88BgDvP3NL7AP8zjtTCsZhPW9aurtLP7ykCido/QwcGII=
X-Received: by 2002:ad4:594c:0:b0:87c:2559:fa28 with SMTP id
 6a1803df08f44-882926b374dmr196606536d6.43.1763409744840; Mon, 17 Nov 2025
 12:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20251117194840.2322115-1-JPEWhacker@gmail.com>
 <1878E35BD8113CE6.1265056@lists.openembedded.org> <CANNYZj8OMHqFdUcgWnE2_XEJKoR8=+NBVKbRf51m=rnXTGOVgg@mail.gmail.com>
 <CAJdd5Gbkd=gHL8CMdXDoMv=ZpckQvdReB5OmOkF33K091V5mZg@mail.gmail.com>
In-Reply-To: <CAJdd5Gbkd=gHL8CMdXDoMv=ZpckQvdReB5OmOkF33K091V5mZg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 21:02:13 +0100
X-Gm-Features: AWmQ_bmIUvB6T7sfqHsguhCiQbBL4W4HmIEc7Lordrgw3Q9vuV5q4WZ1ryLZtY4
Message-ID: <CANNYZj93vSNP-tRC7hS8TSQMJdxBUgO+jn9in97JkOrUBtbR2A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Allow setup-dir-name to
 be specified in JSON
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 20:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18442

On Mon, 17 Nov 2025 at 20:58, Joshua Watt <jpewhacker@gmail.com> wrote:
>> > This (and the actual json tweaks) greatly increases the chances of
>> > directory names clashing, so there should be a check for existence,
>> > and a logic to deal with it (probably just fall back to the full
>> > style)?
>>
>> Also see my proposal for a setting. There are pros and cons for either
>> approach, I just would like you to read and consider it.
>
>
> Ya this was more just to show how to do the template string per request, not necessarily the complete solution. I probably should have sent it as an RFC.

My C is that I'm okay with this, if it also comes with a
'force-full-setup-dir-name' setting :)

Alex

