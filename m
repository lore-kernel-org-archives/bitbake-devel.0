Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDE9C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 23:59:07 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8679.1737590340669724940
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 15:59:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aYIKqySM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4368a293339so3458185e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 15:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737590339; x=1738195139; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPjsv+sfhPP04jvBlnZbcFKoVuDROlkirZLNGKzlZ+c=;
        b=aYIKqySMwDN/y4Na3ZGcHku+Rt14D9BWr3NP0qWdW8HYi0UPLADCXDQTEDPhHeuOCG
         UIeG7SSu6GxUEX21t6glFHc5yec2mc8Bfz6Y8mMEOgMzqj9vO4Zfa0wuFW5zMllvosAs
         +aGdRkRGTjfZndDtGymA7YES7Ysw2PUj8skMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737590339; x=1738195139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPjsv+sfhPP04jvBlnZbcFKoVuDROlkirZLNGKzlZ+c=;
        b=u1MNRO9UuvgahAzcpMiiLFJQnCa/0vJ4rYKMMcMdYaivmjSTciFObZxzsHOR+KDkix
         G3qFHJsS8pp6kITc+d+DLfkktn7vUZibE6wk2FWzPLTKTLfc6JQseShbpYTl1ChmCceB
         gSOL3uDdK25vePS7ONJqzooeqVe/F9piBrzmeA+aa7MYiZ4zu/8B+/bpmkxhHT2HifsF
         1UJu1ddM5CE0aeXrO912DIlzcniQ8AjK5TeJDzdQKx9/cofFGZ8xdTOvoA5f81+YzxfD
         5XJt17Jfi4SxSPqtWwUxf6QYf4K1bWoDi35trdkAHrcr9ToC4709N7s4gHhuYBMY03Jp
         4hVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMfeUYzBqTzTpXrulQqcso8M+y8W7rdfk9OEHthskyn1p8jE9aGw0ONuyQh2eKtz95Luq58ulL+gAd+vOp@lists.openembedded.org
X-Gm-Message-State: AOJu0YwkTdQ/+mdG4I80lRQUulYAa48/6GY1ZfHXcu8A61cgw8gkaGVw
	mK/YBiOcv/AgCvKr+N+pFGozVM4m6aI9iAoMjGcG0U7bFv/jfwn0cSYTYcOk5Oo=
X-Gm-Gg: ASbGncvPcafNKencLq+EZxf7EZqgiKB6761Ji5rB8DaEDbvFmlbn8IevUB9P/MPGWch
	1sioHEOMiWy2chkCcP+iR9XpSplPSF/xIW7/gQXAcYydrUV1WgqqFtxLadq9d22VSydzL7dgyqk
	h/TK5hrHwV6kRz1b8IB+36cMkxQ1v9CHK9R0LXlvRSLkGzmAH8E+ag8RgT6UimZF7ZL/l4ZU+9Q
	Buhxt0pJQxclqPENP+ftZEUug+mpKlT1/DzbRlZgOJW2bYQnHXNoI03GtmlVC9oh38rSLm87sEN
	1xfOI2tDAFfRmBHVbe2x/EIFDUwW2XOFh4Fq1rtZkqmfpfR6D/8ixAMowUk=
X-Google-Smtp-Source: AGHT+IGfyBKkdIZAbQxfF6FTZjkl14xURIeenxgBRbxuOyZ74vAgW2fQhm/0nG06Y5mDIn9EmYY7Tg==
X-Received: by 2002:adf:e8d1:0:b0:38b:da34:5915 with SMTP id ffacd0b85a97d-38bf566f5e5mr18563384f8f.23.1737590338923;
        Wed, 22 Jan 2025 15:58:58 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da76:a423:32d0:6ce0? ([2001:8b0:aba:5f3c:da76:a423:32d0:6ce0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3222bebsm17793598f8f.30.2025.01.22.15.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 15:58:56 -0800 (PST)
Message-ID: <d05b30d434783fde60e10f7a98074d98aa1f5186.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/4] bitbake: progressbar: Check
 resizable file descriptor.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: egyszeregy@freemail.hu, bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jan 2025 23:58:56 +0000
In-Reply-To: <20250122232411.133-2-egyszeregy@freemail.hu>
References: <20250122232411.133-1-egyszeregy@freemail.hu>
	 <20250122232411.133-2-egyszeregy@freemail.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 23:59:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17063

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDAwOjI0ICswMTAwLCBMaXZpdXMgdmlhIGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcgd3JvdGU6Cj4gRnJvbTogQmVuamFtaW4gU3rFkWtlIDxlZ3lzemVyZWd5QGZy
ZWVtYWlsLmh1Pgo+IAo+IC0gQ2hlY2sgaWYgZ2l2ZW4gZmlsZSBkZXNjcmlwdG9yIGlzIHJlc2l6
YWJsZS4KPiAtIEludHJvZHVjZSBzZWxmLl9mZF9jb25zb2xlIGFzIGEgZGVkaWNhdGVkIGF0dHJp
YnV0ZSBvZiBzZWxmLl9oYW5kbGVfcmVzaXplKCkuCj4gCj4gU2lnbmVkLW9mZi1ieTogQmVuamFt
aW4gU3rFkWtlIDxlZ3lzemVyZWd5QGZyZWVtYWlsLmh1Pgo+IC0tLQo+IMKgbGliL3Byb2dyZXNz
YmFyL3Byb2dyZXNzYmFyLnB5IHwgMjUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpUaGUgZXhpc3Rp
bmcgY29kZSBjaGVja2VkIGlmIGEgcmVzaXplIHdhcyBwb3NzaWJsZSBhbmQgdHJhcHBlZCB0aGUK
ZXhjZXB0aW9uIGlmIG5vdC4KClRoZSBuZXcgY29kZSBhc3N1bWVzIHN0ZG91dC9zdGRlcnIgYXJl
IHJlc2l6ZWFibGUgYW5kIGRvZXNuJ3QgaGF2ZSBhbgpleGNlcHRpb24gaWYgbm90LiBUaGUgY29t
bWl0IGRvZXMgbm90IHNheSB3aHkgZWl0aGVyIGNoYW5nZSBpcwpuZWNlc3Nhcnkgb3Igd2h5IHRo
ZXkncmUgYW4gaW1wcm92ZW1lbnQuIEl0IHJlbW92ZXMgdGhlIGNoZWNrLCBjb250cmEKdG8gd2hh
dCB0aGUgY29tbWl0IG1lc3NhZ2Ugc2F5cy4KCkNoZWVycywKClJpY2hhcmQKCgo+IGRpZmYgLS1n
aXQgYS9saWIvcHJvZ3Jlc3NiYXIvcHJvZ3Jlc3NiYXIucHkgYi9saWIvcHJvZ3Jlc3NiYXIvcHJv
Z3Jlc3NiYXIucHkKPiBpbmRleCBkNGRhMTBhYjcuLjIwM2ZmODA0ZiAxMDA2NDQKPiAtLS0gYS9s
aWIvcHJvZ3Jlc3NiYXIvcHJvZ3Jlc3NiYXIucHkKPiArKysgYi9saWIvcHJvZ3Jlc3NiYXIvcHJv
Z3Jlc3NiYXIucHkKPiBAQCAtMTEwLDE5ICsxMTAsMjYgQEAgY2xhc3MgUHJvZ3Jlc3NCYXIob2Jq
ZWN0KToKPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYud2lkZ2V0cyA9IHdpZGdldHMKPiDCoMKgwqDC
oMKgwqDCoMKgIHNlbGYuZmQgPSBmZAo+IMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5sZWZ0X2p1c3Rp
ZnkgPSBsZWZ0X2p1c3RpZnkKPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5fZmRfY29uc29sZSA9IE5v
bmUKPiArCj4gK8KgwqDCoMKgwqDCoMKgIGZkX251bSA9IGZkLmZpbGVubygpCj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYuc2lnbmFsX3NldCA9IEZhbHNlCj4gwqDCoMKgwqDCoMKgwqDCoCBp
ZiB0ZXJtX3dpZHRoIGlzIG5vdCBOb25lOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxm
LnRlcm1fd2lkdGggPSB0ZXJtX3dpZHRoCj4gK8KgwqDCoMKgwqDCoMKgIGVsaWYgKGZkX251bSA9
PSBzeXMuc3Rkb3V0LmZpbGVubygpKSBvciAoZmRfbnVtID09IHN5cy5zdGRlcnIuZmlsZW5vKCkp
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgQ2hlY2sgaWYgZ2l2ZW4gZmlsZSBkZXNjcmlw
dG9yIGlzIHJlc2l6YWJsZSBmb3IgZXhhbXBsZSBiZWxvbmcKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAjIHRvIGEgdGVybWluYWwvY29uc29sZSBhcyBTVERPVVQgb3IgU1RERVJSLiBJZiBmaWxl
IGRlc2NyaXB0b3IKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIGlzIHJlc2l6YWJsZSwgbGV0
J3MgYWxsb3cgdG8gdXNlIGZvciBzZWxmLl9oYW5kbGVfcmVzaXplKCkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAjIGluIGEgZGVkaWNhdGVkIHNlbGYuX2ZkX2NvbnNvbGUgaW4gb3JkZXIgdG8g
YmUgYWJsZSB0byBzZXQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIHRlbXBvcmFyaWx5L3Bl
cm1hbmVudGx5IHNlbGYuZmQgdG8gYW55IFN0cmluZ0lPIG9yIG90aGVyCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgIyBmaWxlIGRlc2NyaXB0b3IgbGF0ZXIuCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2VsZi5fZmRfY29uc29sZSA9IGZkCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Vs
Zi5faGFuZGxlX3Jlc2l6ZShOb25lLCBOb25lKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNp
Z25hbC5zaWduYWwoc2lnbmFsLlNJR1dJTkNILCBzZWxmLl9oYW5kbGVfcmVzaXplKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc2lnbmFsX3NldCA9IFRydWUKPiDCoMKgwqDCoMKgwqDC
oMKgIGVsc2U6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5Ogo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5faGFuZGxlX3Jlc2l6ZShOb25lLCBOb25lKQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2lnbmFsLnNpZ25hbChzaWduYWwuU0lHV0lOQ0gs
IHNlbGYuX2hhbmRsZV9yZXNpemUpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
ZWxmLnNpZ25hbF9zZXQgPSBUcnVlCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZXB0IChT
eXN0ZW1FeGl0LCBLZXlib2FyZEludGVycnVwdCk6IHJhaXNlCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJpbnQoIkRFQlVHIDUgJXMiICUgZSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNlbGYudGVybV93aWR0aCA9IHNlbGYuX2Vudl9zaXplKCkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLnRlcm1fd2lkdGggPSBzZWxmLl9lbnZfc2l6ZSgpCj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYuX19pdGVyYWJsZSA9IE5vbmUKPiDCoMKgwqDCoMKgwqDCoMKgIHNl
bGYuX3VwZGF0ZV93aWRnZXRzKCkKPiBAQCAtMTgyLDcgKzE4OSw3IEBAIGNsYXNzIFByb2dyZXNz
QmFyKG9iamVjdCk6Cj4gwqDCoMKgwqAgZGVmIF9oYW5kbGVfcmVzaXplKHNlbGYsIHNpZ251bT1O
b25lLCBmcmFtZT1Ob25lKToKPiDCoMKgwqDCoMKgwqDCoMKgICIiIlRyaWVzIHRvIGNhdGNoIHJl
c2l6ZSBzaWduYWxzIHNlbnQgZnJvbSB0aGUgdGVybWluYWwuIiIiCj4gwqAKPiAtwqDCoMKgwqDC
oMKgwqAgaCwgdyA9IGFycmF5KCdoJywgaW9jdGwoc2VsZi5mZCwgdGVybWlvcy5USU9DR1dJTlNa
LCAnXDAnICogOCkpWzoyXQo+ICvCoMKgwqDCoMKgwqDCoCBoLCB3ID0gYXJyYXkoJ2gnLCBpb2N0
bChzZWxmLl9mZF9jb25zb2xlLCB0ZXJtaW9zLlRJT0NHV0lOU1osICdcMCcgKiA4KSlbOjJdCj4g
wqDCoMKgwqDCoMKgwqDCoCBzZWxmLnRlcm1fd2lkdGggPSB3Cj4gwqAKCg==


