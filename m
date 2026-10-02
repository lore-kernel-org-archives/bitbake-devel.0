Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7420ACA5FD4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 09:06:30 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7167.1790931985338701289
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Oct 2026 02:06:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y6qfTN6l;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so59124925e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790931983; x=1791536783; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LzKvXRpNNB2/ipmIw4DV/GoCyHb2T3WMv3tjeNqRkfw=;
        b=Y6qfTN6lTS5b8ArNrCXTcCONNV6/YTOslPMFS8wfvUvmARNm7MDoUPeGMxIX4X6UC7
         D1gvQvEm73FCWxUn0gPKVgLvabFICQ6XqJZmmIxkePoKQ8OXqNsEoxIsW0VWX9Xj+VeM
         9z78jhQ7+oUXD0KMoPAiYdKAQhO1zFOxXMFQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790931983; x=1791536783;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzKvXRpNNB2/ipmIw4DV/GoCyHb2T3WMv3tjeNqRkfw=;
        b=1tUT6Nn1q4+GIKiA08sn6fg84OvAMAV9zhaym44vhyj7ZsnHQFW4oS8Xuw/eZljXLg
         EGfiZza0Gh5vQFHvbGVUyHNh/YrhUW3VvOMWq3N1luOXF3/FG8fKxVBI3eArUXgTcGXj
         9+gbKuhZgQpp+Tz07iiLvFhC+5KRkLuN70+6X430A9e4zL8jvb0C1M9ZtEgVlrUxjIuf
         haASz/wq+suM/3nQmikENYlcR2LFdyZgZ/Flqh8tfi3N7y75mIKRoGXUQZ6PZ6Q3tcRD
         RFOs1XE0v5qT7AMoHKeENsnm0Fy3ffd4VTTsOYl0699TytEtp2zunpkSRIsQeyiTI2ZB
         nf0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxn4AZxgN5ETLKkUnPbRV2AxkJqG+3tOiaRnADPCoevtv+Zmr0KLmHiw07KGufWERBm2Du6q5LXiQcBQSfr@lists.openembedded.org
X-Gm-Message-State: AFuF++m5dSkpb1MWRnEEXy/HydUJ+xy39TYq2lmFLmuA1InDQuT65z0R
	a8eHBW0Qqe1gtUVu43iR9KpQlWy0Az4y1I2WPJ2CxC7a8uVvi0ueXZIGDGTmL3ziMkc=
X-Gm-Gg: AYBFou2Vbk2dBlJoB0NvkZsa0QbUdvk4L1AfF9r88byMnehkXQQlnyWuRPLZB5Wx8MR
	A+jV6UUEnUFu6MD/dVBIE3MTub5AV5Rkb2PHfGH98zlv8jm6Wi5/t1Shk0TVqEKNL00SmVeyABw
	cdFr4Q1haTmtlVIb+3vqP9gFVAeJHRqUfZCEyxOtQ7MU89saJmhj6/PS6qE+qmqoScT3WWikWAs
	wRut7LgTwPds708m8Kn6e9bxOEnrGwcySHtzWk3nnSdR2qp9sgmK9GT5dZfqFh4iHUGxC3EhCo/
	mq3VlEPN3lZptApvQYmUTvK7EY4bA6iiSS7nc+H93fDJl99OfBy6AZlQjei3/bEzW7GDXrqIp1x
	Otea0tzg9IbD8ir5HA37N2mLtTEGibo/8FDMcfMEGMoz/llUvr2eTrcjJvP1LaM1M8R0+6c6lDr
	c8Iz5PL0GHOlj0o7IvASyNsF6niVQjFPkNDwvO9EOPSaU5dOlu2VYLNZ8eMBwd5mHpnYExaxEsO
	55tOXRLa9p41eNGyjJfIMHsafavBYppIiYzA2qJe6UWx22HDPoWm3ddNu7SmsUt
X-Received: by 2002:a05:600c:548b:b0:4a0:53e:b7bd with SMTP id 5b1f17b1804b1-4a027594e23mr37917235e9.18.1790931983259;
        Fri, 02 Oct 2026 02:06:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2? ([2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c8bb0sm69727675e9.11.2026.10.02.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:06:22 -0700 (PDT)
Message-ID: <b74c234b8309474162629112b3467f1331c2695b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ricardo.salveti@oss.qualcomm.com, bitbake-devel@lists.openembedded.org
Cc: jose.quaresma@oss.qualcomm.com
Date: Fri, 02 Oct 2026 10:06:21 +0100
In-Reply-To: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 09:06:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20290

SGkgUmljYXJkbywKCk9uIFR1ZSwgMjAyNi0wOS0yOSBhdCAwMToyOCArMDAwMCwgUmljYXJkbyBT
YWx2ZXRpIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IGRpZmYgLS1naXQgYS9s
aWIvYmIvdGVzdHMvZmV0Y2gucHkgYi9saWIvYmIvdGVzdHMvZmV0Y2gucHkKPiBpbmRleCA3MWIw
YTYzZmUuLjk2MjdiM2IxYiAxMDA2NDQKPiAtLS0gYS9saWIvYmIvdGVzdHMvZmV0Y2gucHkKPiAr
KysgYi9saWIvYmIvdGVzdHMvZmV0Y2gucHkKPiBAQCAtMTcwNiw2ICsxNzA2LDU5IEBAIGNsYXNz
IEZldGNoTGF0ZXN0VmVyc2lvblRlc3QoRmV0Y2hlclRlc3QpOgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHIgPSBiYi51dGlscy52ZXJjbXBfc3RyaW5nKHZlcnN0cmluZywgdl9s
YXJnZXIpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRUcnVl
KHIgPT0gLTEsIG1zZz0iUGFja2FnZSAlcywgdmVyc2lvbjogJXMgPD0gJXMiICUgKGtbMF0sIHZf
bGFyZ2VyLCB2ZXJzdHJpbmcpKQo+IMKgCj4gK2NsYXNzIFdnZXRDaGVja3N1bVRlc3QoRmV0Y2hl
clRlc3QpOgo+ICvCoMKgwqAgY29udGVudCA9IGIiYml0YmFrZSB3Z2V0IHRlc3QgZGF0YVxuIiAq
IDY0Cj4gK8KgwqDCoCAjIEFzIGxhcmdlIGFzIHRoZSByZWFsIGZpbGUsIHNvIHdnZXQgLS1jb250
aW51ZSBoYXMgbm90aGluZyBsZWZ0IHRvIGZldGNoCj4gK8KgwqDCoCAjIGFuZCBrZWVwcyBpdCBh
cyBpcwo+ICvCoMKgwqAgY29ycnVwdCA9IGIieCIgKiBsZW4oY29udGVudCkKPiArCj4gK8KgwqDC
oCBkZWYgc2V0VXAoc2VsZik6Cj4gK8KgwqDCoMKgwqDCoMKgIHN1cGVyKCkuc2V0VXAoKQo+ICvC
oMKgwqDCoMKgwqDCoCBzZWxmLnNlcnZlcmRpciA9IG9zLnBhdGguam9pbihzZWxmLnRlbXBkaXIs
ICJzZXJ2ZXIiKQo+ICvCoMKgwqDCoMKgwqDCoCBmb3Igc3ViZGlyIGluIFsidXBzdHJlYW0iLCAi
bWlycm9yIl06Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3MubWFrZWRpcnMob3MucGF0aC5q
b2luKHNlbGYuc2VydmVyZGlyLCBzdWJkaXIpKQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnNlcnZl
ciA9IEhUVFBTZXJ2aWNlKHNlbGYuc2VydmVyZGlyLCBob3N0PSIxMjcuMC4wLjEiKQo+ICvCoMKg
wqDCoMKgwqDCoCBzZWxmLnNlcnZlci5zdGFydCgpCj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYuYmFz
ZXVybCA9ICJodHRwOi8vMTI3LjAuMC4xOiVzIiAlIHNlbGYuc2VydmVyLnBvcnQKPiArwqDCoMKg
wqDCoMKgwqAgc2VsZi51cmwgPSAiJXMvdXBzdHJlYW0vdGVzdC5iaW47c2hhMjU2c3VtPSVzIiAl
ICgKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmJhc2V1cmwsIGhhc2hsaWIuc2hhMjU2
KHNlbGYuY29udGVudCkuaGV4ZGlnZXN0KCkpCj4gKwo+ICvCoMKgwqAgZGVmIHRlYXJEb3duKHNl
bGYpOgo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLnNlcnZlci5zdG9wKCkKPiArwqDCoMKgwqDCoMKg
wqAgc3VwZXIoKS50ZWFyRG93bigpCj4gKwo+ICvCoMKgwqAgZGVmIHdyaXRlKHNlbGYsIHBhdGgs
IGRhdGEpOgo+ICvCoMKgwqDCoMKgwqDCoCB3aXRoIG9wZW4ocGF0aCwgIndiIikgYXMgZjoKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmLndyaXRlKGRhdGEpCj4gKwo+ICvCoMKgwqAgZGVmIGFz
c2VydERvd25sb2FkZWQoc2VsZik6Cj4gK8KgwqDCoMKgwqDCoMKgIHdpdGggb3Blbihvcy5wYXRo
LmpvaW4oc2VsZi5kbGRpciwgInRlc3QuYmluIiksICJyYiIpIGFzIGY6Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc2VsZi5hc3NlcnRFcXVhbChmLnJlYWQoKSwgc2VsZi5jb250ZW50KQo+ICvC
oMKgwqDCoMKgwqDCoCBzZWxmLmFzc2VydEZhbHNlKG9zLnBhdGguZXhpc3RzKG9zLnBhdGguam9p
bihzZWxmLmRsZGlyLCAidGVzdC5iaW4udG1wIikpKQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmFz
c2VydFRydWUob3MucGF0aC5leGlzdHMob3MucGF0aC5qb2luKHNlbGYuZGxkaXIsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgInRlc3QuYmluX2JhZC1jaGVja3N1bV8lcyIgJSBoYXNobGliLnNo
YTI1NihzZWxmLmNvcnJ1cHQpLmhleGRpZ2VzdCgpKSkpCj4gKwo+ICvCoMKgwqAgZGVmIHRlc3Rf
d2dldF9jb3JydXB0X3BhcnRpYWxfZG93bmxvYWQoc2VsZik6Cj4gK8KgwqDCoMKgwqDCoMKgIHNl
bGYud3JpdGUob3MucGF0aC5qb2luKHNlbGYuc2VydmVyZGlyLCAidXBzdHJlYW0iLCAidGVzdC5i
aW4iKSwgc2VsZi5jb250ZW50KQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlKG9zLnBhdGgu
am9pbihzZWxmLmRsZGlyLCAidGVzdC5iaW4udG1wIiksIHNlbGYuY29ycnVwdCkKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgIGZldGNoZXIgPSBiYi5mZXRjaC5GZXRjaChbc2VsZi51cmxdLCBzZWxmLmQp
Cj4gK8KgwqDCoMKgwqDCoMKgIHdpdGggc2VsZi5hc3NlcnRSYWlzZXMoYmIuZmV0Y2guRmV0Y2hF
cnJvcik6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmV0Y2hlci5kb3dubG9hZCgpCj4gK8Kg
wqDCoMKgwqDCoMKgIHNlbGYuYXNzZXJ0RmFsc2Uob3MucGF0aC5leGlzdHMob3MucGF0aC5qb2lu
KHNlbGYuZGxkaXIsICJ0ZXN0LmJpbi50bXAiKSkpCj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBmZXRj
aGVyLmRvd25sb2FkKCkKPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnREb3dubG9hZGVkKCkK
PiArCj4gK8KgwqDCoCBkZWYgdGVzdF93Z2V0X21pcnJvcl9hZnRlcl9jaGVja3N1bV9mYWlsdXJl
KHNlbGYpOgo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLndyaXRlKG9zLnBhdGguam9pbihzZWxmLnNl
cnZlcmRpciwgInVwc3RyZWFtIiwgInRlc3QuYmluIiksIHNlbGYuY29ycnVwdCkKPiArwqDCoMKg
wqDCoMKgwqAgc2VsZi53cml0ZShvcy5wYXRoLmpvaW4oc2VsZi5zZXJ2ZXJkaXIsICJtaXJyb3Ii
LCAidGVzdC5iaW4iKSwgc2VsZi5jb250ZW50KQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmQuc2V0
VmFyKCJNSVJST1JTIiwgIiVzL3Vwc3RyZWFtLyAlcy9taXJyb3IvIiAlIChzZWxmLmJhc2V1cmws
IHNlbGYuYmFzZXVybCkpCj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBmZXRjaGVyID0gYmIuZmV0Y2gu
RmV0Y2goW3NlbGYudXJsXSwgc2VsZi5kKQo+ICvCoMKgwqDCoMKgwqDCoCBmZXRjaGVyLmRvd25s
b2FkKCkKPiArwqDCoMKgwqDCoMKgwqAgc2VsZi5hc3NlcnREb3dubG9hZGVkKCkKPiArCj4gwqBj
bGFzcyBGZXRjaENoZWNrU3RhdHVzVGVzdChGZXRjaGVyVGVzdCk6Cj4gwqDCoMKgwqAgdGVzdF93
Z2V0X3VyaXMgPSBbImh0dHBzOi8vZG93bmxvYWRzLnlvY3RvcHJvamVjdC5vcmcvcmVsZWFzZXMv
c2F0by9zYXRvLWVuZ2luZS0wLjEudGFyLmd6IiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAiaHR0cHM6Ly9kb3dubG9hZHMueW9jdG9wcm9qZWN0Lm9yZy9y
ZWxlYXNlcy9zYXRvL3NhdG8tZW5naW5lLTAuMi50YXIuZ3oiLAo+IAoKSSBtZXJnZWQgdGhpcyBi
dXQgdGhlIHRlc3RjYXNlIGlzIGludGVybWl0dGVudGx5IGZhaWxpbmcsIGUuZy46CgpodHRwczov
L2F1dG9idWlsZGVyLnlvY3RvcHJvamVjdC5vcmcvdmFsa3lyaWUvIy9idWlsZGVycy80OC9idWls
ZHMvNDc4Ni9zdGVwcy8xNC9sb2dzL3N0ZGlvCgp3aGljaCBJJ20gc3RydWdnbGluZyB0byB1bmRl
cnN0YW5kIHdoeS4gWW91IGNhbiBzZWUgdGhlIHJlbmFtZSBpbiB0aGUKbG9ncyBzbyBpdCBpbXBs
aWVzIHRoZSBjaGVja3N1bSBkaWRuJ3QgbWF0Y2ggdGhlIGV4cGVjdGVkIHZhbHVlLCBvciB0aGUK
ZmlsZSB3YXMgc29tZWhvdyBkZWxldGVkLi4uCgpDaGVlcnMsCgpSaWNoYXJkCg==


