Return-Path: <jonas.gorski@bisdn.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72CC4707C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 09:07:02 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.3566.1705050415566930923
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 01:06:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bisdn-de.20230601.gappssmtp.com header.s=20230601 header.b=3KqANZup;
 spf=none, err=SPF record not found (domain: bisdn.de, ip: 209.85.128.51, mailfrom: jonas.gorski@bisdn.de)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e67e90d5aso1297255e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 01:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1705050413; x=1705655213; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nWpbkUc1tKYlPaeqP5PSkZzXeHGFw3K7ZCf5N1yDLU=;
        b=3KqANZuppEiZIfDIJJHm5cHIq+3/salO1nl0I8cfZTY94sumrkgMBBx3AIGBWPm0AJ
         6o32Bnaucstuf1b5LLC0IJ9UGbOZJsaWCGh9/XarHUalaORqaVgsMSjNvGeXgdy9KpUj
         AvKtjFVDB22oWw7tCrYPZBQdU+7WOBKUs5yAmOooRa2yT9verB5WusRa5XfIlZYJzRc+
         HU3vDxg+OZZMZVQHqorohPKDEhYp2mTtbVw5/DXCC80K9ZuIcoID/+wx3AUxUphXy7HX
         6HMv+UmYZy0aLg1EaYyYc+O5wRfmYxOaj14+7th6ccyt7VjZGPp5gOk327ubwsUJ74uD
         zTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050413; x=1705655213;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nWpbkUc1tKYlPaeqP5PSkZzXeHGFw3K7ZCf5N1yDLU=;
        b=OlNi6clq5h+wdRwh7oOXZisILaZ17RoKhH2BmaXLN1CO3w1ZzrmaWzJa1UsEON5wkK
         szlTN1mipw0uzCgyZNcYkwwHvI2L9jShwl+zfKYHQYMUsFkOFiX2y6Nob34KOEx+zTxb
         D1hpKnaUbzYVmxY9Xk+t2//BtjHie8/mKKNJYbj1fZb0CVL2DbjgpfmamHavCBco1Xtn
         fCqKO7es7sk4m2063PvDB7/zRUDrobPgTuUZ7FS0YYrkWNcxpnhczMtuKBSlEdSxobq0
         uAKy8RlOekTJfbbZxdQXKK65V49PPT0bkmXwWBfYYFPAvQOZ9sFdvIEHs2O1mvP/Ywif
         lo0w==
X-Gm-Message-State: AOJu0YyfPw+RsaTW+PxFTS8k8eM1FQ/RcicFaQ4whc3iHwTjwBAluek2
	Dxvo71Y1SkDqbSv35isIcVJvemZpSr3rBelTYAY+m+xYa0DEWLS6iu6y18lF96UO4ma8/ZINSHf
	g2mO/f9jUcQjBx/0QrivbMD1FsR8P85/s2dHq
X-Google-Smtp-Source: AGHT+IH64gVaEVD/Yu5Xnp6AlnTTt6E/YFkTS+Edkyc81LUrqEdupj+FetFPJbawGm60yo1hFHF6uQ==
X-Received: by 2002:a05:600c:3b06:b0:40e:4a7b:f5df with SMTP id m6-20020a05600c3b0600b0040e4a7bf5dfmr654695wms.127.1705050413057;
        Fri, 12 Jan 2024 01:06:53 -0800 (PST)
Received: from [192.168.0.240] (dslb-002-205-020-122.002.205.pools.vodafone-ip.de. [2.205.20.122])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040d62f89381sm4983218wmn.35.2024.01.12.01.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:06:52 -0800 (PST)
Message-ID: <23674239-587b-4798-a489-5879ad273df0@bisdn.de>
Date: Fri, 12 Jan 2024 10:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] runqueue: Fix runall all bug
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20240111172806.3311690-1-richard.purdie@linuxfoundation.org>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Autocrypt: addr=jonas.gorski@bisdn.de; keydata=
 xjMEXa6zBhYJKwYBBAHaRw8BAQdAGGcVHNgZDLgv7j4XQeUeHkx441k6vnULvoShtTAtM+fN
 JEpvbmFzIEdvcnNraSA8am9uYXMuZ29yc2tpQGJpc2RuLmRlPsKWBBMWCAA+FiEEzts6HPAQ
 45w4GxfO03QS4qWx5yAFAl2uswYCGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AA
 CgkQ03QS4qWx5yDB2wD/Q9L+9m06zcayLrxm0fxiLAu38LH2bfZwB9UAbmIxUtIBAIlGEw3W
 XbXS45m+XSJKA6pI47i8kbo5AXRUCDZ3EggPzjgEXa6zBhIKKwYBBAGXVQEFAQEHQOdPH4Aq
 NkDaYontQWzEJs7R592IClXKwPSjWE13fXoeAwEIB8J+BBgWCAAmFiEEzts6HPAQ45w4GxfO
 03QS4qWx5yAFAl2uswYCGwwFCQlmAYAACgkQ03QS4qWx5yClLwEA84GFaTI0Wv36UnVzDyyt
 UylN7Llrj+lxjVCL0r9+L5QBANfiVuc3h2jZmiqHvKWI/BOsEFA3SoxUvaOeS18rvXgC
In-Reply-To: <20240111172806.3311690-1-richard.purdie@linuxfoundation.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 09:07:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15784

On 11.01.24 18:28, Richard Purdie wrote:
> Where chains of RDEPENDS are multiple levels deep, the runall code was no=
t
> accounting for this and recursing deeply enough to gather all dependencie=
s.
>=20
> Fix this by iterating over the result until no more dependencies are foun=
d.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Can confirm this fixes my issue with deep RDEPENDS chains.

So in case you care about that, have a

Tested-by: Jonas Gorski <jonas.gorski@bisdn.de>

and since it was me on IRC as well a

Reported-by: Jonas Gorski <jonas.gorski@bisdn.de>

Thanks for the quick fix!

Best regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


