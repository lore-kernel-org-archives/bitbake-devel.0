Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54436C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 14:13:17 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.16607.1739369588961347375
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 06:13:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UZZPZN46;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7c501bbecso525783066b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739369587; x=1739974387; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQU+288weypstltfC4tTto6CNwLvru50wMV2X7BRw7I=;
        b=UZZPZN46hwkXpKRTB/i+oCvHMNVKsIf3hh7FzB3vjJiQWTk8PluKwwBGfraOOKvcPZ
         +WUv4k9cjGVw0a6wygu00/trOFtWmHW5bKFFhXsx3uJo+lR0ZbGU5QGWL/9MgI3Z77Mn
         IsOaCIKEXV6C+k6y+P0a8W9Sa9mh1TRsWayM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369587; x=1739974387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQU+288weypstltfC4tTto6CNwLvru50wMV2X7BRw7I=;
        b=BUTgSL2Q0s4K/Zk+PdT0953GbS5JdCWTrVmWMr3+VpBLy6DUc08fXFQKetyeM/ZRx+
         9kGinQ7eVKu2LY2hqfYzfxDa4Vw/MMLmVJIweFi0KUIFuGn2xkhVRuHcssuhhUX6OLqZ
         Hsl4XX1vNv8l9sTHU1qWqXNZ1tj9TrUawk4eA4XKKFRq6jBQ8OH8RrsQCw5cYyw20BNx
         aP+/x4opa4VN1tDjVwTQsY6A2j4+3Iy/oZYMw7Ccy5NZ3LgngIdQiXUxBvt45bMw8PUo
         E0epYuZuApA1XGCz2vK6Moo4DpkPd1D3bITT4FW3LHekV3L1re7hLXlXYB+oGH+J2TPo
         MGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPfbCtG13s3CnZLKVVsmIsmlbF78sAzAobqY052+6YBBD+2g1N3IQOU7OOpLhLDQj9o+Te7BH/3qiNgFqv@lists.openembedded.org
X-Gm-Message-State: AOJu0YwYrJ3g9ZYr3T8VX3Rqs+j4XUthVUJb74gIwSog93Xv8O4Y5ftf
	zxoS/pa5OFhKHjcbi3xHYoNESz5Z+Xwcpap3qiH9RxCDJp0gjywXrwDts+qhRnU=
X-Gm-Gg: ASbGncuc0/QxMs78bNS6/VNomvL6uKnzsb79axNlqGBSXcg7q9nsdB64VZcuVQPgdt8
	9tSPLu45KDQ0nqsVQF1LzognKRsVPjEblCIwmtFdoPB3MpwH/P6wN+W8m2ItHj2Tlr9+2McypjJ
	J0jbjPeNNg0xEnAnTZgoK9zKxVtKta/b2s+x7aXiGOOJdcdfpp9UxwtW2sAToLSDvwBxd1emzsE
	AWft6TVQRb5+UZ0i9qOg14clADFTtF1GZmYdtqziaddmRmuf5Qi/E6kuY5cL+Jyzic9M/gSq3h1
	XB3vXwNgfGvR9RYgCsi+vg1nYpRj9pu5smwUlgIbR3ymEW2fB9/0U7wN1kepOqZQX2wlAx311aw
	bZw==
X-Google-Smtp-Source: AGHT+IFlc32hVjRmu6wZNZufy8wft78kGzbmiXjZHIVtlJoi4+5g2Xjw1rbM58AGOZ6UCeHeiHp2Pw==
X-Received: by 2002:a17:907:d8c:b0:ab7:d735:18c5 with SMTP id a640c23a62f3a-ab7f3344fecmr309985366b.4.1739369587189;
        Wed, 12 Feb 2025 06:13:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:af16:73ba:601:d9ae? ([2001:8b0:aba:5f3c:af16:73ba:601:d9ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ca66cc36sm534816066b.155.2025.02.12.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:13:06 -0800 (PST)
Message-ID: <1f5455e336cd35e8ffadcad1abd1b0daf782764e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: data_smart: fix ??=
 operator for getVarFlags
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: louis.rannou@syslinbit.com, bitbake-devel@lists.openembedded.org
Cc: louis.rannou@non.se.com, pascal.eberhard@se.com, yoann.congal@smile.fr
Date: Wed, 12 Feb 2025 14:13:05 +0000
In-Reply-To: <20250212-varflags-v1-1-3a756c7aa95c@syslinbit.com>
References: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
	 <20250212-varflags-v1-1-3a756c7aa95c@syslinbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 14:13:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17207

T24gV2VkLCAyMDI1LTAyLTEyIGF0IDEzOjE2ICswMTAwLCBMb3VpcyBSYW5ub3UgdmlhIGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6Cj4gRnJvbTogTG91aXMgUmFubm91IDxsb3Vpcy5yYW5u
b3VAbm9uLnNlLmNvbT4KPiAKPiBWYXJpYWJsZSBmbGFncyBoYXZlIGJlZW4gZml4ZWQgaW4gY29t
bWl0Cj4gMDMyOWE3ZTNhYzY5NDczN2YyZDJjMTg2MWY2NTQ5MjU1MTM2MDY2MyB3aGljaCBpbnRy
b2R1Y2VzIHRoZQo+ICJfZGVmYXVsdHZhbF9mbGFnXyIgcHJlZml4IGZvciBkZWZhdWx0IHZhbHVl
cy4gVGhpcyBtdXN0IG5vdCBiZSBpZ25vcmVkIGFzCj4gb3RoZXJzICJfIi1wcmVmaXhlZCBmbGFn
cyBuYW1lcy4KPiAKPiBTcGxpdCB0aGUgcHJvY2Vzc2luZyBvZiBkZWZhdWx0IHZhbHVlcyB0byBi
ZSBzdXJlIHRoZXkgYXJlIG92ZXJ3cml0dGVkIGJ5IHRoZQo+IG90aGVycyBvcGVyYXRvcnMgZGlz
cmVnYXJkaW5nIG9mIHRoZWlyIG9yZGVyLgo+IAo+IEZpeGVzIFtZT0NUTyAjMTU2ODVdCj4gCj4g
U2lnbmVkLW9mZi1ieTogTG91aXMgUmFubm91IDxsb3Vpcy5yYW5ub3VAbm9uLnNlLmNvbT4KPiAt
LS0KPiDCoGxpYi9iYi9kYXRhX3NtYXJ0LnB5IHwgMTYgKysrKysrKysrKysrKy0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2xpYi9iYi9kYXRhX3NtYXJ0LnB5IGIvbGliL2JiL2RhdGFfc21hcnQucHkKPiBpbmRl
eCA4OTdjZWViMzJjN2NlMGFjYjhlZDQ0YzI1ZTFiZjJmMmYyOGFhOWRjLi43NjYzZjI4YzUwNzFh
NzdjODQ1MmMxMDE2ZTVlZTBkOTY5Yzg0YmVjIDEwMDY0NAo+IC0tLSBhL2xpYi9iYi9kYXRhX3Nt
YXJ0LnB5Cj4gKysrIGIvbGliL2JiL2RhdGFfc21hcnQucHkKPiBAQCAtOTUyLDEyICs5NTIsMjIg
QEAgY2xhc3MgRGF0YVNtYXJ0KE11dGFibGVNYXBwaW5nKToKPiDCoMKgwqDCoCBkZWYgZ2V0VmFy
RmxhZ3Moc2VsZiwgdmFyLCBleHBhbmQgPSBGYWxzZSwgaW50ZXJuYWxmbGFncz1GYWxzZSk6Cj4g
wqDCoMKgwqDCoMKgwqDCoCBsb2NhbF92YXIgPSBzZWxmLl9maW5kVmFyKHZhcikKPiDCoMKgwqDC
oMKgwqDCoMKgIGZsYWdzID0ge30KPiArwqDCoMKgwqDCoMKgwqAgZmxhZ3Nfc2V0ID0ge30KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgbG9jYWxfdmFyOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZvciBpIGluIGxvY2FsX3ZhcjoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIGkuc3RhcnRzd2l0aCgoIl8iLCAiOiIpKSBhbmQgbm90IGludGVybmFsZmxhZ3M6Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGksIHZhbCBpbiBsb2NhbF92YXIuaXRlbXMoKToKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGkuc3RhcnRzd2l0aCgiX2RlZmF1bHR2
YWxfZmxhZ18iKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSA9
IGlbbGVuKCJfZGVmYXVsdHZhbF9mbGFnXyIpOl0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZmxhZ3NbaV0gPSB2YWwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVsaWYgaS5zdGFydHN3aXRoKCgiXyIsICI6IikpIGFuZCBub3QgaW50ZXJuYWxmbGFn
czoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFnc1tpXSA9IGxvY2FsX3ZhcltpXQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZToKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3Nfc2V0W2ldID0gdmFsCj4gKwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICMgRmxhZ3Mgc2V0cyB0YWtlIG92ZXIgZGVmYXVsdHMKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmbGFncy51cGRhdGUoZmxhZ3Nfc2V0KQo+ICsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmb3IgaSBpbiBmbGFnczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiBleHBhbmQgYW5kIGkgaW4gZXhwYW5kOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3NbaV0gPSBzZWxmLmV4cGFuZChmbGFnc1tpXSwgdmFy
ICsgIlsiICsgaSArICJdIikKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIGxlbihmbGFncykgPT0gMDoK
CkkgZGlkIHNwZW5kIG1vcmUgdGltZSBsb29raW5nIGF0IHRoaXMgYW5kIEkgaGFkIG1pc3VuZGVy
c3Rvb2QgdGhlCnByb2JsZW0uIEkgdGhpbmsgdGhpcyBjYW4gc3RpbGwgYmUgc2ltcGxpZmllZCB0
aG91Z2ggYW5kIEkgYWxzbyBzdXNwZWN0CnRoZSBpbnRlcm5hbGZsYWdzIGhhbmRsaW5nIGFib3Zl
IGlzbid0IGNvcnJlY3QuIElmIGludGVybmFsZmxhZ3MgaXMKc2V0LCBJIHRoaW5rIGl0IHByb2Jh
Ymx5IHNob3VsZCByZXR1cm4gX2RlZmF1bHR2YWxfZmxhZ18gdmFsdWVzCnVuY2hhbmdlZC4gVGhl
IGNvZGUgd291bGQgdGhlcmVmb3JlIGxvb2sgbW9yZSBsaWtlOgoKCmZvciBpLCB2YWwgaW4gbG9j
YWxfdmFyLml0ZW1zKCk6CiAgICBpZiBpLnN0YXJ0c3dpdGgoIl9kZWZhdWx0dmFsX2ZsYWdfIikg
YW5kIG5vdCBpbnRlcm5hbGZsYWdzOgogICAgICAgIGkgPSBpW2xlbigiX2RlZmF1bHR2YWxfZmxh
Z18iKTpdCiAgICAgICAgaWYgaSBub3QgaW4gbG9jYWxfdmFyOgogICAgICAgICAgICBmbGFnc1tp
XSA9IHZhbAogICAgZWxpZiBpLnN0YXJ0c3dpdGgoKCJfIiwgIjoiKSkgYW5kIG5vdCBpbnRlcm5h
bGZsYWdzOgogICAgICAgIGNvbnRpbnVlCiAgICBlbHNlOgogICAgICAgIGZsYWdzX3NldFtpXSA9
IHZhbAoKSSdkIGFsc28gYWRkIGEgY29tbWVudCB0byB0aGUgdGVzdCBjYXNlIGV4cGxhaW5pbmcg
dGhhdCB3ZSdyZSB0ZXN0aW5nCndlYWsgZGVmYXVsdCBtYWtlIGl0IHRvIHRoZSBnZXRWYXJGbGFn
cyBvdXRwdXQuCgpDaGVlcnMsCgpSaWNoYXJkCg==


