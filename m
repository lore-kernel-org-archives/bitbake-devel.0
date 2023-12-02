Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE3C4167B
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 18:08:38 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.23486.1701540517063295448
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Dec 2023 10:08:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aQ8pW4Q6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33318b866a0so2943546f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Dec 2023 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701540515; x=1702145315; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GcQZWuwiOsai8aQhdVrFlF1LVZcrIFWb1HWohkjhOsg=;
        b=aQ8pW4Q6tLQ4O6eFqysRZRj84ZQXwjNzCrzhM8rT233fXzBlJXLqjhKsGFJI/eagz2
         DmvaV1shaAVhIaGsW65dtx6qDT/T40YH2dNWJE+MKULNTD+9TTRduYZ3zlwTbI+4Ejfh
         yPyCLeK/ldRoZxWU4heu3xq5y4LQb5O0xghtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701540515; x=1702145315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcQZWuwiOsai8aQhdVrFlF1LVZcrIFWb1HWohkjhOsg=;
        b=k6Tm3rWQZB8gkR+z8GA1yjn4bDdKnPWMJz2A33MyI8DiPRPmLEOqo2M+0+Qbu1TAk+
         jBMMLAfjslt41zZJYyNL3aUcl5nzabAe14u5QtYvC3H4E1sq44w/TVrcSSP9pgx4PJIM
         2ZHzdnbGiSoN49qJyVtVC8gTxSva8QlgXDQSlxDOMRVaKy7mu7EaOp0j1PSmr1wGrXmW
         c71Tz4qVn/pvATDyZwx7Cw6b2lMQw+FOE6mbFjc69fXVToQrT5iTD7J2Q2ctwlQzz70f
         pCdVvQRX1o/EoCcF5HnehgHTBLRfauEUf+WLbhFisoAHItkkIvvEah5+nJn/HgOS9OdO
         LuJA==
X-Gm-Message-State: AOJu0YxCZWCRdY+qz56GECxR9Jik9ZeqwCGtsm7FYKl5CwpBc1PIljWe
	y28BApHR3c3ndYx0OHU/KbIyyQ==
X-Google-Smtp-Source: AGHT+IGCTz8T7teOFsQdcGbTho/qHelOmO30eHGhLSghRC8IGSjyZg2nsyAfjP8BiJXl6YQ5Guwcpg==
X-Received: by 2002:a05:6000:18e:b0:333:2d6b:a6a3 with SMTP id p14-20020a056000018e00b003332d6ba6a3mr1600960wrx.34.1701540515460;
        Sat, 02 Dec 2023 10:08:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:cb0d:a6b4:a11e:1d3a? ([2001:8b0:aba:5f3c:cb0d:a6b4:a11e:1d3a])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600000d200b003334041c3edsm711237wrx.41.2023.12.02.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 10:08:35 -0800 (PST)
Message-ID: <4e47d6bc7b120da7a84ac34f23b84ae07334115f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Improve inter setscene task
 dependency handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 02 Dec 2023 18:08:34 +0000
In-Reply-To: <20231201190203a0cd89c1@mail.local>
References: <20231129214644.536837-1-richard.purdie@linuxfoundation.org>
	 <20231201190203a0cd89c1@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Dec 2023 18:08:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15604

On Fri, 2023-12-01 at 20:02 +0100, Alexandre Belloni wrote:
> Hello Richard,
>=20
> This caused all those failures:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6269

I don't understand it since my builds with that patch passed. Unless it
requires the patches in master-next of OE-Core but that doesn't quite
make sense...

Cheers,

Richard

