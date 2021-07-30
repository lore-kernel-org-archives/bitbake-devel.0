Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.24661.1627655815353485506
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:36:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F7ElSZ4f;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id n12so11620013wrr.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S7zI3+kEwHpjlkCHZ0tIcvT4EHT2Oup3Ec0gqBCaye8=;
        b=F7ElSZ4feJU1KlANaRFSwGCouIiOZmjLQKlRkcwWV3dgvR2zAwZJTC84LHfmEOJSDf
         G7g4FCtMMgzZssTah5Pm9GSmKxQEjINxzmMAY5LGwTaIUwsz/Fcn8VqtGKw+qpcn9vwr
         ypght4D25tWSbYSrKKwdqzD2u/PmC9rr2zUNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S7zI3+kEwHpjlkCHZ0tIcvT4EHT2Oup3Ec0gqBCaye8=;
        b=djjLbOI20MpTeRSrYM1PF9oHt6BfoG2Iw8LxHIFA89SfPHBR7+TTndGjwaYP12dRO4
         YcNw5/7AtxBT3kxt8b6exxPp7LhKa/qdfNBnW6cd0/G6IkwsI4x+/CoUXo8rcNgrHo/5
         FUv6VMWkAeLDIKeDvVZ/FHbMTPo6a57pIZhA0KUi5CqmDG00+AnWyywaSIL8SWvrhwN4
         Dst/GVRBQSHySC1G/2/yu6jkPiDOJ/7yyaIshhnm5+zjPFI9BiU+JObaR9bBv5r4ubha
         VKLgRLLURIcVoBdvUFUxwkiz0cn8+X1UPtetUUtnMcz818AAzlPLergn3gRki0HMd4QW
         6NRw==
X-Gm-Message-State: AOAM531txP5fCF8mvFinCdjvlPv3WGb9Wkn91nku+BQn5Ed/fbXwcICP
	rxEHrI98smY7d6SSyuhoiRSpsA==
X-Google-Smtp-Source: ABdhPJw4lfi0wCcKKMKrm0GfbcpQusg8hj9izDU/m+bBSp9aa8wtfMtPx3zC45AUTG3sfN/vib6KRg==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr3451520wrr.356.1627655813819;
        Fri, 30 Jul 2021 07:36:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b? ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id r18sm1886330wrt.96.2021.07.30.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:36:53 -0700 (PDT)
Message-ID: <78a12d99338e061d2680a6d4c5a819a3985b7e39.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake: Switch to using new override syntax
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 Jul 2021 15:36:52 +0100
In-Reply-To: <CA+chaQfGLE507bYOivb8XSYcNbm3ssHqEFCdgav5W4XYmgiXuA@mail.gmail.com>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
	 <CA+chaQfGLE507bYOivb8XSYcNbm3ssHqEFCdgav5W4XYmgiXuA@mail.gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-30 at 16:24 +0200, Martin Jansa wrote:
> The webos_configure_manifest_comment_remover is a false positive, but I don't mind renaming it to something
> else (if it can confuse he regexp, then person could get confused as well).

We could change that to do if "_append_" in var or var.endswith("_append")
which would remove the false positive. I guess it depends if we want
to encourage these kinds of names... :)

Cheers,

Richard



