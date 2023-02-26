Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B4C7EE2D
	for <webhook@archiver.kernel.org>; Sun, 26 Feb 2023 12:09:05 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.64150.1677413334616543642
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Feb 2023 04:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g9zjd+Eo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id l1so458872wry.12
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Feb 2023 04:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mkvkUnV43m6JTfUskvORGohmEcjwdvhdAI56qa1QOp8=;
        b=g9zjd+Eo0Tbj45ZBVDN+PQ4EPNfH3FIFaRkYNML/jo6TJCKORnnJyaXLNY4wsR3c3Z
         5bqncnbe0z6luv7XrY8BR+kWfEMvZwd+YRswKzJid5c4l/lssGmNb3hpRHcnON05Hr4n
         AUkdr7duvZJ9dHR1xEsduRsU1w+2cgshwqk8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkvkUnV43m6JTfUskvORGohmEcjwdvhdAI56qa1QOp8=;
        b=zf3nDYo7+H5IHIh9waMWm1xAl6fiV009AGTm0kn7DxKW3aQJ7hRj2gVaSjdmoHE0sB
         /nwHzZKdeYqZjYGa+unPsnR0dFeKKok3IdB7rsgUfS+RmlA5jrRp3rzL/gs+Zhenb7QO
         +3Gkr8J+UYqv09Fq5NKhMt47rICxUgeFI5AHhHTx9G/l0FjCUyNykNvGZqArj5t+qXVR
         cikX5HYAPb0y7Wl6Tl2VpSJgR8BpNZenHrkUH11MF66s+lP5EXx42t/Et56UGOswQenR
         vN3u/nW1ApTojJ11ceKXGJCLLXaqjL/wA6NY2JsosO0orUCi8fteBSNBdDT6MZil1RcI
         7Ggw==
X-Gm-Message-State: AO0yUKXiUaH7B5K2xERGsZLGTymaOZK+bIjyBVtToahREamkt0YLIqeU
	Nr2Px1fpZNxWPu4e4bdt+z11oHt6KeqULJg4
X-Google-Smtp-Source: AK7set9iKYx/vSAYYxqxOugNOe9hEAoKFDNMcumfkrCW3SI2k8XErWTj+RpffTlKe+VM75G7B3tbag==
X-Received: by 2002:adf:fbca:0:b0:2c5:899f:3412 with SMTP id d10-20020adffbca000000b002c5899f3412mr17236658wrs.26.1677413333166;
        Sun, 26 Feb 2023 04:08:53 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:acca:18ee:3f6:d4ed? ([2001:8b0:aba:5f3c:acca:18ee:3f6:d4ed])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b002c7163660a9sm4327832wrs.105.2023.02.26.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:08:52 -0800 (PST)
Message-ID: <41b18bac009eb26cfbbccc4e179feabab0ebef53.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] documentation: bitbake: add file-checksums to
 varflags section
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Richard Elberger <rich@richelberger.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Date: Sun, 26 Feb 2023 12:08:52 +0000
In-Reply-To: <01000186896f2981-96e1cb88-396f-45d3-adb6-386dacf207ce-000000@email.amazonses.com>
References: <20230224201426.357606-1-rich@richelberger.com>
	  <010001868510232c-5929cc94-ce2e-4817-b311-3ea6f58a267c-000000@email.amazonses.com>
	  <8ddacda7563bc605bae4686733d3e8bf72f0f9ed.camel@linuxfoundation.org>
	  <169ccc6a-513e-88a0-b2e8-1c74b3aa2b5d@richelberger.com>
	 <01000186896f2981-96e1cb88-396f-45d3-adb6-386dacf207ce-000000@email.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Feb 2023 12:09:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14494

On Sat, 2023-02-25 at 16:36 +0000, Richard Elberger wrote:
> Hello Richard, I have added this, amended the commit, and sent through=
=20
> another patch.

Thanks! I've merged it. If there are other tweaks others want to
make/add we can build on this incrementally, it is great to get it
documented.

Cheers,

Richard

