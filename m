Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0941F4612B
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 14:26:06 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18844.1774275966058008830
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 07:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IerPlnAa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso2853094f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774275964; x=1774880764; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxGbK/ArfTpRiuWZnO99pRgBjNfyr7+hEzQU5vipQvw=;
        b=IerPlnAaAmu5Wzx4Nhn0Sgl6TZ4VJaTjNf6YTolb324G+4RhAQPXIo9ZehoOsDD4oF
         d22cnkfYVSRT+z9/0sBoAG0O3462V+35qN6MgQSWnZqqcNy5RqWHu5C5+1hNGm5GkC6U
         dTfqOfY50p1sVTH8ls4Xxzs5uKs2q9oM35gTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275964; x=1774880764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxGbK/ArfTpRiuWZnO99pRgBjNfyr7+hEzQU5vipQvw=;
        b=VehWc32+Qfnwy2O44H7EvuHwKh4zFTVfau7cHsRaQfujlqnqKdPMRcPg3iCThxF99I
         KywIytmbI0MQIs6MvZGIxtbaQU6jZDb/dE19vcmB5Y9R/pKIGF3GNDResFxfKOto4tjY
         4beczV16tYEGRgdTdna9ieIyXWXu8/HNwnw4UAi8JhxohMKpYlNnb1+jT+YDHi5V/WJv
         uJ/xgjdzT89E5vFCaxlzJtA8s8uhD9k5l7RxuoTCo3WqVU8vLc3JHUVmmIG2mZ9elOgT
         IrPJbL6y9/l6OYc+43D8xs0hE4S54qeDvdhFACbX5e3ddY5fLSzHsJGENiWMuHpJKtQC
         fOfA==
X-Forwarded-Encrypted: i=1; AJvYcCUPWKtC1PGWrivcvkrxqu+crNZLdw+hztsG2MUyfIrsx+fW4sIKjk9vHkcuFkjtv1Oq7p9nqutLJBKe5clp@lists.openembedded.org
X-Gm-Message-State: AOJu0YyCiephPE9UcHOkTYfz/ijOT3fUKgWaxl02CSKecgr54gHnmA/0
	bRL3KXPgwUtox0MffaRmUTFyjUxukqJQlV7+uALZViitqy35m5e3FLsDKyBAzYO0d2k=
X-Gm-Gg: ATEYQzxbpkYkt9H1eVSVorNR4miFYhtp94Wk2dUQKSrHosxoOWxvKWtSrZQMr73GlJB
	5yR+yWJYq+zSPkMWT0AJ9RRT/44FVG7AfMs7xgIC4qHS38wctU61TzEoMDrigkG5qXhgE2BPK+e
	YusnClVZDwH9NdeppEtdZ9pXGKqKftDCRfBMAtFr+ENRpHVIdIP9RLYERFi/+/I1HpnRuE93tWK
	7fxhXQ1MymQzpsy2i5GezTqWTpOwfvQoXzLbRI36Ybpj8YBHEztuh3ONZ3ItYpjyrzqCWI0nF2G
	lRVsqmMs2qsxeNNho4LmIxp7jfczw7sKnQG6X34viK1tyj1iNNK9Zkyj+2pmr6e464k4mgfLAgi
	XBGMrlyqPnPr0NX0Gr6Eofen7s8Jrv9YRuA3emq4VQ0WZOxTKpMvSceDV0vizVViiUcBn5WO7tE
	6UeDcN6uLxWEhQqEWOxw0mNR4I3TaEAFnXUeSdAQ/c6u/JGBKZdqLBVSiQk7b8bZdmgPVmXT+JQ
	1PXtaAOnTdaB/2B
X-Received: by 2002:a5d:5f86:0:b0:43b:5356:a7f7 with SMTP id ffacd0b85a97d-43b6423db79mr19949947f8f.9.1774275964299;
        Mon, 23 Mar 2026 07:26:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dee7:1e95:1d9e:b065? ([2001:8b0:aba:5f3c:dee7:1e95:1d9e:b065])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c7fsm29815410f8f.23.2026.03.23.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:26:03 -0700 (PDT)
Message-ID: <2ce1a755a695b80d825e28b9d31968cc4e1a30e4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 5/9] bitbake-setup: report local
 modifications blocking an update
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Date: Mon, 23 Mar 2026 14:26:02 +0000
In-Reply-To: <20260322193440.870120-6-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
	 <20260322193440.870120-6-adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 14:26:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19209

T24gU3VuLCAyMDI2LTAzLTIyIGF0IDIwOjM0ICswMTAwLCBBZHJpYW4gRnJlaWhvZmVyIHZpYSBs
aXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+IEZyb206IEFkcmlhbiBGcmVpaG9mZXIgPGFk
cmlhbi5mcmVpaG9mZXJAc2llbWVucy5jb20+Cj4gCj4gV2hlbiB1bnBhY2tfdXBkYXRlKCkgZGV0
ZWN0cyB1bmNvbW1pdHRlZCBjaGFuZ2VzIGluIGEgbGF5ZXIgcmVwb3NpdG9yeQo+IGl0IHJhaXNl
cyBhbiBVbnBhY2tFcnJvciwgd2hpY2ggcHJldmlvdXNseSBwcm9wYWdhdGVkIGFzIGFuIHVuaGFu
ZGxlZAo+IGV4Y2VwdGlvbiB3aXRoIGFuIG9wYXF1ZSB0cmFjZWJhY2suCj4gCj4gQ2F0Y2ggdGhl
IFVucGFja0Vycm9yIGluIF9jaGVja291dF9naXRfcmVtb3RlIGFuZCByZS1yYWlzZSBpdCBhcyBh
Cj4gcGxhaW4gRXhjZXB0aW9uIHdpdGggYSBtZXNzYWdlIHRoYXQ6Cj4gLSBuYW1lcyB0aGUgYWZm
ZWN0ZWQgc291cmNlIGFuZCBpdHMgcGF0aAo+IC0gdGVsbHMgdGhlIHVzZXIgdG8gY29tbWl0LCBz
dGFzaCBvciBkaXNjYXJkIHRoZSBjaGFuZ2VzCj4gLSBpbmNsdWRlcyB0aGUgb3JpZ2luYWwgZXJy
b3IgZGV0YWlsIGZvciBkaWFnbm9zdGljcwo+IAo+IFNpZ25lZC1vZmYtYnk6IEFkcmlhbiBGcmVp
aG9mZXIgPGFkcmlhbi5mcmVpaG9mZXJAc2llbWVucy5jb20+Cj4gLS0tCj4gwqBiaW4vYml0YmFr
ZS1zZXR1cCB8IDkgKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Jpbi9iaXRiYWtlLXNldHVwIGIvYmlu
L2JpdGJha2Utc2V0dXAKPiBpbmRleCBlOGQ1MjA2ODcuLjZkMjRmOGZjYyAxMDA3NTUKPiAtLS0g
YS9iaW4vYml0YmFrZS1zZXR1cAo+ICsrKyBiL2Jpbi9iaXRiYWtlLXNldHVwCj4gQEAgLTE4Miw3
ICsxODIsMTQgQEAgZGVmIGNoZWNrb3V0X2xheWVycyhsYXllcnMsIGNvbmZkaXIsIGxheWVyZGly
LCBkKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZToKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcmNfdXJpID0gZiJ7ZmV0Y2h1cml9O3Byb3RvY29sPXtwcm90fTty
ZXY9e3Jldn07bm9icmFuY2g9MTtkZXN0c3VmZml4PXtyZXBvZGlyfSIKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmV0Y2hlciA9IGJiLmZldGNoLkZldGNoKFtzcmNfdXJpXSwgZCkKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkb19mZXRjaChmZXRjaGVyLCBsYXllcmRpcikKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXBvZGlyX3BhdGggPSBvcy5wYXRoLmpvaW4obGF5ZXJkaXIsIHJl
cG9kaXIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5Ogo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZG9fZmV0Y2goZmV0Y2hlciwgbGF5ZXJkaXIpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZXhjZXB0IGJiLmZldGNoMi5VbnBhY2tFcnJvciBhcyBlOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFpc2UgRXhjZXB0aW9uKAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiQ2Fubm90IHVwZGF0ZSBzb3VyY2UgJ3t9JyBpbiB7
fSBiZWNhdXNlIGl0IGhhcyBsb2NhbCBtb2RpZmljYXRpb25zLlxuIgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUGxlYXNlIGNvbW1pdCwgc3Rhc2ggb3IgZGlzY2Fy
ZCB5b3VyIGNoYW5nZXMgYW5kIHJlLXJ1biB0aGUgdXBkYXRlLlxuIgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRGV0YWlsczoge30iLmZvcm1hdChyX25hbWUsIHJl
cG9kaXJfcGF0aCwgZSkpIGZyb20gTm9uZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cmxk
YXRhID0gZmV0Y2hlci51ZFtzcmNfdXJpXQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXZp
c2lvbiA9IHVybGRhdGEucmV2aXNpb24KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGF5ZXJz
X2ZpeGVkX3JldmlzaW9uc1tyX25hbWVdWydnaXQtcmVtb3RlJ11bJ3JldiddID0gcmV2aXNpb24K
ClRoZSBweXRob25pYyB0aGluZyB0byBkbyBoZXJlIGlzIHByb2JhYmx5IHRvIGNyZWF0ZSBhIG5l
dyBleGNlcHRpb24gZm9yCmxvY2FsIGNoYW5nZSBpbiB0aGUgZmV0Y2hlciBpdHNlbGYsIHN1YmNs
YXNzaW5nIFVucGFja0Vycm9yIHdpdGggdGhlCnN0aW5nIHlvdSdyZSB1c2luZyBhcyB0aGUgZXJy
b3Igc3RyaW5nPwoKQ2hlZXJzLAoKUmljaGFyZAoKCg==


