Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.10])
 by mx.groups.io with SMTP id smtpd.web12.21848.1627919724061056179
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 08:55:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=J4HVDNml;
 spf=pass (domain: outlook.com, ip: 40.92.89.10, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjD3UW7zN5XmVR+32PKIrcCwju0RrRFqagK9KkL8S0hucyHpokxqcTTxVyw6wNfXlLKA/pzFMs9oFqTYpXdVTKqKS60+ZTvlbhVRfOZjXC4amlUM4aRzYbtOPhF0ZsOMJsQTSL5SCnblytZiQ3qNIXA9MhdLStkgPH77MiPecidvLzWgoJrlNogfyHXebrf5b2yMjlUBvt9weCMlnSs6MPRrktFzrYDLdZ4Tj9g9gnQxNqe4PRahboBGZ9kE+kzldQibW+CaUfaYfoyJaRfhilAkf48Q3QhG+wHQtJ26zsJwBTs/picFeYx8tS17/UaRlkoxOD7xjuYTg5oUVu29wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es3AqOxa+YuzJ38sS5z0SDSksDSZvuuy6T78G/GJtP0=;
 b=jq53Cn7PQRscPrKQFKX5REJPwSVbErk0weGOYzLSHxkJgtHJnXA/FXJhO7Yx4E8fsEEOXT4X9WB/s+zG9vMMmiQDLy7+ptukUy1d1Fta2G8Pnq08kmJe3lBheFZM9siNbUBjSMCA6sdnJp1esYOYXCgn+i3ZzUeTdfjCfSf5UsrTfLFAvV+bF6SkNwvyFRxLoo5PLX/Idn7ma7q9pc2UjPKsDIL6yFNSM5DOwQvOI5h0MRbdNo/YHAKCEKgGjutvvIvLOclsMydwzD2mEnvWr6M6iQkHYc7PnpAHHeLx05G2ceihvWtDAVD8QvSaMHlIjKxi2ae0EaRmIURsPrZgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es3AqOxa+YuzJ38sS5z0SDSksDSZvuuy6T78G/GJtP0=;
 b=J4HVDNmldH+bt3XGaFIHoWF3FsB+4oQyaQ1UI0gl2KeEogqiCgXHFcRVjjfuTwDXCCxWj9R8K9o9TGBKmqKeG3RfKIJfKxwAJOjXVfuyQhIw0uQkADFYhSYU/2XGeQ3u9mzdBZLcOm9XgLsSTXy0tcXPzwTc70YzIf6/kr1bQcaxTuMEp5MmQF4j4WLKTI761ujb+6QJi/botydplqTkqNWbDH4qyjW8DVi1eXsaBOA4F/2kd+ejuOMJ5OpGkjW1TUcGY/0EsACG0gxHnRuayfmyZ2gQxGwzkx0WSuz1uQWcfoOvSxcBy0kLi2erCH0tkudxitxrSoVb40OYBR+8zA==
Received: from DB8EUR05FT017.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::42) by
 DB8EUR05HT166.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::76)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 15:55:22 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:fc0f::42) by DB8EUR05FT017.mail.protection.outlook.com
 (2a01:111:e400:fc0f::311) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 15:55:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8BFAAEC52EBE0699128C59C73FC2E8C28B49AAD893244BAA3CB1825973676F6F;UpperCasedChecksum:B8165128D5DC250AEB93EA675B585862B8F3650BFE12543554DB2A84A03DD7AF;SizeAsReceived:9069;Count:47
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::411f:efb1:4a12:95b7]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::411f:efb1:4a12:95b7%8]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 15:55:21 +0000
Subject: Re: [bitbake-devel] [PATCH] data_smart: Fix inactive overide accidental variable value corruption
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
 <AM9PR09MB46429863371012A2E7080F37A8EF9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <2ad1b01f7147de6149cc581963af1379a7984124.camel@linuxfoundation.org>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: <AM9PR09MB4642DC91F3CDEDFDF6855FC9A8EF9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Mon, 2 Aug 2021 17:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <2ad1b01f7147de6149cc581963af1379a7984124.camel@linuxfoundation.org>
X-TMN: [iRnOnopiRWIOIG0Kch+tPRbPdHR47NMRhLtUVaLdVOykv730doywr24ryIBzjF9EvdnOHK5gE9Y=]
X-ClientProxiedBy: AM8P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::23) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <b5cb4880-b505-d32c-cffb-585908999f55@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:8109:9a80:3b94:19cb:1ee8:a90f:12a0] (2a02:8109:9a80:3b94:19cb:1ee8:a90f:12a0) by AM8P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 15:55:21 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 22c3ec26-b347-4ebc-0308-08d955cdeeee
X-MS-TrafficTypeDiagnostic: DB8EUR05HT166:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DiYq+DK+GBl/0UUBgNwvumW+2qP7uaqIedoGz/99NzQmBYcCqnfb9uELv72/QiTQLq9y+hk8KJYKOhZFrG2I++bnzJezOmpCFjYP4NtVNck8LXVjyP+pdSzhA3NzhN0xWIq/SqLf4stSMwyLbpPAHmW1zYslzEWUHFCCiK68HLihQAxwUpGsQUApVrqJUCzU/OpaXw+BzwFk0FluYUVymDD42sicYHA6Bhrp0QLqL/L2oQFADk3nnOmHnWmzC1G356aWsKSbZReoeTLBKwgXM3goFiAqQwkV2E3EcdKPjQHreWkgROEDXq+gHW2fqFPAJCQmd3KzcDX2p86D/djTrEBgkul1E2LgBC2snTuRnujMStdka4dqQJ4qr4M5JDXUY9cbfcwDva4vZM2+niRLOwzDTf7Ccn7OAG+Ju/5XPGZqPtZA/Iyh0l4wIQUPM++t
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Q4d6gITNbmHzw2SOLlLRt9xeQVb/LuSbjbsn2NbVjTna3evfbkGPfgOuguaPYPNf9liuN1HcuBg6sVA6u9yEDS5UHKhjC7kub5zsVcIHoWtcdSb9d50iUaxV5qR4Ox8aHV+sQfYm3b80AESnqFkispJfgHcyzN/fJe6EYi30srhQXI1u+Q3WD/dYi3hRhrvEqmn+HEsxLihvDIbOw/Cg8g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c3ec26-b347-4ebc-0308-08d955cdeeee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 15:55:21.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	DB8EUR05FT017.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT166
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 02.08.21 17:53, Richard Purdie wrote:
> On Mon, 2021-08-02 at 17:46 +0200, Konrad Weihmann wrote:
>>
>> On 02.08.21 17:42, Richard Purdie wrote:
>>> Setting something like:
>>>
>>>  =C2=A0=C2=A0=C2=A0BAR:append:unusedoverride
>>>
>>> should cause BAR to be None, not "" which was what the datastore was
>>> returning. This caused problems when mixing variables like:
>>>
>>>  =C2=A0=C2=A0=C2=A0RDEPENDS:${PN}:inactiveoverride
>>>  =C2=A0=C2=A0=C2=A0RDEPENDS:${BPN}
>>>
>>> since key expansion would report key overlap when there was none. This
>>> is a bug in the datastore. Fix it and add a test too.
>>>
>>> [YOCTO #14088]
>>>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> ---
>>>  =C2=A0=C2=A0lib/bb/data_smart.py | 8 ++++----
>>>  =C2=A0=C2=A0lib/bb/tests/data.py | 5 +++++
>>>  =C2=A0=C2=A02 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>>> index 43e9e78555..65528c6ae6 100644
>>> --- a/lib/bb/data_smart.py
>>> +++ b/lib/bb/data_smart.py
>>> @@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
>>>   =20
>>>
>>>   =20
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if flag =
=3D=3D "_content" and local_var is not None and ":append" in local_var and =
not parsing:
>>> -            if not value:
>>> -                value =3D ""
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0self.need_overrides()
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0for (r, o) in local_var[":append"]:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0match =3D True
>>> @@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if not o2 in self.overrides:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0match =3D False
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if match:
>>> +                    if value is None:
>>> +                        value =3D ""
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D va=
lue + r
>>>   =20
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if flag =
=3D=3D "_content" and local_var is not None and ":prepend" in local_var and=
 not parsing:
>>> -            if not value:
>>> -                value =3D ""
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0self.need_overrides()
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0for (r, o) in local_var[":prepend"]:
>>>   =20
>>>
>>> @@ -774,6 +772,8 @@ class DataSmart(MutableMapping):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if not o2 in self.overrides:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0match =3D False
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if match:
>>> +                    if value is None:
>>> +                        value =3D ""
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0value =3D r =
+ value
>>>   =20
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parser =3D=
 None
>>> diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
>>> index 7f1d3ffbbc..e667c7c7d3 100644
>>> --- a/lib/bb/tests/data.py
>>> +++ b/lib/bb/tests/data.py
>>> @@ -405,6 +405,11 @@ class TestOverrides(unittest.TestCase):
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bb.data.ex=
pandKeys(self.d)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0self.asser=
tEqual(self.d.getVar("VERSION"), "2")
>>>   =20
>>>
>>> +    def test_append_and_unused_override(self):
>>> +        # Had a bug where an unused override append could return "" in=
stead of None
>>> +        self.d.setVar("BAR:append:unusedoverride", "testvalue2")
>>> +        self.assertEqual(self.d.getVar("BAR"), None)
>>
>> Maybe I'm not seeing it but to me the test doesn't match the changes mad=
e.
>> If the code change turns None into "", how can the assert ever work here=
?
>> I would have expected assertNotEqual or similar here
>=20
> The code change turns what was a return value of "" into a return value o=
f None. I
> did run the test before and after the change and it seems to be correct?
>=20
> Put another way, sstting "BAR:append:unusedoverride" shouldn't change BAR=
 from
> None to "" unless the override is active.

Yeah, it took a moment too long in my head to compute this change :-)
Sorry for the noise.
Patch is correct IMHO, although I'm not sure about the fallout of this=20
change, as any kind of string operation resulting from a d.getVar might=20
get us into trouble here.

>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
>=20
>=20
>=20
