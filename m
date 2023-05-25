Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7395AC77B7E
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 12:22:09 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.10174.1685017328104080198
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 05:22:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=S4cLrkJP;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af1822b710so5480611fa.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685017326; x=1687609326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LugEbfKWEMVweFaip4bqYKgmPZw/1nC7h73GZvxvvKE=;
        b=S4cLrkJPwEyM6oNaBsmbBVl3hT7cbeqyliphy6DH19NjpjTSKro7LSE5JmGjr8ilpU
         VuO/Mw0NCLxrLAcQztqNBPIJKsZEmQ3DOEp1HYdrziVn8EQ/TEVGK4fQslgxVM2uSG5p
         9W/IjohhXQ1O3J9nz7b4GIL1DxbDUNW7MsxQbaYaqGrnqNULQjR3dhwlGuKXk6m8/9y+
         HmfI4BveGmcniedFwbFrJjYKJYMryMso1NcwPCsUJkyRqaluVBPg3Y5dFuaLld5SWZEm
         NQ+PoywOCeyutmreU33wiNwiNNFmqNyUnujuCERJOb6r+/DyMGdwzmxciOifElgGGSZi
         SWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017326; x=1687609326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LugEbfKWEMVweFaip4bqYKgmPZw/1nC7h73GZvxvvKE=;
        b=My3Q9Xe3ciYlSNeDDlZi/wq/Bp2sSbfhW76K13kSs+ABfprvmZ9gCED1HdXOdqh4hZ
         uLbk7h9rQda13Z/eQpddUu7dHTY0ioI5Pvq70m2QqGNRKWgB6xSyrZmaO0DHU84wj2GS
         9r3+aTD9k8ZS/H4hvluY+HK6741VxnYYyT5Bkdt2enjkCnjRNNIjeIJsTbsZrFT5Wm8U
         y7CPv+724nrF0YVN37OGYaZtmDtkDS/XCt0MVWMVWfpqiNILwwEbpBhKmD7EW/Hoa+12
         yxXhISc+s5W4d7fgjCgEcH5tD941jF9Z4lb7Gi9JTJ12DXiKCwcmxaDw2xqID1uxqIY4
         73zQ==
X-Gm-Message-State: AC+VfDyfoXu2FaYcoIprvyEPCdPZC9OZ6Xri0wGPvfQ4faDGgCqFahJ5
	WNHsXayAHG/2ZFutMpv4WvsHqEtxB68hEQkhk0g=
X-Google-Smtp-Source: ACHHUZ7T0oMD22mI0fOkeceNAbC8wqoTFNL/NjWVrx454M1nL8+QH+kcnYVDgxSJIQ1Iq4VjYKNGHsqmeShrzIZgRJM=
X-Received: by 2002:a2e:9515:0:b0:2b0:486c:3102 with SMTP id
 f21-20020a2e9515000000b002b0486c3102mr879140ljh.10.1685017326024; Thu, 25 May
 2023 05:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska> <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
 <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
 <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com> <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
In-Reply-To: <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 25 May 2023 14:21:54 +0200
Message-ID: <CANNYZj9LiEv3O6fxYYkE2TsmtRn5S9-PTps5cnUS2pHSSfnFkw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Michal Sieron <michalwsieron@gmail.com>, 
	bitbake-devel@lists.openembedded.org, 
	Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 12:22:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14812

On Thu, 25 May 2023 at 14:09, Tomasz Dziendzielski
<tomasz.dziendzielski@gmail.com> wrote:
> Well, it's  not like I'm saying this as a solution, usually we just disable jobs until the slowness is gone. But isn't that what we already do with wget in bitbake?
> "wget -t 2 -T 30" from bitbake/lib/bb/fetch2/wget.py, where -t is tries, and -T is timeout
> Problem is that we get the slowness for git repositories and git does not support such a thing.

But then you can simply wrap git with a timeout command.
https://man7.org/linux/man-pages/man1/timeout.1.html

No?

Alex

