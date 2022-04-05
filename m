Return-Path: <o.mandel@menlosystems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13528C4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:47 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web09.4912.1649158725874242739
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 04:38:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: menlosystems.com, ip: 212.18.0.9,
 mailfrom: o.mandel@menlosystems.com)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4KXlyp6Q3vz1r1Mv;
	Tue,  5 Apr 2022 13:38:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4KXlyp5w0Xz1qqkD;
	Tue,  5 Apr 2022 13:38:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
	with ESMTP id WBTDcxWkT733; Tue,  5 Apr 2022 13:38:42 +0200 (CEST)
X-Auth-Info: NUFAF6XpT0MC7IGej0BRLcNEY9E88JvzNzVkQo0XygDgkj4dOlawMhIUTPh7dcD6
Received: from [10.0.0.213] (host-82-135-125-165.customer.m-online.net
 [82.135.125.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue,  5 Apr 2022 13:38:42 +0200 (CEST)
Message-ID: <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
Date: Tue, 5 Apr 2022 13:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] fetch2/git: stop generated tarballs from leaking info
Content-Language: en-US
To: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
References: <20220324164759.4097867-1-o.mandel@menlosystems.com>
 <20220328173618.960965-1-o.mandel@menlosystems.com>
Cc: Marek Vasut <marex@denx.de>
From: Olaf Mandel <o.mandel@menlosystems.com>
In-Reply-To: <20220328173618.960965-1-o.mandel@menlosystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------G1aPkI09Yf9GtgLUvy2XnU7q"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 17:24:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13579

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------G1aPkI09Yf9GtgLUvy2XnU7q
Content-Type: multipart/mixed; boundary="------------Q2QtO4DijPk84BOoQI01XwZA";
 protected-headers="v1"
From: Olaf Mandel <o.mandel@menlosystems.com>
To: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Cc: Marek Vasut <marex@denx.de>
Message-ID: <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
Subject: Re: [PATCH v3] fetch2/git: stop generated tarballs from leaking info
References: <20220324164759.4097867-1-o.mandel@menlosystems.com>
 <20220328173618.960965-1-o.mandel@menlosystems.com>
In-Reply-To: <20220328173618.960965-1-o.mandel@menlosystems.com>

--------------Q2QtO4DijPk84BOoQI01XwZA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkFtIDI4LjAzLjIwMjIgdW0gMTk6MzYgc2NocmllYiBPbGFmIE1hbmRlbDoN
Cj4gV2hlbiB1c2luZyBCQl9HRU5FUkFURV9NSVJST1JfVEFSQkFMTFM9IjEiIHRvIGdlbmVy
YXRlIG1pcnJvciB0YXJiYWxscw0KPiBvZiBnaXQgcmVwb3NpdG9yaWVzLCB0aGV5IGxlYWtl
ZCBsb2NhbCBpbmZvcm1hdGlvbjogdXNlcm5hbWUsIGdyb3VwIGFuZA0KPiB0aW1lIG9mIHRo
ZSBsYXN0IGZldGNoLiBSZW1vdmUgYWxsIHRoZXNlIGJ5IHNldHRpbmcgZml4ZWQgaW5mb3Jt
YXRpb246DQo+IA0KPiAgICogdW5hbWUgPSBwb2t5YnVpbGQgKDYwMDApDQo+ICAgKiBnbmFt
ZSA9IHVzZXJzICgxMDApDQoNCml0IHdhcyBwb2ludGVkIG91dCB0byBtZSBieSBNYXJlayB0
aGF0IGluc3RlYWQgb2YgdXNpbmcgcG9reWJ1aWxkOnVzZXJzLCANCndoaWNoIHNlZW1zIHRv
IGJlIGFuIGFydGlmYWN0IG9mIHRoZSBZUCBhdXRvYnVpbGRlciwgSSBzaG91bGQgdXNlIHRo
ZSANCiJjYW5vbmljYWwiIGNvbWJpbmF0aW9uIG9lOm9lLiBCdXQgdGhhdCByYWlzZXMgdGhl
IHF1ZXN0aW9uOiB3aGljaCANCm51bWVyaWNhbCBJRHMgc2hvdWxkIEkgdXNlIHRoZW4/DQoN
CkJlc3QgcmVnYXJkcywNCk9sYWYgTWFuZGVsDQo=

--------------Q2QtO4DijPk84BOoQI01XwZA--

--------------G1aPkI09Yf9GtgLUvy2XnU7q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEErGOsr28GGMKRE/TmVL2dtGJSHf8FAmJMKkEFAwAAAAAACgkQVL2dtGJSHf/5
8wgArk+FFThHbC95CqhodHcd49glH8AaDsjr4P4QrHVw+pTW6/3M0qJ/qYSPLXgniqMawn5X/8p7
S3KHN7h9Lg1f/FOR4Sx+jiKyTKqVhtJhJq373xFKwL/hxb4BnnB5YK+skTloZdvsxo0thBAepmIr
JGObjF145wl43LgalWdAzRasbMTbj2jM8VgZzRTgZumC9uJFZhxkrmW1rykGUWBMJ8DW7Yxg4UlT
1fjQ2jv+sEsqREnRWpX8FxGYGUqjZCpSYMh9rxAIqurInl3uNqecA5Y4pSR06eaVAxaa8NYd3XNW
e1+KEpho286bqth2fXaQPP3TWG9+DSs6kG8C6HDafw==
=mNWx
-----END PGP SIGNATURE-----

--------------G1aPkI09Yf9GtgLUvy2XnU7q--

