Return-Path: <jpuhlman@mvista.com>
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
	[209.85.167.176])
	by mail.openembedded.org (Postfix) with ESMTP id A0A1E7F27B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 23:12:20 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id i16so3626974oie.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=Q242mLsL5RgXQBFk5fRgH05JWl4TFI/ZqnMwPMwXgik=;
	b=L+cmunKr4TuRra47cPCqKAkvD8oYACW4Mik5oaMiTa56SRmV7JYdoZ41k5GQeC934D
	32W7SK5yvBzCsWfsnDyhjPYnaV9Y/fvXZEsLKfxMiFXbtFvg57EvNuUVULI37GeoEKX+
	VHSFQJFQo+gh2l3B8uxVnQozlYuQtBNlARkb3akTiAwVhS7RAHBi/y/UyMIbdZDD7FCC
	dliitx2AEGcbliuCupIV0ENczQDOLNsiJF6c/7L90K+KcsP/yXYNkPoOxZeGLntHVi12
	oKYz90FaSQ3yZwYJi2KHw7unAUobWgpkBVgZanivlVkVD5LdIdSbmXjAjXvLL1jtjpOq
	4MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Q242mLsL5RgXQBFk5fRgH05JWl4TFI/ZqnMwPMwXgik=;
	b=c+H2Mw2r8pQXrVEFdS+WXqmhbMqnZcFTVX0a2TrwKI9oEkpBq1gT0H26BC1R92zeCI
	oDUAqB5zklnhdBlInn83K6Z3wdC3Dhgsnj/2mXrvi0X/ExRcqqWGg/lLabYGQsBAKLHt
	yvJKup2TkSOWji3l6mciTNhrgnOedSBmPxY4w+U5MJAyhqgf7R8EbFQmt6tdViv+l7Bc
	WxWnteRBQKMcBV7eQwUzxbOcZWULrvMQrxbUlx3ZsZysyM+QPCpSShMqqeD2WgwG9bNx
	wGvGUEksn1FRz7zNFbXIY0w4p/ESNuhROp2OfDQaysLSd0kCnRF63bBSZQOXPLQrWlLt
	OeOQ==
X-Gm-Message-State: APjAAAV0Kr2VG96TwncIz7qRn9S4HOFtFfSoHBMVY8y6QDmjR7ii/5RG
	IPrXFSe3a2QWycgte2V2hki+OQ==
X-Google-Smtp-Source: APXvYqwgLMe9aFuXc6rRKjC6JaD9NVSy+F2PAiMLSZLzYoGH2Z8oalJrDgsaHlRNa/omML2o2mhIPQ==
X-Received: by 2002:aca:aa56:: with SMTP id t83mr4718453oie.178.1569539541510; 
	Thu, 26 Sep 2019 16:12:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:4c90:60a0:8460:5454:270e:1a37?
	([2600:1700:4c90:60a0:8460:5454:270e:1a37])
	by smtp.gmail.com with ESMTPSA id n17sm290514otk.5.2019.09.26.16.12.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 16:12:20 -0700 (PDT)
To: Mark Hatle <mark.hatle@kernel.crashing.org>,
	bitbake-devel@lists.openembedded.org, grzegorz.heldt@gmail.com
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
	<d6a33b15-e28a-b2b8-3359-8c4b38afe5eb@mvista.com>
	<9022a7bc-7f91-dddb-5bfc-530b42a2d1bf@kernel.crashing.org>
From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>
Message-ID: <625be95c-9f8f-adcc-2c27-179733423b59@mvista.com>
Date: Thu, 26 Sep 2019 16:12:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9022a7bc-7f91-dddb-5bfc-530b42a2d1bf@kernel.crashing.org>
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Thu, 26 Sep 2019 23:12:20 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


>> This is what you get on thud.
>>
>> [cluge@jptest01 build]$ bitbake-layers add-layer ../meta-openembedded/meta-python/
>> NOTE: Starting bitbake server...
>> [cluge@jptest01 build]$ bitbake-layers add-layer ../meta-openembedded/meta-oe/
>> NOTE: Starting bitbake server...
> Ya, the dredded circular dependency.  I thought you could add them both at the
> same time to resolve this.  (You can via the layer index mechanism at least..)
> I believe the circular dependency has been resolved in master.)
>
> --Mark

I haven't looked at warrior, but thud its not circular at least when it 
comes to layer depends(yeah it think
there is meta-oe content that can depend on meta-python). If you reverse 
the two, it works just fine.

-- 
Jeremy A. Puhlman
jpuhlman@mvista.com


