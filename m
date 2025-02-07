Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E9C02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 19:18:13 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.943.1738955883883835294
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 11:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BVJew/eq;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46783d44db0so24866741cf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738955883; x=1739560683; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSAa3HU0D7sYxvDcwr+dQST2R/FmHQaOGPQ/AZrkla0=;
        b=BVJew/eqmt+LSLJA+J4qqvqoiIMWKD0FmVTNTOs204wnyDFOff1r3t8rCt6tXX09aW
         5UD9vfS3+0rsz+1iZfuw5dR/SQbdj46agdkSci9fsEtyYHe9Dq1mUjky206W8SkgxZ8s
         wrC+sJfKUkxFoZljfUTiCfFl+/yGbXoS+gZWMGc3YXl3YaEZIy8AXr/qdGvxpIEjDKqE
         ZaYsY1p2SDUPYbdg78C3lZFT2WPUxAVVAjTjQhdTEthY3DxSxUtKSEzGMYBCaYAbL/sG
         3wEGldmIRt/Mehe5HcZ5tYCREVxdNN4nUv5A3QTF5oXnZh/C497P++9f/G7HRUrMOHp3
         TKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738955883; x=1739560683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSAa3HU0D7sYxvDcwr+dQST2R/FmHQaOGPQ/AZrkla0=;
        b=bOyo7M5ATgwchdQojf8OBrleZ/poYcnZXOFKelNRNngDRHIZdwx9ijNKNTeJafOVJT
         CdootY+0ko10YV6wnwz0SmF6Vaz5vkcLxAh3uZ/bGvnSw101Ikx2euYE5U2kfCLwUedq
         U0ZFouqG/c+ABB3udWV0H1VEgUu6SEa3rE5ZZduZeyP2x5YJSnZc1yRvoiV+ucnZ3B4g
         a2PG1u/S+E/SvRH4wEiMnz1zUkg8ingAJJkAbn4q0PQXvj88Isqa2DbM7ReFmsIiElWT
         LC8hJMUuKc7pOI+dllhyWSWqxfw+HJqNSrOmvzfmQHH1eTdU6Q7kiutqghorQNYUpYrl
         4Vgg==
X-Forwarded-Encrypted: i=1; AJvYcCXCX2lXqCbPN6TZCObj2O6bKaFZCLlXCR/6bpsevqBCEMsA/f6btt5PQiIUb68kF3zQTTrKHheUo6X6DHh7@lists.openembedded.org
X-Gm-Message-State: AOJu0YytMw6QCJsJlhKYLThNIADFNRKTL4mDw4yn6K99fKqmImjb0WMx
	1hyDTzzEss0JNfkRJWv1KNG/bOTuavNVY3DJ5GmCMANEZ8CDPdh7cALo3O9SmQgPQTaAUebwWZF
	1k1MLCvopB6FZfcmFywqAiom3Q9U=
X-Gm-Gg: ASbGnctPAFtBxcjbbnNSPntr2pAfub2uCU3bqWkmjhMgIt4tQKHfIfaIP/yO548LOMT
	EyACT82xaaujOKVkcfHFG5Y1y4j9yxh2AJf0WU+D7xjjAeH7efohv+553F6GRfKUPlr1BWpZ1RM
	QGjrN2iauYrPp/1FdP5O4fm7OOSmkpZrA=
X-Google-Smtp-Source: AGHT+IGpHWnJl+5Yp1GxTLUC6TVi+Jg1lnUbJxNiR4WINPVQ/OfOoCuIP/U8vcBM2SUamyzW7nPkrn9jXBbOuJcMczI=
X-Received: by 2002:a05:6214:2621:b0:6d9:353b:a8e9 with SMTP id
 6a1803df08f44-6e44561996dmr60590836d6.15.1738955882812; Fri, 07 Feb 2025
 11:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20250129112406.1660522-1-stefan-koch@siemens.com>
 <20250129112406.1660522-3-stefan-koch@siemens.com> <CANNYZj_sd3O_=dYGPuC1NKQDzbMSsjHPPLGi+qb2=3L174rUMg@mail.gmail.com>
 <87f5216654f92c2b0a9790cf336023ec1b788eb1.camel@siemens.com>
 <1821E627D6FBF186.752@lists.openembedded.org> <1821E75CA5CDE51A.18160@lists.openembedded.org>
 <1821E95A02BB5E12.752@lists.openembedded.org> <CANNYZj8QH7QfxpDMdi_oEfiZp4qT6pNSRR9QO2MbvEUJaFg7iQ@mail.gmail.com>
 <07ed332ad4733a7a4d5160b390124eb3053266e6.camel@siemens.com>
 <CANNYZj-aKm-A14gv3eAjbPUj0UpbqBecvb+o_xmFhW3DfoCtdQ@mail.gmail.com> <3583b11ba1dd99203c4c9651a546d337a131d19b.camel@siemens.com>
In-Reply-To: <3583b11ba1dd99203c4c9651a546d337a131d19b.camel@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Feb 2025 20:17:51 +0100
X-Gm-Features: AWEUYZmQ_y0RI0X4zHJ1Wq_vCQrzHQICrrdiNNeFQ-qX9wXHKbV6mImGQ37oL3o
Message-ID: <CANNYZj-PoHKcmrh=6YYPLU+YHfX4TL7ZfruQy6br2wZUjS35wQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] fetch2/git: Add offline build support
 for tags
To: "Koch, Stefan" <stefan-koch@siemens.com>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 19:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17187

On Fri, 7 Feb 2025 at 18:19, Koch, Stefan <stefan-koch@siemens.com> wrote:
> git:git.server/eventmanagerv1.0.10-
> test    f56e663ec0982e8b300c03b14a95cb67ab2fead5
>
> #SRCREV = "f56e663ec0982e8b300c03b14a95cb67ab2fead5"
> SRCREV = "v1.0.10-test"
> SRCPV = "v1.0.10-test"
>
> So only the SRCREV as hash. But no tag.

What makes you say that? I see the tag right there:

git:git.server/eventmanagerv1.0.10- test
f56e663ec0982e8b300c03b14a95cb67ab2fead5

> One curious thing:
> - Without this PATCH 2/3 build without BB_NO_NETWORK = "1" works
> - It fails after bitbake -c clean, with used BB_NO_NETWORK = "1"
> - But when applying this PATCH 2/3 again, and let BB_NO_NETWORK = "1",
> it works

Please forget the patch (for now, at least). I don't understand it,
and it should not be needed to begin with. You should figure out why
the cache database lookup doesn't work and the fetcher has to issue
'git ls-remote'. I've already asked you to look into it in a previous
message, showing the place in code where the incorrect branch is
taken.

Alex

