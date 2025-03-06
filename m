Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424EFC282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 22:05:17 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.360.1741298713740587702
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 14:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FvKZo1OO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so9372265e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741298712; x=1741903512; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MvZ9aAuECaeCaBVW29rHD0KI/NxR2zxjyya6cZrTbuM=;
        b=FvKZo1OOlbdC+yx+C0GHHfL9y2gM+GRToCiU4PZNfYOt9c46MQNeluzzy3kt0S21PF
         lI348hJVM4D9axpEHcNvIl6OJVu5qnWfqnWDTzaqw9VGAgXI32kghoZCi1stHpieh5Ow
         y711jTOfk43/TdxHNvXE8oNsvoqqGaCQaIYa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298712; x=1741903512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvZ9aAuECaeCaBVW29rHD0KI/NxR2zxjyya6cZrTbuM=;
        b=nICT7dgEit6NocDyk6X4pbDHuQ0/1YubhHwOzAGrsbP3fhLOTeLGQblB7O5rjw5TM+
         PNCOBQz+ZN7iavYuuUzgQZrjxmCTjSeVV730gUP6VNQm2/+/Dn5nIA0GGdKY+H8L5I0q
         yGsge/FIordSWj1zHjEf6PNfbWAM/6gv5DaGuDgKuNfIyJe0kMSBCBRwVh9J9zVEM2/O
         5kGBOAScIDfv17mgsSq+7IJx7csvpuakBS33eNlccyPIpQasMkdS5lvXu3F8TUKNLEBL
         Fw0uoSfubrJPk5PgtO9VQ/RUh0Qx+XcE6auiEx3QReHBsfdcAKpQ4E1SscF2UnHEq7mj
         8Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCWLY3INGHDOR3i1Kxn4OA5NwhB16Erc5sigQkWQ0EsQrlG5Y5BxNfz50F7CMlcgzF/+KYz/Q9bdsgwkYMOu@lists.openembedded.org
X-Gm-Message-State: AOJu0YzAYWhvrquCUZiyyN3xp0qR6G2Na3tErrFCqJByvPY6IalmOMVC
	F7n47RAitk1KRxyfpUyJumnErFtHVOERjEzg1SKFCOxEJSQk7wvz/pePId4YbSc=
X-Gm-Gg: ASbGncs7WF0/gKsRaljN3tDgrKiewogjoxVr7OlEKrh6F7wkFkaSvbw7LPJkJeYDKMZ
	ZXG2GtL+yfN5WfCXa5pPnde3MZxIYp6b9qNcZMUJFIulkCF0LR/urHck75VmeIV7iFsW9smzpit
	+9jRgEEhQEl178Ix2pz3tqeiX8sFseWrBRknmz/l1pTpEZ/lFwZXNtIwvZmubXFwHzFEm75v/FI
	Z0FdfZKDGuTSvIpPp1Pqc/6G/QHaz39WXKTS3iVWkxz8AYXZF5b8TZyUhrIhxj7LSYPqsgpnlTX
	ggFr9fquYgIXpnrhP/IpDCdFOf5qG+b73Z9csJIYwXK2UGofyX/mWlE7oRKOtCqwirruRnkmbWs
	S5UX4RkvVOGbktkWxbxnKSe3JJ3Ue
X-Google-Smtp-Source: AGHT+IHl607+PelODK00zsY0NHV9p6nFFNM09VIb+bkLEAhevYIcc70FwPnIopjWfL4oblSblVR3tQ==
X-Received: by 2002:a05:600c:1907:b0:439:8e3d:fb58 with SMTP id 5b1f17b1804b1-43c5a5fe368mr10184775e9.11.1741298712024;
        Thu, 06 Mar 2025 14:05:12 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2d49:705a:d4c1:b0? ([2001:8b0:aba:5f3c:2d49:705a:d4c1:b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42b7245sm61550915e9.17.2025.03.06.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:05:11 -0800 (PST)
Message-ID: <4090036f9516a7af7e3bbf6abeb76490c1c2abc6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] codeparser: Skipping typing when
 inspecting Python modules
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pmi183@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Date: Thu, 06 Mar 2025 22:05:10 +0000
In-Reply-To: <20250306150628.278459-1-pmi183@gmail.com>
References: <20250306150628.278459-1-pmi183@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 22:05:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17396

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDE1OjA2ICswMDAwLCBQZWRybyBGZXJyZWlyYSB2aWEgbGlz
dHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToKPiBGcm9tOiBQZWRybyBGZXJyZWlyYSA8UGVkcm8u
U2lsdmEuRmVycmVpcmFAY3JpdGljYWx0ZWNod29ya3MuY29tPgo+IAo+IElmIGEgY3VzdG9tIHB5
dGhvbiBtb2R1bGUgaXMgYWRkZWQgdGhydSBCQklNUE9SVFMgYW5kIGl0Cj4gdXNlcyB0eXBpbmco
QW55LFR1cGxlLFVuaW9uLi4uKSwgY29kZXBhcnNlciB3aWxsIGZhaWwgYmVjYXVzZQo+IGluc3Bl
Y3QucHkgcmFpc2VzIFR5cGVFcnJvciBleGNlcHRpb24gaWYgdGhlIG9iamVjdCBpcyBhCj4gYnVp
bHQtaW4gbW9kdWxlLCBjbGFzcywgb3IgZnVuY3Rpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogUGVk
cm8gU2lsdmEgRmVycmVpcmEgPFBlZHJvLlNpbHZhLkZlcnJlaXJhQGNyaXRpY2FsdGVjaHdvcmtz
LmNvbT4KPiAtLS0KPiDCoGxpYi9iYi9jb2RlcGFyc2VyLnB5IHwgMjIgKysrKysrKysrKysrKyst
LS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2xpYi9iYi9jb2RlcGFyc2VyLnB5IGIvbGliL2JiL2NvZGVw
YXJzZXIucHkKPiBpbmRleCBkMjQ5YWYzMjYuLjdmNmFkYWYzNiAxMDA2NDQKPiAtLS0gYS9saWIv
YmIvY29kZXBhcnNlci5weQo+ICsrKyBiL2xpYi9iYi9jb2RlcGFyc2VyLnB5Cj4gQEAgLTcyLDE1
ICs3MiwyMSBAQCBkZWYgYWRkX21vZHVsZV9mdW5jdGlvbnMoZm4sIGZ1bmN0aW9ucywgbmFtZXNw
YWNlKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyc2VyLnBhcnNlX3B5dGhvbihOb25l
LCBmaWxlbmFtZT1mbiwgbGluZW5vPTEsIGZpeGVkaGFzaD1maXhlZGhhc2grZikKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgI2JiLndhcm4oIkNhY2hlZCAlcyIgJSBmKQo+IMKgwqDCoMKgwqDC
oMKgwqAgZXhjZXB0IEtleUVycm9yOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldGZu
ID0gaW5zcGVjdC5nZXRzb3VyY2VmaWxlKGZ1bmN0aW9uc1tmXSkKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiBmbiAhPSB0YXJnZXRmbjoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICMgU2tpcCByZWZlcmVuY2VzIHRvIG90aGVyIG1vZHVsZXMgb3V0c2lkZSB0aGlzIGZpbGUK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNiYi53YXJuKCJTa2lwcGluZyAlcyIg
JSBuYW1lKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyeToKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRhcmdldGZuID0gaW5zcGVjdC5nZXRzb3VyY2VmaWxlKGZ1bmN0aW9u
c1tmXSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIGZuICE9IHRhcmdldGZu
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjIFNraXAgcmVmZXJl
bmNlcyB0byBvdGhlciBtb2R1bGVzIG91dHNpZGUgdGhpcyBmaWxlCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNiYi53YXJuKCJTa2lwcGluZyAlcyIgJSBuYW1lKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluZXMsIGxpbmVubyA9IGluc3BlY3QuZ2V0c291
cmNlbGluZXMoZnVuY3Rpb25zW2ZdKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3JjID0gIiIuam9pbihsaW5lcykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBh
cnNlci5wYXJzZV9weXRob24oc3JjLCBmaWxlbmFtZT1mbiwgbGluZW5vPWxpbmVubywgZml4ZWRo
YXNoPWZpeGVkaGFzaCtmKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2JiLndh
cm4oIk5vdCBjYWNoZWQgJXMiICUgZikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlcHQg
VHlwZUVycm9yOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBTaW5jZSBQeXRo
b24gaW5zcGVjdCB3b250IHN1cHBvcnQgc3BlY2lhbCB0eXBlcwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgIyBTa2lwIHJlZmVyZW5jZXMgb2YgdHlwaW5nIHNwZWNpYWwgZm9ybXMs
IGFsaWFzZXMgYW5kIHR1cGxlcwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmIu
d2FybigiU2tpcHBpbmcgcmVmcyB0byAlcyA6ICVzIiAlIChmLCB0eXBlKGZ1bmN0aW9uc1tmXSku
X19uYW1lX18pKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluZXMsIGxpbmVubyA9IGluc3BlY3QuZ2V0c291cmNl
bGluZXMoZnVuY3Rpb25zW2ZdKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNyYyA9ICIiLmpv
aW4obGluZXMpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyc2VyLnBhcnNlX3B5dGhvbihz
cmMsIGZpbGVuYW1lPWZuLCBsaW5lbm89bGluZW5vLCBmaXhlZGhhc2g9Zml4ZWRoYXNoK2YpCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2JiLndhcm4oIk5vdCBjYWNoZWQgJXMiICUgZikKPiDC
oMKgwqDCoMKgwqDCoMKgIGV4ZWNzID0gcGFyc2VyLmV4ZWNzLmNvcHkoKQo+IMKgwqDCoMKgwqDC
oMKgwqAgIyBFeHBhbmQgaW50ZXJuYWwgbW9kdWxlIGV4ZWMgcmVmZXJlbmNlcwo+IMKgwqDCoMKg
wqDCoMKgwqAgZm9yIGUgaW4gcGFyc2VyLmV4ZWNzOgo+IAoKClRoaXMgbWF5IGJlIGEgZ29vZCBy
ZWFzb24gbm90IHRvIHVzZSB0eXBpbmcgaW4gcHl0aG9uIG1vZHVsZSBjb2RlIHdlJ3JlCmltcG9y
dGluZy4gQ2F0Y2hpbmcgYW5kIGlnbm9yaW5nIGFsbCBUeXBlRXJyb3JzIGxpa2UgdGhpcyBzb3Vu
ZHMgbGlrZQppdCB3aWxsIGNhdXNlIHVzIG90aGVyIHByb2JsZW1zIGluIHRoZSBmdXR1cmUgYnkg
aGlkaW5nIHJlYWwgZXJyb3JzIDooCgpDaGVlcnMsCgpSaWNoYXJkCg==


