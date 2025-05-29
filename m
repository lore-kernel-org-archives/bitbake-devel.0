Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414CC5AD49
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 15:34:37 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.24098.1748532866958068179
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 May 2025 08:34:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W90QN8ff;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so11957345e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748532865; x=1749137665; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJt+iClc6F45VwteuySeoW+BzA07LBQT4w2eG8TJ/sk=;
        b=W90QN8ffqMstUW/1o47RtDOScN2GNTI9dz0bqq5g8T6k/rXgnBXF45iRjNMugBU8ef
         DgmYOc8qZ+rImp5tHwvJJMYrXtbPjYa5C/Th9Vi8hevDRI2xOW31f05gMZNVow1R+PLR
         eoz0FdWwGBd10tlvLeTnOcEef9JG8/GDFY6R4xQTWafurNXdS+K9elNLk/uWC7nB+3YD
         Flq//Z9Qoduk07sOlCyq9iXH52S5bDvaDOO9jrAD9qcOuPTGzj8MBM9ESFYD+D0RYMWh
         jAl2oOCZopNZ009Jj1ddW1+QxfX8EZCTbH1vAnFx6Rs6iPshizY9wLI6QB/tmqdU9cEq
         jd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748532865; x=1749137665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJt+iClc6F45VwteuySeoW+BzA07LBQT4w2eG8TJ/sk=;
        b=vM5OEEjwfIEASsL2bC9WkIQbNcqECZtGp+LYpaGqs4s2ncngbCBEP+JdoLVKMI+Sr/
         vDZucCeHy/vX4wqOh2g6EAsYW3aobiOXkbaIDj+x/smtahBaheIWUOgeyqgOy9e4T5Om
         ZCJttefwLsq/m/RfcH5S6AYAMV0dALQq3JAZplqshek5cEhReAEA0iShusBu5bMFAAOe
         jHTpqdXq461hQ6o1gacPxt1Ih6NcAta4vh4myE+1g24P6B8cg8KKOrKktv3I8HGu9/PL
         /szcUeNWnGkueVGCf1BPDNyZB3N/fcyDSOimAJP9GEhdLLlhSb3SDqIK2OL2Vcbpsguh
         2z3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXG69j08s93K/x/Ivs9ezvyQtG26QzGNmlx61FKDgg8nJGNH74NPyjDFuHelO8iZSb2GVlMVokvp8v/Lqs@lists.openembedded.org
X-Gm-Message-State: AOJu0YzAOEX8EzeGOeqSAITD5cC9niC0s4gzlrMFJowf8Z9YvTqXoU8y
	z/WE2TBeC4MVKvHHxU61sNKU8d9x73TeX3bb1beTuiszomsyA8+E+CI5
X-Gm-Gg: ASbGncumbzZSZr6393+/GfbYhps66xV1pnCWmszqyXo0WIp2ELlGKMYowv22fLsEExf
	0A3gmxDJbxxGFa5rTUKfpUIHAKpxstqrqMhbEEBrm7gipLVdwJhURP2FP+uVjxcgnsX3Al+5i5r
	yxFVxYRKH8OskfRKo1pMY4Uievn0fy5qSaatDXEkf0XuKPGb9IiXJr89GfcEDafThtO+SiYHsgx
	iddzUtiUxp/JBeimrF/YB4YMghFWDBXSyf6a//LB/ahKJmeQGHjghLSS3ov7p6bAqEArXGdHIx0
	gJKUVnz7eUquvDhoyTOjaZqdM4V3/BcygNj35sYHOp6NibhJoY8UJRu3jBKG2WE+3FaU3g==
X-Google-Smtp-Source: AGHT+IERjjoChG5DtXI4z/EdNUfjnJR2B8ezder7QlBjmocW+0QsR2jKafFa7FEowJ097S5M26wRIg==
X-Received: by 2002:a05:600c:8108:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-450d658f8f5mr1587785e9.29.1748532864961;
        Thu, 29 May 2025 08:34:24 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc51585sm22736115e9.23.2025.05.29.08.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 08:34:24 -0700 (PDT)
Message-ID: <9ae97e78-1fdb-45dd-8746-122f6e5a919f@gmail.com>
Date: Thu, 29 May 2025 17:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] [YOCTO #15882] Add question mark to
 mark the start of the AZ_SAS query parameters.
To: robbinvandamme@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbin.vandamme@renson.be>
References: <20250529141418.1939172-1-robbin.vandamme@renson.be>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250529141418.1939172-1-robbin.vandamme@renson.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 15:34:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17655

On 5/29/25 16:14, robbin van damme via lists.openembedded.org wrote:
> Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
> ---
>  lib/bb/fetch2/az.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
> index 346124a8b..327273379 100644
> --- a/lib/bb/fetch2/az.py
> +++ b/lib/bb/fetch2/az.py
> @@ -36,7 +36,7 @@ class Az(Wget):
>  
>          az_sas = d.getVar('AZ_SAS')
>          if az_sas and az_sas not in ud.url:
> -            ud.url += az_sas
> +            ud.url += f'?{az_sas}'
>  
>          return Wget.checkstatus(self, fetch, ud, d, try_again)
>  
> @@ -62,7 +62,7 @@ class Az(Wget):
>          az_sas = d.getVar('AZ_SAS')
>  
>          if az_sas:
> -            azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
> +            azuri = '%s%s%s?%s' % ('https://', ud.host, ud.path, az_sas)
>          else:
>              azuri = '%s%s%s' % ('https://', ud.host, ud.path)
>  
I think that this is going to be a documentation problem.
Though not mentioned in the commit message unfortunately, I believe I
see the issue: the url has the classic
"protocol://domain/path?param=value&param2=value2..." format. The AZ_SAS
variable holds the "param=value..." part. The original commit message[1]
does contain a (not too strong) reference that it should start with a
question mark, however this didn't reach the documentation, and it gives
an example without a question mark[2].

I think the documentation should be updated primarily. Of course the
code could be a bit smarter too, for example if az_sas doesn't start
with '?', then maybe emit a debug message and prepend a '?'
automatically. Though I don't know how many people rely on this fetcher,
but I don't think the current behavior should be changed with suddenly
not expecting a '?' in this variable.

[1]:
https://git.openembedded.org/bitbake/commit/lib/bb/fetch2/az.py?id=b103b02f2ce2f8f5079f17ec1a854f904c2110a4
[2]:
https://docs.yoctoproject.org/bitbake/2.6/bitbake-user-manual/bitbake-user-manual-fetching.html#az-fetcher-az


