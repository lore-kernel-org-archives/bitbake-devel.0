Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06BDCF6D42
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:02:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.975.1727888539146098769
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Oct 2024 10:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E6RFMH03;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso552085e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727888537; x=1728493337; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtXBc50uhW7QGMgEgrFDQJhnrHOX4S3eeuModI7Ww5A=;
        b=E6RFMH03l31/+cLn6XYD5Vp348aczqJAzOxT1gxK/zlarJQ3HrqSDV3ohQcUlp6izy
         obd+/gVCjLT2WUrA/xnxkWNpzYGacxFqXP4N8ybboEgujarxFAHTOkVQ/H0EDpWapvYl
         SK36e332z3898nyJtDc1xcN/FSe+bScVzXeh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888537; x=1728493337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BtXBc50uhW7QGMgEgrFDQJhnrHOX4S3eeuModI7Ww5A=;
        b=eVrPYiJHWgB23hnqQe8BNXpATRLh+RCMy/7rK3uO1wdBwLxrxRfPnV+T9aSJRIokoT
         8tUqr82390MBnVePxVixbsse032av0L8ia3vle7jcpenaIklNGXwUFH0nB8sxp+6imCe
         O6mKCQvz1ZAy/UU0dtQpVPNODCe4SNnAyHRkpmET8HASW3AKM+A593eIMQ5SwGQ0Sowu
         dGgZ/8FnyJmGuDD7GFtTIlet4f6DXrJ7oymD5KMR5I6LUNLYEIftRV+XIDXrW58qYWbd
         iPBL6DCrKY1RFD25lHm+5tcJiPTBssX/cQDluzKSK3SYcxgIuDw6RjXlxymnQ7D0eNN3
         eK6A==
X-Forwarded-Encrypted: i=1; AJvYcCXGS7a38T9WTkFIrZWZ2Fkp6ZMZpMFEzUwkswLFnUACzqlh6jMYwwGjXRlMyxPKJuabEQ53DJRKvhwWkaMv@lists.openembedded.org
X-Gm-Message-State: AOJu0YyUwvi4ybueURAqk7lhWv/gKt2v+8IgC+c5QpU2a0UoZ/TZtVqV
	BrNW4CtxCd+ccnJNrMy9vEgRuLkZOhaxKBmwA+UcreXfL4wN1tgukxfVUlT1DJo=
X-Google-Smtp-Source: AGHT+IEyDawxBqJE5yA+V/bNTPns9k4A6YtQR4VF4QCDCDsoV8c6yVk/xUgvSSzewjek6zeLzTFAIw==
X-Received: by 2002:a05:600c:4e43:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-42f7df6e53fmr2145155e9.16.1727888537246;
        Wed, 02 Oct 2024 10:02:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:33ed:8fde:4d0c:205f? ([2001:8b0:aba:5f3c:33ed:8fde:4d0c:205f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ead833sm23802445e9.13.2024.10.02.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:02:16 -0700 (PDT)
Message-ID: <b33c38bbfe19400415208b8e57c87cd0898b1ffc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake: fetch2: Fix systemd
 template file parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brennan Coslett <brennan.coslett@bluerivertech.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 02 Oct 2024 18:02:15 +0100
In-Reply-To: <CAAc_J+_nSKHeZ13Gt0ONCPpi9dJjKJAc553gVuDWWDkmrRy50Q@mail.gmail.com>
References: 
	<CAAc_J+_bjkedrH1kj2+qHi=OiEnC9TPxCqpZAVSLiqBs7Xsp6g@mail.gmail.com>
	 <6732.1727883773132320625@lists.openembedded.org>
	 <15815bbb3b9518dbd9cee9df627e24de74482a17.camel@linuxfoundation.org>
	 <CAAc_J+_nSKHeZ13Gt0ONCPpi9dJjKJAc553gVuDWWDkmrRy50Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 17:02:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16625

On Wed, 2024-10-02 at 11:56 -0500, Brennan Coslett wrote:
> The decodeurl part is the only part that was needed to actually solve the=
 problem
> (I was able to verify that the missing files ended up in the archiver out=
put dir, the
> encodeurl part was just to make the existing test format happy because it=
 has
> asserts that the value was exactly identical.

The test is correct in that what we put in and out of those functions
is meant to match. If it doesn't that opens up other problems.

>  If you have thoughts on a better way to
> change that, idk if doing that substitution in the test before it checks =
for equivalency
> but somehow that feels more gross to me? It seems like maybe we should us=
e the
> https://docs.python.org/3/library/urllib.parse.html#urllib.parse.quote sa=
fe arg instead
> and just set that to include basically everything=C2=A0when encoding loca=
l files?

I suspect most references in our file urls are not encoded so it should
probably be the other way and not be doing encoding on file url path
components at all?

I'm just working off distant memories of the code though so I'm not
sure how right my instinct is :(.

Cheers,

Richard

