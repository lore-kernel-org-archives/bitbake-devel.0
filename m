Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A0C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:36:11 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.43125.1694374565571693925
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cLnaUZJF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so40015005e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694374564; x=1694979364; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qLbg7Tm4O9z49qOYO6fB64s398BWArcUK5jKlS8nFAc=;
        b=cLnaUZJFkt4OUfbPwK8bhQjSbJ+PY28DM3iw2TtN4+HE1uNRws6/GABT9dWfp6vO+k
         p+D5YR4Ts75GyvwFqYatjS6/4rYuCcc3iDKnjplmdvkTu6YzlE77U8W1Gm4YCKMA7As2
         PdY4vFVpVSAugG8k/7fK4xIKEEoqd5AZYVbSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694374564; x=1694979364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLbg7Tm4O9z49qOYO6fB64s398BWArcUK5jKlS8nFAc=;
        b=ruPRCyVUhVeeenFNuws4PX90EDnffw6cdV2N6RrgcBCglOpzyrj4iglEesTLuJsDge
         Jlj6zyzWqBLok9BafNuhtGxiZk0QtSNIww7HXtcHcNWofXdF3dDLKBqeKxJ2t8W00J5E
         kNPCEtfjN4lZfULZQCouH9BEyegJTSP5t4bCZPOkVaEoEw0vAbsy9Pjyd2vv3pJOX2+M
         Dl2Fbq4ysApG/iCkkZGO3hS1FSScMHk+9ee2ForgxtoZXq+SXxYy9G8TMprGFivxxVEc
         XSVZABIlsyFsgSABx4L/47ZDm5yXGRfcbiGIfd60y1Ngy4FY2nlMkcJ1Z4WClCMW9OiT
         O/7A==
X-Gm-Message-State: AOJu0Yy6wiELqHrQXlhI8LDSy6B1MNBZT5n5nb3hHcuV57JZjVIQ27eA
	rfqEkroH07QnQZZvT0SldPr5RQ==
X-Google-Smtp-Source: AGHT+IF4orQ+eyVmOAJcBUXvDp4tgTajof0KdCeyS6JvqrYLLEu8c5C4XEBFBfQTSPM6i64fTqxqrQ==
X-Received: by 2002:a05:600c:ad3:b0:401:bcd9:4871 with SMTP id c19-20020a05600c0ad300b00401bcd94871mr7007841wmr.21.1694374563891;
        Sun, 10 Sep 2023 12:36:03 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5580:ed73:9c6:f365? ([2001:8b0:aba:5f3c:5580:ed73:9c6:f365])
        by smtp.gmail.com with ESMTPSA id x5-20020a1c7c05000000b003fef5402d2dsm11175898wmc.8.2023.09.10.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:36:03 -0700 (PDT)
Message-ID: <e791771b8eae8d0bac91bee84551795923d200d0.camel@linuxfoundation.org>
Subject: Re: [PATCH] bitbake-worker: remove the network flag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rs@ti.com, alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, denis@denix.org, reatmon@ti.com
Date: Sun, 10 Sep 2023 20:35:57 +0100
In-Reply-To: <20230910191445.564413-2-rs@ti.com>
References: <20230910191445.564413-2-rs@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:36:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15020

On Sun, 2023-09-10 at 14:14 -0500, rs@ti.com wrote:
> From: Randolph Sapp <rs@ti.com>
>=20
> The network flag does not respect proxies as the fetch stage does [1].
> As such it only works for some users at the whim of the recipe writer.
>=20
> This introduces an issue downstream as the build results are now
> dependent on the network architecture of the builder, the recipe in
> question, and the combination of proxy variables they choose to export
> in addition to the normal host variables that affect builds (host tool
> version, build environment, etc).
>=20
> This is far more indeterminate than a build system that properly exports
> proxy variables. If abuse of the network tag is an issue, then the
> network tag should be removed in it's current state.
>=20
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/100924096
>=20
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>=20
> The logical followup to my last patch, even if it does seem a little extr=
eme.

My logical followup is to say no, I'm not merging this. The reason is
self evident.

We should ensure custom fetch code correctly accounts for proxies.

Cheers,

Richard

