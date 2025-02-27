Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA44C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 12:29:29 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.9405.1740659362602118472
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 04:29:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y7hzUDCU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390dd3654aeso490052f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 04:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740659361; x=1741264161; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgBMZi/LEWoNncPoRjDSplrCH3hIhHWjZoRiXYVXo6I=;
        b=Y7hzUDCUuYY2jAbxeKBrMYBL+LrWrAdQqSaKry+kBw1qShpuTVQecH1xS+4I6+yzOT
         6J9uPmPGLiYxlKF9QscI1dNO3cPBMnVSTgKCDdvlxlGjvaug+F0tzno74SqdPA2Qp8Yc
         sf+ng6Xz13/nGrQh8csKvljh6Ha4F83dDMJUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659361; x=1741264161;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgBMZi/LEWoNncPoRjDSplrCH3hIhHWjZoRiXYVXo6I=;
        b=mqT3gkMAGstGjk6VgDDCv+Zx9h6VjMEFDGQffbHXc5w/9vKkNPoj2Pmn6HhK4aE20N
         ciLqdIPbAkUcLkU0ZJtrtMw59ph2DuyQsQEMrArQxeUbEhWBVtvc6OMZ12z/zCyyetAx
         J3KcH1Fm7eOWA6jzeJwRJT15k96CVVx5vZ5FX/BtA/eAVTvR0f9kNuIEdJlA1ExIukoB
         kH+BC/W6IICv6Mvn/fEoZKEmGX/b1K2jiORHrhJo6EEiPxHdyLspAFKZ6VEFwnmdxPyV
         GfxT9v38XpIk7E0RqpTSp7IqEX+S37YvvBi6FibvHQ6PKNFvDgC/WLT6EiYKoA6M4FC4
         DDNw==
X-Forwarded-Encrypted: i=1; AJvYcCViWFPrC3KvYklSLgjULHLVOQWgSmQV0IzZ3y/aeBpqUilvuO0WXI74F4nvLSPwsSyqlBmOzxuWbSx1OS3c@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywf5xcQ3LvRhwg3Kb8QR32Zb9wpwgfYZUgfgk+nfOBIYYlADg+Z
	ksmqUduyeB7N71b5Rg1SAQE0yUqHj79UM3BfuTrzFsUhhcZyOFOPjdHfgfyfkNs=
X-Gm-Gg: ASbGncuXY7z+p6pgYEdmarm+u9jtZIiVezyQQhGBW3IcNNiboydpvhf90cxrxkKc2Iq
	gNtNjU1oj2n9UXvkJO545GRdHWHsC1UO5Wy6WKwA+hVioDWiP854+K1otBLc3T8qcNp3Z0+JP9I
	ER62MQqRjVZGgH2CJY17n1ZryHQJpnjPPb7YV55470zWjFJBO5kF3hC9kaqK6/F7ZyvaGevjnUj
	V+M6sWlnSvDqKI0dUiKlE0gBQagq7PnjPiKtg9zvXd55WvF35fa6pTubz1rMRsnX6F3Ix4mB6PW
	B2qI8kTrlo6b88yUrPqnBhzCNN4p1+cA8VZ4NGwYHBr2VnymQ0vL1uVC5mKe1sdPjsg3rauHa1d
	QOiutxO1fi1a1ELg=
X-Google-Smtp-Source: AGHT+IFNQ/DYLKC25nf8Z8jMCELaUBTxRRhLYjglUk6hsC6SACZGB5E0S9JzkgJo6cWvnbzARzOIUw==
X-Received: by 2002:a05:6000:178b:b0:390:e85b:a8d1 with SMTP id ffacd0b85a97d-390e85bab64mr993066f8f.1.1740659360834;
        Thu, 27 Feb 2025 04:29:20 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:af40:c449:3dc9:d155? ([2001:8b0:aba:5f3c:af40:c449:3dc9:d155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484486bsm1892978f8f.65.2025.02.27.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:29:20 -0800 (PST)
Message-ID: <f05d2e28a7b234ed74c6780f62800bdfb4f0c8a4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake: runqueue: Verify mcdepends
 are valid
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mark.hatle@kernel.crashing.org, bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>
Date: Thu, 27 Feb 2025 12:29:19 +0000
In-Reply-To: <1740508733-4989-1-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1740508733-4989-1-git-send-email-mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17345

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDEyOjM4IC0wNjAwLCBNYXJrIEhhdGxlIHZpYSBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IEZyb206IE1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAYW1k
LmNvbT4KPiAKPiBJbiBvcmRlciB0byBhdm9pZCBhIHBvdGVudGlhbGx5IGNvbmZ1c2luZyBiYWNr
dHJhY2UsIGNoZWNrIHRoYXQgdGhlIG1jZGVwZW5kCj4gaXMgdmFsaWQgd2hlbiB3ZSBhZGQgaXQu
Cj4gCj4gQWRkIGEgdGVzdCBjYXNlIHRvIGVuc3VyZSBpbnZhbGlkIGNvbmZpZ3VyYXRpb25zIGFy
ZSBjYXVnaHQgYW5kIHRyaWdnZXIgYW4KPiBlcnJvci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJr
IEhhdGxlIDxtYXJrLmhhdGxlQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXRsZSA8
bWFyay5oYXRsZUBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+IC0tLQo+IMKgbGliL2JiL3J1bnF1ZXVl
LnB5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
Kwo+IMKgbGliL2JiL3Rlc3RzL3J1bnF1ZXVlLXRlc3RzL3JlY2lwZXMvZzEuYmIgfMKgIDIgKysK
PiDCoGxpYi9iYi90ZXN0cy9ydW5xdWV1ZS10ZXN0cy9yZWNpcGVzL2gxLmJiIHzCoCAwCj4gwqBs
aWIvYmIvdGVzdHMvcnVucXVldWUucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTggKysrKysrKysrKysrKysrKysrCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvYmIvdGVzdHMvcnVucXVldWUtdGVzdHMv
cmVjaXBlcy9nMS5iYgo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi9iYi90ZXN0cy9ydW5xdWV1
ZS10ZXN0cy9yZWNpcGVzL2gxLmJiCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi9ydW5xdWV1ZS5w
eSBiL2xpYi9iYi9ydW5xdWV1ZS5weQo+IGluZGV4IGZmYjJkMjg0OS4uNTM5YTYwNjVmIDEwMDY0
NAo+IC0tLSBhL2xpYi9iYi9ydW5xdWV1ZS5weQo+ICsrKyBiL2xpYi9iYi9ydW5xdWV1ZS5weQo+
IEBAIC03MzAsNiArNzMwLDggQEAgY2xhc3MgUnVuUXVldWVEYXRhOgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIG1jID09IGZyb21tYzoKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZuID0gdGFza0RhdGFbbWNkZXBdLmJ1aWxkX3RhcmdldHNb
cG5dWzBdCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdkZXAg
PSAnJXM6JXMnICUgKGZuLGRlcHRhc2spCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIG5ld2RlcCBub3QgaW4gdGFza0RhdGFbbWNkZXBdLnRhc2tlbnRyaWVzOgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJiLmZhdGFs
KCJUYXNrIG1jZGVwZW5kcyBvbiBub24tZXhpc3RlbnQgdGFzayAlcyIgJSAobmV3ZGVwKSkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhc2tEYXRhW21jXS50YXNr
ZW50cmllc1t0aWRdLnRkZXBlbmRzLmFwcGVuZChuZXdkZXApCj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgIGZvciBtYyBpbiB0YXNrRGF0YToKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3RzL3J1bnF1
ZXVlLXRlc3RzL3JlY2lwZXMvZzEuYmIgYi9saWIvYmIvdGVzdHMvcnVucXVldWUtdGVzdHMvcmVj
aXBlcy9nMS5iYgo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi4zYzdk
Y2EwMjUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvbGliL2JiL3Rlc3RzL3J1bnF1ZXVlLXRlc3Rz
L3JlY2lwZXMvZzEuYmIKPiBAQCAtMCwwICsxLDIgQEAKPiArZG9fYnVpbGRbbWNkZXBlbmRzXSA9
ICJtYzo6bWMtMTpoMTpkb19pbnZhbGlkIgo+ICsKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3Rz
L3J1bnF1ZXVlLXRlc3RzL3JlY2lwZXMvaDEuYmIgYi9saWIvYmIvdGVzdHMvcnVucXVldWUtdGVz
dHMvcmVjaXBlcy9oMS5iYgo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAw
Li5lNjlkZTI5YmIKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL3Rlc3RzL3J1bnF1ZXVlLnB5IGIvbGli
L2JiL3Rlc3RzL3J1bnF1ZXVlLnB5Cj4gaW5kZXggY2M4N2U4ZDZhLi5lMTVmZGMzMzAgMTAwNjQ0
Cj4gLS0tIGEvbGliL2JiL3Rlc3RzL3J1bnF1ZXVlLnB5Cj4gKysrIGIvbGliL2JiL3Rlc3RzL3J1
bnF1ZXVlLnB5Cj4gQEAgLTMxNCw2ICszMTQsMjQgQEAgY2xhc3MgUnVuUXVldWVUZXN0cyh1bml0
dGVzdC5UZXN0Q2FzZSk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBbIm1jXzI6YTE6JXMiICUgdCBmb3IgdCBpbiByZXJ1bl90YXNrc10KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRFcXVhbChzZXQodGFza3MpLCBzZXQoZXhwZWN0
ZWQpKQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBBc3NlcnRpb25FcnJvciBpcyBy
YWlzZWQgYnkgc2VsZi5ydW5fYml0YmFrZWNtZCBpbiB0aGUgZXZlbnQgb2YgYSBmYWlsdXJlCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBpbiB0aGlzZSBjYXNlIGEgZmFpbHVyZSBpcyByZXF1
aXJlZCwgYnV0IHdlIG5lZWQgdG8gZG8gZnVydGhlciBwcm9jZXNzaW5nCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIyB0byB0ZWxsIGlmIGl0J3MgdGhlIFJJR0hUIGtpbmQgb2YgZmFpbHVyZS4K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aXRoIHNlbGYuYXNzZXJ0UmFpc2VzKEFzc2VydGlv
bkVycm9yKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyeToKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5ydW5fYml0YmFrZWNtZChbImJp
dGJha2UiLCAiZzEiXSwgdGVtcGRpciwgIiIsIGV4dHJhZW52PWV4dHJhZW52LCBjbGVhbnVwPVRy
dWUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlcHQgQXNzZXJ0aW9uRXJy
b3IgYXMgZToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBJZiB0
aGUgd29yZCAnVHJhY2ViYWNrJyBvciAnS2V5RXJyb3InIGlzIGluIHRoZSBleGNlcHRpb24gdGV4
dCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyB3ZSd2ZSByZWdy
ZXNzZWQuwqAgU28gdmVyaWZ5IGl0J3MgTk9UIHByZXNlbnQsIGFuZCBwYXNzIHRoZQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIGV4Y2VwdGlvbiB0byBpbmRpY2F0
ZSBhICdwYXNzJy4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
bm90ICgnVHJhY2ViYWNrJyBpbiBzdHIoZSkgb3IgJ0tleUVycm9yJyBpbiBzdHIoZSkpOgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgUmFpc2luZyAn
QXNzZXJ0aW9uRXJyb3InIGlzIGEgdGVzdCBwYXNzCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICMgRHVtcCB0aGUgb3V0cHV0IGZvciB0cmlhZ2UsIGJ1dCBkb24ndCBy
YWlzZSBhbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICMgZXhjZXB0aW9uLCB0aGlzIGluZGljYXRlcyBhIHRlc3QgZmFpbHVyZS4KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludCgiJXM6ICVzIiAlICh0
eXBlKGUpLCBlKSkKPiArCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc2h1dGRvd24o
dGVtcGRpcikKPiDCoAo+IMKgwqDCoMKgIGRlZiB0ZXN0X2hhc2hzZXJ2X3NpbmdsZShzZWxmKToK
PiAKClNvcnJ5IHRvIGFzayB0aGlzIGJ1dCBkdXJpbmcgcmV2aWV3IFJvc3MgcG9pbnRlZCBvdXQg
dGhhdAphc3NlcnRSYWlzZXNSZWdleCBjYW4gdGFrZSBhIHJlZ2V4IGFuZCB0aGVuIHlvdSBjYW4g
cmVhbGx5IHNpbXBsaWZ5CnRoaXMgZnVydGhlci4gV291bGQgeW91IGJlIGFibGUgdG8gdHdlYWsg
dGhpcyBmdXJ0aGVyIHRvIHVzZSB0aGF0PwoKQXMgSSd2ZSBtZW50aW9uZWQgZWxzZXdoZXJlLCBo
YXZpbmcgd2VsbCB3cml0dGVuIHRlc3RzIGhlbHBzIGZvc3RlcgpmdXJ0aGVyIHdlbGwgd3JpdHRl
biB0ZXN0cyBpbiB0aGUgZnV0dXJlLiBHaXZlbiBob3cgbG9uZyB3ZSBlbmQgdXAKbWFpbnRhaW5p
bmcgdGhlc2UgZm9yLCBpdCBpcyB3b3J0aCBnZXR0aW5nIHRoZW0gcmlnaHQhCgpDaGVlcnMsCgpS
aWNoYXJkCgo=


