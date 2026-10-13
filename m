Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F7CC6B03
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 08:59:53 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2770.1791881982633187408
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 01:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=tCHHTffB;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1347d16530008d8d@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=3hnnQPQiD5V2SXyDVTvlEfb1tUtrg+13Cl8vIpb6+5M=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=tCHHTffB8VYXjMz0XUYNv0QJJWzySBJegrSDwVeHzk2DgQHQCoDTHTDacMsh5dNa3jMSCdtym
 QNBP+XJ/AjdjSre8uoKIh1807YfHqyceQ5Nrb0D0YfGZTIYQKXqbVzzxq9qkVqjOJ6Bl9sxG+mh
 M7kIfIIif0Wcg9RJkq0oXNSCoV+Ty99rz84P/L2l34frPvRMhKsoPx34eHn1wVxYedg0REfUAvL
 xPqJJbDthTt5Q9wVruXicGfgIk/F4ldMwzFDFQWWjMc6QbZXKlj0GOCI2pIupRP3j/y+ZVgo7J6
 R7A6plEMlRWVeIYGdiI/5+CAcQ5zfUgxA6rzIShRyIrQ==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a1347d16530008d8d.002
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 08:59:35 +0000
X-Zone-Loop: ea164d3956b0c5108770587aefadbbb6ce664806772c
x-campaign-type: default
x-transaction-id: 0e9dcc54-f3be-45a6-81a9-aaef7befe25b
x-swg-uid: 01-463535e7-cf0b-4798-9d53-2f49e6f25c41
X-Mailer: Sweego
Message-ID: 
 <1791881975.8631fc262581453bbf619ec5b2062170.1a1347d16530008d8d@vates.tech>
x-swg-bid: 1791881975.8631fc262581453bbf619ec5b2062170.1a1347d16530008d8d
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from [10.137.0.41] (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id B133481EFA;
	Tue, 13 Oct 2026 10:59:33 +0200 (CEST)
Date: Tue, 13 Oct 2026 10:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 2/2] data_smart: restore the ability to
 use capital letters
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20261007125138.59937-1-yann.dirson@vates.tech>
 <20261012084202.103724-1-yann.dirson@vates.tech>
 <1791794550.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7@vates.tech>
 <DM3GEW286NB5.302OAXPFSNBM5@bootlin.com>
Content-Language: en-US
From: Yann Dirson <yann.dirson@vates.tech>
Organization: Vates
In-Reply-To: <DM3GEW286NB5.302OAXPFSNBM5@bootlin.com>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.13d.22eac08eba5aec8b.1a1347d1019.9b2f053cd99984f4=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791881973786
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 08:59:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20322

---=Part.13d.22eac08eba5aec8b.1a1347d1019.9b2f053cd99984f4=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/13/26 7:17 AM, Mathieu Dubois-Briand wrote:
> On Mon Oct 12, 2026 at 10:39 AM CEST, Yann Dirson via lists=2Eopenembedd=
ed=2Eorg wrote:
>> This reverts commit 6eb56624e6d8dc1944e559b4f6584bfe66f566ba=2E
>>
>> That commit was meant as an ad-hoc band-aid when "_" was used as
>> override prefix, and it explicitly blocked capital letters from being
>> usable in the overrides=2E  There is no reason to keep it now we use ":=
"
>> as prefix=2E
>>
>> Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
>> ---
>=20
> Hi Yann,
>=20
> Thanks for the new version, but we are still seeing the same failure:
>=20
> FAIL: test_append_in_expanded_override (bb=2Etests=2Edata=2ETestOverride=
s=2Etest_append_in_expanded_override)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bi=
tbake/lib/bb/tests/data=2Epy", line 417, in test_append_in_expanded_overrid=
e
>      self=2EassertEqual(self=2Ed=2EgetVar("TEST"), "base appended")
> AssertionError: 'base' !=3D 'base appended'
> - base
> + base appended
>=20
> https://autobuilder=2Eyoctoproject=2Eorg/valkyrie/#/builders/23/builds/5=
075
> https://autobuilder=2Eyoctoproject=2Eorg/valkyrie/#/builders/35/builds/5=
043
> https://autobuilder=2Eyoctoproject=2Eorg/valkyrie/#/builders/48/builds/4=
856

Wow, that's funky=2E Getting the same sha1 tested in the autobuilder I=20
don't see any failure, do I have anything special to do to reproduce how=
=20
the autobuilder tests things?

$ git fetch origin 83afc355141f2451058f505f18be4b95486ec050
=2E=2E=2E
 From https://git=2Eopenembedded=2Eorg/bitbake
  * branch                83afc355141f2451058f505f18be4b95486ec050 ->=20
FETCH_HEAD

$ git checkout FETCH_HEAD
=2E=2E=2E
HEAD is now at 83afc3551 data_smart: restore the ability to use capital=20
letters

$ =2E/bin/bitbake-selftest=20
bb=2Etests=2Eparse=2EParseTest=2Etest_parse_mixedcase_pn_override
=2E
----------------------------------------------------------------------
Ran 1 test in 0=2E001s

OK

$ git checkout HEAD^
=2E=2E=2E
HEAD is now at 6e7bdd494 parse: add a (failing) test for a variable=20
override with capital letters

$ =2E/bin/bitbake-selftest=20
bb=2Etests=2Eparse=2EParseTest=2Etest_parse_mixedcase_pn_override
x
----------------------------------------------------------------------
Ran 1 test in 0=2E002s

OK (expected failures=3D1)



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.13d.22eac08eba5aec8b.1a1347d1019.9b2f053cd99984f4=---

