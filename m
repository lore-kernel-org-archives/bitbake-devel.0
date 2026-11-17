Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15959.1794916246133221974
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 03:50:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QpCCK0F9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so23306435e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 03:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794916244; x=1795521044; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bX2tO6rSChploXgF7loh/dJ+6IrSJl6OASKYC0bPtE4=;
        b=QpCCK0F9McVmqdzCzlF69FFUPcVKWW4LcDPkEyUk+i8mm02kHaCXSla2juIIEmw7cf
         5PNfPboo7S8mvrp+Gg7FXOZrSd7qDkhKuz9TBDYUhrfRWA+m498InzMghaj/ELWRrfB1
         CccuXPjRpa0Zyfw45gNkwchxaUxQZyuAmZnlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916244; x=1795521044;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX2tO6rSChploXgF7loh/dJ+6IrSJl6OASKYC0bPtE4=;
        b=RmjzalQ0VqYxDKh2rhaxkra3TfwAhTil/etXdTPUW8P66ZkOEgTOop2dBS6GPsPePx
         4lRTvjG74ud1R8ri6WxOSMDtkkHZWnGewkRX8fWJ+wJFvAC3XD0VSPBtkrosYeMRiq+9
         gfOhQX37/JpQp8Lvt4KPNLqbGmLUqzPlX10/eGq3iiRSnMY2tPNN/KJU7MouUkxDOyTT
         tBRQ3rWU2KR6eMXUgASzgPhvXyOsz296l9BNOam+9R9Vc1Y8hw4tb/W+nG97j5g+T15T
         wM6hWGHuiOi2Em4QB7Hnxv2AC0+jYvo52GYi9/rbpd9joUIP2IBMz5kVDoAGu3lM6plT
         G4nA==
X-Forwarded-Encrypted: i=1; AL+hErEXlC91Q1Z8xKNcS8poEx9zURQ8PKKsl6md/vNWRJSl4VNW2bvTzYGHOIs8vjRM7itCEsSd7amouO9RIg3o@lists.openembedded.org
X-Gm-Message-State: APuU4Z9LuyFCuUrw+1pzRLcVrTKXDHLiG65cXbufSjL0d+eCAIjo1kf6
	0USgSsWDCgmifwstJTGKlSV5ToS1hpccGnbaI5WIwT+julSyaq2Nq4tNhJu+b9rOWkU=
X-Gm-Gg: AYBFou280Q2D8XO253x08xNDOHFiaGZW37cpRjcJ3tBNLLnFsPvKLaFxEeP27Zmy3tr
	yemCZ2XZ31SluDcDTjykzDjbQ/+dra3+iDD0Pxsl81NZhlKQhYaxy8oWUyXnpfAPiAzWT7/Q8yh
	gWxedfHpNUovBCwqx5tyojSV4SzMU8IREy3fnPnKMI7S6LF4HNfN1jQIX3phB+CUG4WIgGYrrVA
	mM2fze9xpH4SmPumMySFA4gv8z2CDdiEi/t94bnrqoElfutIUjLqOtSsn7Ldb7qMOp1+XRxKtqV
	0TedYsMqP17RoAF6P2ciHB9xG1m4zqICofKp7NKP76FfpsSobZqsuMyngFHRBQnmSn44ZqcdYps
	DmnqOcqxJDl16P/Tpf2Euvk7NC6avOc3n2I6RXr7OVk0EcQAJLXfkKd0CX8a6o+NARiaX9Ug3DY
	c0sBoBOicyCRU5ME6cHmgp/HmFJ4z+yd5NFbeqd5jI6HNmnP4Sg0mL43e7YfiI9Us95l4ZigSTU
	P9yVqqh250V/RAuUyB0j5Wm8tUJcZ5Tu5rCYCfaemjS3wRrC021QHlvfCx3zVCAJ8mwIDl03SIy
	33ZuTkqj7Pw8CCpvRIxUBW3m3ZpfmpE+opNmZBoVNXmgCMZ0Ea9TMVUZZXdL8SHU1+ahpbqN9cM
	8yhqZ9iiGZhvcldI6rw==
X-Received: by 2002:a05:600c:a00d:b0:4bb:6842:66ef with SMTP id 5b1f17b1804b1-4bb6842670dmr196824815e9.30.1794916244331;
        Tue, 17 Nov 2026 03:50:44 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5769:a004:a5af:24bf? ([2001:8b0:aba:5f3c:5769:a004:a5af:24bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm94547925e9.9.2026.11.17.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:50:43 -0800 (PST)
Message-ID: <83b8af04f9ac91840f44f4e5a11b8f565245f94a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Don't defer setscene tasks
 behind already completed tasks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mark.hatle@amd.com, bitbake-devel@lists.openembedded.org
Date: Tue, 17 Nov 2026 11:50:43 +0000
In-Reply-To: <20261115220956.758312-1-mark.hatle@amd.com>
References: <20261115220956.758312-1-mark.hatle@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 11:50:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20447

T24gU3VuLCAyMDI2LTExLTE1IGF0IDE1OjA5IC0wNzAwLCBNYXJrIEhhdGxlIHZpYSBiaXRiYWtl
LWRldmVsIHdyb3RlOgo+IFdoZW4gYSB0YXNrIGNvbXBsZXRlcywgdGhlIGZpcnN0IHNldHNjZW5l
IHRhc2sgZGVmZXJyZWQgYWdhaW5zdCBpdCBpcwo+IHJlbGVhc2VkIGFuZCBhbnkgb3RoZXJzIGFy
ZSByZS1kZWZlcnJlZCBiZWhpbmQgdGhhdCB0YXNrLiBJZiB0aGUgcmVsZWFzZWQKPiB0YXNrIGhh
ZCBhbHJlYWR5IGNvbXBsZXRlZCAoZS5nLiBpdHMgc2V0c2NlbmUgd2FzIHNraXBwZWQgZHVlIHRv
IGEgdmFsaWQKPiBzdGFtcCksIGl0IG5ldmVyIGNvbXBsZXRlcyBhZ2Fpbiwgc28gdGhlIHJlLWRl
ZmVycmVkIHRhc2tzIGFyZSBuZXZlcgo+IHJlbGVhc2VkLiBTZXRzY2VuZSB0aGVuIGNhbid0IGZp
bmlzaCB1bnRpbCB0aGUgZGVhZGxvY2sgZmFsbGJhY2sgZm9yY2VzCj4gZWFjaCBvbmUsIHByaW50
aW5nICJSdW5xdWV1ZSBkZWFkbG9ja2VkIG9uIGRlZmVycmVkIHRhc2tzIi4KPiAKPiBUaGlzIHNo
b3dzIHVwIHdpdGggdGhyZWUgb3IgbW9yZSBtdWx0aWNvbmZpZ3Mgc2hhcmluZyBhIHRhc2sgaGFz
aC4gU2tpcAo+IGFscmVhZHkgY29tcGxldGVkIHRhc2tzIHdoZW4gcGlja2luZyB0aGUgbmV3IGJs
b2NrZXIuCj4gCj4gQUktR2VuZXJhdGVkOiBVc2VzIEdpdEh1YiBDb3BpbG90Cj4gU2lnbmVkLW9m
Zi1ieTogTWFyayBIYXRsZSA8bWFyay5oYXRsZUBhbWQuY29tPgo+IC0tLQo+IMKgbGliL2JiL3J1
bnF1ZXVlLnB5IHwgNCArKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4g
Cj4gZGlmZiAtLWdpdCBhL2xpYi9iYi9ydW5xdWV1ZS5weSBiL2xpYi9iYi9ydW5xdWV1ZS5weQo+
IGluZGV4IGVmOTVlYjQ2Yi4uMmE2YjA5OWI4IDEwMDY0NAo+IC0tLSBhL2xpYi9iYi9ydW5xdWV1
ZS5weQo+ICsrKyBiL2xpYi9iYi9ydW5xdWV1ZS5weQo+IEBAIC0yMTEyLDYgKzIxMTIsMTAgQEAg
Y2xhc3MgUnVuUXVldWVFeGVjdXRlOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYmIuZGVidWcoMSwgIkRlZmVycmVkIHRhc2sgJXMgbm93IGJ1aWxkYWJsZSIgJSB0
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVsIHNlbGYuc3Ff
ZGVmZXJyZWRbdF0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVw
ZGF0ZV9zY2VuZXF1ZXVlX2RhdGEoW3RdLCBzZWxmLnNxZGF0YSwgc2VsZi5ycWRhdGEsIHNlbGYu
cnEsIHNlbGYuY29va2VyLCBzZWxmLnN0YW1wY2FjaGUsIHNlbGYsIHN1bW1hcnk9RmFsc2UpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgQSB0YXNrIHdoaWNoIGFs
cmVhZHkgY29tcGxldGVkIHdpbGwgbmV2ZXIgY29tcGxldGUgYWdhaW4gc28gbXVzdAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIG5vdCBiZWNvbWUgdGhlIG5ldyBi
bG9ja2VyLCBlbHNlIHRoZSByZW1haW5pbmcgdGFza3MgbmV2ZXIgZ2V0IHJlbGVhc2VkCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIHQgaW4gc2VsZi5ydW5xX2Nv
bXBsZXRlOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnRpbnVlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3Vu
ZCA9IHQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOgo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmIuZGVidWcoMSwgIkRlZmVycmluZyAl
cyBhZnRlciAlcyIgJSAodCwgZm91bmQpKQoKSnVzdCB0byBjb25maXJtLCB0aGlzIGlzIG5vdCBx
dWl0ZSB0aGUgcmlnaHQgZml4LiBJIGRpZCB3b3JrIG91dApleGFjdGx5IHdoeSBpdCB3YXMgYnJl
YWtpbmcgYW5kIHdoaWxzdCB0aGlzIHdvcmtzIGFyb3VuZCB0aGUgcHJvYmxlbSwKdGhpcyBicmVh
a3MgdGhpbmdzLiBUaGVyZSBpcyBhIGJldHRlciBmaXggYW5kIEkndmUgc2VudCBwYXRjaGVzLgoK
Q2hlZXJzLAoKUmljaGFyZAo=

