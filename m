Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B2C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 14:00:57 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.16357.1739368850309513043
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 06:00:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=adIHpf7L;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso548965f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739368849; x=1739973649; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxfEa2xucVamCuD/DEkJC055XHezpdfcmYOgZW2o7p8=;
        b=adIHpf7LPgODe95qiogur4MzZxQDD7tYq7sDJzffq/myieR2vuvK60hcug8NZ1gKvf
         ZQuChYA0Ru1i9n3sF6tib1nxVLKzfRu6UNxScKMgq2v8+Qd8+fraNEowEa3w/fQWv185
         NBePTp2+XK5pEjjBQGf5JriqzzTIR2hN0Tr0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368849; x=1739973649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxfEa2xucVamCuD/DEkJC055XHezpdfcmYOgZW2o7p8=;
        b=N4pFw+FbGrF2kt1oucW4g/bJiIDdgwnsPKKBvnq7yFfDgMtK0/t0UKZGWxlbJ81I1W
         yMXuEXc1tOaiKPuXSImfcFWiLrWTYzEUblvQRJzxfrE3+BdWSS0pbwVxDrsphQt/qNGX
         2YL9/XNeB7HK6RwCkpgO9nuTCg+IDbABy9SqW2b/u7reg0Qtnjzs1Hy9imPoCxfUYeZ+
         Oh9cCFk0uoXm3uF+ktD7HrncZmaoHJj06x5ZauYYu/HdjuFcfhyjCryI7yQC2tqs1akg
         7bTAzYfDGUCIvih6Xa2AmlyDPlLmG75avjh1k+QIHCwTdXyC+GBaC0+TRBQM7PS8o/fi
         Ay3g==
X-Forwarded-Encrypted: i=1; AJvYcCWCymoG1vAH/wX0cGboLy/chdPAn8Z3djYWL1NQ0UBQi2k1VcSOGEZdVTbb2k1Av9LEw6F9DCnwtD+1opps@lists.openembedded.org
X-Gm-Message-State: AOJu0YzyijdxSaT98e4l64rhjLZWlKowyd8NTFdJdqCAsmWz9zZFVu8t
	0xofENU11BSL00X+z6RwTzvTXPCMfAzCHkwSxlofyMf09VFO+DZlM0NbRfYBIN8=
X-Gm-Gg: ASbGncvA/HrVEBF7Mh51jx0dfUHqVLOnzveXdWOYCndU7Eymi77yb5Guuvvf2jfwVi4
	Wxg9mt5QcBxdR5f/J+wGpPy5Hgcf3WEPu6746d/I/+iwsPJIelxtB57hcpUxTTPIF2NjWP5Zbwe
	UwyjL6uznnKW9/9AsigbUsSny412Du7P4OwonGZzWDo1mngA/Joyg0gqLITZq8/6NRFfJj03KWl
	lv1rN6aLDeH+DgzZONbgCwI/v7lS974kOGjqDBsIgWRxNXKCC1pf1gGAmhPlBidqZ5ww0rT/fIj
	a/AjlLpXUV9ijc7nccPWOc6veqqWL25W1FEVM55DQOQr7yfCwd07XS5+Y6VBw6lawJ3lexztORV
	RKQ==
X-Google-Smtp-Source: AGHT+IEUeccin/45nGmwOzy8LodBNGBCtWGfx9nx1hwY/QlgMeqwdbmFNjHCqM0ol4UVAvyaEL0ohw==
X-Received: by 2002:a5d:5985:0:b0:38d:ae4e:2267 with SMTP id ffacd0b85a97d-38dea1e1de5mr2694538f8f.11.1739368848094;
        Wed, 12 Feb 2025 06:00:48 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:af16:73ba:601:d9ae? ([2001:8b0:aba:5f3c:af16:73ba:601:d9ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb4410e6sm14536409f8f.8.2025.02.12.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:00:47 -0800 (PST)
Message-ID: <07afa496c6e85a015e3f046275d1a6d42e5883e3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: data_smart: fix ??=
 operator for getVarFlags
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: louis.rannou@syslinbit.com, bitbake-devel@lists.openembedded.org
Cc: louis.rannou@non.se.com, pascal.eberhard@se.com, yoann.congal@smile.fr
Date: Wed, 12 Feb 2025 14:00:46 +0000
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
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 14:00:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17205

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
PiAKCkkndmUgbm90IGdvbmUgaW50byB0aGUgZGV0YWlscyBidXQgdGhpcyBkb2Vzbid0IGxvb2sg
cmlnaHQgYXQgYWxsCnVuZm9ydHVuYXRlbHkuIEl0IGxvb2tzIG92ZXIgY29tcGxpY2F0ZWQsIGl0
IGlzIHNwZWNpYWwgY2FzaW5nIG1hZ2ljCnZhbHVlcyB3aGljaCB3ZSB0cnkgdmVyeSB2ZXJ5IGhh
cmQgbm90IHRvIGRvIGFuZCBJIGRvbid0IHRoaW5rIHRoaXMgaXMKZ29pbmcgdG8gYmUgbWFpbnRh
aW5hYmxlIGNvZGUuIFdlJ3JlIG5lZWQgdG8gZmluZCBhIGJldHRlciBzb2x1dGlvbi4KV2l0aG91
dCBkaXZpbmcgaW50byB0aGUgY29kZSBJJ20gZ29pbmcgdG8gc3RydWdnbGUgdG8gcHJvdmlkZSBi
ZXR0ZXIKYWR2aWNlIHRob3VnaC4KCkNoZWVycywKClJpY2hhcmQKCg==


