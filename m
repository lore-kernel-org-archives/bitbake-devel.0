Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D8C4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 08:27:45 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.18495.1701419258486969141
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 00:27:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QV1af0w2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bc8b7d8ffso2713813e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701419256; x=1702024056; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cFibcXEbrZ868iMw2+PK71EuH2C3NcHSggIPSXRtPE=;
        b=QV1af0w2tvsTjvO/D6nHuJDRuf7MCPdEJV0Zf9QBhqawhZ7mzTLaGTxum0JRWIPWOr
         YD/uKmZbhPylQr8FznaPql8XCrP0NOQtuda7jU/98xeeLXQTsfNND2cpdsSn5nxvz6hT
         wYtQ1KigijuEi3ca/LoeZJrRW8iT1J4mGd5I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419256; x=1702024056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cFibcXEbrZ868iMw2+PK71EuH2C3NcHSggIPSXRtPE=;
        b=UhpgR7ldp17GShCOr4ivkxo/pBlE42nfADKRWFgcbDsXeokm66840RRHbMxjwnpdY7
         FGEfD3AAa67gW3DrB/39VHgS+adWxTPmlQbwwXDPOum45VG6XqKnEl7m0tYQj3IufLfV
         TMncLApPmcOq+wPaw75M1hOQftg++mtOzahtnh8mKDESa5EWY86MBdrwTGgM+4diVDx7
         6zOBj0Ffabhin4CVsqdb8yi46OIcSDf6Ix0jef5LK+8aaVLdWdiuDfRG9jb5DgeERd2e
         b2C3QVUU7wcVP65Q1yHt9GuYOh5BDM9iygLP3mPsxK+txOKn1kptUV94lfoW2MToCaQp
         ZJ0Q==
X-Gm-Message-State: AOJu0Yy27p44sanXA61xqhyAtfN2Ir2eDWbArmZmeVnJJILOGMCYYb7P
	JeqM3adoKiz7chWWxHdTOl+jhg==
X-Google-Smtp-Source: AGHT+IHz/tUE++KAacjH1KsBtIUlnnVbuLQLIv11jdSPuqtmILubpdbsjHa6j4LCKIV8eTItGbnnHg==
X-Received: by 2002:a19:2d09:0:b0:50b:d764:28ef with SMTP id k9-20020a192d09000000b0050bd76428efmr376258lfj.135.1701419256405;
        Fri, 01 Dec 2023 00:27:36 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:201d:dd04:f9b4:3c83? ([2001:8b0:aba:5f3c:201d:dd04:f9b4:3c83])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040b36ad5413sm4557489wmq.46.2023.12.01.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:27:36 -0800 (PST)
Message-ID: <d93bf7e3412237f73025b0749391d8aa55e9bac8.camel@linuxfoundation.org>
Subject: Re: AUTOREV, PREMIRRORS and unavailable upstream
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 bitbake-devel@lists.openembedded.org,  enrico.scholz@sigma-chemnitz.de
Date: Fri, 01 Dec 2023 08:27:35 +0000
In-Reply-To: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 08:27:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15596

On Fri, 2023-12-01 at 12:16 +0800, Jan Kiszka wrote:
> Hi all,
>=20
> this topic has been discussed already long time ago [1], but I don't
> find a conclusion that helps when the original server is unavailable
> (like github.com for me right now while staying in China). What is the
> right answer to this?
>=20
> Jan
>=20
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/72112230


AUTOREV is defined as "get the latest upstream from the SRC_URI". Using
mirrors would make it inconsistent. If you want to make it work with a
mirror, you need to point it specifically at the mirror. There is no
guarantee that any given mirror has the "latest" revision. YP's own
mirrors will only update to pull in new changes when something
references them.

The current code does work correctly by our definitions even if it
doesn't do what you want/need right now.

Cheers,

Richard








