Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C5ACC6B03
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 09:56:15 +0000 (UTC)
Received: from prod-mta-13-01.swg-srv.net (prod-mta-13-01.swg-srv.net [185.255.28.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3384.1791885367797373362
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 02:56:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=TU3vUmf+;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.34, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=V0aYJqTs9DaVzVUBDgj7oA57rOPYWSB76lzzS1JDLjI=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=TU3vUmf+58xt9xJve6XGTrpuee1uk5ttcfv4Dh1vFsZkPf2pPGYaJ04XHIvBDvXpP4+tirIPv
 V3QTKqz6sN/pX9Xngcoc0tiqCXZ6LQRFxqIZW97hIXiNdP9bwV9/l4HFUv1hfRvM5fr/VdBDBDI
 kRnlpTFlT7WAGvaXjSmRSVeI0fQk9twu9oJKqwtidNk7U91BtU4oso5wAkrT5SH8/eNxgi7Lf2T
 uZ6g1pn63vPeAOmBQS7S2Vg6zyQtz+1kYAksZt3UkQU+4iigqDqYaYv9V41UeyDY0zEKBgjbRvv
 RnibEuUkPQhaEn1nXvYQe8EQhHT1KV+5OUSmBIhy/sGw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-01.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a134b0cf0a0008425.003
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 09:56:05 +0000
X-Zone-Loop: 944a939a578b6149e3bc710bc2a89a47dc0e77770105
x-campaign-type: default
x-transaction-id: e0fe6ad6-2648-4c08-a07d-7fba3659d937
x-swg-uid: 01-671be1d4-518c-431a-bbf2-f0fa9ef03ace
X-Mailer: Sweego
Message-ID: 
 <1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@vates.tech>
x-swg-bid: 1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from [10.137.0.41] (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 5FEE9829ED;
	Tue, 13 Oct 2026 11:56:03 +0200 (CEST)
Date: Tue, 13 Oct 2026 11:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Cc: docs@lists.yoctoproject.org
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
 <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
 <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
Content-Language: en-US
From: Yann Dirson <yann.dirson@vates.tech>
Organization: Vates
In-Reply-To: <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.149.3c6f96235b4ac805.1a134b0c90b.890d985bcd0a3326=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791885363468
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 09:56:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20323

---=Part.149.3c6f96235b4ac805.1a134b0c90b.890d985bcd0a3326=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/26 3:20 PM, Antonin Godard wrote:
> On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists=2Eopenembe=
dded=2Eorg wrote:
>> Hi,
>>
>> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists=2Eopenembed=
ded=2Eorg wrote:
>>> Reported-by: Claude Opus 5=2E5
>>> Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
>>> ---
>>>   doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst | 8 +++++=
+++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Ers=
t b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>> index 621aab253=2E=2Eeef1f9624 100644
>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automatic=
ally, and if the imported
>>>   module specifies an attribute named ``BBIMPORTS``, that list of
>>>   sub-modules is iterated and imported too=2E
>>>  =20
>>> +Additionally, Bitbake will detect usage of functions from such a
>>> +library and include them in task hashes, so changes in those function=
s
>>> +trigger task rebuilds=2E  Note that only functions inside modules
>>> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
>>> +any name defined directly in the specified namespace (e=2Eg=2E in
>>> +`<namespace>/__init__=2Epy`, or in a library hat would be defined as
>>
>> s/hat/that/
>>
>>> +`<namespace>=2Epy`) would *not* benefit from this tracking=2E
>>
>> Otherwise, this is clear to me=2E I did not know about this limitation/=
feature,
>> and this is definitely important to document, thanks!
>=20
> Reading the code[1], it seems that functions prefixed with _ are not inc=
luded
> in the task checksums - if I understood correctly=2E I think it would be=
 also
> important to mention that=2E Could you add it in a v2?

It could be asked why we would want to exclude them=2E  Usually that would=
=20
be internal functions, to be called by the exported ones, so they would=20
equally matter - but then they are actually not included in the task=20
hash, so it rather looks like a bug rather than something to document?



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.149.3c6f96235b4ac805.1a134b0c90b.890d985bcd0a3326=---

