Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id C80107C0AB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 23:04:23 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 125so4982557pgc.12
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=SqrgDndn9KH2fJLtP4uwXuJsQ67EZfqGYQxpxxxsWzE=;
	b=rB/YVE9mVjI680mL7+7ZM2BrDhEcEbGxIR+y2AbM1+Mysz8sP73fAnLnSV8T6IZ1eb
	tdAqt01eT521kfRMJS+hTQc1+/7pitqrILnymhtil9+3ijp1YU8HkqjJohoF9Gg888dB
	9Ij4dB0KKDdJSFj7igVCyGn6AU/BRYbe0JwVVSx/K6dpHuzNc2RNPPOhfejKYI4lD/M+
	AL7j7hHTCiJVasGh2cV4npCEJZhP8Zouu0GZDYHHt7/kGMWsjE/VejYcA2zb3f9rcm4a
	+vo04bTODFXkqsQ222/8xJ/BZUI0tO4rjTNlTBvSwGeP/5HVT4h/25JsAdnTINjIfIvv
	zXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=SqrgDndn9KH2fJLtP4uwXuJsQ67EZfqGYQxpxxxsWzE=;
	b=QNBJnJR7sa2IM17c02Nv+0YdTejz+KPTHDm/xG/xjiTKgihLr2aVjSlKivpK/qi0Sy
	1lzXn4ODmT4X9KFIbaQKhWHx919AcQV+fxOhMToxcPNBXAL/BV/EI67/vu7yKVPoEhZL
	kx7YeyPId9SUKIs7GPy+nCXjC1IMox2jdjRkafVqn/mTuoe+DwpUd5kOoZIv0bG+b1GF
	Bf6lBIpHvHhavh/lUyjnq2EHYZYT5s5EBkJtP7vy5cxhw3pb9nlS5PM9BjVkNloYLsOX
	G7SiwsB6g1cYI4ekYmpa7BKJOj2vxsHSgGMV3vCW0MaHrJq0UXw1fsqL5kbx/sZ6M3J/
	suGQ==
X-Gm-Message-State: APjAAAX0JaYK95ChnNBIvPtzX5C2BqEHJqOMdMzaWZ1XZn5Dt/2Zr4qn
	+RqOhfX03YkFs4hNLX2Mm/OiVIzk
X-Google-Smtp-Source: APXvYqzjcdEXa3GWSmfZjCGQb0D56uN0MFXYfnHQx92+aTThHtt0nzf1Cu8rV/LaDVq0oaZEAr802w==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr729355pfh.21.1552604664190;
	Thu, 14 Mar 2019 16:04:24 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:1c38:8eb8:1763:902b?
	([2601:202:4180:c33:1c38:8eb8:1763:902b])
	by smtp.gmail.com with ESMTPSA id
	u184sm381390pgd.13.2019.03.14.16.04.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Mar 2019 16:04:23 -0700 (PDT)
To: Scott Murray <scott.murray@konsulko.com>, akuster808 <akuster808@gmail.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
	<8edf457e-e537-9f9d-435a-e8acdcf2c3eb@gmail.com>
	<alpine.LFD.2.21.1903141125230.20874@godzilla.spiteful.org>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <4721701b-acf7-dd74-5ab6-945622c52f3f@gmail.com>
Date: Thu, 14 Mar 2019 16:04:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1903141125230.20874@godzilla.spiteful.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [1.40][PATCH 0/10] Backport gitsm fetcher fixes
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
X-List-Received-Date: Thu, 14 Mar 2019 23:04:24 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 3/14/19 8:27 AM, Scott Murray wrote:
> On Wed, 13 Mar 2019, akuster808 wrote:
>
>>
>> On 3/12/19 3:46 PM, Scott Murray wrote:
>>> Backport Mark's git submodule fetcher fixes and a related testcase
>>> change to the 1.40 branch so they can make their way into thud.  All
>>> changes cherry-picked cleanly, and bitbake-selftest passes successfully.
>>> Additional testing has been done with the Automotive Grade Linux (AGL)
>>> build, which requires these fixes to build against poky thud.
>> Seeing errors on the AB for fedora, ubuntu, centos and debian hosts.
>>
>> https://errors.yoctoproject.org/Errors/Details/232884/
>>
>> Have not triaged it yet.
> Looks like git.infradead.org was down?:
>
> fatal: unable to connect to git.infradead.org:
> git.infradead.org[0: 2607:7c80:54:e::133]: errno=Connection refused
> git.infradead.org[1: 198.137.202.133]: errno=Connection refused
>
> I can clone mtd-utils here without issue ATM, so perhaps something
> intermittent.
most likely.. After I sent the message I saw the same failures across
all the branches. I am rerunning the builds now.

- armin
>
> Scott


