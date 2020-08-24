Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
 by mx.groups.io with SMTP id smtpd.web12.197603.1598284322407725241
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 08:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=lwgSfk4c;
 spf=pass (domain: gmail.com, ip: 209.85.222.196, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f196.google.com with SMTP id g26so7824218qka.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E8vMHyHLNfHK8licpPzYSvvdfSHQOalTt5XESEcoByw=;
        b=lwgSfk4ca651ZSqyD8HerPvcHSl6AbDrmfcbNtJrIGDprGAY7NEnzd1DADLqdpMxpJ
         5rPqXR0GOi1byrJqKaiDHh0BPiBZ9U2o5fhfmkiDmFRVkf1MUmYE7mLxe0BJXMrRDTJ6
         bPj0QnroAK0gLDLjPrsyxaScirJ1Q0kOSosQKpvQjef0ArkF6tp8eooEEDRA4RlFs0gz
         vPOqDqJEj/L+YhRGB4cHcu2ImKY4Qc4ReS3p4zt2/6IkkVN73CFLDZYndHPf3Tpnl+po
         X/IeHMDgIpTtn/Ab0MyZ5CovVMUuUzfCX1/nA8I1IFrdKe9J8bPWCs1DqQaRJ5pXihF4
         OqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E8vMHyHLNfHK8licpPzYSvvdfSHQOalTt5XESEcoByw=;
        b=gdcsEtbhF+dy+Zy7XsYb/no5RkWltWBa4TpYHXu3TZyN52nEtoYMOCPYBOcEeqWVdv
         CvFMF/nTQoB3LTDpk/bpdKMV2bNApt6qDO1B6bcT/BWwzOJlAOcLDMW+4l7rfcHv5TKs
         r/whY1uGm/5N2dPGPAMyx3TMG/X4lS6GQJ3oTMcpJengv/HrnR1bjGPi5dsi5mQKjHdu
         wGT9F6Q3URVKMAeV/SWZas3QWLXB2Ewv8uT8a4ojD6xVdZb0SP4EPO/nLpAdq2nwTkv8
         8CZ55/TZhsfs+XJuyiJe7kqeIS3/Xlc/ykmHiWmdindBDm8QJ9ZDOT8H8zS8uDSWDxq6
         EWVw==
X-Gm-Message-State: AOAM532Rxonij6ipXgLI2YX1D/rJXSeD0y1Fozq3h2YH3RLPXU+eVZ6T
	xuOofxuuwEoNW6SrH8wvCpADLdicVDHZ8g==
X-Google-Smtp-Source: ABdhPJwxxQe2MbwlTTc9lsmQaNWSyqo09+YnDLvabzg84dHsE8fk6cBRl5MK+AdJCBLuZ/Gq9pRRXw==
X-Received: by 2002:a37:99c7:: with SMTP id b190mr5276029qke.347.1598284321401;
        Mon, 24 Aug 2020 08:52:01 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from [10.0.0.29] ([135.0.225.35])
        by smtp.gmail.com with ESMTPSA id o16sm4846225qkj.18.2020.08.24.08.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 08:52:00 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 2/2] bitbake: siggen: clean_basepath: improve perfo and readability
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
In-Reply-To: <20200824154836.23600-2-jeff.dagenais@gmail.com>
Date: Mon, 24 Aug 2020 11:51:58 -0400
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-Id: <8CC64418-6365-4092-825C-8D7EC786C8B4@gmail.com>
References: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
 <20200824154836.23600-1-jeff.dagenais@gmail.com>
 <20200824154836.23600-2-jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> On Aug 24, 2020, at 11:48, Jean-Francois Dagenais =
<jeff.dagenais@gmail.com> wrote:
>=20
> Sigend-off-by: Maxime Roussin-B=C3=A9langer =
<maxime.roussinbelanger@gmail.com>

Typo here... sorry. Resend?=
