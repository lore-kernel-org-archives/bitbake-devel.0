Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83E2C52D7C
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 14:01:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.123991.1723730468373560849
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Aug 2024 07:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Hw3prEcp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42808071810so6473295e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723730466; x=1724335266; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShNsTvJ0AkppTxQrdFOTwi9FR8QYs64xY99S50UOG8w=;
        b=Hw3prEcp+9ZsesDE1WhvSnbZaEQtzB29P4w/TRaJpUouNcBzDGRLfsBT2YhtqZQS8t
         3edhnbc1UMz7J5sLlwPE4/jGNEWRQBsDMqc8qs1ZcY49YCA7k6AhdnDmdD+yNc1Iy7GG
         7L9isGAGIx3i4Em8ksMa4oWGNo+hGTof4WG4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730466; x=1724335266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ShNsTvJ0AkppTxQrdFOTwi9FR8QYs64xY99S50UOG8w=;
        b=KQp1+U2dE/PGAxGG2g587atG0+/O5jZTW2T0tzrH/b7y4tnKpBGfzRtRaA4q46UgH7
         ywBXfVwPD2zWuOxgnP/63HfRmKjjc7787TzXwyO23Fiq4pUV/00wHawFfRBR5rhNmWgF
         NOiMD16AJlekeQWDt8sjzu9BbDMGbGB2YBFPbBD+iHhZR5hbePd84ajQABFlzXFt63Hd
         Jxtjd6634oCdftnbfgV7t7D16G2JUqIn5ibZKBzPm5R41DkaH+q3UK25i40PEIc1G62p
         HVqHfiS+AYc0QiSE5IdlHbIs1DIaQpbiHesVU6m1KKqm4G8JUEJgN4Q9ehaFlCbgJ/Jr
         HyFA==
X-Forwarded-Encrypted: i=1; AJvYcCUDS37nK597cntkBOR+ookpBPRTj1a17aUCKvK2p7PFDhWV3QnYDo+HthshfzqjVOc1wX28ArSYwboLm+o18LtXXxRE5sgdLnhVxLxXNX6YEVXIjmI=
X-Gm-Message-State: AOJu0YyTXnuzFLciOJtsIrWTCsJ5O5F4O+2wxgN14XuDP9pKE/GlnzEr
	OhXB9x+P/40hswXgPa5XsoXXnQqWt/7FrKbWlylLTjHff83Y400fxFZAiYVnSKybLdc/8KWKD1L
	OfBU=
X-Google-Smtp-Source: AGHT+IGBmG8P1PNozbvF+h6Uq+utxpv4vL/Z5GQcCeXMFr2vWMSnZ0I9XDcVxFkcyEbWnZQf+bz49A==
X-Received: by 2002:a05:6000:cc2:b0:368:3f56:b24a with SMTP id ffacd0b85a97d-37177777818mr4685357f8f.15.1723730466435;
        Thu, 15 Aug 2024 07:01:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2bbd:6430:deb7:a333? ([2001:8b0:aba:5f3c:2bbd:6430:deb7:a333])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a8fcsm1614631f8f.63.2024.08.15.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:01:05 -0700 (PDT)
Message-ID: <c4d8c96110f0686387c4b9b008a2bdee3014c439.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] bb: Log str() instead of repr() for
 exceptions in build
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: tdah@bang-olufsen.dk, bitbake-devel@lists.openembedded.org
Date: Thu, 15 Aug 2024 15:01:04 +0100
In-Reply-To: <20240809115013.17469-2-tdah@bang-olufsen.dk>
References: <20240809115013.17469-1-tdah@bang-olufsen.dk>
	 <20240809115013.17469-2-tdah@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 14:01:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16486

T24gRnJpLCAyMDI0LTA4LTA5IGF0IDEzOjUwICswMjAwLCBUcm9lbHMgRGFsc2dhYXJkIEhvZmZt
ZXllciB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToKPiBXaGVuIGdldHRpbmcgZXJy
b3JzIGR1cmluZyBidWlsZCwgdGhleSB3b3VsZCBiZSBwcmludGVkIHVzaW5nIHJlcHIoKSwgd2hp
Y2gKPiBkb2VzbnQgaGF2ZSBhIGxvdCBvZiBjb250ZXh0IGluIHNvbWUgY2FzZXMuCj4gRm9yIGV4
YW1wbGUgRmlsZU5vdEZvdW5kRXJyb3IoMiwgImZpbGUgb3IgZGlyZWN0b3J5IG5vdCBmb3VuZCIp
LCB3b3VsZCBiZQo+IHByaW50ZWQsIHdpdGhvdXQgdGhlIHBhdGggb2YgdGhlIGZpbGUgbm90IGZv
dW5kLgo+IFRoaXMgY2hhbmdlcyB0aGUgYnVpbGQgbG9nZ2luZyB0byB1c2Ugc3RyKCkgaW5zdGVh
ZCwgd2hpY2ggYWNjb3JkaW5nIHRvCj4gdGhlIHNwZWMgaXMgZm9yZSBodW1hbiByZWFkYWJsZSBz
dHJpbmdzLCB3aGVyZWFzIHJlcHIoKSBpcyBmb3Igc3RyaW5nCj4gcmVwcmVzZW50YXRpb25zIHRo
YXQgY2FuIGJlIGJlIHVzZWQgYXMgdmFsaWQgcHl0aG9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRy
b2VscyBEYWxzZ2FhcmQgSG9mZm1leWVyIDx0ZGFoQGJhbmctb2x1ZnNlbi5kaz4KPiAtLS0KPiDC
oGxpYi9iYi9idWlsZC5weSB8IDQgKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2J1aWxkLnB5IGIv
bGliL2JiL2J1aWxkLnB5Cj4gaW5kZXggYWI4YmNlM2Q1Li4wOTc3MzAwNDcgMTAwNjQ0Cj4gLS0t
IGEvbGliL2JiL2J1aWxkLnB5Cj4gKysrIGIvbGliL2JiL2J1aWxkLnB5Cj4gQEAgLTc0Myw3ICs3
NDMsNyBAQCBkZWYgX2V4ZWNfdGFzayhmbiwgdGFzaywgZCwgcXVpZXRlcnIpOgo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoCBpZiBxdWlldGVycjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
bm90IGhhbmRsZWQ6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dnZXIud2Fy
bmluZyhyZXByKGV4YykpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dnZXIu
d2FybmluZyhzdHIoZXhjKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZlbnQuZmlyZShU
YXNrRmFpbGVkU2lsZW50KHRhc2ssIGZuLCBsb2dmbiwgbG9jYWxkYXRhKSwgbG9jYWxkYXRhKQo+
IMKgwqDCoMKgwqDCoMKgwqAgZWxzZToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJycHJp
bnRlZCA9IGVycmNoay50cmlnZ2VyZWQKPiBAQCAtNzUyLDcgKzc1Miw3IEBAIGRlZiBfZXhlY190
YXNrKGZuLCB0YXNrLCBkLCBxdWlldGVycik6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IHZlcmJvc2VTdGRvdXRMb2dnaW5nIG9yIGhhbmRsZWQ6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZXJycHJpbnRlZCA9IFRydWUKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgbm90IGhhbmRsZWQ6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dnZXIu
ZXJyb3IocmVwcihleGMpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9nZ2Vy
LmVycm9yKHN0cihleGMpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBldmVudC5maXJlKFRh
c2tGYWlsZWQodGFzaywgZm4sIGxvZ2ZuLCBsb2NhbGRhdGEsIGVycnByaW50ZWQpLCBsb2NhbGRh
dGEpCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMQo+IMKgCgpHb2luZyBieSB0aGUgcHl0aG9u
IGRvY3MsIHRoaXMgaXMgdGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8uIEkgYWxzbyBrbm93CndlJ3Zl
IGhhZCBoYXJkIHRvIGRlYnVnIHByb2JsZW1zIGR1ZSB0byBzdHIoKSBub3QgZ2l2aW5nIGVub3Vn
aAppbmZvcm1hdGlvbiB0byBkZWJ1ZyBleGNlcHRpb25zIHRob3VnaCB3aGljaCBkb2VzIG1lYW4g
SSdtIGEgYml0CmNvbmZsaWN0ZWQgYWJvdXQgZG9pbmcgdGhpcywgaXQgZmVlbHMgbGlrZSB3ZSdy
ZSBnb2luZyBhcm91bmQgaW4KY2lyY2xlcyA6KAoKQ2hlZXJzLAoKUmljaGFyZAo=


