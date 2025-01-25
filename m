Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9801C0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 09:04:54 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.6869.1737795891103894836
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 01:04:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N+r32+lS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361c705434so20083995e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 01:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737795889; x=1738400689; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9OBbLJmmAXmXQvUhaNUUzSpKmbOWvLw7Co5JJQaa84=;
        b=N+r32+lSmez0pC6XvgL6CkznW0g/E1VTfrKLj6gl8ucDOPPWi2OJbJkLq9M/pwz8NK
         qufP/2bW3F6U1sFyBX2S7v2v8z5sn9alwrxzVz6QS/pV/RLoCn/XeNSvTnSis+0PwWxR
         HdkoF6sBZKnFtVrRFOh+WqQPVj8G72B6GeB6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737795889; x=1738400689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9OBbLJmmAXmXQvUhaNUUzSpKmbOWvLw7Co5JJQaa84=;
        b=asgrQ6YdMljR9iYiBVQbR3Pa276md5XHW2jMJrzWhGXSqyrvUeWS3Eeiv7PLLhc43C
         d34OanLSQLxeiNJpNqUzDI+xTk2DrLjs9+WL3CzLvXdfIjjW8uxHzDeDyPKNmUJUy+Qc
         XYhma6A20wXsZ+DMRA6D7z3LqS95AitZjeILIqRFjSJE2qT8pzDBQlCyT2+N0uQ4D8aV
         0623EOw/jpzvobGXRV9pT2WdYVVmicCbk/m9f6HcTGXksBzdZ3oplWAmtDd8eL9xAsIW
         w3qyN/gecGompynBc4u1O9REW5gX59USm3F8+aGpqioZE3ewR4ymi06lEKND1ahE1y8Q
         EFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5/dFXd9mwmcu68yPTf2UZCZHqSuyI4Giga+Y9MI069OnYs1GpqWBrmV1U0/b101RZzkwtMj8Qu9EWsfaU@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy2ftjUo+qUjbYaeSXKLAT7B/5YALNSqnC7AsTucJyPZsHE4GZf
	XZK5T6YuwgKYQUW6X5249fz3MCti5k3APGzIs+MByTbS5SQmFUqv+cOeugpOBN4=
X-Gm-Gg: ASbGncvLG5KksSxR1YLWR6gpct5etSPprgCkOzdnxP7KVgvCWMil1k0ROSR7uPTH6bd
	A9+LZCwXXAUv9Xl4UxIN4RyJGgNIcbYYTvOZ3IsBjP7wjx/P59Pw+hADxm4KYYlMd+t+FZ8NNhK
	NXMZ/3BYqhUEP+/eLAnkI4PdigrXZwBGQche8YwwcHhvB91TIBhaI2FCDLE/igAUHEaCsgGSAEp
	pEf93xxSpOayzLdS93QQZ/3FV9hbrD5uY8krjT53LEfo32oKLSsMQsO31B1ISzpgBQRMeisC3Nj
	m1z4eqsnVAP7BifBCsB1+jGg0KE6kzRLAtsvpjjoPuHCsNz+M5raJZICODOawdfOVqU=
X-Google-Smtp-Source: AGHT+IFGsPzNh8QihIweLgci57BgW92h0do4EXT2wLrSuizwkN842Q4VM9ptanSsE5s3TZHIK007pA==
X-Received: by 2002:a05:6000:178e:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-38bf55c5f54mr30366592f8f.0.1737795889269;
        Sat, 25 Jan 2025 01:04:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac79:b32:597e:d068? ([2001:8b0:aba:5f3c:ac79:b32:597e:d068])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4199sm4890039f8f.89.2025.01.25.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 01:04:48 -0800 (PST)
Message-ID: <ff1c5b5c5bfa5a0a1ef0eb992114571fef010c8f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] runqueue: Verify mcdepends are valid
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mark.hatle@kernel.crashing.org, bitbake-devel@lists.openembedded.org
Date: Sat, 25 Jan 2025 09:04:46 +0000
In-Reply-To: <1737687019-22232-2-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
	 <1737687019-22232-2-git-send-email-mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 09:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17080

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDIwOjUwIC0wNjAwLCBNYXJrIEhhdGxlIHZpYSBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IEZyb206IE1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAYW1k
LmNvbT4KPiAKPiBJbiBvcmRlciB0byBhdm9pZCBhIHBvdGVudGlhbGx5IGNvbmZ1c2luZyBiYWNr
dHJhY2UsIGNoZWNrIHRoYXQgdGhlIG1jZGVwZW5kCj4gaXMgdmFsaWQgd2hlbiB3ZSBhZGQgaXQu
Cj4gCj4gQWRkIGEgdGVzdCBjYXNlIHRvIGVuc3VyZSBpbnZhbGlkIGNvbmZpZ3VyYXRpb25zIGFy
ZSBjYXVnaHQgYW5kIHRyaWdnZXIgYW4KPiBlcnJvci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYXJr
IEhhdGxlIDxtYXJrLmhhdGxlQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXRsZSA8
bWFyay5oYXRsZUBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+IC0tLQo+IMKgYml0YmFrZS9saWIvYmIv
cnVucXVldWUucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMiArKwo+IMKgYml0YmFrZS9saWIvYmIvdGVzdHMvcnVucXVldWUtdGVzdHMvcmVjaXBlcy9q
MS5iYiB8IDIgKysKPiDCoGJpdGJha2UvbGliL2JiL3Rlc3RzL3J1bnF1ZXVlLnB5wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDkgKysrKysrKysrCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDEzIGluc2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBiaXRiYWtlL2xpYi9i
Yi90ZXN0cy9ydW5xdWV1ZS10ZXN0cy9yZWNpcGVzL2oxLmJiCj4gCj4gZGlmZiAtLWdpdCBhL2Jp
dGJha2UvbGliL2JiL3J1bnF1ZXVlLnB5IGIvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHkKPiBp
bmRleCBmOTQxNzQ5YjBkLi45MGY2MDY0NjliIDEwMDY0NAo+IC0tLSBhL2JpdGJha2UvbGliL2Ji
L3J1bnF1ZXVlLnB5Cj4gKysrIGIvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHkKPiBAQCAtNzM0
LDYgKzczNCw4IEBAIGNsYXNzIFJ1blF1ZXVlRGF0YToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiBtYyA9PSBmcm9tbWM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmbiA9IHRhc2tEYXRhW21jZGVwXS5idWlsZF90YXJnZXRzW3BuXVswXQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV3ZGVwID0gJyVzOiVz
JyAlIChmbixkZXB0YXNrKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiBuZXdkZXAgbm90IGluIHRhc2tEYXRhW21jZGVwXS50YXNrZW50cmllczoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiYi5mYXRhbCgiVGFzayBt
Y2RlcGVuZHMgb24gbm9uLWV4aXN0ZW50IHRhc2sgJXMiICUgKG5ld2RlcCkpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXNrRGF0YVttY10udGFza2VudHJpZXNb
dGlkXS50ZGVwZW5kcy5hcHBlbmQobmV3ZGVwKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBmb3Ig
bWMgaW4gdGFza0RhdGE6Cj4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL3Rlc3RzL3J1bnF1
ZXVlLXRlc3RzL3JlY2lwZXMvajEuYmIgYi9iaXRiYWtlL2xpYi9iYi90ZXN0cy9ydW5xdWV1ZS10
ZXN0cy9yZWNpcGVzL2oxLmJiCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAw
MDAwLi4zYzdkY2EwMjU3Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2JpdGJha2UvbGliL2JiL3Rl
c3RzL3J1bnF1ZXVlLXRlc3RzL3JlY2lwZXMvajEuYmIKPiBAQCAtMCwwICsxLDIgQEAKPiArZG9f
YnVpbGRbbWNkZXBlbmRzXSA9ICJtYzo6bWMtMTpoMTpkb19pbnZhbGlkIgo+ICsKPiBkaWZmIC0t
Z2l0IGEvYml0YmFrZS9saWIvYmIvdGVzdHMvcnVucXVldWUucHkgYi9iaXRiYWtlL2xpYi9iYi90
ZXN0cy9ydW5xdWV1ZS5weQo+IGluZGV4IGNlYTJjYTEzZmUuLjQ2NjJlZmJmNTUgMTAwNjQ0Cj4g
LS0tIGEvYml0YmFrZS9saWIvYmIvdGVzdHMvcnVucXVldWUucHkKPiArKysgYi9iaXRiYWtlL2xp
Yi9iYi90ZXN0cy9ydW5xdWV1ZS5weQo+IEBAIC0zMjEsNiArMzIxLDE1IEBAIGNsYXNzIFJ1blF1
ZXVlVGVzdHModW5pdHRlc3QuVGVzdENhc2UpOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgWyJtY18yOmkxOiVzIiAlIHQgZm9yIHQgaW4gc2VsZi5hbGx0
YXNrc10KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRFcXVhbChzZXQodGFz
a3MpLCBzZXQoZXhwZWN0ZWQpKQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBDaGVj
ayB3aGF0IGhhcHBlbnMgd2l0aCBhbiBpbnZhbGlkIHRhc2sgZGVwZWRuZW5jeQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHBhc3NlZCA9IEZhbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHJ5Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5ydW5fYml0YmFrZWNt
ZChbImJpdGJha2UiLCAiajEiXSwgdGVtcGRpciwgIiIsIGV4dHJhZW52PWV4dHJhZW52LCBjbGVh
bnVwPVRydWUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZXB0IEFzc2VydGlvbkVycm9y
IGFzIGU6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludCgiRXhwZWN0ZWQg
ZmFpbHVyZTogJXMiICUgZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhc3Nl
ZCA9IFRydWUKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmFzc2VydEVxdWFsKFRydWUs
IHBhc3NlZCkKPiArCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc2h1dGRvd24odGVt
cGRpcikKPiDCoAo+IMKgwqDCoMKgIGRlZiB0ZXN0X2hhc2hzZXJ2X3NpbmdsZShzZWxmKToKCgpG
aXJzdGx5LCBJICpyZWFsbHkqIGFwcHJlY2lhdGUgcGVvcGxlIGFkZGluZyB0ZXN0cywgaXRzIGdy
ZWF0IHRvIHNlZSBzbwp0aGFua3MgZm9yIHRoYXQuCgpUaGUgdGVzdCBuZWVkcyBhIGZldyB0d2Vh
a3MsIGp1c3QgdG8gZm9sbG93IGJlc3QgcHJhY3RpY2UuCgpCYXNpY2FsbHkgeW91IGNhbiB1c2Ug
YXNzZXJ0UmFpc2VzKCkgdG8gdGVzdCBpdCByYWlzZXMgYW4gZXhjZXB0aW9uIGFuZAp3ZSBzaG91
bGQgcmVhbGx5IGNoZWNrIHRoYXQgaXQgc2F5cyAiQ29tbWFuZC4qZmFpbGVkIiBhbmQgIm1jZGVw
ZW5kcyBvbgpub24tZXhpc3RlbnQgdGFzay4qZG9faW52YWxpZCIuCgpodHRwczovL3d3dy5nZWVr
c2ZvcmdlZWtzLm9yZy90ZXN0LWlmLWEtZnVuY3Rpb24tdGhyb3dzLWFuLWV4Y2VwdGlvbi1pbi1w
eXRob24vCgpBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBoYXZlIGEgbmV3IHBhcmFtZXRlciB0
byBydW5fYml0YmFrZWNtZCB3aGljaApqdXN0IG1ha2VzIGl0IHJldHVybiB0aGUgZmFpbHVyZSBv
dXRwdXQuCgpDaGVlcnMsCgpSaWNoYXJkCgo=


