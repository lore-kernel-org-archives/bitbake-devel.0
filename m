Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E5C3DA64
	for <webhook@archiver.kernel.org>; Sun,  4 Aug 2024 12:05:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.25373.1722773115134744452
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 04 Aug 2024 05:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hKgknOLB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bca3960so66843815e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 04 Aug 2024 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722773113; x=1723377913; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQg3rg/PxRrijaC0W4Eird99mOpTG0hdd8B36YXya3E=;
        b=hKgknOLBJIke5B11DRl6nwtGLS3U7iNLuPGM6415RIx44fGrEg3btiNiWj/xi8SyEP
         CyrbfBysBg/N0yh7gzKc6W68qjWIrRvyBcAyA7Wun6sazKi0PdnhYpKq1c0Yha0KYJdV
         tno0d/P1FZlXiK8FfamywbYq4d9lU5RvsGXVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722773113; x=1723377913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQg3rg/PxRrijaC0W4Eird99mOpTG0hdd8B36YXya3E=;
        b=URGKOqOk1myXG0yP+uRlDyCXbhWCHrOprA+HT/IF7P5MqBXgesmFVsvHbbol9SRKFi
         VG5t6HyRghBhhAoa86hJvqZeaNKysUn6fjAcE+/watldnbbsFHuLF0jSWgil3JLFdQY8
         oAUZtD1Q4nNgx5wlyJMoNerPQG5IyyLlEMAKfUmlfS+sWYHIwSLdVX509Hip9zTnximk
         G+ezeDXiVPbgwOGwaTJL5lr4jE69U+oW25M8DsG2ko9ObxAlxCQ8XtJltIPiw/SZezTr
         hIDApR91ZCwZQOKAxqos9IUizuHrFurfG3uELRa+RNM8aiNPlojc/TiVR4QZIEW0V3yK
         v6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXFxbhUQVo6E6hGAr7yTkJQW/k1y5fleaGvVL4XPnhCKvLKvThMrortktyblaSSTp8IWrRTAMFhNsryqkkXKgPNuA9cUKHBm+9J6KXsfgjYHYbqFjg=
X-Gm-Message-State: AOJu0Ywo6DK9hm4Z9H6OBd2knL661BjaOMTeElDqF4fei3hrfNBnm1ub
	rN/FJ0z0ESU/oGlal+lJjrdnET/7yOmHzwJZCeHh7MftXL++W79BlW6zfl2qEcN1JStmMsQ6PtI
	vYPI=
X-Google-Smtp-Source: AGHT+IGNUir7iqHBayyDvAsmaTZlmVitd/VjiUIb7RWV99s5c324Pt2fNUN6tWUjUW9aj/NBx8Z98A==
X-Received: by 2002:a05:600c:3549:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-428e6b789acmr60431725e9.29.1722773112881;
        Sun, 04 Aug 2024 05:05:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c970:9bdb:c2fc:595d? ([2001:8b0:aba:5f3c:c970:9bdb:c2fc:595d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bab9f7esm155292155e9.21.2024.08.04.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:05:12 -0700 (PDT)
Message-ID: <e7d003c88e234039a454c16cad58393a45b6f0ba.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart: Improve performance for
 VariableHistory
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Sun, 04 Aug 2024 13:05:11 +0100
In-Reply-To: <cd06a65773c4be6a51ccba0155cbebe42c2f355e.1722137668.git.liezhi.yang@windriver.com>
References: <cover.1722137668.git.liezhi.yang@windriver.com>
	 <cd06a65773c4be6a51ccba0155cbebe42c2f355e.1722137668.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 04 Aug 2024 12:05:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16443

T24gU2F0LCAyMDI0LTA3LTI3IGF0IDIwOjM5IC0wNzAwLCBSb2JlcnQgWWFuZyB2aWEgbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZyB3cm90ZToKPiBGcm9tOiBSb2JlcnQgWWFuZyA8bGllemhpLnlhbmdA
d2luZHJpdmVyLmNvbT4KPiAKPiBGaXhlZDoKPiAtIEJCTVVMVElDT05GSUcgPSAicWVtdXg4Ni02
NCBxZW11YXJtNjQiIGFuZCBtb3JlIHRoYW4gNzAgbGF5ZXJzIGluIEJCTEFZRVJTCj4gJCBiaXRi
YWtlIC1wIC1QCj4gQ2hlY2sgcHJvZmlsZS5sb2cucHJvY2Vzc2VkLCB0aGUgcmVjb3JkKCkgY29z
dCBtb3JlIHRoYW4gMjAgc2Vjb25kcywgaXQgaXMgbGVzcwo+IHRoYW4gMSBzZWNvbmQgd2hlbiBt
dWx0aWNvbmZpZyBpcyBub3QgZW5hYmxlZCwgYW5kIHRoZXJlIHdvdWxkIGJlIHRoZSBmb2xsb3dp
bmcKPiBlcnJvciB3aGVuIG1vcmUgbXV0aWNvbmZpZ3MgYXJlIGVuYWJsZWQ6Cj4gCj4gVGltZW91
dCB3aGlsZSB3YWl0aW5nIGZvciBhIHJlcGx5IGZyb20gdGhlIGJpdGJha2Ugc2VydmVyCj4gCj4g
RG9uJ3QgY2hhbmdlIHRoZSB0eXBlIG9mIGxvZ2luZm9bJ2RldGFpbCddIG9yIHJlLWFzc2lnbiBp
dCBjYW4gbWFrZSByZWNvcmQoKQo+IGJhY2sgdG8gbGVzcyB0aGFuIDEgc2Vjb25kLCB0aGlzIHdv
bid0IGFmZmVjdCBDT1cgc2luY2UgbG9naW5mbyBpcyBhIG11dGFibGUKPiB0eXBlLgo+IAo+IFRo
ZSB0aW1lIG1haW5seSBhZmZlY3RlZCBieSB0d28gZmFjdG9yczoKPiAxKSBUaGUgbnVtYmVyIG9m
IGVuYWJsZWQgbGF5ZXJzLCBuZWFybHkgMSBzZWNvbmQgYWRkZWQgcGVyIGxheWVyIHdoZW4gdGhl
Cj4gwqDCoCBudW1iZXIgaXMgbGFyZ2VyIHRoYW4gNTAuCj4gCj4gMikgVGhlIGdsb2JhbCB2YXIg
c3VjaCBhcyBVU0VSX0NMQVNTRVMsIGFib3V0IDEgfiAyIHNlY29uZHMgYWRkZWQgcGVyIGxheWVy
Cj4gwqDCoCB3aGVuIHRoZSBsYXllcnMgbnVtYmVyIGlzIGxhcmdlciB0aGFuIDUwLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IFJvYmVydCBZYW5nIDxsaWV6aGkueWFuZ0B3aW5kcml2ZXIuY29tPgo+IC0t
LQo+IMKgYml0YmFrZS9saWIvYmIvZGF0YV9zbWFydC5weSB8IDggKysrLS0tLS0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2JpdGJha2UvbGliL2JiL2RhdGFfc21hcnQucHkgYi9iaXRiYWtlL2xpYi9iYi9kYXRhX3Nt
YXJ0LnB5Cj4gaW5kZXggMDEyOGE1YmIxNy4uYzYwNDlkNTc4ZSAxMDA2NDQKPiAtLS0gYS9iaXRi
YWtlL2xpYi9iYi9kYXRhX3NtYXJ0LnB5Cj4gKysrIGIvYml0YmFrZS9saWIvYmIvZGF0YV9zbWFy
dC5weQo+IEBAIC0yNzIsMTIgKzI3Miw5IEBAIGNsYXNzIFZhcmlhYmxlSGlzdG9yeShvYmplY3Qp
Ogo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4KPiDCoMKgwqDCoMKgwqDCoMKgIGlm
ICdvcCcgbm90IGluIGxvZ2luZm8gb3Igbm90IGxvZ2luZm9bJ29wJ106Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGxvZ2luZm9bJ29wJ10gPSAnc2V0Jwo+IC3CoMKgwqDCoMKgwqDCoCBpZiAn
ZGV0YWlsJyBpbiBsb2dpbmZvOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvZ2luZm9bJ2Rl
dGFpbCddID0gc3RyKGxvZ2luZm9bJ2RldGFpbCddKQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgJ3Zh
cmlhYmxlJyBub3QgaW4gbG9naW5mbyBvciAnZmlsZScgbm90IGluIGxvZ2luZm86Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJhaXNlIFZhbHVlRXJyb3IoInJlY29yZCgpIG1pc3NpbmcgdmFy
aWFibGUgb3IgZmlsZS4iKQo+IMKgwqDCoMKgwqDCoMKgwqAgdmFyID0gbG9naW5mb1sndmFyaWFi
bGUnXQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgIGlmIHZhciBub3QgaW4gc2VsZi52YXJpYWJsZXM6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYudmFyaWFibGVzW3Zhcl0gPSBbXQo+IMKg
wqDCoMKgwqDCoMKgwqAgaWYgbm90IGlzaW5zdGFuY2Uoc2VsZi52YXJpYWJsZXNbdmFyXSwgbGlz
dCk6Cj4gQEAgLTMzNiw3ICszMzMsOCBAQCBjbGFzcyBWYXJpYWJsZUhpc3Rvcnkob2JqZWN0KToK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWcgPSAnWyVzXSAn
ICUgKGV2ZW50WydmbGFnJ10pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxz
ZToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWcgPSAnJwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgby53cml0ZSgiI8KgwqAgJXMgJXM6JXMl
c1xuI8KgwqDCoMKgICVzXCIlc1wiXG4iICUgKGV2ZW50WydvcCddLCBldmVudFsnZmlsZSddLCBl
dmVudFsnbGluZSddLCBkaXNwbGF5X2Z1bmMsIGZsYWcsIHJlLnN1YignXG4nLCAnXG4jwqDCoMKg
wqAgJywgZXZlbnRbJ2RldGFpbCddKSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBvLndyaXRlKCIjwqDCoCAlcyAlczolcyVzXG4jwqDCoMKgwqAgJXNcIiVzXCJcbiIgJSBcCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChldmVudFsnb3AnXSwgZXZl
bnRbJ2ZpbGUnXSwgZXZlbnRbJ2xpbmUnXSwgZGlzcGxheV9mdW5jLCBmbGFnLCByZS5zdWIoJ1xu
JywgJ1xuI8KgwqDCoMKgICcsIHN0cihldmVudFsnZGV0YWlsJ10pKSkpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIGxlbihoaXN0b3J5KSA+IDE6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgby53cml0ZSgiIyBwcmUtZXhwYW5zaW9uIHZhbHVlOlxuIikKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvLndyaXRlKCcjwqDCoCAiJXMiXG4nICUgKGNvbW1l
bnRWYWwpKQo+IEBAIC0zOTAsNyArMzg4LDcgQEAgY2xhc3MgVmFyaWFibGVIaXN0b3J5KG9iamVj
dCk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGlzc2V0IGFuZCBldmVudFsnb3AnXSA9
PSAnc2V0Pyc6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXNzZXQgPSBUcnVlCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaXRlbXMgPSBkLmV4cGFuZChldmVudFsnZGV0YWlsJ10pLnNwbGl0KCkKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpdGVtcyA9IGQuZXhwYW5kKHN0cihldmVudFsnZGV0YWlsJ10pKS5z
cGxpdCgpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBpdGVtIGluIGl0ZW1zOgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgVGhpcyBpcyBhIGxpdHRsZSBjcnVkZSBi
dXQgaXMgYmVsdC1hbmQtYnJhY2VzIHRvIGF2b2lkIHVzCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIyBoYXZpbmcgdG8gaGFuZGxlIGV2ZXJ5IHBvc3NpYmxlIG9wZXJhdGlvbiB0
eXBlIHNwZWNpZmljYWxseQo+IAoKVGhpcyBsb29rcyBsaWtlIGEgZ29vZCBmaW5kLCB0aGFua3Mg
Zm9yIGRpZ2dpbmcgaW50byBpdCEgSSdtIGEgbGl0dGxlCnN1cnByaXNlZCB0aGlzIGNhdXNlcyBh
cyBtdWNoIG9mIGEgcHJvYmxlbSBhbmQgd2FzIGEgYml0IHdvcnJpZWQgYWJvdXQKdW5pbnRlbmRl
ZCBzaWRlIGVmZmVjdHMgYnV0IEkgZGlkbid0IGZpbmQgYW55IGluIHRlc3Rpbmcgc28gaXQgaGFz
Cm1lcmdlZCwgdGhhbmtzIQoKQ2hlZXJzLAoKUmljaGFyZAoKCg==


