Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C073C43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 05:54:17 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web09.23679.1654840452411038585
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 22:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=q4atlYyB;
 spf=pass (domain: gmail.com, ip: 209.85.167.52,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id y32so41198017lfa.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YsdIFTB8qRpsScc9BjL6x0LrgQdUZi59l2i2XLtjn+Y=;
        b=q4atlYyB45veXKYLyHAQFtVBoD173+vmz7mlJjYugOib8RNwnEPhr+0X3dnq5fUEsj
         iMd40aBRegN6tiTpdi0BwNGM1zVWCyY9jVSpNdgZ1+17gB+odVWvBv6Um1f0kB8KorQZ
         07sxHosA8c7QbbZyBMhJ93Hzgo52g+Fz/jsfelWNsJQjq6K+RUBpud5LzqV8xDktbFvL
         rLYTMozhUaoYd1JlKZWziH0CdUhOYtXvv/9WGLTPHXt1zZxeaM6PtWq2jaKDbh/KPzB6
         eck2mDYb+uwaeMT6yF2mTPeOlIX3mTQzSnVeqC4kPZ3suOopU6HxiN/1EfS28F/vZ3Ce
         2dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YsdIFTB8qRpsScc9BjL6x0LrgQdUZi59l2i2XLtjn+Y=;
        b=pPO03psUQCGeKTCSZQtsaQucZu+e/BwQ8WHFv+L7aXEuS9wUP7lf8niQ7hF7Fmdj/C
         J4ws+HiZqfeycfTOmwbkcro/2Mu5M09VhcvmWO/4FVsiDFvtl5yVGAEBIcQA2DIZl6ft
         SHpSj0mdKBkSHPor9mlPO7T5ey0yfbk23DNcT3OQDXqbQP2rrnjERVWuQxda3n8vjUJO
         mat3KEBmWBDK51R7KC6K2ZHrfoS9FMls03TnD1tiPbv1ezCS0R1LqSCXeZWwYT6oLnTI
         0G6v7kUMzq38Wio/XRDgbSrzFOiwAaLGKsVORDxhBKuMPT83uv/Z2OUEEr97+o/JXn2N
         XO9A==
X-Gm-Message-State: AOAM531SFrFON89D/i52X6ZBXtRgNISOEd2zDaQw4KP9iZO+ensW/hpH
	RjztRWB22R5jmUip0yivtSLcgbGJScY=
X-Google-Smtp-Source: 
 ABdhPJx8x3jWaxHkiF0O2+UK2baO3lPZHOOCb1UrDIQDWkHqhM1W5GYEZFleqSd7w3Niq+7gC/jF6g==
X-Received: by 2002:a05:6512:694:b0:479:587e:db05 with SMTP id
 t20-20020a056512069400b00479587edb05mr12750544lfe.458.1654840450110;
        Thu, 09 Jun 2022 22:54:10 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 w25-20020ac254b9000000b0047943248581sm2253271lfk.33.2022.06.09.22.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 22:54:09 -0700 (PDT)
Message-ID: <17d4c8c6-6bfe-e25e-ae20-35b3b70ec7a9@gmail.com>
Date: Fri, 10 Jun 2022 07:54:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <16F51C865CCCC8A5.4993@lists.openembedded.org>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <16F51C865CCCC8A5.4993@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jun 2022 05:54:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13750

On 6/3/22 14:36, Jacob Kroon via lists.openembedded.org wrote:
> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> ---
> 
> Changes in v2:
> * Add comment to line with immediate variable expansion
> 
>   .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>   1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index af4b1358..cfe46562 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is set to "aval".
>   Setting a weak default value (??=)
>   ----------------------------------
>   
> -It is possible to use a "weaker" assignment than in the previous section
> -by using the "??=" operator. This assignment behaves identical to "?="
> -except that the assignment is made at the end of the parsing process
> -rather than immediately. Consequently, when multiple "??=" assignments
> -exist, the last one is used. Also, any "=" or "?=" assignment will
> -override the value set with "??=". Here is an example::
> -
> -   A ??= "somevalue"
> -   A ??= "someothervalue"
> -
> -If ``A`` is set before the above statements are
> -parsed, the variable retains its value. If ``A`` is not set, the
> -variable is set to "someothervalue".
> -
> -Again, this assignment is a "lazy" or "weak" assignment because it does
> -not occur until the end of the parsing process.
> +The weak default value of a variable is the value which that variable
> +will expand to if no value has been assigned to it via one of the other
> +assignment operators. Here is an example::
> +
> +   W ??= "x"
> +   A := "${W}" # Immediate variable expansion
> +   W ??= "y"
> +   B = "${W}"
> +   W ?= "z"
> +
> +After parsing we will have::
> +
> +   A = "x"
> +   B = "z"
> +   W = "z"
>   
>   Immediate variable expansion (:=)
>   ---------------------------------
> 

Any thoughts on the changes above ?

Jacob

