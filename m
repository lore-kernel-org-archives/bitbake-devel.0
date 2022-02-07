Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA3C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 10:16:46 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web12.20615.1644229005152613908
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 02:16:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kDPPZNzQ;
 spf=pass (domain: gmail.com, ip: 209.85.208.169,
 mailfrom: ptsneves@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id a25so18763940lji.9
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 02:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=J3b8FIx3fK30kjiuRphm6iuCGZqtpVpIhgFBiJNWf4s=;
        b=kDPPZNzQQAD7DJjK3WQwgCEB7HE7gSJdPFqzK8NZzVgHIW19ooEUEHoNs7VxIRPAgZ
         cM/GgE56EvPBkkGU8FUg5ZnlTUyG37ZQHe8iV1syC8snAk513tRumpNAMLR1S1tPmYyP
         qy9S4tjt1IVFaYdWqKgZgkaYbRt44g5GDOuS65W29TS8w3Ng5As4FvwpUHNxxJvbf0dU
         Oh2v2ScOmVhlUCdJW4/XoCfpJZjHRNCj2NjKYbQxEmZVdfuWECCV/3VUa5tieGIWTkL9
         9V1CN2S0MZd6LkHp+Hbk7WlJH1gp8OC2ULcnqgTPzu3Wle+doE00ni4GJHapnWdwZCbz
         4NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J3b8FIx3fK30kjiuRphm6iuCGZqtpVpIhgFBiJNWf4s=;
        b=sISZcVbiXyqYQ/xHziNiAYcD9v9kCZoDQZIJBjXv+6mG593r0egqgkLrOFWIQWqCVF
         h+dGXENwYEZzYSQ0s6dIQvku3aYuXKdGBcfaN6AY407SaEpu2vWVGISmONqjUsiuY0B1
         4M1FILqtEGNEuEEKdkDPYw+fL77Hd0nMI1K5jf+zgWXsj0gW4SOEIvOdHXCmZllXw6NI
         QwC+t5ZgZZadVLMmL8PGm41a+Ldk7DBDnKjwEQ+TrY8WtWygRWmcEqmNv4pZWpgtlkR5
         ccoTHBUVxHhgkAqjmZmPY9G/pssfc2PX00593+4UEaf4L92DDLb7K0MdFxfvQfKicHk4
         Qlow==
X-Gm-Message-State: AOAM530rjgz+gAqxTTw9zr8Atx3JLsg+N2Q6Hs4f3R9txAOxALxvhFqZ
	HRdW+m0e9sF7jVVq3+AJnA==
X-Google-Smtp-Source: 
 ABdhPJy8kVmBAbqp5lHr1nf508reTQ/6k/XmuXdA3HoBLwy1t/r0cJoz8H7MyOGT5KcpwvK2I8Xcvg==
X-Received: by 2002:a2e:9e98:: with SMTP id f24mr8189921ljk.471.1644229003306;
        Mon, 07 Feb 2022 02:16:43 -0800 (PST)
Received: from [192.168.1.248]
 (031011128254.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.254])
        by smtp.gmail.com with ESMTPSA id
 k4sm1439229lfr.102.2022.02.07.02.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 02:16:43 -0800 (PST)
Message-ID: <fc916698-247f-4603-bfb6-50c948ee06e3@gmail.com>
Date: Mon, 7 Feb 2022 11:16:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220206134507.123558-1-ptsneves@gmail.com>
 <e8d78db446c3c0649d0003afdcc7c2f897c6e744.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: 
 <e8d78db446c3c0649d0003afdcc7c2f897c6e744.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 10:16:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13316

Thanks Richard.

I will try to have a look and fix it :)

Paulo Neves

On 2/7/22 11:06, Richard Purdie wrote:
> oe-selftest -r layerappend.LayerAppendTests.test_layer_appends


