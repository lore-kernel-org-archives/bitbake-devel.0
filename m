Return-Path: <pascal.huerst@gmail.com>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id B0B2E7FC0B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2020 15:14:40 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id p9so15322314wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2020 07:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lUIb86gEkSR7IJZvIGI0SVNUWP6ER8mPWpnn7yoAvic=;
	b=YZ3+R7RoLpFv6p7O+BUUGCfsrwCfok7EIDPDMwHZyISD7dunqjbakLbLY01fT45xyw
	Gx5Hj977UXyQXnf5GORYq6Iv3SSpu08RqwKwl0QwJXbeLBfN4dnE0BcbcyzdK8a5HJBu
	wpzrVuO1Uj/f7EOcxgPDzcZD+/4ueB0h2vlpw32BVc7dU6F62ghC6hgMquLBj4o4N1iJ
	P2m/QSb9teJhLBMwgdiK03uvpzwXnvhfV116U76Lqbr62mIPykl3wrHBVA6SZerBglMJ
	wliuYYwZ2XNl4rcb/vvVKluctyZteFOSjCMHF0JJH3MBR+upk6CZReKtxgjkmxhnqAXO
	56pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:cc:references:from:autocrypt:subject
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=lUIb86gEkSR7IJZvIGI0SVNUWP6ER8mPWpnn7yoAvic=;
	b=AaYNIh+o7tg9tslnyWpwFh0fvVC9T8qkA00JcngBYI0f6nd3/TZ/ATQ1UtY7mz6F0t
	mQK1slpnxDX8JUcMtgrtkBQkn4yNvL0D13t5YolTyFBXQ2vrGo2KZ4TelYxp/bQJIt2O
	tSBbB7vRStTqSuz7+f2ond9RV4KJfAplL0JIpztRCbQKYwsZFk39g0eIv68kprzUeETw
	2JC9DLDLR0RRlEaDBSwLqx5EldjMkazuq82MTv1HUKpuhm5Jyx24SUn83BhqeaIMmrbQ
	RZnn/o/pjt9Ny8GUuguNE8qNJgcVK6AG09QIzPUFFTPc9IfVerm48rVk7E80y7qtM1Rf
	/y7g==
X-Gm-Message-State: APjAAAW4DybkS1wOfnVRp9VEaD+s0Pnm3y2bjUoOUmqF9G6Vl+ohqqhM
	UISvLPzuLYZRsMjoQJsjgbpvWUIO
X-Google-Smtp-Source: APXvYqwKdV4jgRwQ80yuSL9YIfm6zPo1EnpRKGHkBzSSa5EBIv7eQ+atu3fcw7rAkV0HBMYveHZ8UQ==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr33172285wmi.166.1578323681047;
	Mon, 06 Jan 2020 07:14:41 -0800 (PST)
Received: from [10.10.223.137] ([194.162.236.226])
	by smtp.googlemail.com with ESMTPSA id
	b68sm23095018wme.6.2020.01.06.07.14.39
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Mon, 06 Jan 2020 07:14:40 -0800 (PST)
To: Rich Persaud <persaur@gmail.com>
References: <20191204091540.28005-1-pascal.huerst@gmail.com>
	<53A94A50-42DF-469F-8372-62BF68789262@gmail.com>
From: Pascal Huerst <pascal.huerst@gmail.com>
Autocrypt: addr=pascal.huerst@gmail.com; prefer-encrypt=mutual; keydata=
	mQINBFs8fy0BEACvfZUsC0q+fvzD/js7ZegK9Jz3Y7AD2DGcn3x1oha6R5BUrHvCZ22Mo6dh
	7vI/2nyS6gr5QD8WNrlzy2QhGRUR1r5VeknyD1hpKNqCHgJECWvnHFu5UZWm/8hT6fxIgob9
	fmio9+xZGyWGt747Gh6iJN9++8X2Phwxd7G02lQaRrLPYc2huHQNRWIn/lIzzE9Ma1iBqcvk
	GD0QONOi3fqSlQ9kD85RbQmS9BGqy+rp860ao7zsSqr+SAp7OK6JWTeu9Yxfo022rcTX1cfk
	OTLNoka2+2d1EkcYHfCpD9H524SU5t3eluT+/9RGj4KzdIZahu5j7ZeEKfL+yvh8r/5Dl1FX
	gM0bN2ReDtarJcul5eGqbyYKR3me8gTwz0ZRuiFmEoBS56KucI2ceEb1+YS+2+ED+U6dxXOF
	SJn62kIxknRmKKmu46zURtwFXBiWax5nEUHeItMfk1xJJVdA/Nw2YPXLUg7/Sgntr6GX4O+x
	RdLQOkSkzu49EGoaqb91D84kKwEjDfFM+KWVLspSj35SGKprfuKIwMW8f+etY/KdpRci2Xft
	vAPLATQ/a2w+kMp21+z72sZR9uqUkC95n2N/RIDH5thmdaoQl2WozdfYQR2k354FyQLonb+x
	irMuq+FxTisWIoaWQkp3IFLjwoZYidS7uAa3zv060pjhg90+ywARAQABtCdQYXNjYWwgSHVl
	cnN0IDxwYXNjYWwuaHVlcnN0QGdtYWlsLmNvbT6JAk4EEwEIADgWIQTBSyGs03ODQs/SXgL7
	4dGsVQWa3gUCWzx/LQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD74dGsVQWa3jAc
	D/45pZ1HBGVm38/U7MlZOdOGBeKydcF9iAs892XPjsxU5RR9pLw/aM/5Roh6I/NzqZRYmuNw
	cfrcUXmWskjnF8hWFgpvt6Cl12l3qhCBvotsCdB2rNfmdMGYth3teZ3T8TLD0ttXqhlgVc0m
	dccxTWjv92kdjux/s+lnp6ZgRUYdQBJCTZpdHo51M81DLQ6/KGYf9hn+hOzAbrNKeY57+5UL
	0v/byjqZ3TKHcsrlt+7MOtxBuRaXd9iWUzxhzWT/tw18DmHH82JtAABSPC6WLO1l98iZmzk8
	neDcwOR572yzq2Ryyr2xtLJCMOVt6rNnQuzJ9SBt/j6+OfLC0/zm3NS7GA/hKHT30KKlq2/r
	bbOfegWY+9qlHKS3GRhzEhTiMJ+1+QwtygqBSA9dDLGJ73AVlumZ8UeH2WGp5i/MtTSpfhwD
	34RUor5p6jduBKkzaU21pgqR0qOj/I6WOzot0XEaGMc9bUx27KOVdAazl0NzIwlhkGQToLT3
	TAZ2FsuGbOrzYIB1xwe4ncw+NwKwSHEV5gl12c2POxSmw26rY5VmGWRO+uXYMihe35LS8GHf
	2cTbOqx00nrQ/zTVTjUVSgVszK7u2N9Rdl3WhHRrqhK6Yulo7o8OKmy4XNfcwScoJaTIh2Il
	vEWKR95rCP6Jnjex3m+FhZnazbVsWrWND+C7oLkCDQRbPH8tARAAtr2LfVmnDksqMzKNXeqs
	FitOfBzYHUtoWfoW04F88T4ZU4cOPNbBs6v+MGDpqozpVCqTvEtJKRkgNWqDeTY5J0Oy4N1m
	OW+Pl6ayL7YzLAhVi3smMDzsZIWNfheER2To9+7z6JRUBl8c0eoyy3D46/+3eIfUHfjmKxdN
	Nifo5Kt8cGsmNJPQpv7Q+tnxr42L3ttSCPdp8j8A3QNS2do8ZsfqfOCZpjHlRHMr36tG3bad
	TFNqSZILc7uzdON5OKkpNRvud80J77gSudRJ2NsxKmosoIbXCNLheSv3uMUiNznAWD5T3Ev0
	wlccAe3nGnz4yBqyZSV+Bdd013B45/GxSRiCe90tCduuNeLtMMns3MSEzHGY6IstYudVratF
	eVprCYpPT/gjDzoImW4fe7i/ZDrl3z4DQpiEv/fDGCFYvzbJa5GNLNHpOeehZ4OcxH91iwBW
	Zt7AiNWyXrYzqERTg9F6+bJxHSB06ue1/GcApbl3FKk7wyjC8+wFW+nD4wv48EL6VPli7dhi
	s03LrGWPQNtdqJyK6tSuxDyYjDkk5VTNurCo7pHY4YwRxpiuQasnd/HnKvqpgOqtN9sPlfLk
	OUj10+XrGXXOK/5P/wrj1BsFWrdzSFIKPP2lxvjbLHulZ6vLfjh16KrTThKatze1WLLsP2pv
	cBZ0bbHR84u1nDUAEQEAAYkCNgQYAQgAIBYhBMFLIazTc4NCz9JeAvvh0axVBZreBQJbPH8t
	AhsMAAoJEPvh0axVBZrePDsP/3QQ03Cb20esSnTcCwsjZYFErgi5XKzj8kJRevgpP/wr0Oko
	p5ILKMPDAobPrCWO6hU3tqjio14TeatrUZ1tc2a1s1XJsx0bbXbvMHe36l+Jv7nlOQ1tFmLB
	M78Bo1z1B/pQ+I3P3hRXNGWUbwMAx2kbkWCOZ7NsWuOW1Riy+/3hMN5Nr319gFlYYsGWgd5N
	N9fuTlswmayG9uuvnBnQjRtvbWAxssIthWMIrwOU9IDhuRFlH7MW6GFrcP+3uoM1rK+B2MW4
	y7/M7lr46gpgup9zUb+pEYoaITOk6g4PQpq/B+ZfHats3PSmIirUzswAdCix67rcONMp1rG3
	/xHgeZeQnFLSGjIrn0zjWG+2jmWszoHueRWzfEPbiNyLLqNcxDmX1xesgDlEDly/d0yCvSjP
	+Nd/QQht0mP9AVypwoC+G6fYQrMZO3Es7t/8v6piKUUSquApd4EbULTyaHOHmWT63SHEfoKi
	43tC1odRSzMCAvpFBJyTQbkFnfpomnnHJ2Ij0GStuedvzkeSwo9/oK5bj8Q0+iMfnXXtemCr
	6aZvVuipHYT+QdVX20xm/1N1mLfIhYAWh2dz8bT2h+Ndd7I4qu39qWJLj9jcK6r0HzJlb6M+
	XdhezFFtSzjr5L8T7GcwbdXs2jcCz8xmdafBhFZxzFE/jbOAObiRemKqL91p
Message-ID: <ec84fd38-c014-0014-2dbb-b3bb06364ce1@gmail.com>
Date: Mon, 6 Jan 2020 16:14:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <53A94A50-42DF-469F-8372-62BF68789262@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v1] bitbake: fetch2/git: add SRC_URI option versiontag
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
X-List-Received-Date: Mon, 06 Jan 2020 15:14:41 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hey Rich,

On 29/12/2019 03:04, Rich Persaud wrote:
> On Dec 4, 2019, at 04:16, pascal.huerst@gmail.com wrote:
>>
>> ﻿From: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> Use latest_versionstring() to find the latest tagged release for use with
>> AUTOREV. This can be useful, if you want to build the latest tagged
>> release
>> instead of a branch. UPSTREAM_CHECK_GITTAGREGEX can be used to specify a
>> version format.
> 
> Have you seen this approach?
> https://code.ossystems.com.br/gitweb?p=meta-ossystems-base.git;a=blob;f=classes/ossystems-srcrev-handler.bbclass

Thanks for the hint, this goes into the right direction, but does not
solve my problem.

> For development workflows, it would be useful to override a
> recipe-specific branch/tag via bitbake CLI.  For production/stable
> release workflows, it would be useful to override a layer-specific
> branch/tag via bitbake CLI, which could be propagated to all recipes
> within the layer.   This would help when maintaining multiple versions
> of a layer, corresponding to multiple OE versions.

That's exactly how we manage our development releases, but what I wanted
to achieve with this patch is to just tag releases in our repositories
and let bitbake figure out the latest releases to create an image from
it. That way we don't have to fiddle around with bitbake CLI or yocto at
all, but can just tag releases in our repositories.

I find that quite useful, but the interest has been near zero for that
patch and I'm not sure, whether this is such an exotic use-case or if
there are quality issues with my patch...?

Thanks,
Pascal

