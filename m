Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92356C4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 13:19:45 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.121136.1699535980610274206
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 05:19:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BpRC9Wt+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso6094885e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 05:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699535979; x=1700140779; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1aVsEq4pfHA85hvY01+yt7vuNHfUC7wKt/V9aby/E58=;
        b=BpRC9Wt+Hd+rrbcR7cAO8HPsd8nuiVF208GK+Qu14jG1Ax6AVJE8ocwqaAKHQ8oAGa
         WF8hd/a0fJh1QwZXqIx+ns693SCnCuPle8m/QkgMPbVC5f3NOobhXGB9hCcARdj44xhr
         6uihPuOYpLzNWO/V3Cq02rx40EUsQd48zFkeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535979; x=1700140779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aVsEq4pfHA85hvY01+yt7vuNHfUC7wKt/V9aby/E58=;
        b=CvidSYWWYUaZJKrYZMS3MKRGoQ+tUWy0ELu0EpMBo7Au/Q4Oo+eTK66Q01xSL8fw/c
         FuZNNShjWyHXuK2ihM8hiG3UEMqi2NBe7VxSLWhp19chM8e5lP501CNrd99+Up3yJsGv
         HDsslLcgFv2TLz2lL0xmWn8F/tcm6mzI/lKX13txD0Vt56tPbFMk0G2aju0j2njwmntG
         5Zc78bK/oLpQqqaDuPDfKFIpFcVAe5N1oI2R+20iBQT7d2B5q9ScgOr436dZS56jx27G
         QKICbAoCPqJcWRUeL9HyB2YCDCu7xC2JIWwCeqidJZSowBd+Me3UD/t4ooyc+5cqxoSh
         bJuQ==
X-Gm-Message-State: AOJu0Yy/m9Yj0BaFMlDDygXeoTHtPdZSaH+ehoK7VgIHsV50liogCOTZ
	uoU+vhaQ4+SE36c8Ea0WwW7/6Q==
X-Google-Smtp-Source: AGHT+IH07MCaha7riqgcuyVL8GdKxSyDgin6qGNyxyMQyczv23GKzpglwNLe+rRf25oEEMtsMoonZQ==
X-Received: by 2002:a05:600c:1c98:b0:405:34e4:14cf with SMTP id k24-20020a05600c1c9800b0040534e414cfmr4439705wms.4.1699535979079;
        Thu, 09 Nov 2023 05:19:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7d6a:4777:87ed:703e? ([2001:8b0:aba:5f3c:7d6a:4777:87ed:703e])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d5272000000b0032fbe5b1e45sm7403226wrc.61.2023.11.09.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:19:38 -0800 (PST)
Message-ID: <7aa96c2f530c8aca3c0ba2e5132f7d724e0c2b0c.camel@linuxfoundation.org>
Subject: Re: [Toaster] [bitbake-devel] [PATCH 8/8] Toaster: Added
 pytest.init file
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: Tim Orling <ticotimo@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>, toaster
 <toaster@lists.yoctoproject.org>
Date: Thu, 09 Nov 2023 13:19:37 +0000
In-Reply-To: <1356747739.298841.1698774199817.JavaMail.zimbra@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
	 <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com>
	 <CANx9H-ChzdqV_wyra4RFhswNYZYmjaXO-iFdJvateo7NtL5f2A@mail.gmail.com>
	 <9c0799acda8eb7751d518614477246db8456dead.camel@linuxfoundation.org>
	 <1356747739.298841.1698774199817.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 13:19:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15458

On Tue, 2023-10-31 at 13:43 -0400, Alassane Yattara wrote:
> Tim,
>=20
> > > Typo: pytest.ini file?=20
> Non, pytest.init is a config file for pytest, next step is to merge this =
file with tox.init.=20
> tox.ini file are the configuration files of the tox project, and can also=
 be used to hold pytest configuration if they have a [pytest] section.=20

The subject line shortlog says "pytest.init" but the patch adds a
"pytest.ini" file. The tox settings file is called "tox.ini", not
"tox.init" too. We need to get the names right...

Cheers,

Richard

