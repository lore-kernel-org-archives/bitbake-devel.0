Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237DC636DF
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 16:07:53 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.238.1724861264096864108
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Aug 2024 09:07:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ndmobp/G;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca782dso60858715e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724861262; x=1725466062; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5af10Q2kM2nIrOlJEF2b/7egGXkT6LU+7U2myUubYM=;
        b=Ndmobp/G04cpTCL4q0qEzHUMR2e7pR2w5Vofu3HBGlzW0VCBKCaY68XAY6lglADD+c
         SPnPG9GJEoMOOjypuVIsZjYigNYMPFiOeTn17gURsVpHyyCpWYAmzaQR6YvzYr6FTHg6
         F3XMm23uSBBBXLogfq0ovueWhKB3j6lzKbgm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861262; x=1725466062;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5af10Q2kM2nIrOlJEF2b/7egGXkT6LU+7U2myUubYM=;
        b=XtNBn1GPGdiIKVxMfmn2TzYDONNSUzMTSgEDEs3YySsjK5NJX7+9yC/4frFdTPsygC
         CP+qOXYIIdYUqOIeahABF01e+Xc/rYjKq2KcMdcwuaKfjKZ8yAy0LCKcx+T1+NjEArux
         rHHgj1bIG8X0Z22iLN6fFAWB79rDjZdoEP4DsSdUGJ56qwqapfMhv8G397Jxcuvnsnwi
         an+ZxRYSyNBciYcdPWjxGt5t12D1cI9ynNVcbV+yv2qAuAtcXIzYb9DEzxzDS8oOPgLX
         xFi2cCGtcpP7lc2bXQYto49uxeUu0lrQixCaQ/iVv3uiaSTkqhZKt8VAoX1z/F0Wk4zV
         k7iA==
X-Gm-Message-State: AOJu0Yyemv4YdaHkXvYZ0J4cQCuE7BOR//OGwjEywnPOEpfZ3hoo6ZLF
	LFhESC08bAONvEJRSXZnArfL61ta1o8iQKQ+3aNV/zoLHO8xqKvCA4fTXIdcJVot/1VsEr31XYl
	o
X-Google-Smtp-Source: AGHT+IFdmna5mdol70B40ThxeDUbHG6Tz0+asYSAilx6hXDyGKTA/uby44uym1icnDb5876z3To0YQ==
X-Received: by 2002:a05:600c:4fc4:b0:426:6099:6eaa with SMTP id 5b1f17b1804b1-42bb02d95c8mr998055e9.26.1724861261811;
        Wed, 28 Aug 2024 09:07:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:354e:532a:804e:264e? ([2001:8b0:aba:5f3c:354e:532a:804e:264e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63acd66sm25691455e9.23.2024.08.28.09.07.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:07:41 -0700 (PDT)
Message-ID: <2f29e3a376e53ec8ebab98da40ec63837a55ff0e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] coreparser: Allow code visitor
 expressions to be declared in metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Aug 2024 17:07:40 +0100
In-Reply-To: <17EFE30923F5B4D3.18536@lists.openembedded.org>
References: <17EFE30923F5B4D3.18536@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 16:07:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16524

I've tweaked the shortlog to say correctly read "codeparser"!

Cheers,

Richard

