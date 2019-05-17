Return-Path: <akuster@mvista.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id 3E5287DD81
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:32:46 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id a3so3479453pgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Bn28nv9da35jnCZ3q0cWWMe+QY+v+npxBLrC5XDB//8=;
	b=xRqJlZ7gQAkEuPplG2wj6w1eDf+LEAEBsM1CuO+tUlCt/by6fem68iDrC0ymKgBEl4
	uC2MytvFzVQJ9azbSZCTkcsYuGNkAcl7tehPlQlK/mj4pLiSaT8LAH670paql2wmoqeD
	5HL0QBAJl3nkU711V/c+dt3kBNGJbzuXiWLZLTDcDfx8WRnff2gr62d8CjUK/0pXMwJS
	nWyzDFnTG4Kb/qh+ynHG4l5pCRxvmG2O5AO8jrlQkWQHRbnkf5qXylyc94I+Tdbedlyl
	x6tog+UHLktLmQduKgYLpY1bdc8/eCRS+fBnzdehAVSLFIIXaUbFHAqkFzZdNRWgSOM+
	/X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=Bn28nv9da35jnCZ3q0cWWMe+QY+v+npxBLrC5XDB//8=;
	b=oNSup4qvzrULhWDi1d9ZzPX4XwoaZkEKmBkkJA9YiBgWsI8MZYHSl6jO4ijTPiKEKr
	5ntjdjRHmTGLymrLKXsmhNEUUQzbBjdF99KDVykuGMn8aUgIE/WLjRsu8Fl6LA11Zzoc
	L5z/lia11vuLUe7v3P76R5SX2qxlrup8O/xp4NjOjnM/XuEf+SPNnLFOthjUr5Ps27yK
	LmMogjzQqqM+/0VaQT7BUD+sHLYgs6z3xkocWqRRj4+BGX9WlbDy9xLsR0OmAopYu/rp
	ZPoKp+3R0LNJXS94SsNiKgC6RiqbnaFI/JyR9EwEcFQ+XoIETCPEEF4fhbzaGd5o306E
	8QQw==
X-Gm-Message-State: APjAAAWOnJktJcA3GNxN5L7v4VlPGqqxk8eBDEcfDacPyeLl3iu1IGVm
	c+Jf5MYQ6PheGjdxCR7JdRq/Jh38Tao=
X-Google-Smtp-Source: APXvYqyJtF0B1GalXKSX9BTUiuG35Enjic3xLqPX/L0KujVDMhuzHtZ/9yE3KwaQwvtDfO1ztLNz7Q==
X-Received: by 2002:a65:6656:: with SMTP id z22mr57221423pgv.333.1558107166832;
	Fri, 17 May 2019 08:32:46 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:3826:f17b:9bfa:3b9?
	([2601:202:4180:c33:3826:f17b:9bfa:3b9])
	by smtp.gmail.com with ESMTPSA id
	a64sm9847053pgc.53.2019.05.17.08.32.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 08:32:45 -0700 (PDT)
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>,
	bitbake-devel@lists.openembedded.org
References: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <7ae99b0a-258f-9f52-265a-a9b2de251774@mvista.com>
Date: Fri, 17 May 2019 08:32:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
Subject: Re: [PATCH 0/4] NPM fixes
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
X-List-Received-Date: Fri, 17 May 2019 15:32:46 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 5/17/19 8:14 AM, Jean-Marie LEMETAYER wrote:
> Hi folks,
>
> I have recently integrated a nodejs server with an angular application using
> poky and meta-openembedded (thud branch). Some fixes were needed to make it
> work.

Is this fixing YP bug:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13344 ?

- armin
> Best regards,
> Jean-Marie
>
> Jean-Marie LEMETAYER (4):
>   bitbake: fetch2/npm: fix npw view parsing
>   npm: get npm package name from npm pack
>   npm: fix node and npm default directory conflict
>   npm: remove some temporary build files
>
>  bitbake/lib/bb/fetch2/npm.py | 19 +++++--------------
>  meta/classes/npm.bbclass     | 11 +++++++----
>  2 files changed, 12 insertions(+), 18 deletions(-)
>
> --
> 2.20.1
>


