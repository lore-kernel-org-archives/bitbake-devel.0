Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
 by mx.groups.io with SMTP id smtpd.web12.874.1585934468808338070
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2020 10:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=jI+ZL5Qc;
 spf=pass (domain: gmail.com, ip: 209.85.166.195, mailfrom: raj.khem@gmail.com)
Received: by mail-il1-f195.google.com with SMTP id n13so8029340ilm.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2020 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A2HWLbIGrfM2gWLCeRBTyS9RJCkw0AJr5/ZRwTlAPKU=;
        b=jI+ZL5QcqjBBfRkQdzSxu7FrxiLeRRwhdFZm4WtpLz55CU1ZvfKGJ/6s4Fd0/76NAF
         zMyITKyTlnOlkomkycV8Go5DdABGWz8UU9Yn27R4Q6PaDmbB6cgIOnQwwaI+OVP/QSBG
         nUpOYNTN1pxnuqiMkSAFcMRhzT9CM75tXmg1zicL4LJEpQbkwjfjnvIkEvOl6JMwL7LN
         HeJyYA6V0MtkRO3OJ/E1f4FnUc8EJMkfRZ+s32209uk8Iu9Ndwk3MQYDoct9QDnlnXjl
         iUJZV7g+dKo11WgrihvHX7AAQbEECqUAgnmEHdt9hxMxMKRAbnNsI3vXdgKXYK3+SAYO
         q+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2HWLbIGrfM2gWLCeRBTyS9RJCkw0AJr5/ZRwTlAPKU=;
        b=TxOWjIE6cqZlVJl6WXaFxM2VuDBzwXefT6VT3Hm8xQ7tlCIiZcM4+oT84SshewmzSk
         D5nSKbIQpmU7v5SnWu7gvms8xKd1fOAzOiZSyYAZ854hR5olRxNNUSac953ysUkOoORH
         jWxV9bGbwydJnwAAGk3kDdrtHGtWVmQcWBEM5UwC/SiUu/JijdERN+Y+XflBv6HWrRaV
         pCmoj4tDz943hcaiuYrNWjMM9fSOXKgQcv2KHcij8dX16uTWXPGsKE3a/J8N4bliIbjG
         BMFQtMMXpSiIPFZ52oT9k4lyw2ch0YO6I5DWRxTJTrCG+IDsLr+XXSIAejonSC2ZrGBD
         E2Yw==
X-Gm-Message-State: AGi0PuawwrgcBdyInNCO7bfJ0Q099a5bf2yF4cgpLY5LzLgytXhUg/lJ
	0LFOilOX04fYwi9ts4AcJJU45ukbsyY=
X-Google-Smtp-Source: APiQypJXAD6d2NRRjCfhlYZO0U4wM8JI0NhH6G1ICZa3uLj3Uv2Zm4ZKOcdzDzHp2wAK0OIJYqensQ==
X-Received: by 2002:a92:3d10:: with SMTP id k16mr9395600ila.274.1585934467615;
        Fri, 03 Apr 2020 10:21:07 -0700 (PDT)
Return-Path: <raj.khem@gmail.com>
Received: from ?IPv6:2601:646:9200:4e0:5d80:f4ba:ee3c:9546? ([2601:646:9200:4e0:5d80:f4ba:ee3c:9546])
        by smtp.gmail.com with ESMTPSA id h12sm3003882ilq.66.2020.04.03.10.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 10:21:07 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
To: bernd.bauer@gmx.at, bitbake-devel@lists.openembedded.org
References: <20200402195104.2405-1-bernd.bauer@gmx.at>
 <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
 <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
From: "Khem Raj" <raj.khem@gmail.com>
Message-ID: <d5b377f1-413b-6e50-87f3-c77e37ca9c35@gmail.com>
Date: Fri, 3 Apr 2020 10:21:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit



On 4/3/20 12:29 AM, Bernd Bauer wrote:
> Am 02.04.20 um 23:08 schrieb Richard Purdie:
>> On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
>>> If the git server needs authentication the credentials are
>>> encoded in the URL of the repositories.
>>> The credentials from the main repository are deposited in the
>>> recipe so main repository can still be cloned.
>>>
>>> But the URLs from the submodules are listed in the .gitmodules
>>> file.
>>> The submodule url is encoded with an username and a password
>>> or a bitbucket URL token. See example.
>>>
>>> The password is not stored in the ud.user but in the ud.pswd
>>> variable. So in this case the url is made up by ud.user and
>>> ud.pswd.
>>>
>>> Example:
>>> [submodule "sub1"]
>>>          path = sub1
>>>          url = https://user:password@test.org/url/to/sub1
>>>
>>> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
>>> ---
>>>   bitbake/lib/bb/fetch2/git.py | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> We have had requests for this before and we've said "no" since
>> encouraging people to put passwords in urls is bad and it leads to
>> people making accidental exposures. Its basically too risky.
>>
>> For git submodules the line becomes blurred.
>>
>> I'm open to the opinions of others but in this form the patch applies
>> to git and gitsm and that in itself makes it more risky.
>>
>> I do understand why people want this, equally it really isn't a great
>> idea in general :/.
>>
>> Cheers,
>>
>> Richard
> 
> Hi!
> 
> Of course it is not a good idea to write the credentials directly
> in the recipe or in the .gitmodules.
> Unfortunately I have no other choice than to encode the username
> and password in the URL. This GIT server only allows HTTPS with
> authentication. No SSH keys, no anonymous checkout.

perhaps you should talk to your infosec about this.
this is unusual setup, using key based authentication is far better than 
username/password mechanism. but they might have their own reasons so 
basically work out with IT and infosec to allow right kind of access 
will get a long lasting solution

> 
> But without my patch the result would be the same.
> I would have the URL with username and password in the
> recipe and also in the submodules.
> The only difference would be that I would have to define a
> task in the recipe to check out the submodules.
> So my recipe is getting complexer.
> 
> do_configure_prepend() {
>    cd ${WORKDIR}/git
>    git submodules update --init --recursive
> }
> 
>  From my point of view, my patch would be more like
> fixing a bug than an extension.

> 
> Just my two cents...
> 
> Greets Bernd
> 
> 
> 
> 
