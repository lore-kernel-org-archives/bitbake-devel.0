Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A62C021BB
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 13:47:01 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.8125.1740491211199814750
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 05:46:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WYSvwmx9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43994ef3872so34447745e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740491209; x=1741096009; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbdzEpYJvxsPzptslW+pP7zXv7eZMt0Xox9Dmg++aBc=;
        b=WYSvwmx9ckeQQMrIqSAoaqkG6HZlbhMAgbwINhrpp9GAyQ7+tgjnX3wEJ3vUvQFpyr
         l0eeUOMcdJX5QyC7JQpbKUo4jxGWz8J8+TsI+zKeQJyBfYlVmbSoCl6Oe7g2jTQRFw1t
         ppquhdThSSDJHP8s/x+ZvLsFBoU8yuU/it8xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491209; x=1741096009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbdzEpYJvxsPzptslW+pP7zXv7eZMt0Xox9Dmg++aBc=;
        b=KKAjx+MSSBDr3Va/xH6QiwzgJHRL6B2hg+oxCTq3A2gDQ6nqiA63iQPhjz2YzHO6mK
         UnCvlE2w5a7Ttyz5EFGBbDoOQU4AWui3zzE83sr6tfRzS2nFyi3T5MU+3Zwm/Mjd5vWR
         VsDE4N7qmDyrgxpURCWFp0wpYqvssiz3CNmFQRWrBbV9yxHVDyE3WJELvWx1VNAtSPtE
         7zwVg2s8B/Bq5OW4qbN2O1yuQLpREBPIPctxkZw0X0VW2tITk1kjo87HCqcWwh6D2As7
         dqEtj5LnrhPepvvNYgO8bqQDEhkS2UQxuaavpyDYhVl9GXyRl5Ey+PFx+py+z3wZnFNP
         6MKw==
X-Forwarded-Encrypted: i=1; AJvYcCUeT+FPDdV2Q5byJGYbIVlTXTXb4Bjs+pci+KJp7+I3sWNWTi9l9JwM8Uu06dQirNFU0net+23TJELhuMvn@lists.openembedded.org
X-Gm-Message-State: AOJu0YxFW3HGHdPycjzbpv4Ze1JlINlMW/J+JwwHmS+s9YtfHZ0pYd65
	R3f43vzxmheUQobYXyWDlQf2Af6Yrw/5iiyeNqOQZVPq7q+5BseNMAJO569zoVE=
X-Gm-Gg: ASbGncu+UQJq8MyiLscDqgwCpuHXsdONgl8eUqUjOd5foEC2vJdrA1md/ezE1rZDG3t
	vzWK9x3Sen1ej+naLxU+hwxKIaWnfiaNqAqE5E8teelOSVeyJHKuD72N48gBwBuwDxZG5hhskzC
	19s/temR4Sba4rQp/J1aA5uUr99FbbHcu9bBYjj6LqURMPyfV2QvBSRlUi4vLcmkujI+9orOB1f
	+HW+HhvAcKhPGre0lsMq9JRu7udSU26ESfEC+9WxsTbj8whNcsR8sYb2GzAYD6P888k1ToLsXVq
	RLeCjQ77Ffs/2W00QLk0DJXacJFUTIEVPe+dRrC4i5DIw7oLr6DrnZp9gW8n0xtEVizZistDnYg
	Ga7Ax4nJ0LJTaHsY=
X-Google-Smtp-Source: AGHT+IF9FQaTOjzJObv0dHC+SdJ0CATYjpxuPGhKuxU/4RPcyuCxwOAOww5gZsAHbNUIlri0RSvB6A==
X-Received: by 2002:a05:600c:4f45:b0:439:88bb:d007 with SMTP id 5b1f17b1804b1-43ab0f28850mr30751635e9.3.1740491209508;
        Tue, 25 Feb 2025 05:46:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:92c7:7a17:f809:bc92? ([2001:8b0:aba:5f3c:92c7:7a17:f809:bc92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866dc4sm2372896f8f.11.2025.02.25.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:46:48 -0800 (PST)
Message-ID: <b4e76037f4fff35822a2f80888587fe6cb124953.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/cooker.py: make
 BB_HASHSERVE_UPSTREAM issues fatal, write specific error messages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Tue, 25 Feb 2025 13:46:48 +0000
In-Reply-To: <20250225120947.172025-1-alex.kanavin@gmail.com>
References: <20250225120947.172025-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 13:47:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17317

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDEzOjA5ICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB2aWEg
bGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToKPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8
YWxleEBsaW51dHJvbml4LmRlPgo+IAo+IFByZXZpb3VzbHkgaWYgdGhlIHNlcnZlciBjb3VsZG4n
dCBiZSBjb250YWN0ZWQgb3Igd2Vic29ja2V0cyBtb2R1bGUgd2FzIG5vdCBpbnN0YWxsZWQKPiBi
aXRiYWtlIHdvdWxkIG9ubHkgcHJpbnQgYSB3YXJuaW5nIGFuZCBjb250aW51ZSwgcmVzdWx0aW5n
IGluIGEgZGVncmFkZWQgdXNlcgo+IGV4cGVyaWVuY2UgZHVlIHRvIGluYWJpbGl0eSB0byB1c2Ug
dGhlIGNvbmZpZ3VyZWQgc3N0YXRlIHNlcnZlci4KPiAKPiBMZXQncyBjb25zaWRlciB0aGVzZSBh
cyBmYXRhbCBtaXNjb25maWd1cmF0aW9ucywgc28gdGhhdCB1c2VycyBjYW4gYWRkcmVzcwo+IHRo
ZSBpc3N1ZSBwcm9wZXJseSBhbmQgbm90IHdvbmRlciB3aHkgYnVpbGRzIGFyZSB0YWtpbmcgZm9y
ZXZlci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleEBsaW51dHJv
bml4LmRlPgo+IC0tLQo+IMKgYml0YmFrZS9saWIvYmIvY29va2VyLnB5IHwgMTEgKysrKysrKyst
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL2JiL2Nvb2tlci5weSBiL2JpdGJha2UvbGliL2Ji
L2Nvb2tlci5weQo+IGluZGV4IDViODg1Y2RkZDdlLi42Njg1OTZjNWNkYiAxMDA2NDQKPiAtLS0g
YS9iaXRiYWtlL2xpYi9iYi9jb29rZXIucHkKPiArKysgYi9iaXRiYWtlL2xpYi9iYi9jb29rZXIu
cHkKPiBAQCAtMzE2LDEwICszMTYsMTUgQEAgY2xhc3MgQkJDb29rZXI6Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdpdGggaGFzaHNlcnYuY3JlYXRlX2NsaWVudCh1
cHN0cmVhbSkgYXMgY2xpZW50Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsaWVudC5waW5nKCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZXB0IChDb25uZWN0aW9uRXJyb3IsIEltcG9ydEVycm9y
KSBhcyBlOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGJiLndhcm4oIkJCX0hBU0hTRVJWRV9VUFNUUkVBTSBpcyBub3QgdmFsaWQsIHVuYWJsZSB0byBj
b25uZWN0IGhhc2ggZXF1aXZhbGVuY2Ugc2VydmVyIGF0ICclcyc6ICVzIgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlcHQgQ29ubmVjdGlvbkVycm9yIGFzIGU6
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmIuZmF0
YWwoIlVuYWJsZSB0byBjb25uZWN0IHRvIGhhc2ggZXF1aXZhbGVuY2Ugc2VydmVyIGF0ICclcycs
IHBsZWFzZSBjb3JyZWN0IG9yIHJlbW92ZSBCQl9IQVNIU0VSVkVfVVBTVFJFQU06XG4lcyIKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAlICh1cHN0cmVhbSwgcmVwcihlKSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGV4Y2VwdCBJbXBvcnRFcnJvciBhcyBlOgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJiLmZhdGFsKCIiIiJVbmFibGUgdG8g
dXNlIGhhc2ggZXF1aXZhbGVuY2Ugc2VydmVyIGF0ICclcycgZHVlIHRvIG1pc3Npbmcgb3IgaW5j
b3JyZWN0IHB5dGhvbiBtb2R1bGU6Cj4gKyVzCj4gK1BsZWFzZSBpbnN0YWxsIHRoZSBuZWVkZWQg
bW9kdWxlIG9uIHRoZSBidWlsZCBob3N0LCBvciB1c2Ugc2NyaXB0cy9pbnN0YWxsLWJ1aWxkdG9v
bHMgZnJvbSBvcGVuZW1iZWRkZWQtY29yZS4KPiArWW91IGNhbiBhbHNvIGFkanVzdCBvciByZW1v
dmUgQkJfSEFTSFNFUlZFX1VQU1RSRUFNIHNldHRpbmcsIGJ1dCB0aGlzIG1heSByZXN1bHQgaW4g
c2lnbmlmaWNhbnRseSBsb25nZXIgYnVpbGQgdGltZXMuIiIiCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICUgKHVwc3Ry
ZWFtLCByZXByKGUpKSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1cHN0cmVhbSA9IE5vbmUKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNlbGYuaGFzaHNlcnZhZGRyID0gInVuaXg6Ly8lcy9oYXNoc2VydmUuc29jayIgJSBz
ZWxmLmRhdGEuZ2V0VmFyKCJUT1BESVIiKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlbGYuaGFzaHNlcnYgPSBoYXNoc2Vydi5jcmVhdGVfc2VydmVyKAo+IAoKSSBhZ3JlZSB3
ZSBzaG91bGQgc3BsaXQgdGhlIG1lc3NhZ2VzIGFuZCBJJ20gb2sgd2l0aCBtYWtpbmcgSW1wb3J0
RXJyb3IKZmF0YWwgYnV0IEknbSBub3Qgc3VyZSB3ZSBzaG91bGQgY2hhbmdlIENvbm5lY3Rpb25F
cnJvciBhcyBpdCBtZWFucyBhCnNpbmdsZSBjb25uZWN0aW9uIGZhaWx1cmUgdG8gYW4gb3Zlcmxv
YWRlZCBzZXJ2ZXIgd2lsbCBhYm9ydCB0aGUgYnVpbGQuCldlJ3ZlIHNlZW4gdGhpcyBwcm9ibGVt
IGJlZm9yZSB3aGljaCBpcyB3aHkgaXQgaXMgYSB3YXJuaW5nLgoKV2UgY2FuJ3QgcmVhbGx5IHJl
ZmVyZW5jZSBvZS1jb3JlIGZyb20gYml0YmFrZSB1bmZvcnR1bmF0ZWx5IGVpdGhlci4KV2UnZCBw
cm9iYWJseSBuZWVkIHRvIGxpbmsgdG8gZG9jcyBhdCB0aGF0IHBvaW50LgoKQ2hlZXJzLAoKUmlj
aGFyZAoK


