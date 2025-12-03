Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93986D12D4A
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 11:47:16 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13278.1764762426161544624
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 03:47:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oRwOQja5;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2b90ad22so1735195f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 03:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764762424; x=1765367224; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTZvfTtBvORQTMWBVgPoiCGqMLZwOYnSyE03BM9+T9o=;
        b=oRwOQja5ObhxiSvfLEuY1L+C7RTKX8tUYGHhmlsPSWfjvnTcila2AoUBDa+ODDX6VG
         kSXB2PSUZxMLNeFP6mTGc/PrKNetl3/Dzot6tB/t1vDdaJ12U8kjdB1dgNir98pZ8HwD
         +4XWsUwDayild+sZDZZoD1Y4jO8HIw6hb7cvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762424; x=1765367224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTZvfTtBvORQTMWBVgPoiCGqMLZwOYnSyE03BM9+T9o=;
        b=g7rMWmJxTUTjpdW1qqu5lZGNX3kvTV593FK/CXMkV41CEcc1lvHCaEhYzw73HLAf8q
         wX2ZH+aM3NzMGSq33D94JhqyJJifyWOr6tRiYP7lp3xpXX3s6IDvBBeXS3poJ3HEDRDj
         eozgNWatMneHxvJ/NktDAk5sBGi8NnuCLXgKwwCqvtVusZz1LwSLHvWHsqUMnoDFneQP
         eA+gFEk4weHBk5BkipnmILMKsX8Wa1bvuOzEW2M4oWxj7qyy+2GrX/N1Hzj8sc5UELlg
         XUQI9MEHFNO9tMlRlNlQ+lD3cPwt/LPmjuRMbftkEQ/4E7ECIP9PMWUz1MnhmCP9dqSB
         lCQg==
X-Forwarded-Encrypted: i=1; AJvYcCULqSvG7bJyBtRCfPO6spDIJ/BUdnt1BVJqD+sViszUQuoFEnXnnoL3fL59ZUNuLIQufBUCZchhe8FsRgV/@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz+k45Ma+2PfUaII5nXRi0wh2twjm5HXW8Z/BNcnPBVOLWhbkfU
	FsYReRAsuR7xxx3zsyyuCPqDo2J5jW4kJrbj+zYb4KZ+KYHVFoP/oc8uywigFQBCKyWQwwJkgk2
	Xi0GEf7uNR3amIEoCm/wcDlIU2eqMJnSlpe9C115t4w==
X-Gm-Gg: ASbGncuzpWBiqNonEOXDSpwXcNQ++olKQsn5YjWOn/sWgMLDnL2MWmyxTuR3kdOL+tP
	SJEuTYnPCplZdKkTiC44TMLoE+h2P9S5vwhAjh8LF4Izd3ZEmwgsl+4zwlc/FZMhV6Z4rKVcl+w
	FLOSl3YkKHF8/qncxbzaeK0qcyNtXgijwQUIJsoOQPDPq6v2fJgAW7ULDt3w2BE8rVkY7CB1vRw
	f5ru6K3ilWSTY3FwojL4tEvqNZy1jErgFXHavect5jTVEVhkGfYJFS50oii6jsEsl/SfRzsqCGd
	lYzWT8hE567+rPz6R0M1JxHYJSMhXZav+sGRSUk=
X-Google-Smtp-Source: AGHT+IFDZSlRY1WZatKuV5RKlund+OelqI9b7CRoVK1ygNLCKSzpq0bdN6l4DiLmfJvCKqBJR1yiv2DeMcvC3ZpNjfo=
X-Received: by 2002:a05:6000:1887:b0:42b:2f90:bd05 with SMTP id
 ffacd0b85a97d-42f731c3290mr1868309f8f.45.1764762424558; Wed, 03 Dec 2025
 03:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20251202160402.819060-1-corentin.guillevic@smile.fr>
 <20251202160402.819060-2-corentin.guillevic@smile.fr> <CANNYZj-dNDhzchZU02w6-Q-CLkU2MiFaZ-z-=n7JxsmGdDsgxQ@mail.gmail.com>
 <CAMSfU+6JeaWFAah4AH_N7Ewpzw8g-WCq=we4-kTVfaNF63MdaQ@mail.gmail.com> <CANNYZj91Q5GxUVmMoOrZg17tdY=TCsAmF8SEM+Mtriu1VQNTOQ@mail.gmail.com>
In-Reply-To: <CANNYZj91Q5GxUVmMoOrZg17tdY=TCsAmF8SEM+Mtriu1VQNTOQ@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Wed, 3 Dec 2025 12:46:38 +0100
X-Gm-Features: AWmQ_bmHIlda7Q9h4MqOkclkRrBnAFcJ4GWOdhNRytDq5_Li227gP8QpqHsOIAA
Message-ID: <CAMSfU+4RTXYaTqLuOFrYDWY_RZYfxM+FNDSjD92WA6-E58z7yQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] layers.schema.json: support 'uri',
 make this and 'remotes' mutually exclusive
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: corentin.guillevic@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 11:47:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18521

Le mar. 2 d=C3=A9c. 2025 =C3=A0 19:28, Alexander Kanavin
<alex.kanavin@gmail.com> a =C3=A9crit :
>
> On Tue, 2 Dec 2025 at 18:53, Yoann Congal <yoann.congal@smile.fr> wrote:
>
> > That was to avoid weird behavior on "origin" being defined twice: once =
in "uri" and once in remotes/origin.
> > How do you suggest to handle this case, throw an error?
>
> If a config defines the same fetch uri twice, regardless of which
> syntax is used, that's a mistake in the config. Not the reason to make
> the two ways mutually exclusive.
>
> Or did I misunderstand you? Can you show an example?

At first that was to avoid this kind of setup:
"uri": "http://example.org/git/",
"remotes" : {
  "origin": {
    "uri": "http://anotherexample.org/git/"
  }
}
In this config, what the "origin" remote should be? To avoid this
confusion I proposed to make the two modes mutually exclusive.

But, thinking about it, when using the short version, a user most
likely won't care about the remote name so we can choose anything that
isn't a "remotes":{} key : a random string, an incrementing
"origin_%d", ...

What do you think?

> Alex



--=20
Yoann Congal
Smile ECS

