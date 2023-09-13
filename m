Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6DEE0211
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 21:51:15 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.9879.1694641866602241880
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 14:51:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C6jrlIGx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso244663f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694641865; x=1695246665; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FO9iNAr7nx1IME674DJFdT3Nr2UuO7pZGUXyhrBcPo=;
        b=C6jrlIGxDocz0ObHMRgeS23Sb4qSQ5USkFp0YFXxRsbpl8aYRat8IDp8EKyftXgtXO
         fly808/4c0kAXnTvz4kok41MJYVw8eIL+7fx3fslyrLsxguFlQvX8pSegxZEbVAVjPFe
         rg7cNjmaaeelZC6aYYs4QOSt3KGfVCCp6tjGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641865; x=1695246665;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1FO9iNAr7nx1IME674DJFdT3Nr2UuO7pZGUXyhrBcPo=;
        b=MMmz5Tc+PzRJKO3r3mpRnVJiktDHC2RYglPG9zWgGhucSAO7+2+oVWpn+VXLLz1b8l
         vJ/Uf5gWW/FkiS9TzT6AfJeiG0/5rFUU88Xsb/YrvZon7gWVkCUhIu8wbeoxlzkmpT5A
         PJ6/w8rbU7FvJOvYCRSiyXa8Ku+FGb3DLx//pK5BrrSj+1cSihoLUmtztkxeOtEvmVa/
         P2HTwkVejtmM409rIqyCwoA+xNjSapEMZmDmEowG4ZFjlmFATPW3hCqq+NmjJ4J4jgWv
         tpWzF4Zcd3BA++RFhXXglN7xIJQWvdHmGymsubR/ssGS/3hijLIj7bxYNASpas3DDNBJ
         kOBw==
X-Gm-Message-State: AOJu0YwgFRuW0FtEJ/OgkxWzfS4hp0RSdOHGgxHLjis9IYg+9HvomjkJ
	Ksp6SQoF7SKAig6Jgk2pRwbikw==
X-Google-Smtp-Source: AGHT+IE9TdN9rsn7ajb/C0Xy+MFJ1W42N2s6vQmb0BnlB1uYSGuZynYdejxn2LHsDu90/8O+ks6WTA==
X-Received: by 2002:adf:d4cf:0:b0:311:3fdc:109d with SMTP id w15-20020adfd4cf000000b003113fdc109dmr3609835wrk.1.1694641864936;
        Wed, 13 Sep 2023 14:51:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97? ([2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b0031981c500aasm4640wrq.25.2023.09.13.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:51:04 -0700 (PDT)
Message-ID: <ba61cf89ade909db31dbb3131385b78fa62aa910.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Adds vscode devcontainer support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matthias Schnelte <develop@schnelte.de>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 13 Sep 2023 22:51:03 +0100
In-Reply-To: <29acfeb3-246f-4ddf-8701-a5ee6d7affaf@schnelte.de>
References: <29acfeb3-246f-4ddf-8701-a5ee6d7affaf@schnelte.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 21:51:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15058

T24gTW9uLCAyMDIzLTA5LTExIGF0IDE2OjEzICswMjAwLCBNYXR0aGlhcyBTY2huZWx0ZSB3cm90
ZToKPiBWaXN1YWwgc3R1ZGlvIGNvZGUgaXMgaW5qZWN0aW5nIGEgZ2l0IGNyZWRlbnRpYWwgaGVs
cGVyCj4gaW50byBldmVyeSBkZXYgY29udGFpbmVyLiBUaGlzIGhlbHBlciBpcyBmb3J3YXJkaW5n
IHRoZSBnaXQgY3JlZGVudGlhbHMKPiBmcm9tIHRoZSBob3N0IGludG8gdGhlIGNvbnRhaW5lci4K
PiAKPiBJbiBvcmRlciBmb3IgdGhpcyBoZWxwZXIgdG8gd29yayB0aGUgUkVNT1RFX0NPTlRBSU5F
UlNfSVBDCj4gbmVlZHMgdG8gYmUgYXZhaWxhYmxlIGluIHRoZSBlbnZpcm9ubWVudCBmb3IgYWxs
IGdpdCBvcGVyYXRpb25zCj4gdGhhdCByZXF1aXJlIGF1dGhlbnRpY2F0aW9uLgo+IC0tLQo+ICDC
oGxpYi9iYi9mZXRjaDIvX19pbml0X18ucHkgfCAzICsrLQo+ICDCoDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2Zl
dGNoMi9fX2luaXRfXy5weSBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkKPiBpbmRleCA3NjVh
ZWRkNS4uNTUyYTA5MzkgMTAwNjQ0Cj4gLS0tIGEvbGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQo+
ICsrKyBiL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkKPiBAQCAtODc0LDcgKzg3NCw4IEBAIEZF
VENIX0VYUE9SVF9WQVJTID0gWydIT01FJywgJ1BBVEgnLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ0FXU19TRUNSRVRfQUNDRVNTX0tFWScsCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnQVdTX0RFRkFVTFRfUkVHSU9O
JywKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdHSVRfQ0FD
SEVfUEFUSCcsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ1NT
TF9DRVJUX0RJUiddCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
J1NTTF9DRVJUX0RJUicsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJ1JFTU9URV9DT05UQUlORVJTX0lQQyddCj4gCj4gIMKgZGVmIGdldF9mZXRjaGVyX2Vudmly
b25tZW50KGQpOgo+ICDCoMKgwqDCoCBuZXdlbnYgPSB7fQoKVGhpcyBwYXRjaCBpcyBtaXNzaW5n
IGEgU2lnbmVkLW9mZi1ieSBsaW5lIGFuZCB0aGUgcGF0Y2ggaXRzZWxmIGlzIGFsc28KaGFzIGRh
bWFnZWQgd2hpdGVzcGFjZSAobm90ZSB0aGUgbXVsdGlwbGUgc3BhY2VzIGluIGZyb250IG9mIGRl
ZgpnZXRfZmV0Y2hlcl9lbnZpcm9ubWVudCkgc28gY2FuJ3QgYmUgYXBwbGllZCB1bmZvcnR1bmF0
ZWx5LgoKQ2hlZXJzLAoKUmljaGFyZAo=


