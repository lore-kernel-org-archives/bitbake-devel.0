Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E5CD6E56
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 12:43:58 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27762.1780317835492990177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 05:43:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TQa+ZbmW;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a765e68eso11359115e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780317834; x=1780922634; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyo/so3wfzCTH2J5MCFFbeX6zdm/D40dOgl8nPlYFlA=;
        b=TQa+ZbmWHb1pDEn8sWB/alKaWb7VokkEfzRjSi4qHnD74yo9cobY2vsY/zz04N4Kqu
         80svboPW4E48/23pICXPiiDsVLu5rxKgRc8r4SHZCiLHtuSTYopW8yfF2eNMfWmePmvh
         Hzmh1JPTfQKVePHwIvZSH7AjcyU6AudYUab9j9a1FOS4tTqKr/dU0pRTUSQihs07gplW
         B7v3CTd/7wPSIQYbBKu1KouIN4BZk2Cgwa0wTa82k11vflEnpsfvvXyxd5k2rOXzrnVb
         9hHaCP+Vab16Bw5pCxGmSj++seLerWiX7rAr0cc4NERZq/TEa/oXFip87FRd/Zc6CFcf
         jSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317834; x=1780922634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyo/so3wfzCTH2J5MCFFbeX6zdm/D40dOgl8nPlYFlA=;
        b=EO0HD1HsI+vACYEZgQM+rN+dKbZHNwLcj9FV+EZ5BT4drjJsiPedbGZT8xiNm0vDZg
         1tj1t/uDu4lfTUZoQMCAMiQpjFPalBZAoU4Hy77PFilM4pgLaMd964Pv4uZABnWL9AcP
         eVslNKcM6r4zgFzc59TTq+MLqkbwbed35pfE+wrd8aS+53Hq1TUVa6hvOBypYWnhz9PX
         /V06j5SQ/wo5kvQMVwsTMY6P0NBkG/Og3eMIIvliKD/noSF0m9CaRCp7txna/nfaWLgk
         D0jcGZKoqhciyzZP+FPajNbrB+l0/kp6AkGp1EbNpYUTAXHnsEmaZOtCyvNAfr7dCEvv
         3plw==
X-Gm-Message-State: AOJu0Yxo5bQpRAJlWQEHxmEVk4w8EmzuBzBRnbmFq6PIjyGEUFCLGmnR
	q1ixYUYTl4vcj001kepq6GIVsxb6I6G8kW/Rje348aaAJQAGjj+YVdbc
X-Gm-Gg: Acq92OHF9umDhyii/m6+/AqKoUb3C7HYv5rgAdqAhaQKH7JCMJAxrtR+I16BWjUt6Kp
	QpUENdDXi4sFF2T3KaW5yR1tqq+KT9MD3ztZxLTzjD+YvhgXLpZUBBuiaPsGXtrb0vqagrrdqFZ
	kaiKaRg5dlyTgpnVx4CxWfTQAoXakDLaYLT7sQKMn+ytqSG6Tk7gUkjHxo85/fbWG0eIxK3Ev4C
	1VY3rz8mSLTvBsFmF6NrMj0VqnXZYcfwDzLOJHkteZLsFEbbxqfIACf3Czv19BELa3/wswRSw+x
	S7oTW3xjbwZwRN6C/gbs95BD26VddfKno4qOI34Z8ej+1yPpioXsoY8ESPDxkHzbJJfCCZEl583
	6lyFk2f2yXyZFE0EFx19UrA5vA2QjJD2sI8sekE+7BagKoqkWW8jL5KJ124hpq0MPAJZipxoaNN
	w7pHlKqvJmI7sEKwlttoPri5qrWVYRfendMDJ7yrmlUqWkZU3bDLtU6SYoZ/itmqPrQkptlCRFH
	8XXBC+FU7nrzyzIT3UOLBn4X+DP1bMrcZrKKuCWa/FK3ZpC
X-Received: by 2002:a05:600c:540e:b0:490:acc1:29b4 with SMTP id 5b1f17b1804b1-490acc12a7fmr44126885e9.27.1780317833492;
        Mon, 01 Jun 2026 05:43:53 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af60e03esm8123155e9.2.2026.06.01.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:43:53 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:43:52 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
Message-ID: <o2tur4mf7vfsmx2qkizqhhxjnz34vifjtxeschtjvueskuzrcy@5hmfaoevpek6>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
 <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 12:43:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19581

On Fri, May 29, 2026 at 06:46:32PM +0200, Alexander Kanavin wrote:
> On Fri, 29 May 2026 at 16:52, Ernest Van Hoecke via
> lists.openembedded.org
> <ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
> > The bitbake-setup documentation currently states that:
> > "The --source-overrides option can be passed multiple times, in which
> > case the overrides are applied in the order specified in the
> > command-line."
> >
> > However, this is not currently true and only the last --source-overrides
> > argument is actually used.
> 
> To be honest, I'd rather fix the documentation, and avoid increasing
> code complexity in the lack of clear use case. It's always possible to
> merge multiple jsons into one with a simple python script. This would
> also keep things consistent with the 'multiple sets of sources in
> json' idea, where you'd only pick one of them.
> 
> Alex
>

I arrived at this from a real use case. Admittedly, that might now be
semi-artifical if we don't want the other default-source-overrides
patch.

My setup idea was to have all sources move, then use a fixed revisions
override to create a "release" setup at known pins, and then apply
another override on top of that one to create an "integration" setup for
CI where most sources are at known pins, but some repos are at latest.

By overriding again, it prevents needing to maintain a "release" and
"integration" sources override files, that are mostly duplication of
each other.

You're right that this can easily be managed with other tools, the small
risk I see is that lots of custom solutions start growing around
bitbake-setup, but with your feedback on the other patch I also see less
value in this one.

In short, the expectation here is that people use their own tooling to
manage the .conf.json and source overrides .json files? If so I'll send
a patch later to remove the multiple --source-overrides option from the
docs.

Kind regards,
Ernest
 

