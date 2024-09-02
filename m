Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8411CD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 11:58:18 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.37025.1725278294218576987
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 04:58:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XVDkKKB5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c180d123so957037f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725278293; x=1725883093; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiU5GNyq+J2hrALZQIe0MXzKWmv1pmoN89xrS4Q4Hzg=;
        b=XVDkKKB5zYDHuJkaTSr3oH20FtoUSIEHKfBiX8xAbj/rCHBd5BxyrUgQn6IoSig/0+
         ZeM5TOuqaUMrLGvnec49nqfJBYnkn7cSAYidkMkUmOXEl6R/HTjOTfrmXBQTCcQIRsPn
         B967GRc11fOQHSXGVQ+81q+shtMijyUjTKQqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278293; x=1725883093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GiU5GNyq+J2hrALZQIe0MXzKWmv1pmoN89xrS4Q4Hzg=;
        b=npOd4CH9lbrALgDCd2L0sZs4X1baQkrqy+p9DJfr3yUU4BLe9qrUPiwMwD0RZRetIV
         fet7pFSJODc2opr9ijXN9MfFkh0Wu/2k/UjwzF4LkjQaH07yhFEHKshsgxdyrTAbhUOA
         yh7N2NTWp0+bAz+/rXec5+TVS2OiooHEU3woxuUqZQgkAUPItTNOBN9Oc+n8/ORdxjO9
         C44LkvY5UZ1S4ez73Ej3xUh/y2EhILDNokcefxwwnN8GGmnAYj5PHCiaE4et38Rpk7eI
         vYXHh2ZfZdLvIAdO/FSouYXqUuxxpuCAYlP8AImKSsK99i1igqK3nSMZR12Xi4IQ6O7X
         Ptlw==
X-Forwarded-Encrypted: i=1; AJvYcCVDTg2G6EeORsH9HSjEUBpc6sZDzh8En/roW+lIMRIfBbZsEbZRCarTvZI3hnM0xwCGtwdVk1ftHBDsZP/g@lists.openembedded.org
X-Gm-Message-State: AOJu0YwLZx3zeKaZsAv++130ouKhdyOlpAl0bVifeo0X6+vPmOhlxaHq
	HNivvqzKgtIso26R622vFJje7dFKmGZYYljcqFi1fbpRuXopt9cvFZguDlDw7SE=
X-Google-Smtp-Source: AGHT+IHSxnGjMLN9M8dddSM2d4YbLa0ainvqMJaR33wNDx8Zifig9sDhSy8IiOx2oR7PT7fnj49LPw==
X-Received: by 2002:adf:e70f:0:b0:374:c35a:7335 with SMTP id ffacd0b85a97d-374c35a73b3mr3373908f8f.18.1725278292487;
        Mon, 02 Sep 2024 04:58:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ed45:1ec7:2c83:ff6d? ([2001:8b0:aba:5f3c:ed45:1ec7:2c83:ff6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb01d300csm146573675e9.15.2024.09.02.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:58:11 -0700 (PDT)
Message-ID: <65ec906f864408329f7435f8123d4a254019cf04.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0] Appends discarded by
 expandVarref
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adam.blank.g@gmail.com, bitbake-devel@lists.openembedded.org
Date: Mon, 02 Sep 2024 12:58:11 +0100
In-Reply-To: <17365.1725273736587575150@lists.openembedded.org>
References: 
	<083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
	 <17365.1725273736587575150@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 11:58:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16535

T24gTW9uLCAyMDI0LTA5LTAyIGF0IDAzOjQyIC0wNzAwLCBBZGFtIEJsYW5rIHZpYQpsaXN0cy5v
cGVuZW1iZWRkZWQub3JnIHdyb3RlOgo+ID4gVG8gZml4IGl0IHdlIHJlYWxseSBuZWVkIHRvIGF2
b2lkIGV4cGFuZGluZyBhbnkgdmFyaWFibGVzIGF0IGFsbAo+ID4gYW5kCj4gPiBqdXN0IGRvIGEg
c2VhcmNoL3JlcGxhY2Ugb24gdGhlIHZhcmlhYmxlIGNvbnRlbnRzLgo+IEknZCBsaWtlIHRvIHBy
b3Bvc2Ugc29tZXRoaW5nIGxpa2UgdGhhdDoKPiDCoAo+IC0tLSBhL2xpYi9iYi9kYXRhX3NtYXJ0
LnB5Cj4gKysrIGIvbGliL2JiL2RhdGFfc21hcnQucHkKPiBAQCAtMTAwNyw5ICsxMDA3LDM0IEBA
IGNsYXNzIERhdGFTbWFydChNdXRhYmxlTWFwcGluZyk6Cj4gwqAgwqAgwqAgwqAgwqByZWYgPSAn
JHslc30nICUgdmFyaWFibGUKPiDCoCDCoCDCoCDCoCDCoHZhbHVlID0gc2VsZi5nZXRWYXIodmFy
aWFibGUsIEZhbHNlKQo+IMKgIMKgIMKgIMKgIMKgZm9yIGtleSBpbiBrZXlzOgo+IC0gwqAgwqAg
wqAgwqAgwqAgwqByZWZlcnJlcnZhbHVlID0gc2VsZi5nZXRWYXIoa2V5LCBGYWxzZSkKPiAtIMKg
IMKgIMKgIMKgIMKgIMKgaWYgcmVmZXJyZXJ2YWx1ZSBhbmQgaXNpbnN0YW5jZShyZWZlcnJlcnZh
bHVlLCBzdHIpIGFuZAo+IHJlZiBpbiByZWZlcnJlcnZhbHVlOgo+IC0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzZWxmLnNldFZhcihrZXksIHJlZmVycmVydmFsdWUucmVwbGFjZShyZWYsIHZhbHVl
KSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgY293ID0gRmFsc2UKPiArIMKgIMKgIMKgIMKgIMKgIMKg
aWYgbm90IGtleSBpbiBzZWxmLmRpY3Q6Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxvY2Fs
X3ZhciwgXyA9IHNlbGYuX2ZpbmRWYXIoa2V5KQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
b3cgPSBUcnVlCj4gKyDCoCDCoCDCoCDCoCDCoCDCoGVsc2U6Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGxvY2FsX3ZhciA9IHNlbGYuZGljdFtrZXldCj4gKwo+ICsgwqAgwqAgwqAgwqAgwqAg
wqBmb3Igc0tleSBpbiBbIl9jb250ZW50IiwgIl9kZWZhdWx0dmFsIiwgIjphcHBlbmQiLAo+ICI6
cHJlcGVuZCIsICI6cmVtb3ZlIl06Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCA9IGxv
Y2FsX3ZhcltzS2V5XSBpZiBzS2V5IGluIGxvY2FsX3ZhciBlbHNlIE5vbmUKPiArCj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIGlzaW5zdGFuY2UodmFsLCBzdHIpIGFuZCByZWYgaW4gdmFs
Ogo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwyID0gdmFsLnJlcGxhY2UocmVm
LCB2YWx1ZSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgY293Ogo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLl9tYWtlU2hhZG93Q29weShrZXkp
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvdyA9IEZhbHNlCj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYuZGljdFtrZXldW3NLZXldID0gdmFsMgo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbGlmIGlzaW5zdGFuY2UodmFsLCBsaXN0KToKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmFsMiA9IE5vbmUKPiArIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZm9yIGksIChyLCBvKSBpbiBlbnVtZXJhdGUodmFsKToKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgcmVmIGluIHI6Cj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIG5vdCB2YWwyOgo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2YWwyID0gbGlzdCh2YWwp
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbDJbaV0gPSBb
ci5yZXBsYWNlKHJlZiwgdmFsdWUpLCBvXQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiB2YWwyOgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBjb3c6
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYuX21ha2VT
aGFkb3dDb3B5KGtleSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY293ID0gRmFsc2UKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vs
Zi5kaWN0W2tleV1bc0tleV0gPSB2YWwyCj4gwqAKPiBFZmZpY2llbmN5IHdpc2UgaXQgZG9lcyBu
b3QgZG8gbW9yZSB0aGF0IHRoZSBvcmlnaW5hbCBjb2RlLCBhbmQgaXQKPiBnZXRzIHN0cmFpZ2h0
IHRvIHRoZSBwb2ludC4KClRoZSBkb3duc2lkZSBvZiB0aGlzIGlzIHRoYXQgZmlyc3RseSwgaXQg
aXMgdXNpbmcgYSBsb3Qgb2YgaW50ZXJuYWwKa25vd2xlZGdlIG9mIHRoZSBkYXRhIHN0b3JlIHdo
aWNoIEkgd29ycnkgbWF5IG1ha2UgY2hhbmdlcyBtb3JlIGZyYWdpbGUKaW4gdGhhdCBjb2RlLsKg
CgpTZWNvbmRseSwgaXQgZG9lcyBicmVhayBzb21lIHVzYWdlcywgZm9yIGV4YW1wbGU6CgpBQkMg
PSAiJHtAZC5nZXRWYXIoJ0xBWUVSRElSJyl9IgoKd291bGQgbm8gbG9uZ2VyIHdvcmsgYWZ0ZXIg
dGhhdCBjaGFuZ2UgKGFzIGEgc2ltcGxlIGV4YW1wbGUpLgoKSSdtIHRvcm4gb24gdGhpcyBidXQg
SSB3b3VsZCBub3RlIHRoYXQgeW91J3JlIHNlbmRpbmcgdGhlIHBhdGNoIGZvcgpraXJrc3RvbmUg
YW5kIHdlIGRlZmluaXRlbHkgY2FuJ3QgbWFrZSBhIGJyZWFraW5nIGNoYW5nZSBsaWtlIHRoYXQg
aW4Ka2lya3N0b25lIGF0IHRoaXMgcG9pbnQuCgpDaGVlcnMsCgpSaWNoYXJkCg==


