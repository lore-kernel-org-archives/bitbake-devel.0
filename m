Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7930C433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 11:11:07 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.40368.1656328260420772817
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jun 2022 04:11:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JLdDMoQo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id o16so12548271wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jun 2022 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=/Xx/sWAOzvzAjFRoHfv6x75Rq6jVgYy41Bkojx98Hm8=;
        b=JLdDMoQoV0edIb2Rc87ixGDohbAuq6hr6EbPHmIAMk8NHbJ2/Qn8+YKwjcEkkZV58f
         k7Ijzz/FMz62VDMEbUemdWDr8dNCHg/F3pCmI89Bi7jGtmtOqL2T4xQIpqxoEL2oKkOP
         kXecLDY9q307GbKq7krGMRdBxvCOC2mTzWavs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=/Xx/sWAOzvzAjFRoHfv6x75Rq6jVgYy41Bkojx98Hm8=;
        b=ZF1IZTlZ2g1XvKn9rBnddHqMK+WifxROEn/MiFognv5q8vMOwH5yNRySnyWVuVsYPS
         fsUiEqFljFjvbhjrMpB7jkE/tFOf6hDFui9St2ghlZpD3XARva5uTu341VGHnRmgsW3d
         C5PRBfSj4HRvdUW+bVdAL4wpdot2xusnbKEIOSGq/1fV3qlAmxexdIUoIvCWAe3Jcuas
         W78ruHvdKww44y+EElYhxACEskabOzqEDKWhiQokZR9D3dIv+9ViabOJ4PHsCQg/UlmG
         wBzWz5puiT8OMNQlYfZC+XXOlPJZxH9PJxLYXtIMfndE0kYAeXyec8vmEXGXzwi6chVN
         daEw==
X-Gm-Message-State: AJIora/r2xcoF/Ssan7Lu8TB961wxbbbl6aPihp9g/ZCQ6p+q0TjlC9v
	0VNr8fxbyHiGWooedkqyqcEAgA==
X-Google-Smtp-Source: 
 AGRyM1tMSH3eBIS2LkWHEeBFR6p4003V1MSFciqEJnNNfn1f/dnwio7OfwAnnQiVnG6zmaMmTA6BRQ==
X-Received: by 2002:adf:e308:0:b0:21b:891a:136f with SMTP id
 b8-20020adfe308000000b0021b891a136fmr11729260wrj.14.1656328258760;
        Mon, 27 Jun 2022 04:10:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8950:ad6c:6fd6:5033?
 ([2001:8b0:aba:5f3c:8950:ad6c:6fd6:5033])
        by smtp.gmail.com with ESMTPSA id
 k31-20020a05600c1c9f00b0039c5642e430sm13252277wms.20.2022.06.27.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:10:58 -0700 (PDT)
Message-ID: 
 <d6260e8bcd7b49395c7e81e4649f5989df8d6e91.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: Pass flags through variable
 rename
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Otavio Salvador
	 <otavio.salvador@ossystems.com.br>, Alex Kiernan <alexk@zuma.ai>
Date: Mon, 27 Jun 2022 12:10:57 +0100
In-Reply-To: 
 <CAO5Uq5SxhRhpRGyD4PoXm3b2Edtzy=tgGWkRFpjKRikFgsW+mg@mail.gmail.com>
References: <20220609070631.23346-1-alex.kiernan@gmail.com>
	 <5e781972643ed99e2948ac5a908222a190678475.camel@linuxfoundation.org>
	 <16F6ED45D7C68CA7.32696@lists.openembedded.org>
	 <CAO5Uq5SxhRhpRGyD4PoXm3b2Edtzy=tgGWkRFpjKRikFgsW+mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jun 2022 11:11:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13791

On Thu, 2022-06-16 at 13:27 +0100, Alex Kiernan wrote:
> I've been thinking around this, I guess the bit I really want to work
> is for flags to survive through variable renames, rather than
> overrides, but the two use cases do tend to collide as we often have
> overrides with variable expansion, which is then renaming...
>=20
> Just realised I c&p my example from our vendor branch which is still
> on _ based overrides rather than : based ones, but both seem to work
> for me.

I've been pondering this a bit more but I'm not sure we want to wade
into the complexities of how flags+overrides+key expansion can all
collide together.

I did notice this in the metadata though:

RRECOMMENDS:coreutils-dev[nodeprrecs] =3D "1"

which happens to work as it doesn't use key expansion and doesn't rely
on override expansion for access (the variable named
"RRECOMMENDS:coreutils-dev" exists).

It does mean we have some subset of this problem live in metadata
though :/.

Changing it to RRECOMMENDS:${PN}-dev breaks things.

Cheers,

Richard

