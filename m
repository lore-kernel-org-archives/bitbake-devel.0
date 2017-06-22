Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
	by mail.openembedded.org (Postfix) with ESMTP id E265471AB9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jun 2017 22:29:52 +0000 (UTC)
Received: by mail-pg0-f65.google.com with SMTP id e187so4034650pgc.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jun 2017 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=KEpb2+KdOmYyIEWyioQGzFRkw1k7OmNGYTKaOVlJptE=;
	b=rDM2UNthqLdSUMgtyuMxNXqP6DY3qm6xUaax+6/EiDX6Chur/D2NqjtT/yAH435Fkw
	bbrBFPk/5wmcokKqahXdX7ONGFGQshqGw/aUqJDzNIHFm7nKtcOfmLiweBfEIUHKJ1uh
	VJDJ5fBPj/we3DPCBSFKCm6f0EFmNCHq4DNPFXV9ttB3DEeDVXeFy3dwMvegHbiz2mNU
	P+fQFxZTESqt+ONV9w1GEKX51OjrTDiqzobSgpm85xDSINVJAWHzGMOIdYVvC7I6hTNV
	iax65NKv3TFeYsHwcU5oHQLMKi3SVjaXEE1NrglZV/d2vMWAmnOfcTrV28Fdck40S/8s
	emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=KEpb2+KdOmYyIEWyioQGzFRkw1k7OmNGYTKaOVlJptE=;
	b=aoIeq+QoUoHW7dRx87B2VdySL5CN5vI80gB4/BjEVNEjh97ebD64i0NSMiIYKAbKl9
	Fl4sk7YO80ZBRqFw6J0iA63cNN7KXNtcm61ZUp66CqTIkdmk6t6mGf4cdKRAzwfDcir5
	ykJjDs5NvVSrKYhdI76jyyvEShfGrx5pNr2/5JL7eNFdUgagfT8cnHdXp6TAx/Lne5c4
	8sQboBKhu2jL8mRGGzgJBgSmbnuWfVAni5GCNeE6i/8vSTchOFTc50XwYPgBpQ1N+DRW
	L0kWafcKpewvEOr0Wy6jCcuKudTtD1X7sxow9J3DZqH+XafjbC3WurUIKb5vg5bysp4z
	SuMQ==
X-Gm-Message-State: AKS2vOy6k/FWxKjH0HTTzgbaaK50yg42hzTd0Jup+8Is1p1qPUoq9oHZ
	GGrCtfZp5IYdEhYRkeo=
X-Received: by 10.99.23.100 with SMTP id 36mr4975397pgx.118.1498170593815;
	Thu, 22 Jun 2017 15:29:53 -0700 (PDT)
Received: from [10.43.100.234] (50-233-148-156-static.hfc.comcastbusiness.net.
	[50.233.148.156]) by smtp.gmail.com with ESMTPSA id
	s18sm5745753pfg.44.2017.06.22.15.29.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Jun 2017 15:29:53 -0700 (PDT)
To: Matthew McClintock <msm-oss@mcclintock.net>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
	<CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <7c5e6653-c5a4-6622-b40f-58f80a238c07@gmail.com>
Date: Thu, 22 Jun 2017 15:29:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Make calc_taskhash match get_taskhash for file checksums
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 22 Jun 2017 22:29:53 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 06/22/2017 02:10 PM, Matthew McClintock wrote:
> Seeing this issue on some older (err, really olderrrr) versions of
> bitbake. How far back could we backport?
Technically 1.34, 1.32 and 1.30 (krogoth). How far back is "olderrrr' ?

- armin
>
> -M
>
> On Fri, Jun 2, 2017 at 8:02 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> The code in these two functions is meant to be equivlanet in behaviour
>> but isn't. Add in code to ensure files that don't exist are handled
>> consistently by both functions. Users did report being able to generate
>> tracebacks otherwise.
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>>   lib/bb/siggen.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
>> index 169756e..f71190a 100644
>> --- a/lib/bb/siggen.py
>> +++ b/lib/bb/siggen.py
>> @@ -667,7 +667,8 @@ def calc_taskhash(sigdata):
>>           data = data + sigdata['runtaskhashes'][dep]
>>
>>       for c in sigdata['file_checksum_values']:
>> -        data = data + c[1]
>> +        if c[1]:
>> +            data = data + c[1]
>>
>>       if 'taint' in sigdata:
>>           if 'nostamp:' in sigdata['taint']:
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


