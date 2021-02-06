Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web12.13904.1612653492033766632
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:18:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gD/+WhYA;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id s24so5715671pjp.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+PlpjXc4e2ZJPAXzSQDw4AS+Ie33YQ1u7AW/XQEo3BA=;
        b=gD/+WhYAjZctzz10opOJy64uwKTZqyYE692jgRvefyQ7y/gmj4psy9pVM6KEkXn/q1
         H20VbnhRnqQRkx6Y4OyMaYFZ4+kDHYn3d1ckrId8inwJu3mLAIxST+WJ3BSNLQkOmyXZ
         NEOn1jvMrEc3PFWzd3RxaV/JDewMTZXNrCTlxHEXL+vZhSWts1XVWcKn9zu7oREnileW
         XFw8cFzSA8ZBFM6+GZw8cdiRCbjxSNw7AMqSlxh+EcXT4K23SxZQZGAzjMT5s24QvZHN
         W34qqqsWBSF5IudKLsHyNx5HpdQwEzR57Af8ruplmNfJA0KU/r+cNQPXO4NFYh9QQz6l
         InJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+PlpjXc4e2ZJPAXzSQDw4AS+Ie33YQ1u7AW/XQEo3BA=;
        b=k1v83IvA7JTL7W8Ig0xJWqhEiT1rX0lebGK2WDw/jHirxbWQb8xvMu2Y/GafTC14TA
         JmL+6JQkh7QWT9g0ynxydLumXmpkN8N6xulZfQNBgykrQZZy2kw6ufgNLal2DetiSpic
         0ilGQ6q3mRtYgR4iJszgfQpoi8nDAaQqsieEI+kjVuhUPLjGUD27RFhnOnlheWS8CHjU
         XR0R3ZDPV045nlWRAnITMW4aOcgEEvVS9KsgeyDYh1d8crlAWXa0yxyY3l7ZzPgRRJ07
         62JA3t3QTnPF1OHYvjnKqhIxew547trh1fLQB8iG4BJzq3YLxd5gycUA8BVAX0LBsUCp
         Fgdg==
X-Gm-Message-State: AOAM5334ru6ZeIUQe/2gduRenwBLsnH0bMcYY4NCjs67wUgufZUxUwRm
	00v9RY/F9bxDP45dJ/3Q86DpZgqivHO87g==
X-Google-Smtp-Source: ABdhPJxWoSbVg4m8Tmcgj5X5oqo5P4ncLELPOpoxP0i8pRP0td1ihUohCB1t1NisMnqBjh8SVYqsTQ==
X-Received: by 2002:a17:90a:fb83:: with SMTP id cp3mr9800091pjb.168.1612653491484;
        Sat, 06 Feb 2021 15:18:11 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:c5c4:f80e:4f44:b02e? ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id x1sm15274392pgj.37.2021.02.06.15.18.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 15:18:11 -0800 (PST)
Subject: Re: [bitbake-devel] [gatesgargh 00/10] patch review Feb 06
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
References: <cover.1612652802.git.akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <4063ac8b-9b4a-5056-b064-b94586400d00@gmail.com>
Date: Sat, 6 Feb 2021 15:18:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

nothing like getting old and using the wrong mailing list.

sorry for the noise.
Armin

On 2/6/21 3:08 PM, akuster wrote:
> Next Gatesgarth patch review.
> Please have comments back by Monday.
>
>
> The following changes since commit 6ff4bd4f345b4e8030b9197d13097308df521576:
>
>   postgresql: Update to 12.5 (2021-01-18 08:20:58 -0800)
>
> are available in the Git repository at:
>
>   git://git.openembedded.org/meta-openembedded-contrib stable/gatesgarth-nut
>   http://cgit.openembedded.org/meta-openembedded-contrib/log/?h=stable/gatesgarth-nut
>
> Anatol Belski (1):
>   xmlsec1: Fix configure QA error caused by host lookup path
>
> Dmitry Baryshkov (2):
>   xterm: install xterm and uxterm desktop files
>   xterm: provide virtual/x-terminal-emulator
>
> Mikko Rapeli (2):
>   flatbuffers: whitelist CVE-2020-35864
>   giflib: apply patch for CVE-2019-15133 and set CVE_PRODUCT
>
> S. Lockwood-Childs (1):
>   sip3: simplify recipe
>
> Søren Andersen (1):
>   zram: fix sourcing of zram parameters
>
> zangrc (2):
>   iscsi-initiator-utils: upgrade 2.1.2 -> 2.1.3
>   openldap: upgrade 2.4.51 -> 2.4.56
>
> zhengruoqin (1):
>   openldap: upgrade 2.4.56 -> 2.4.57
>
>  ...Compare-with-max-int-instead-of-max-.patch | 48 -------------------
>  ....1.2.bb => iscsi-initiator-utils_2.1.3.bb} |  3 +-
>  .../flatbuffers/flatbuffers_1.12.0.bb         |  2 +
>  .../giflib/files/CVE-2019-15133.patch         | 23 +++++++++
>  .../recipes-devtools/giflib/giflib_5.1.4.bb   |  7 ++-
>  meta-oe/recipes-devtools/sip/sip3_4.19.23.bb  | 17 ++-----
>  .../recipes-extended/zram/zram/zram-swap-init |  2 +-
>  .../recipes-graphics/xorg-app/xterm_353.bb    | 16 ++++++-
>  ...{openldap_2.4.51.bb => openldap_2.4.57.bb} |  6 +--
>  .../xmlsec1/ensure-search-path-non-host.patch | 22 +++++++++
>  .../recipes-support/xmlsec1/xmlsec1_1.2.30.bb |  1 +
>  11 files changed, 78 insertions(+), 69 deletions(-)
>  delete mode 100644 meta-networking/recipes-daemons/iscsi-initiator-utils/files/0001-libopeniscsiusr-Compare-with-max-int-instead-of-max-.patch
>  rename meta-networking/recipes-daemons/iscsi-initiator-utils/{iscsi-initiator-utils_2.1.2.bb => iscsi-initiator-utils_2.1.3.bb} (96%)
>  create mode 100644 meta-oe/recipes-devtools/giflib/files/CVE-2019-15133.patch
>  rename meta-oe/recipes-support/openldap/{openldap_2.4.51.bb => openldap_2.4.57.bb} (97%)
>  create mode 100644 meta-oe/recipes-support/xmlsec1/xmlsec1/ensure-search-path-non-host.patch
>
>
> 
>

