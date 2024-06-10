Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81373C41513
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 09:41:10 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.15677.1718012467174109019
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Jun 2024 02:41:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dKd3EpZR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354be94c874so3396868f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718012465; x=1718617265; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8GeubgvKhv5JGz/VHD9oJvpe2Wu1eXGUkfucOtbtYZk=;
        b=dKd3EpZR/1AQemqqeppjy9hsemW6TCYDqy0FuR7V7wHnUYfNQifaiPm/NYfVoWrz7o
         TPN2md7N3r+5qALwcCoOAGewnebUQhL6h4fv5YObbgfVSV4Vn4sesG7DD7apNnM0NyW0
         Ydv95eKnbS7nKUT58I4B1WSg3C2NjsyH4TeGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718012465; x=1718617265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GeubgvKhv5JGz/VHD9oJvpe2Wu1eXGUkfucOtbtYZk=;
        b=wrayHSEG5wjjAG09xYxk8lJj2xbsPwGO4u4PJoL01yzZki+/LH9zDn05tzraL9wUpD
         vCyeSSUKYSxFP3qDYaYXSF4AKgJxaLVQAGOJZqW4tLyq/bHdKX/fs29K65lsOfM84C/f
         DTdzei8+mNFpzZdmS9zTycj3otj2GEuu7Hq5xAqF6OEJ1pu7FYMzm1OFOzdQ/lXZhz8x
         9WlhnqeyY1uN3sekqrts2ycKkd/bg6pbfRdQy2omUxaPE+mNjvsLRlEemk00IVakodr4
         S3R4ORZQZ0Mc7zx+TtIJ6mCxLQu/AWGyaTsjVEl83nlDuwHvle4r9Nf/KBAHahBc0l0P
         3Y1A==
X-Gm-Message-State: AOJu0Yw18T4EKgLn07QQ4RPqskezrlB3ZI4gopTwYFq19+G4mpHIyRkw
	oJP3VdPlPF3/1pyquH38LyeSq4tyeMJyHQ2fI6LcM9dGhJa/QGSdb9LHYGF9OZM=
X-Google-Smtp-Source: AGHT+IHQa2cW8SJEmZ0Yf51oe3VKsJ400L4RNievhKS25qtciVbmii5/wfamWdpYITWKgFc0ncxL4Q==
X-Received: by 2002:adf:eac1:0:b0:35f:1f8a:e69a with SMTP id ffacd0b85a97d-35f1f8ae6f8mr3803654f8f.49.1718012465234;
        Mon, 10 Jun 2024 02:41:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fc3b:77d4:176b:a54? ([2001:8b0:aba:5f3c:fc3b:77d4:176b:a54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f25599edcsm1846919f8f.90.2024.06.10.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:41:04 -0700 (PDT)
Message-ID: <83ab3186c0cef914974e272a3b86a2acbec69ac3.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH v2] fetch2/wget: Add user_agent
 parameter so it can be used optionally
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, egyszeregy@freemail.hu
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Date: Mon, 10 Jun 2024 10:41:04 +0100
In-Reply-To: <CANNYZj9Tr6d9khKBq_qunZ-54DXDj1es=to8aSk9kkecbZqJSw@mail.gmail.com>
References: <20240609220226.977-1-egyszeregy@freemail.hu>
	 <CANNYZj9Tr6d9khKBq_qunZ-54DXDj1es=to8aSk9kkecbZqJSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Jun 2024 09:41:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16340

On Mon, 2024-06-10 at 06:23 +0200, Alexander Kanavin via
lists.yoctoproject.org wrote:
> No. I really do not like the idea that we should pretend to be
> Firefox. And you didn=E2=80=99t answer Ross questions properly.

We already do that unfortunately.

I think the biggest concern I have about the patch is the variable
name, it should be namespaced into the fetcher (BB_FETCH_USER_AGENT?).

I would like to see some answers to Ross' questions as well though. It
would be good to understand what kinds of problems people are facing
that need this.

The trouble is that every time we add more configuration to bitbake, it
complicated testing and if we can see one way of working for the
majority, it does help reduce complexity. This means adding new
configuration and code paths does need careful thought.

Cheers,

Richard

