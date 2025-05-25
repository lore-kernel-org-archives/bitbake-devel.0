Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E7C54F30
	for <webhook@archiver.kernel.org>; Sun, 25 May 2025 10:26:53 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.7149.1748168806805453414
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 May 2025 03:26:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NokrNar8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a37d24e607so1310508f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748168805; x=1748773605; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+2AId3CQLD6b8NQQQBt67ljfJCFVvvuyH7UQ4cGPX4=;
        b=NokrNar83YZPWejNqY2av2N0ckP4Jthwx/6fZiepGm7F4j/p2/AvlS156su4F7N8Gc
         2t8ahWa4i65X3Khs9zaD7wvONvYZOaytBHmz2TYaeaAv3NihcGtYyQ/op8nv/gpSUqTb
         2bZgxr2/9zCMztP/qMMGfjxG8wLLcKolq40uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748168805; x=1748773605;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+2AId3CQLD6b8NQQQBt67ljfJCFVvvuyH7UQ4cGPX4=;
        b=j/7Pq9l+2cRDXWhUDuWDM1BL/DsIqYGU7yFIPC8xuxV57QO1niW2IELLl584u+2eFY
         KABcQV9pfhf5F3yUZEGxPXkIR0BLrvYMQDZjWtSx12MOY5iR245Pp1C/719is/IAqLwq
         WTQ2ZVen38hinZ9pYUWlu5IaYsapos/CelI4krBlx/kHc7ICSUyrUa2Nt/tROE8ssk6u
         lUXRs1BkS9FJUakVSgZLXyo9od+VXeSRJz8fP0fbccBZy8kSR5VvJ+BIc93tBez6DHrm
         dsT1W9ncRpxPcKliR9lz+3JHaF+sN32C6RMs3N4JLVscFfWlPNEgp1GQCmkNeGhBZVZ/
         O7kA==
X-Forwarded-Encrypted: i=1; AJvYcCVQSOaIteOydpObb6GcrqKxqWPmbOQup9LKRWqTbDNS0pc3ai5Jxm3AZBqXcV0MZaVQDCoHnwTSNM6JU/t3@lists.openembedded.org
X-Gm-Message-State: AOJu0YzRsFy6CR8HbjD1B47CbOCXyOXGuaS1MqqP+9njNmi2hqTATJHW
	v00cSoxhK0HYrRgX5ciQaKBXfLHwqAYxH1GYPZbDPTnp4H4qPfyyepfUE+wzCfUn8cs=
X-Gm-Gg: ASbGncuhG1MxYzghjBAuAP3IHQde+P1ZSuPsRCj9N1S7AEyQJz/8y94ygqmNEO8B8Ij
	UK+IyZ8A53+rn0ZeIkD4lBCO29rcYsKOwpCCQeJM+kMfKqwu41Z3btqZQ2Go/Mo3J1TWO0XkZ5k
	ez12IL096Nj9E9MUcvYuVstDTTXX65cDzSsdqJsdiKXWf1prs4l9Czb7wzSOyM6q+IoYY1bC6R+
	skXLM1eWF7J3S+UKZRkDaDunw0h1zk6MEHkxl1qm8diSG9G1eyKBOWpxN6/Vtuuaq1lJCRhDQ/O
	Sqt2wyOpm5RX5kcRN/rruPMWu1AfDhVTtjo2IYb4ZzlQgNgWNDR23M+/XFC5FIIQsNsCnmH6/ym
	fm2FiMF7HEurh8aKsLH44fgfqc0jiwuDmkB5aiDF/
X-Google-Smtp-Source: AGHT+IHH0Gxje1YP8phjB29jglmlol4ueAlGd38lrtelarWcqwJAKC0EXb89e3fxJQ3Gwa0gwHLc+Q==
X-Received: by 2002:a05:6000:4023:b0:3a2:3c51:7c1c with SMTP id ffacd0b85a97d-3a4cb49e27bmr3888914f8f.50.1748168804756;
        Sun, 25 May 2025 03:26:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3? ([2001:8b0:aba:5f3c:eeed:a623:5d92:7ad3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d437f961sm1618485f8f.17.2025.05.25.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:26:44 -0700 (PDT)
Message-ID: <9ceb0807bc83d4782c588a823adc822d19e0ab3b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Add ? to mark the start of the AZ_SAS
 query parameters
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: robbinvandamme@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbin.vandamme@renson.be>
Date: Sun, 25 May 2025 11:26:43 +0100
In-Reply-To: <20250523114923.2206133-1-robbin.vandamme@renson.be>
References: <20250523114923.2206133-1-robbin.vandamme@renson.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 10:26:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17637

T24gRnJpLCAyMDI1LTA1LTIzIGF0IDEzOjQ5ICswMjAwLCByb2JiaW4gdmFuIGRhbW1lIHZpYSBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IC0tLQo+IMKgbGliL2JiL2ZldGNoMi9hei5w
eSB8IDQgKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGliL2JiL2ZldGNoMi9hei5weSBiL2xpYi9iYi9mZXRj
aDIvYXoucHkKPiBpbmRleCAzNDYxMjRhOGIuLjMyNzI3MzM3OSAxMDA2NDQKPiAtLS0gYS9saWIv
YmIvZmV0Y2gyL2F6LnB5Cj4gKysrIGIvbGliL2JiL2ZldGNoMi9hei5weQo+IEBAIC0zNiw3ICsz
Niw3IEBAIGNsYXNzIEF6KFdnZXQpOgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBhel9zYXMgPSBk
LmdldFZhcignQVpfU0FTJykKPiDCoMKgwqDCoMKgwqDCoMKgIGlmIGF6X3NhcyBhbmQgYXpfc2Fz
IG5vdCBpbiB1ZC51cmw6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWQudXJsICs9IGF6X3Nh
cwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVkLnVybCArPSBmJz97YXpfc2FzfScKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFdnZXQuY2hlY2tzdGF0dXMoc2VsZiwgZmV0Y2gsIHVk
LCBkLCB0cnlfYWdhaW4pCj4gwqAKPiBAQCAtNjIsNyArNjIsNyBAQCBjbGFzcyBBeihXZ2V0KToK
PiDCoMKgwqDCoMKgwqDCoMKgIGF6X3NhcyA9IGQuZ2V0VmFyKCdBWl9TQVMnKQo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoCBpZiBhel9zYXM6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXp1cmkg
PSAnJXMlcyVzJXMnICUgKCdodHRwczovLycsIHVkLmhvc3QsIHVkLnBhdGgsIGF6X3NhcykKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhenVyaSA9ICclcyVzJXM/JXMnICUgKCdodHRwczovLycs
IHVkLmhvc3QsIHVkLnBhdGgsIGF6X3NhcykKPiDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF6dXJpID0gJyVzJXMlcycgJSAoJ2h0dHBzOi8vJywgdWQu
aG9zdCwgdWQucGF0aCkKClRoaXMgZGVmaW5pdGVseSBuZWVkcyBhbiBleHBsYWluYXRpb24gaW4g
dGhlIGNvbW1pdCBtZXNzYWdlIGFib3V0IHdoYXQKaXMgYnJlYWtpbmcsIHdoeSBhbmQgaG93IHRo
aXMgZml4ZXMgaXQuIFRoZXJlIGFsc28gaXNuJ3QgYSBTaWduZWQtb2ZmLQpieSBsaW5lLgoKQ2hl
ZXJzLAoKUmljaGFyZAo=


