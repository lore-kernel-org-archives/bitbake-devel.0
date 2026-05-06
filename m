Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C09CD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 13:29:26 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18418.1778074160966920735
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 06:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20251104.gappssmtp.com header.s=20251104 header.b=W/rGr8bX;
 spf=pass (domain: baylibre.com, ip: 209.85.222.180, mailfrom: tgamblin@baylibre.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ee9ec26edaso676973085a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778074160; x=1778678960; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/b1OkOzbaWoHuUjttM/E/RTWx9I3BJYB+gryvr+n7c=;
        b=W/rGr8bXONwr4o1jgqRGgmDu+aqZmIUdlg9Gax2vG8A+AeKBmC9X+Zfk6paB/ETeoQ
         3ehHI7aTvNM+LSoBwimA1aDAKsDi3pbrZW5YNqDzEYAkPAvvg5Io3RECvY+xG8CydiXF
         /J6PseDms9UHAoZRnq3EVrA/KBArv4vx9YjEq9pPCdJBvcMiS7AfD+uWD8OHiDq/93pF
         n6xJyplc1mgh4ZDsmTk5Cza2ZkY+h6UD7pMXnS9+FsSU0elkQM5E8nM2DqJTZtO27lR7
         8izytZyXjUC0EQWGSoptqy8TJugtBbwACg4DBF6dRYt5fgTWbzZbBeiJg3KZBe08lxbG
         ijfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074160; x=1778678960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/b1OkOzbaWoHuUjttM/E/RTWx9I3BJYB+gryvr+n7c=;
        b=T2xPsYtgA2Ag6NflfQFU5SuNXKW1gK1ZQPtvgKcoDZ07xFCmeZ4uZSxNmIn4ERuLGI
         Zrlc6HdvvmRiHB3vXIzgnuNHJo77eyxX2+iHPGLwoAOmbWM3h/2sc3evp6dDTK0Dt3eM
         U3CyItS+KjZ52YSX1+0AKH/FxT6Za0eZevTBGnCJco7HNl4wLqMxaVT6ctjOSszeEi/F
         zPYJFv74hhEmPTnm2gByiIORt9dv7cpKxd2iqObIa4silvWeTaDXahKMZ25LX6IDqYG0
         GDXsryYg14DH3bJa1f/iFSs8JkXuQDqJf3U/K4HLpdDrbCYrWwvNiGc2z2C0iPmwObQt
         kosQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Zwzjmv9NaSdjmA2SIKqBGZTGMBfJo34u4Hbpkh1b1ggBOoJZ1EwaxiFvmDbX/ty7j78JhDyAgCBr9XD/I@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyn8+ZmjGblWPd22JxAKxbUUg6RIUZrAR0BkQTgoQcIXnOUaXsx
	kL7CgeIi88dUmQvP8iT5Hy2VqDARpz1saBnKPBqKUbiotjmx6a1GPSoBkjcHRX13VeQ=
X-Gm-Gg: AeBDieuV47Sd3qKVTQJRTr6kPQidfPeAZpJwv1aTPEadRKcHoBDhII8awvFbmpl11wO
	qAljYX3X9tlODnvIyoknIGRaq4N1OMQ1JuRiqDS9F3bHmOoJ8bgdqNhScbvAaVzkRXL4nj+wbRz
	cCAJw888o5Moj0hbY3mNnNnYK2wtL2FMvkPNVKEAp9vMsYe1inHJo76j7hLovc+0IkvFIQfZ7Zh
	uwted1tSbSPmn+xMxXHofh3cESy9vOLT1PI+6/m9URhCxBw7XmXW6Y2+VJoZQo64dm6jVl+PNWt
	sqvyKv/1jEeoCZ/jUElVAbFqDGmU2zP0OmoEmUCuShDmoZ3YNHk/PXfELcQ3lYrBV5bqgZBluEC
	735yhChcMmgGqzGNOiRICQ0wTglP4UUQ1Z60Kbm9BiQmi140vjv6UX6HsWc2gCzcHMqKifhaWH5
	zMi5+Ko5kFlvYAdOYdog6jCFnlcVaJJ/67UciWq+s6KkqptsWaWSH+8gWGLF7yHcQn6PE+LJ7Yo
	jeVeGMcfPhV44o=
X-Received: by 2002:a05:620a:40d0:b0:8dd:b4fc:d561 with SMTP id af79cd13be357-904d438db5dmr500842185a.10.1778074159413;
        Wed, 06 May 2026 06:29:19 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:1977:be2f:4a71:2892? ([2001:1970:3847:e000:1977:be2f:4a71:2892])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80069sm1856645485a.15.2026.05.06.06.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 06:29:18 -0700 (PDT)
Message-ID: <58d89d74-bca7-49eb-8591-5c5e1a0a40fe@baylibre.com>
Date: Wed, 6 May 2026 09:29:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] proposal: build pipelines in
 bitbake-setup
To: alex.kanavin@gmail.com, Daiane Angolini <daiane.angolini@foundries.io>
Cc: openembedded-architecture
 <openembedded-architecture@lists.openembedded.org>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Yocto-mailing-list <yocto@lists.yoctoproject.org>
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com>
 <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
 <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
 <CANNYZj9=Qap1AsWfgFgEforE17Gz8ft8fNz4hJcU4Y=zmTKDZA@mail.gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <CANNYZj9=Qap1AsWfgFgEforE17Gz8ft8fNz4hJcU4Y=zmTKDZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 13:29:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19447


On 2026-05-06 08:43, Alexander Kanavin via lists.openembedded.org wrote:
> On Wed, 6 May 2026 at 12:23, Daiane Angolini
> <daiane.angolini@foundries.io> wrote:
>>> 6. Run a pipeline, stopping after a particular step:
>>> $ bitbake-setup build <pipeline-name> --stop-after <step-name>
>>>
>>> Etc. How's this looking?
>>>
>> I like the term `steps`. I would like to add that this should be
>> optional, not required. One can still decide to avoid creating a
>> pipeline.
> Yes of course.
>
>> Regarding a setup tool for builds, why not use `bitbake
>> <pipeline-name>` instead of `bitbake-setup build <pipeline-name>`?
> bitbake operates on recipes using a well-known command line interface.
> We can't bolt on something entirely different.
>
> That said, pipeline functions don't have to be in bitbake-setup, they
> can be in a separate tool (Trevor mentioned that 'bitbake-setup' as a
> name doesn't fit that functionality very well). I just don't have any
> ideas off the top of my head. 'bitbake-pipeline' ?
I do like this version of the proposal better. Having read the responses 
from the two of you, I think 'bitbake-setup run' might be a reasonable 
compromise for running steps and pipelines. What do you think?
>
> Alex
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2328): https://lists.openembedded.org/g/openembedded-architecture/message/2328
> Mute This Topic: https://lists.openembedded.org/mt/119158252/7611679
> Group Owner: openembedded-architecture+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/openembedded-architecture/unsub [tgamblin@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

