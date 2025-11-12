Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54095CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:46:54 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8091.1762933607826637676
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 23:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gg/f0XEv;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: skandigraun@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so145418f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 23:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762933606; x=1763538406; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmMcmHC7XE9vk/LnIgsCzpJAAzvJa/KBgOwHEL6fhCQ=;
        b=gg/f0XEvOl6GoIRvl+rtu+pDfDMVCKDAohB1S/IGENJg3Za6PaIbE2xZrvJ87N16v6
         +h3eBLxYW3vuIGQ3aB8/vLbbpa3iSm2zyi0QcfKVtrx8myK9uAI4iBzKqzcvL+z8RvDJ
         4BwPKXJdGx/AQYhCrb2gyH50b0ncMQX18zB8pzue10aQyuupjqekc78byVUkI31N8LmF
         2ONk4ALZkacqSFbnnDUcBCe2zNXjKxVQxj/lVCR0i2zMRlYeeRJJxrLx9KnCJABSltfV
         mH6cSf8ZX4zZZMes+/WUfW/QaZrwpzml5OTjbbb90oKz30rBAx0Y8iHeTYz58Ejdty9Y
         ZT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933606; x=1763538406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmMcmHC7XE9vk/LnIgsCzpJAAzvJa/KBgOwHEL6fhCQ=;
        b=LCvdKTCJWiaICDhPzkzmmbHnPEv9o8aCuQ+cuaHhby+T+HrknMmRJ7rxha9EjHZj2l
         p0a3/+D6fiQ2OfMfzJDXSN3/Fp/Uw7hXTJNYAcPc5D5aEbs19Ix41uP+yg7kBCy4Y4rB
         9dFAN4Jy5mw/6j+FPNOWy0D/ctHWCgCNPABlYzNL0UcjhtlW24MTaObfRNbV83d7tyTx
         kJCpRTmAo9dw99GPEEkJI73geM0425tuJIkFmdWK2x+z9ratOhGDJPmg+Lpiy5oREaFu
         ft22xg8Rq6xofLtebtMeFhiS5ee9GqUvVAZKFSkaHmgwaFE4HdjB36mZT57CVd08WvmE
         m03A==
X-Gm-Message-State: AOJu0YyzNt9bjjO3Fkwdvr9nbHxNbDawHemrwDXtEYEl3pW3az8bX/30
	SfN0wKlvlPxZvnqxj55lTpWQEmwLaN8XF6dIyVzQETe/eJxI0ijifBf1
X-Gm-Gg: ASbGnct6+AmW0vTrTMD5zIjgmKsO7S+dpYw15mgHjQeHPGgvPQpo02LyD665ymvu3tH
	2c/Fh/6g/uMpkUWrJkm9e3WrAAtKedPs2GeK4HM2ckGqQeBmo+tWxUd4mrIhKI/QN8r6xIj8boX
	vaCL1LtllJww5z8qvRV703JOHXZc6hsEBxogJCnFV6CUVyZUflyXpvuoU9QxRGq8iMG5a4tRmFG
	quobqAguaQ3Qrv9UWmS5fGfogCuQQ0UIGo+nFA4wOuHewSzX/6scQle4nH1x7nQLjtdwr8gTIuX
	P8yEse+B3ucG9WRAYa9i0SzKuk55Eap8qdnq5BKkbWwKcTdpjuvK7VxLX/UCAQN6HHCDkKE5p8h
	9XC8A9AOZuLr5fKJqfkDZOKiX/ETXBIjtFuMdUhg5Le73hyctTAQLrjBgkraPSXKwufEaCE40T4
	9myW1ZgjcVIXl/po1/+WI=
X-Google-Smtp-Source: AGHT+IE3LDnB+D86MRiqYpFjMtRebc/BeYcCP0+Sihfnv3ZSpCtNj48DuEF29umHr0GQuuhTJ/SNxg==
X-Received: by 2002:a5d:5d0c:0:b0:429:cf03:8b2e with SMTP id ffacd0b85a97d-42b4b844cd0mr1746385f8f.13.1762933605910;
        Tue, 11 Nov 2025 23:46:45 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b326a950bsm21966767f8f.8.2025.11.11.23.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 23:46:45 -0800 (PST)
Message-ID: <2460b48d-e465-4f00-bfb8-b7b88111a90d@gmail.com>
Date: Wed, 12 Nov 2025 08:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] My bitbake-setup testing notes so far
To: JPEWhacker@gmail.com, richard.purdie@linuxfoundation.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
 <CAJdd5GYNB-s6FiaZDGBSf1DmFHo0cxiyG-uuvYqcGHJyynAiMQ@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CAJdd5GYNB-s6FiaZDGBSf1DmFHo0cxiyG-uuvYqcGHJyynAiMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:46:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18345

On 11/11/25 21:11, Joshua Watt via lists.openembedded.org wrote:
> On Tue, Nov 11, 2025 at 8:17 AM Richard Purdie via
> lists.openembedded.org
> <richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>> I've noted down a summary of my recent bitbake-setup testing notes:
>>
>>
>> "bitbake-setup update" moves local.conf changes out the way. I think by
>> default there should be a warning about out of date conf files and a
>> y/n to move. There should be a command line option not to do this as it
>> really isn't what most users expect/want. I do understand why it is
>> doing it from an upgrade perspective.
>>
>>
>> As Joshua mentions, we should just error for non-global settings that
>> won't do anything.
> A patch is sent for this
>
>>
>> When we set a top level dl-dir, it should filter down into DL_DIR in
>> the builds, we do want to share that.
> Maybe. I want to set that in site.conf so it's the same for all my
> builds (a centralized site.conf is actually a really nice feature of
> this tool!). Perhaps a compromise is that the default site.conf has a
> DL_DIR that points to the one used by bitbake-setup. I'd rather have
> site.conf be the authority on DL_DIR and modify bitbake-setup to use
> the same path though it's settings than have bitbake-setup the
> authority on where DL_DIR is located.
>
> I'll send a patch for that
>
>>
>> There is a related issue with sstate-dir (and maybe hashequiv DB?) not
>> being shared between builds by default. We have an opportunity to fix
>> this right now.
>>
>>
>> The message:
>> 'Bitbake-setup is using /XXX/bitbake-builds as top directory ("bitbake-setup settings --help" shows how to change it)"'
>> is misleading. If you run that, if doesn't tell me. I need to run
>> bitbake-setup settings list and know which one to change.
>>
>>
>> I'm starting to wonder if there should a "--quickstart-help" which
>> lists a set of examplecommands to run like:
>>
>> bitbake-setup settings set --global default top-dir-name poky
> Setting top-dir-name to "poky" wouldn't make any sense to me as a
> configuration option; --setup-dir-name=poky is what I would expect
> instead.
>
>> bitbake-setup settings set --global default dl-dir /media/build/sources/
>> bitbake-setup init poky-master poky distro/poky machine/qemux86-64 --setup-dir-name build
> Ostensibly, you don't _need_ to run any of these unless you want to
> change the settings. Just running `bitbake-setup init` is sufficient
> if the defaults are OK (which, for most people, is probably fine?).
> Other than the confusion about changing the top-dir, I really didn't
> think this was that bad.
>
> bitbake-setup does prompt the user to continue if it looks like the
> top-dir is new (e.g. doesn't contain a site.conf) which gives them an
> option to say 'no' and change it. Perhaps instead that prompt should
> provide guidance on how to change the top directory name at that
> point. I'll send a patch for that
>
>> The reasoning being to give people an idea of needing to set some
>> global values for thing like dl-dir.
> See above.
>
>>
>> When I run init, the I should be able to edit the default build
>> directory name more easily. "poky-master-poky-distro_poky-
>> machine_qemux86-64" is a little nonsensical in that I can change DISTRO
>> and MACHINE in a build without changing the build directory. Could we
>> simplify the default? Should we give the user a hint about how to
>> change the MACHINE/DISTRO? I think we do want to be able to encourage
>> users to switch some settings in their builds.
>>
>>
>> For settings, is there anything other than the default section? Should
>> we perhaps default to default to simplify the commands?
> I'm personally OK with the way it is. It matches the git config model
> where git has sections and variables under those sections (although
> git uses '.' as the separator, e.g. 'user.email'). I understood
> 'default' to mean the values that will be chosen if I don't say
> otherwise, so I didn't find this confusing or cumbersome. I actually
> think making "default" the default will be more confusing as to why
> some variables need a section and some don't (assuming we add more
> sections in the future).
>
> TL; DR - I'd just leave this as is, I don't think it's confusing.

Along with the "global" flag, personally I find it pretty confusing.
Consider 

$ bitbake-setup settings set default foo bar
$ bitbake-setup settings set --global default foo baz
$ bitbake-setup settings list
...
default foo bar
$ bitbake-setup settings unset default foo
$ bitbake-setup settings list
...
default foo baz
#... but both were "default"..

For me, "global" and "default" have the same meaning in this context (or
at least I would expect them to be the same)

Personally I would either remove the "default" section, or I would
remove the "global" flag, and make "default" actually default, globally.

(Or maybe I need further clarification about this...)


>>
>> We also don't have a good way of mimicking something more similar to
>> the older poky layout with bitbake-setup. The autobuilder is the
>> closest on that but with some horrible commands, I think we might want
>> to find a way to allow that more easily/obviously.
>>
>>
>>
>> Any one of these issues in isolation isn't a blocker but together, they
>> all make the experience a bit jarring and not what people are used to
>> from us. We get one chance at users of the tool, I think this will
>> break it.
>>
>> I do probably have more thoughts, I'll try and keep more notes as I go
>> and find things. I'm sorry not to have come to some of this earlier :/.
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>>
>>
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#18334): https://lists.openembedded.org/g/bitbake-devel/message/18334
>> Mute This Topic: https://lists.openembedded.org/mt/116239397/6084445
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [skandigraun@gmail.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>


