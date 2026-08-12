Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93762C5CFDB
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 20:34:31 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4704.1786566868193885532
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 13:34:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VgW5YtU5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49802c418b5so13316685e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786566866; x=1787171666; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TLZ9F7LYV9r2pcTv3pvR6/G2nX1OHCMwFOQMDS5Eowc=;
        b=VgW5YtU5WRwZnUk5wU72m5w7FcksUujUyFkTYywr53Rj7TXB6Ec8HWrOau7kf3ay5M
         Z19msUvVUhuwBAVNoHc442X6AGbuaVYv5rzopijxxuseqCsMMMQO9HeTx0N13t3c3M71
         0sRqIPa3SqqDbQDIM0VRzFnOX4x0Rm9LyOYGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566866; x=1787171666;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLZ9F7LYV9r2pcTv3pvR6/G2nX1OHCMwFOQMDS5Eowc=;
        b=gyh58sNQ6qe3R6wMB44N+ldfJi3CkulMHO2yhTD2LhmPhUrSsqL8cJlPl3+BbyhQ7S
         036ithKcTiW0GAVXMWCamvwad+F8rELWjGWTiu17dgnGUiXZgsSJTMFgxWFhsxNfFTkz
         CunbNtDvIOdOjly41e7HGwCbqKnrFttSzE7wRNyIzi3hzw5Cd04EgJzwBgxE21a2zdHF
         k0C/D0lTR6YtycPiXYSu2vlj2lnQ3HGXt9pUu4fFJUh6ekHqhwtyxH+z5lK90UzmlXbI
         F7ig9efVLvF0g7q7JIFb7XYgbJhnoUeN1UN7WHrc+63gRbugTPusguaTaZr7neuJyzP4
         GNqA==
X-Forwarded-Encrypted: i=1; AHgh+RobqPYhoJapCF/R/QL4KqYjLRBaUMDh+H5KVE+pyWAIp9V6iEq9e00rYCBJ5Xnl1Kh77MQotuaDl6g4lrXC@lists.openembedded.org
X-Gm-Message-State: AOJu0YyV5jV8b1WLQHP6jHb1iCWCGfAKwX3B6kP3ekdDfSm7kL8GVXEb
	DHzfuFjgn9LPf6irX7QlWPQ3+kz1CRRaChWfTPoW6G2XX7hyCwfQnxDz2VCx13092Rk=
X-Gm-Gg: AR+sD10pnGTzcHPtHHwiWJZI5rKJ8TztUl/s84aeGVfyAFLFDzwrYSOJap4Qx/KtWpf
	88tgAcKx0dFwP0oBFd4BhbbtljDVaMysL8yWFjeOnUTzzq+xekyXNNfKPpwb47i9W5/ZpD0Cw7/
	5zmu0iOYOcD2FOZmuDtKFTZg8BH1Ut8Hoow/LITT5ZXFH9Vgtk04iie/aTz0pZqCV96C/zowzmk
	qTa/MaIT6HoULcZkpeKGxbW3H/dalNqFCo0httKiFZDn/ghJaQkZX2xheXF6CCChsl38sEpm1wm
	4VLFF/uKn3fqD80jLHSP2b9f5hIzir6SSggsiLxnIqTicmxm3XHrrQafY8m7W/BVYt+LyvYt5Rd
	PhksGV0Hvoj6+TlyuZWvonEAHm2yG0YZBwEmKPOiTsYDwDimRzUughmb17k1C3sc6mYJhD45eT3
	ZrZHMELdXjgTueKwqkS7j4tiHn6tiGHgF1QR9vtcwnoH/UTXe0bRdmkzJvWx2Hywp9XrRKBX7Hc
	j/VWRt54sKfyGrkD6f6de1NfOLBRMkjFUAh79jKIJBawsBGq+vWLeXcAoY=
X-Received: by 2002:a05:600c:19c8:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499821ca34amr3445025e9.10.1786566866182;
        Wed, 12 Aug 2026 13:34:26 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:49c4:121e:32:2b75? ([2001:8b0:aba:5f3c:49c4:121e:32:2b75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e31783sm7795485e9.3.2026.08.12.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:34:25 -0700 (PDT)
Message-ID: <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: paolo.wattebled@savoirfairelinux.com, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2026 21:34:24 +0100
In-Reply-To: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 20:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19921

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDExOjA0IC0wNDAwLCBQYW9sbyBXYXR0ZWJsZWQgdmlhIGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6Cj4gVG9hc3RlciByZWNvcmRzIGdsb2JhbCBidWls
ZCB2YXJpYWJsZXMgYnV0IGRvZXMgbm90IGV4cG9zZSB0aGUgZmluYWwKPiB2YWx1ZXMgYXNzb2Np
YXRlZCB3aXRoIGluZGl2aWR1YWwgcmVjaXBlcy4KPiAKPiBDb2xsZWN0IHZhcmlhYmxlcyBkZWZp
bmVkIG9yIG1vZGlmaWVkIGJ5IHJlY2lwZXMgYW5kIHRoZWlyIGJiYXBwZW5kcywKPiByZXNvbHZl
IGFjdGl2ZSBvdmVycmlkZXMgYW5kIGV4cGFuc2lvbnMsIGFuZCBzdG9yZSBvbmUgY29tcHJlc3Nl
ZCBKU09OCj4gc25hcHNob3QgaW4gdGhlIGRhdGFiYXNlIGZvciBlYWNoIGJ1aWxkIGFuZCByZWNp
cGUuIEtlZXAgdGhlIHZhcmlhYmxlCj4gY291bnQgc2VwYXJhdGVseSB0byBhdm9pZCBkZWNvbXBy
ZXNzaW5nIHNuYXBzaG90cyBpbiByZWNpcGUtbGlzdAo+IHF1ZXJpZXMuCj4gCj4gRXhwb3NlIHRo
ZSB2YWx1ZXMgdGhyb3VnaCBhIHNlYXJjaGFibGUgYW5kIHBhZ2luYXRlZCBWYXJpYWJsZXMgdGFi
IGFuZAo+IHNob3cgdGhlaXIgY291bnRzIGluIHRoZSBidWlsdC1yZWNpcGVzIHRhYmxlIGFuZCBy
ZWNpcGUgcGFja2FnZSB2aWV3Lgo+IFByZXNlcnZlIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRlciBk
ZXBlbmRlbmN5IHBheWxvYWRzIGFuZCBpbnZhbGlkYXRlCj4gc3RhbGUgQml0QmFrZSBjYWNoZXMg
YWZ0ZXIgZXh0ZW5kaW5nIHRoZSBjYWNoZWQgcmVjaXBlIGluZm9ybWF0aW9uLgo+IAo+IFRlc3Rz
IGNvdmVyIHZhcmlhYmxlIGNvbGxlY3Rpb24sIGNhY2hlIHRyYW5zcG9ydCwgZGF0YWJhc2UgcGVy
c2lzdGVuY2UsCj4gYmFja3dhcmQgY29tcGF0aWJpbGl0eSwgc2VhcmNoaW5nLCBwYWdpbmF0aW9u
LCBlc2NhcGluZywgYW5kIGNvdW50cy4KPiAKPiBBSS1HZW5lcmF0ZWQ6IFVzZXMgR2l0SHViIENv
cGlsb3QgYW5kIE9wZW5Db2RlIHdpdGggR1BULTUuNiBTb2wKPiBTaWduZWQtb2ZmLWJ5OiBQYW9s
byBXYXR0ZWJsZWQgPHBhb2xvLndhdHRlYmxlZEBzYXZvaXJmYWlyZWxpbnV4LmNvbT4KPiAtLS0K
PiDCoGJpbi9iaXRiYWtlLXNlbGZ0ZXN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqBsaWIvYmIvY2FjaGUucHnCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MiArLQo+IMKgbGliL2JiL2NhY2hlX2V4dHJhLnB5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2NiArKysrKysrLQo+IMKgbGliL2JiL2Nvb2tlci5w
ecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNiArLQo+IMKgbGliL2JiL3Rlc3RzL2NhY2hlX2V4dHJhLnB5wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTQxICsrKysrKysrKysrKysrKysKPiDCoGxpYi9i
Yi91aS9idWlsZGluZm9oZWxwZXIucHnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyMSArKy0KPiDCoC4uLi9vcm0vbWlncmF0aW9ucy8wMDIyX3JlY2lwZXZhcmlhYmxlLnB5
wqDCoMKgwqAgfMKgIDI3ICsrKwo+IMKgbGliL3RvYXN0ZXIvb3JtL21vZGVscy5wecKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsrCj4gwqBsaWIvdG9hc3Rl
ci90ZXN0cy9kYi90ZXN0X2RiLnB5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEwMSAr
KysrKysrKysrKysKPiDCoGxpYi90b2FzdGVyL3Rlc3RzL3ZpZXdzL3Rlc3Rfdmlld3MucHnCoMKg
wqDCoMKgwqDCoMKgIHwgMTU1ICsrKysrKysrKysrKysrKysrLQo+IMKgbGliL3RvYXN0ZXIvdG9h
c3Rlcmd1aS9idWlsZHRhYmxlcy5wecKgwqDCoMKgwqDCoMKgwqAgfMKgIDExICstCj4gwqAuLi4v
dGVtcGxhdGVzL2RldGFpbF9wYWdpbmF0aW9uX2JvdHRvbS5odG1swqDCoCB8wqDCoCA0ICstCj4g
wqAuLi4vdGVtcGxhdGVzL2RldGFpbF9zZWFyY2hfaGVhZGVyLmh0bWzCoMKgwqDCoMKgwqAgfMKg
wqAgMiArLQo+IMKgbGliL3RvYXN0ZXIvdG9hc3Rlcmd1aS90ZW1wbGF0ZXMvcmVjaXBlLmh0bWzC
oCB8wqAgMzIgKysrKwo+IMKgLi4uL3RvYXN0ZXJndWkvdGVtcGxhdGVzL3JlY2lwZV9wYWNrYWdl
cy5odG1sIHzCoMKgIDcgKwo+IMKgbGliL3RvYXN0ZXIvdG9hc3Rlcmd1aS92aWV3cy5wecKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDY4ICsrKysrKystCj4gwqAxNiBmaWxlcyBjaGFu
Z2VkLCA2NDIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQgbGliL2JiL3Rlc3RzL2NhY2hlX2V4dHJhLnB5Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
bGliL3RvYXN0ZXIvb3JtL21pZ3JhdGlvbnMvMDAyMl9yZWNpcGV2YXJpYWJsZS5weQoKQXQgdGhp
cyBwb2ludCB5b3UncmUgYmFzaWNhbGx5IGR1bXBpbmcgb3V0IHRoZSBlbnRpcmUgZGF0YXN0b3Jl
IGZvcgpldmVyeSBwb3NzaWJsZSByZWNpcGUuIER1ZSB0byB0aGUgc2l6ZSBvZiB0aGUgZGF0YSwg
SSBzdXNwZWN0IGl0IGlzCmp1c3QgYXMgZXhwZW5zaXZlIHRvIHJlcGFyc2UgYXMgaXQgaXMgdG8g
cmVhZCB0aGUgc3RvcmVkIGNvbXByZXNzZWQKZGF0YSBhbmQgaXQgaXNuJ3QgcmVhbGx5IGEgY2Fj
aGUgYW55IG1vcmUuIFRoZSBwcmVzZW5jZSBvZiB0aGF0IGRhdGEKd2lsbCBzbG93IHRoZSByZXN0
IG9mIHRoZSBzeXN0ZW0gZG93bi4KCkhhdmUgeW91IGxvb2tlZCBpbnRvIHRoZSBwZXJmb3JtYW5j
ZSAoaW4gc3BlZWQsIG1lbW9yeSBhbmQgZGlzayBzcGFjZSkKaW1wbGljYXRpb25zIG9mIHRoaXM/
CgpBbHNvLCBkbyB5b3Uga25vdyBwZW9wbGUgYWN0aXZlbHkgdXNpbmcgdG9hc3Rlcj8KCkNoZWVy
cywKClJpY2hhcmQKCgoKCgo=


