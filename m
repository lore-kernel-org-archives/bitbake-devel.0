Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C426CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 19:57:15 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.6784.1755719834145833450
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 12:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MHmrAOTL;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70ba7aa13b3so4089086d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755719833; x=1756324633; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/WIvU0CxwkjHKAOpTVjhdvTlYjLBRG0+0FdNQeDEkw=;
        b=MHmrAOTLxgt3j26FYI1U3DvTWGaGK7vbpsT/h3oP7lltb03YElL5kEYeyHYH2Zrs9p
         1mu32ST9cYA91lQskzQ8kHs3VJW5r6pNeLyQXasItfGXkyZjFlq2NHNs/UP7GJ34COhI
         rfGWsKicS23NxRtNWpPUXc4jQlrWePeq/GquUYbB6rsmfrWMP106hsOZMSifqkP2G6bv
         u2xhScUbQyDZxTfD84I/9zLrGJvtE0I9dK7CFEFI9XcSzVuoH0t6jY31t3XGLX9pZJsL
         grG5PuGDB87I3NTeF/SQFgeyXYuIs8NX4tZ/iCCOU3uiUpYR9XMzwWV2sLWJBgjlX54o
         WLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719833; x=1756324633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/WIvU0CxwkjHKAOpTVjhdvTlYjLBRG0+0FdNQeDEkw=;
        b=klr45bB7YMvHQNegEQvRN+eqhFPZMHluVYnsJgq76sgzhqcOXVI0w8j0LaS0goYXoR
         VUuj86BB8oxR2jXH/C9C8WLNxfvGZVj9AaIeFYGtbGhqsKDsewH6Bjd6EW/7IUgoEUeO
         1AvDjgymmEP8xU74FX8htWYIDyyuCUBvHtXxjpc7Cdf8LZpOWT1ucHuuvcVU0lOr6oHC
         /9irFWYV2lbKNLpdJDUr9vJOuSa9hsgBDuLdYf2toRQG9R2OVhIFXsKaQLzfiMiXQf0G
         YMYA4LK27ApMucdfQkBd8iQAdwO2MyDSnMPhj+etS7tfiCaq+YUGHbN/yXGhARVW3WFN
         FpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/FJUqj5tYS72eW+o6rg8Scdyo22FRGiiEZGEwSl1Z4HJRH2WRrAddZZCKkY2djGGCmJBEoOkSeLKoCv8@lists.openembedded.org
X-Gm-Message-State: AOJu0YyZQGhnGIsyGYO+tnFarHa09slihc2AhValN2q0Akxzmaf5cto+
	aUxE3voDQfYvwMLVN8+Pi1UN9BlwtAOwNOqftPx2+evHIPsiCODWLcJsx99GwFOCkwLSmIGVZxu
	dmIqbWDlGT8Q0LxsSQVDBEBldLmPC+PihGw==
X-Gm-Gg: ASbGncsptHqado0MqXBhCxE1zomMUn4ja9nxK5n21Nc9kTkSA3rgCg0oTuDRb28pr63
	t88u6r2iuN0ZB66KGD4R9CePPV+1IZ57S58EOOIHSdI6isen3hdeJADpr8TXwrGhyFRpYvsbDRY
	Z0v7S4iSmRocqx8HNAN++pSZsvDLw8/LFAsKRdkCdahd+be6ILOCnyrMbI0YoU9D5rB9WG3i8AE
	2wETQyx6VhfNM1GnwngxqjAg7sXlmmeIfc6oK1tpQ==
X-Google-Smtp-Source: AGHT+IEPNRAk7G1sxEMryvmrnuW7g0JxnjuPifDii2gDEqPPQ+04A2zrnNgVsHOdVTTcw+wb3J2rdrQ3/Nj/1IR3N7U=
X-Received: by 2002:a05:6214:509d:b0:70d:6dc7:77b3 with SMTP id
 6a1803df08f44-70d76f8b873mr40962996d6.18.1755719833121; Wed, 20 Aug 2025
 12:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org> <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
In-Reply-To: <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 20 Aug 2025 21:57:00 +0200
X-Gm-Features: Ac12FXy13p397z5jSCnOd4qlS574u46Pj82of1OPk5EAqIX_A6ZAZGDs9biczP8
Message-ID: <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: Scott Murray <scott.murray@konsulko.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 19:57:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17896

On Wed, 20 Aug 2025 at 18:42, Scott Murray <scott.murray@konsulko.com> wrote:

> I can see where you're coming from, as this shadows how git config works,
> but the top directory behavior is something I've been on the fence about
> with bitbake-setup, and this seems like it'd maybe make that worse.  With
> things as they are now, I fear I'll be having to document passing the
> --top-dir option in any bitbake-setup usage to avoid contamination of
> configurations between projects, and avoid users asking why they're having
> stuff show up in $HOME.  I'd honestly prefer if it only operated in the
> current working directory by default like whisk and kas.

You only need --top-dir if you're not in a bitbake environment yet. If
you are, bitbake-setup will deduce top-dir from BBPATH.

Alex

