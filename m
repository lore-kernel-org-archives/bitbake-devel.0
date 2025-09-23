Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8278CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:25:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.137])
 by mx.groups.io with SMTP id smtpd.web11.13486.1758623135786120824
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Sep 2025 03:25:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=GB0YT+ik;
 spf=pass (domain: weidmueller.com, ip: 52.101.69.137, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTmYdSJJjbly3QbNNOLAqPp8/Bm/tMNcOrpv5K2IqwG4IOy8bD5UylARqw7ccJu3aj0PMZVs/YHg+JLN4vQ+f1oovPeKlt4VS43iNbhzoezQ28tD6jGyqSqSeRY2w2Zaz926t+YGcRE1/3NbcFxgTGbVfx2fOyCliASsN9kfQEZVEV+5wnNaXZQiUvgxObGoTUY8AqiJJgR0o4D3n56LkJkcTl1lyuopmQC+7T+EppIYWuC3Ss6L9jb96c/wZ+EcPn3YQmzdGp7pMtVWq4n6NEFz8WC1tfH420VWv+JKgK0ciXPOly70YBBt0TXKeTYqPKJoFGZOOSQexCGvx+LBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2tjyWprnkHVIqUeMKIeBN+EbQLTbhYxl4NEPCA+Xe8=;
 b=WCjNphSIu4Y7jTptLBfwI8QsFYIgAtyzJ237G/Dupgyhp0m4AD74OBTNNk5FELi8IbcjCux4hwpWEVCvL3o/TfOMPraRko/73bm32HQhaZDqJAqMJkgrFy7LgiCCMET/iKaucYZb9lZpMhE/rVtk6hCxJ7mzljgJAaq2gqb38mtQSlvzP5iVyI+WibsyOWr/F4aTGMY6UgadCPlhFjSe5tTnlCbqVvUzAQYMJH9zQJDgmZtAYRfr3ig6+96Kkj+v00YBZSSOFBz0SNYsXSz8EYOmRtjAZsAdjrqqHHu6U+5ZmtMdAK48LegXXv0ilEJGbFtbrwoAUFRX0+sFOLUUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2tjyWprnkHVIqUeMKIeBN+EbQLTbhYxl4NEPCA+Xe8=;
 b=GB0YT+ikY/wdhQzhGBjvWC/ft8IfpJ85ZgyuoI/j4pqnUbLJAcMNUih2b+P5IPOHLbErvlJfe60Ru++AOrGLV6CcRJT6tcUga/5GuM14lmubEe3XjTLhWLHqOSbRh8Hc9bTlPGFAh26OOzxalG2ZIBFboHQ5Jpj3JZvcM2/PLgnaQTgliFv0/zZ6BPvkT/Y2IC4XRVsYA8K1/viWKsGgZWabkFNO4CwzbkwGI7j3PPDRI2KWRnGjSxGl5oJSJ/XKQpfnvpR17aX0KpWWvjzCEmV/NB9aypxguHTLsXJdblf6ScIqy19gd2bmUKeAetL8MZoMkc116EYjbtTpypdSEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBBPR08MB6188.eurprd08.prod.outlook.com (2603:10a6:10:1f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:25:32 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:25:31 +0000
Message-ID: <e4bd126f-ddbb-4632-a871-078e1a9ac383@weidmueller.com>
Date: Tue, 23 Sep 2025 12:25:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC] fetch2: npm: do keep the sha256sum
To: jeroen@myspectrum.nl, bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250922195059.1052515-1-jeroen@myspectrum.nl>
 <c136f020-69dd-427e-89ed-d9a487ff4477@myspectrum.nl>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <c136f020-69dd-427e-89ed-d9a487ff4477@myspectrum.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBBPR08MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: c611d6c8-5097-423b-8cef-08ddfa8b8614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kwyiuhDZ8lboV+qUAXXnCASSvp7NrQ0LPZ0yiYnmrLeWiHIJCNnahW0YQJ06?=
 =?us-ascii?Q?TUKzpx//M1JRcgr3YYKlnJZcCAE4FlaNzIYUWg8WKgSdfsIsFwOeeEo4Q4Vp?=
 =?us-ascii?Q?EhcihXqBGSoVYZS7St3mcDaFRHzjqs+aVY/V5qAiCsAcJojjSPRV0R2QcRlL?=
 =?us-ascii?Q?8trjKm2tTriXHR5KDhMjr2hoXvPT9dzBWDTALLarWWprzxloJVPU2mbxqL8g?=
 =?us-ascii?Q?foc79Pa2c9ERVUN4XXQeO5hSraFybIb8u6Pstkb+pIVBB/35IHUksNQuVna4?=
 =?us-ascii?Q?6pMz9RlR/ne4j0948xsyzNdSddmwvhj2Nv9Lq460hrtHUp7Zd6FJKzr3SJlW?=
 =?us-ascii?Q?3Id6wNpUIQMx1FkNQ3K++vBHQ3htzxl513jUrFY08DBF0AG/2V2bAKWPmQ38?=
 =?us-ascii?Q?oBYyxkNsk/j06EithV3HbTIn6z0JA0jU9s8fG5Ohxhi9p5uAfQyUW4xrtf/U?=
 =?us-ascii?Q?Gv91jMJKxpaKYfjovnQUYuMhQ1h7TtiIjoM3SqlVoSQysQBd4uPyfvLcHZMX?=
 =?us-ascii?Q?Om6EO7xvOVTQTBgQkIJnAnuDuO+aDezElhC+E7/i7p/jMh56aRyNG2sICoMy?=
 =?us-ascii?Q?e63adKOATdrVeG/wW1yg8/fGlNo1kwxbJZBrEOAKnwuy373tuDeN8N0clkPi?=
 =?us-ascii?Q?QXJY+Yztjmq5QFJjNEfefX5YYVg/2YrvlVALBKtfRto1L7Yl4xvuF2tXYirf?=
 =?us-ascii?Q?A7DTs4gChKlb2g/aK9m0wTaPJSCzHKR9D5dFHxX9rUNuvAXt33PZw1orccBM?=
 =?us-ascii?Q?POpxuECAOPNtvzQYTa6SBodpbkDanFkB2O/ubAUo1iSD1hBLP7eKHH0mb1TX?=
 =?us-ascii?Q?MazcW0Hu3FmbSVPz+rVZA9seMiVeO2+9MReYr+SrE/Ls1jrNJuIF2eTtYRWl?=
 =?us-ascii?Q?zMbbkXTxu0Frd+npGaUvTap2Fph5vHGVys0h5MVts+V56mD+QYuEwiC1wnr9?=
 =?us-ascii?Q?XZvLklT5YAlA0ehJBdgnkI+JqQ+qElEl3wrmZG2EGDnCe+zeq5BTPpsIHvl2?=
 =?us-ascii?Q?Ubpxc8UjXVoat1Q99lhrJKpVURhi44KvDrf1Y58rcF3wBC6rgpLR50FXQlBs?=
 =?us-ascii?Q?JpIQntpYlnUhQpPV8Fpff5OFmP9zs0gXwk6YAB1phduBj3nT+9TXgqQXPVD2?=
 =?us-ascii?Q?FET7k7WF2NQunF08HXswHj/Z9TiGAXSbykCf3WJj3kXUAypYEnAumQKB3mMb?=
 =?us-ascii?Q?1VHPNDwhahmAjlmpNVuc9FzZHA2FJCs5f3Phb1M6/qm7t0XqlJ4jpCGXJXeB?=
 =?us-ascii?Q?GtOzIk9vNDEywWnBtTpeA0Ds/HPYeqZ72uPcjxThqUj16d7DrHdC8Bj8LOc/?=
 =?us-ascii?Q?ekJgRJnrhmWQlPJfWWZ9qPXwfYFIf+cv8S8/j/5pfkKIFo4VbhOFWOV9oZDV?=
 =?us-ascii?Q?t3aUgiCMeHSBD69Kjq4FmBKsA45J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LzHJqEsXVfK2xd4rahgApfhsB82ZITdG5YaaB3TrXw4wI5Hw+/YQKCdfOUgi?=
 =?us-ascii?Q?opjY2ICIVFlFRqrnqXJN4+vBVe+IKZaoUxvPZGFQ30NpeqDD3DrC/LH+TLRt?=
 =?us-ascii?Q?VFvECT1arLeMOiQjH308KCPbLTmYaPIDfwgwB9O6w4wIiM/noX9qQZUqAPwB?=
 =?us-ascii?Q?Dafef93I66P4sJ3lpTSf4XqXB5lDGaYO2mT3k3lN6LYMki7qYMHGrk2aH44Q?=
 =?us-ascii?Q?T7mhmA0UwY1qjaTp+cLvNQXwQ6M40zKRe09nfez4KB+OZVgnQ4Zs/0gKlX1B?=
 =?us-ascii?Q?JmYbJ0N5dWqVD1UUU1TytsehfV+sfCRuQhIotSRE9skj1lqQFXuDYN907fyL?=
 =?us-ascii?Q?fFGZXgqwSD0dnlOW/XR8a7fioNC0OV3ceBAyzRaQRUAUdxU4nF5exHzdubel?=
 =?us-ascii?Q?kBF5QZOCCaKQ8VrQ568GVhYM+U5CdwI9wu3gGB9P/ZzEnr73ZB9DtGZWq/Hr?=
 =?us-ascii?Q?RiqVu/vtphtfl2y0YGAK1ghMeWF2u0UVCAvjZrNU/Fte8N46Jcmq/DaUm9xF?=
 =?us-ascii?Q?YseCRKSktiRrLv92M3ulQcW8fvRdOdKo8pEv5Yj8u9hd3LzyOgriPoGbo1VH?=
 =?us-ascii?Q?mdyvFbx1Bo0MDxB4lkrPcTR58dIL6p+GTysWk31ev9TnsSEwLsNMVr+0eQ9J?=
 =?us-ascii?Q?KzSppM0X8hz5Gm76Zgt+lAAKu1NpGL1uh05cqp9pM+u3Al7w3EQIASKGDSOy?=
 =?us-ascii?Q?sjdaT5qCT7HlbIuhV9XiNHgkhUJTEujW9IQNASOlJ5UdZR0uInxbNyEPrQKh?=
 =?us-ascii?Q?5/IUdgGm6A3B5bcIxeDUdWoA8BotJkkXvmI5j0jK0RybZvIB11HZg+q3mfhl?=
 =?us-ascii?Q?N8NePmN43kKqCxSxTas1TpGB7uNZUZKGI8RKc+6bzjx2qEdZQFYmQbeWrCz/?=
 =?us-ascii?Q?+PlSzJVoB/NHKXlNFl+1H+PyAsVk7T1m3z26dqgaqYOE5lAkoUBRGiWAZVQA?=
 =?us-ascii?Q?aC2dKS3MYUFcs4AwC7I499FDqCXew8aeodZes8/O/dXv0fno/yLDV67q87YA?=
 =?us-ascii?Q?E/qIMPBFvTQf/mVyQVS8NS1niLCWW5nn3xbkvWn0sEUBHpnjGHNdD12nkfDu?=
 =?us-ascii?Q?Ig6VuH43hPSg/GyAswB26/2FTh0oASrs4Mel84jBf8DC4iePev84SHAj1igS?=
 =?us-ascii?Q?+PUukfg0JO64j52nUD4SOmx323HuvA+aOpRHZjmoxx8365w2nkYwluuDqI4w?=
 =?us-ascii?Q?AM3x4Bkulvx8zLsxl/VNn4zQ8YLMJ7XMKJC/oOtZXCPi7XPNFrRelLEq4CEf?=
 =?us-ascii?Q?dIODMUT00EJ6AseJdb43PQzGp0oJLC3+Rw+tkmRkWHn2/d4OBS6b4CWQ8AJb?=
 =?us-ascii?Q?ucekkmPKZCvQGK78jvZinLSHfThhoP3Sbi12TkVM75glZjptDpRm8JeEzos3?=
 =?us-ascii?Q?asEoTcSJuryukCkDIYP7ef8czWRTqNH9rvyv7e3J+qXUzNr1qZUq89P3b283?=
 =?us-ascii?Q?wEphtFEmePG9A3dHacVolO8wRpzeLFlx7CTcbldz0WeIJEyuegqUP0NYIQvt?=
 =?us-ascii?Q?npZL117cjeod+L23ROJrJjPE4auAEIW2fjztWeMRP7WP8xqK4DR06kcIjw56?=
 =?us-ascii?Q?KgcDvxFoRDEpZ559znhTU37zPcVEjrhdphBbC+dMKdacc1jxkE+kdhE+pG8J?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c611d6c8-5097-423b-8cef-08ddfa8b8614
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:25:31.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhA6FBM/uK1fvTfDOyicAnQz8nf9zwfStIhGZN7WEKr2NUkWDWXb2zTeFFNiCWP8LYakbUyBRkdsxECiwh9dOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6188
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 10:25:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18080

Am 22.09.2025 um 22:05 schrieb Jeroen Hofstee via lists.openembedded.org:
> cc-ing Stefan Herbrechtsmeier who is the author of mentioned
> patch.

Please revert the mention patch. The npm fetcher inject the checksum on=20
the fly from the remote source. The mention patch was part of a proposed=20
rework of the npm fetcher to use local checksum and remove the=20
dependency to the npm binary.

>
> On 9/22/25 21:50, jeroen@myspectrum.nl wrote:
>> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>>
>> commit 8d3232152e ("fetch2: read checksum from SRC_URI flag for npm")
>> added npm to require a checksum. The checksum is also added with the
>> `npm view` command which relies on downloaded data. Furthermore in
>> _setup_proxy all the SRC_URI variables are removed, so an explicit
>> local SRC_URI[sha256sum] is removed and it only checks the online
>> checksum from npm view.
>>
>> This removes the data.delVarFlags("SRC_URI"), so the check works again,
>> but given the comment "Avoid conflicts between the environment data and
>> the proxy url checksum", there might be reason for that, but I wouldn't
>> expect tarballs to differ when served directly or via a proxy.
>>
>> We might consider getting rid of npm_integrity completely and force
>> having a local checksum and not depend on the npm infrastructure.
>> ---
>> =C2=A0 lib/bb/fetch2/npm.py | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index e469d6676..ad740f832 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -269,7 +269,8 @@ class Npm(FetchMethod):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # Avoid conflicts between the environment data and:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # - the proxy url checksum
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data =3D bb.data.createCopy(d)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=
.delVarFlags("SRC_URI")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # XX=
X: What is the purpose of removing SRC_URI, it also=20
>> removes the checksum...
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #dat=
a.delVarFlags("SRC_URI")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ud.proxy =3D Fetch([url], data)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def _get_proxy_method(self, ud, d)=
:
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18075): https://lists.openembedded.org/g/bitbake-deve=
l/message/18075
> Mute This Topic: https://lists.openembedded.org/mt/115382619/6374899
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [stefan=
.herbrechtsmeier-oss@weidmueller.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

