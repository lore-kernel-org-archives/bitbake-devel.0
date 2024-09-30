Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C1CF649D
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 09:12:09 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.50104.1727687507869734353
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 02:11:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RShVBHBa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1891368f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727687506; x=1728292306; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYpQBnX+5kPA0MceCe7tUBRvxCkGAfDq4DmKYP5KvoQ=;
        b=RShVBHBa2Fx4j+6yxKlYhxgT/70nXUnBAKd/QEiZQw6dHaa5fyPqca4R3OzOa3oKjQ
         /q6CrXqQUwK0Bq8/erkGjKziDC3m+ZoiTCOj8Y/Vvohx8UxTsDZJffowdPEJkKh7Bf6T
         HdW5tmEHw6ULmJ8RqSC7R+gFBT1a2GMSqkY74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687506; x=1728292306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aYpQBnX+5kPA0MceCe7tUBRvxCkGAfDq4DmKYP5KvoQ=;
        b=Ds3kIJQOyCvhmNNCJE/gfi61svXuGQnS8Ww1uCrMkkkQOmFFtvMBkW6U+d03bTeI1a
         GBb/offvy/3qDD7yUgb97/vGtXfQXA0AH7x5mk4vWcwOV5W/ZLvzQyWLEoql21eIFFnb
         6mhg11gbb8m8lkY7p7f3u7AqnMSNjPTNr+RJkPdiuOerXnQ8zgZckaDlBUK7k4MhXjzA
         AjGF4O58Nb5ErappRW4DVW0ixQmbO9GdqKxS6Kn/xV5a4sfeIc2HxePhX6sR+LkYZGNT
         p48RMIlIbyicZefSu5bd3FPTqgfr8IDXs5PfXwU14NN7HmxLHNowtYrsjAVeO0vgPaWQ
         Z0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUBD1aIaMQZlNOPsLvnK64dbhbLIat4z/Qsdnp0DGLJqLmmGcwkSA4KApN0wvFlN/uiC4W3KaX92hc/mLBH@lists.openembedded.org
X-Gm-Message-State: AOJu0YwFGaWmvDMW4a1+zrAP16nqNc5FOSzdg3O0O4joAfgI7YEnRDE2
	j+BLQonP2GMfSUZdomx7R09OD+g2aG5qI1qSP9GyTZlSRfgbcZNMp9Nayts7vOA=
X-Google-Smtp-Source: AGHT+IEPaeq7JTnRIjrhHLO3vA27BwQOKns18ZWu1VyXOxMIbOgncsvgFcj+Pj+iY257uCJ8kqL5DQ==
X-Received: by 2002:adf:f512:0:b0:376:e2f4:5414 with SMTP id ffacd0b85a97d-37ccdb099fbmr7640199f8f.5.1727687506291;
        Mon, 30 Sep 2024 02:11:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d? ([2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13a28sm98041635e9.29.2024.09.30.02.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:11:45 -0700 (PDT)
Message-ID: <956666c1c49ae4e4b1056d25ddbe9e125726d218.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 3/3] tests/parse: add coverage for
 old override syntax
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: kweihmann@outlook.com, bitbake-devel@lists.openembedded.org
Date: Mon, 30 Sep 2024 10:11:44 +0100
In-Reply-To: <GV1PR07MB91208B4ECFB120D35707021DA8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: 
	<GV1PR07MB91208B4ECFB120D35707021DA8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 09:12:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16615

T24gU2F0LCAyMDI0LTA5LTI4IGF0IDA5OjAwICswMjAwLCBLb25yYWQgV2VpaG1hbm4gdmlhIGxp
c3RzLm9wZW5lbWJlZGRlZC5vcmcgd3JvdGU6Cj4gaW5jbHVkaW5nIHByZXZpb3VzbHkgdW5jb252
ZXJlZCB0ZXN0cyBmb3IgdHJ1ZSBmYWlsdXJlIGNhc2VzIG9mCj4gX3ByZXBlbmQvX2FwcGVuZC9f
cmVtb3ZlLgo+IEluIGFkZGl0aW9uIGFkZCB0ZXN0cyBmb3Igbm90IHZhbGlkIGNhc2VzCj4gCj4g
U2lnbmVkLW9mZi1ieTogS29ucmFkIFdlaWhtYW5uIDxrd2VpaG1hbm5Ab3V0bG9vay5jb20+Cj4g
LS0tCj4gwqAgbGliL2JiL3Rlc3RzL3BhcnNlLnB5IHwgNjkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2OSBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0cy9wYXJzZS5weSBiL2xpYi9iYi90ZXN0
cy9wYXJzZS5weQo+IGluZGV4IDQxMDY3OWQ1YS4uMmRhM2EyYTIyIDEwMDY0NAo+IC0tLSBhL2xp
Yi9iYi90ZXN0cy9wYXJzZS5weQo+ICsrKyBiL2xpYi9iYi90ZXN0cy9wYXJzZS5weQo+IEBAIC0x
MzIsNiArMTMyLDc1IEBAIERFU0NSSVBUSU9OOiR7UE59LWRldiA9ICIke0RFU0NSSVBUSU9OfSBC
Igo+IMKgIFBOID0gImJjIgo+IMKgICIiIgo+IMKgICvCoMKgwqAgb3ZlcnJpZGVfb2xkX2FwcGVu
ZCA9ICIiIgo+ICtFWFRSQV9PRUNPTkZfYXBwZW5kID0gIiBjIgo+ICsiIiIKPiArCj4gK8KgwqDC
oCBkZWYgdGVzdF9wYXJzZV9vbGRfb3ZlcnJpZGVfc3ludGF4X2FwcGVuZChzZWxmKToKPiArwqDC
oMKgwqDCoMKgwqAgZiA9IHNlbGYucGFyc2VoZWxwZXIoc2VsZi5vdmVycmlkZV9vbGRfYXBwZW5k
KQo+ICvCoMKgwqDCoMKgwqDCoCB0cnk6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmIucGFy
c2UuaGFuZGxlKGYubmFtZSwgc2VsZi5kKVsnJ10KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
ZWxmLmZhaWwoJ1BhdHRlcm4gc2hvdWxkIGhhdmUgcmFpc2VkIGJiLkJCSGFuZGxlZEV4Y2VwdGlv
bicpCj4gK8KgwqDCoMKgwqDCoMKgIGV4Y2VwdCBiYi5CQkhhbmRsZWRFeGNlcHRpb246Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFzcwo+ICsKPiArwqDCoMKgIG92ZXJyaWRlX29sZF9wcmVw
ZW5kID0gIiIiCj4gK0VYVFJBX09FQ09ORl9wcmVwZW5kID0gIiBjIgo+ICsiIiIKPiArCj4gK8Kg
wqDCoCBkZWYgdGVzdF9wYXJzZV9vbGRfb3ZlcnJpZGVfc3ludGF4X3ByZXBlbmQoc2VsZik6Cj4g
K8KgwqDCoMKgwqDCoMKgIGYgPSBzZWxmLnBhcnNlaGVscGVyKHNlbGYub3ZlcnJpZGVfb2xkX3By
ZXBlbmQpCj4gK8KgwqDCoMKgwqDCoMKgIHRyeToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
Yi5wYXJzZS5oYW5kbGUoZi5uYW1lLCBzZWxmLmQpWycnXQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlbGYuZmFpbCgnUGF0dGVybiBzaG91bGQgaGF2ZSByYWlzZWQgYmIuQkJIYW5kbGVkRXhj
ZXB0aW9uJykKPiArwqDCoMKgwqDCoMKgwqAgZXhjZXB0IGJiLkJCSGFuZGxlZEV4Y2VwdGlvbjoK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXNzCj4gKwo+ICvCoMKgwqAgb3ZlcnJpZGVfb2xk
X3JlbW92ZSA9ICIiIgo+ICtFWFRSQV9PRUNPTkZfcmVtb3ZlID0gIiBjIgo+ICsiIiIKPiArCj4g
K8KgwqDCoCBkZWYgdGVzdF9wYXJzZV9vbGRfb3ZlcnJpZGVfc3ludGF4X3JlbW92ZShzZWxmKToK
PiArwqDCoMKgwqDCoMKgwqAgZiA9IHNlbGYucGFyc2VoZWxwZXIoc2VsZi5vdmVycmlkZV9vbGRf
cmVtb3ZlKQo+ICvCoMKgwqDCoMKgwqDCoCB0cnk6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YmIucGFyc2UuaGFuZGxlKGYubmFtZSwgc2VsZi5kKVsnJ10KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzZWxmLmZhaWwoJ1BhdHRlcm4gc2hvdWxkIGhhdmUgcmFpc2VkIGJiLkJCSGFuZGxlZEV4
Y2VwdGlvbicpCj4gK8KgwqDCoMKgwqDCoMKgIGV4Y2VwdCBiYi5CQkhhbmRsZWRFeGNlcHRpb246
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFzcwo+ICsKPiArCgpUaGlzIGNhbiBiZSBzaW1w
bGlmaWVkIHRvIGE6Cgpmb3IgeHh4IGluIFsicmVtb3ZlIiwgInByZXBlbmQiLCAiYXBwZW5kIl06
Cgpsb29wIHRvIHJlbW92ZSB0aGUgZHVwbGljYXRpb24gaW4gdGhlIHRlc3RzLgoKQ2hlZXJzLAoK
UmljaGFyZAoK


