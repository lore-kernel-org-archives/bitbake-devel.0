Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB048C3DA4A
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.84])
 by mx.groups.io with SMTP id smtpd.web10.6666.1738739758879250353
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=nJwYIujQ;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJJXoZHhC9PmTkKsE+IbDg3m8T1cErbQrK1Pv/6BVeln95p+JOnG/WGu8qdXnvLKodnFoKq7vRSbscSDdFcIgVoA/clrRmms45/819y8ssOfptnhgXWdjTfhnSG7Wu7sIkBAcKCo1RfSY8Nla/7H/BgHtbknmlM0c82G2wmNeLWwYw2MzivfKnOnmnqZvEea5pUtykGdR05DupIZ6puGx0Y5nzlrRZ2QukJ8hJylIa6PhkWaSkPu4p44zQv/gm5lqpksZfBaIa6fMVipkbLXlXHO3in7zqFAQpn975zOPorBEdkqIRD1dLSPPZZbxvinQqdDdLsWb5MFeVlda41O+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlUNHn9hzsnaJX+iokBGyeLZuN66VGzvl0JgS8J2vNo=;
 b=okJeQq51CVutLeqAaGGdzmjzTSF/cgB64bJNLU7u6hKl3gPmUjCqYeEBoBSw3BcQ7Q5u4X04Ox0oiMz3qkuqg8YLpqYipR+Ln65XF+UBXrP38+tyJ8dY1KIIMJOaYoq3Xy8n4ySeWBUntRv9X8QEFGeX4zbmitX71xFph1uc1iKFLMA1SVyqZUTCDb6VL2G6sOk7/iQMEwMtW1kt96L6UTS9XI9JbmQGqPMv9Mpi1HBbdqJlABb3jOdZWorY/skJPE2ooaCjBZFNF4yX0V5CsqVDFvBdRngVH9/Hu7ySP3J3zvI51anGxbSTy0/mVCfE3SRdUgubFmWO5GARIoQNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlUNHn9hzsnaJX+iokBGyeLZuN66VGzvl0JgS8J2vNo=;
 b=nJwYIujQWtPS52Ktoadf9we119tPB5eiej4qMPYD/HOX/GJEBoWaNeQmS0VKCyrLBvFo2LC1xmQS/4uP8/Ci5tjzp2m9cpmLxAixYtolKsB5HcBiPwQKbiTBPh3bSpaPXbDCJ0ivQ3mUpu2r0cHjgwzYqQRszxBPXGLvsspOiSZskTGBu9KJ6Q94+BtCg2wLRlNZmovxhjZipACv0FPAW8U78K/TgmI+7WFgKfMAP70YJQh8WiREvRvEOlomYww5uUDjvqANd99H9XHLgv0Ko7SkFHRc+jnKSmeTrPATIrLr7uxKd28qpf3hpByL82XorKKUssBcslcD5yg/+2Tpbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB8743.eurprd08.prod.outlook.com (2603:10a6:150:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 07:15:57 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:57 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 15/15] tests: fetch: fix nonsensical mirror uris in FetcherNetworkTest
Date: Wed,  5 Feb 2025 08:15:38 +0100
Message-ID: <20250205071538.2681-15-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: c4569bc8-3a0f-40e3-6ce5-08dd45b4eedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fWpqkjy1eUyyI0X/wFBfe74x780shu4B6eCdMBxMfwKOv7qB9+sGJr9FlRoj?=
 =?us-ascii?Q?Z1mpEvU4UiSPGiRurSjzKtuYw9X6dOiWJeSRKhIcCyvlCCv9tjQoWC53JHoj?=
 =?us-ascii?Q?zuKTBibFluJ2G68NV+VOWCeVucAV4mtBpb0nPoCpQlaL9fTMGqfDknV5ocG8?=
 =?us-ascii?Q?HrWB2pxlLVghoOuuaSQ5yIM01wnpnbfIK9ouZFfxPoCVkhDXOis/0KOAE+Dz?=
 =?us-ascii?Q?BxSUAnNMyh2IcbgeXCA9G31sXeBQziTUARqDE8OH7dluSchIFBWnIKi+tLqv?=
 =?us-ascii?Q?mLegr/SXyacohKhEApboch0IISq16U8kvqVrPztwSqByjEBmLUlC7IW4wJw0?=
 =?us-ascii?Q?jRgwEXNfVFMjFvWWadhd8dEo+Tqhr56paO+OlhnTm50jUmP40LgzQg+D63N3?=
 =?us-ascii?Q?mUud0Rbuh1Z9f+ySa71ziIVjgRybt9DTsrMSDOqatrNFerae9cA5FQBRZGAM?=
 =?us-ascii?Q?CyepH9w+t2vB5JvXWJVvKnCUQZnfpCx/VUzg6ACTl+/3Sje2yY5W+ufOxirR?=
 =?us-ascii?Q?MshkOc+01nOCQTjErYAAwgrVMGO/9BOMChs+o4ZrLhhQSxUXm59h9CNsaNX7?=
 =?us-ascii?Q?yvXwZ0cJVf7HrzI3YIpBir1ev4Sw2OuFNM6U10oQT/MKpxVL1o5CF4WBAxvR?=
 =?us-ascii?Q?1Azwy2TUNBgiSKukzOsyD1RyDDkByWm9WfQ58Lb3b+d7VJFCuXowspiO5bwW?=
 =?us-ascii?Q?+1sx8xwvH/E0esh8Hmm4i48ixVyyZw0kd9xsl7C7j4elfMnM7/m0NyS7cWXs?=
 =?us-ascii?Q?pFMcGmWceY9sYJYxv74gH1NHWY0h5gwXzVKGDAMspybU2ooOTNWSCoGrf8H5?=
 =?us-ascii?Q?HWLZjIcltaa/LY7UTlAHqU6PO9ObBZHMB1vDvsp8CLczhaTfGn6rIzmxVe0E?=
 =?us-ascii?Q?Z/k++7DAzym6m5ym8yx2eqa2gyM3sE8RmfYgA4octpLI3bzpsYTLsvjtzx0f?=
 =?us-ascii?Q?CCs3n516UrMigXzQv0zOYi85cjIB88/WKbAqIPDJhZwcSO+plJLOzIioK/Ys?=
 =?us-ascii?Q?HyMKwdM33yVa1+63IE+q76xOkJbU5hJI3tKPMq9A/gxGkHnuPIkJUzZ/uH/d?=
 =?us-ascii?Q?I6Cd9sj4UG2z2Xqh3ltGYa8GEx0B1j72Um+FR0hGu2vubKe14/W5VOz8ucvB?=
 =?us-ascii?Q?Y5Tqg44kjIJQUUlGD5U0iNscH0oxbDwMTGhEbgqv0AA+aoC1Okd22PSgJx6y?=
 =?us-ascii?Q?XlAoayK8gMOPpwH+2R7wJ9RG0bfKiuY6YXkZOz33X2wer2aA29c0mk993Iob?=
 =?us-ascii?Q?0zLlesvWlqW6bvllR4ay3OWPUO+XsPPvOv4ms/7J6kV9yk3JbMXrlm13DosX?=
 =?us-ascii?Q?ogSK8/8GbCO6Kp/a6M6AOXsqU1ToxvCSYn5zmATr76UXLHlF2UpX4bewBZfm?=
 =?us-ascii?Q?Dk8+vfPpzsBUUx08E/0BVH/44hkh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ciezELMa/HLM8otrRYwqlH/bsdSe1KwhWSVK2Wxm57GWAGivRLEzWHDn8z4m?=
 =?us-ascii?Q?doczA4stpECjFXb28fRD2a52soDE0PAcOUI3rrE+kQKP0oZbXf29B0XyudPA?=
 =?us-ascii?Q?/Q3BVZZLk/rhaVPcrxs/Xwiu80XQXsUfpT5yy2zdsaLjxL5gfgxZXqevMQKW?=
 =?us-ascii?Q?Hb65/H9RPqd/7DJHpAKEX3eZP5xwBFvvoekMY1WVhhSuyldKy0tKE0D4yBs+?=
 =?us-ascii?Q?B7NBKXZg7DHDnTIC7hwq2Jh1hSep0baOjS1qOFXKoN7OcO2KgiDrtNjUWiwF?=
 =?us-ascii?Q?zOPY4ZBjjBdU2KosZ7G8Pz1pPCtOZH8lHvDOx1qAlFWZs2615DXP+2/o7aiJ?=
 =?us-ascii?Q?+S4cAvKu80u6TxUWSpav/H6YtYpXXK1Go7NZ7JjzWrYDNo12E3R6QZCLfCjh?=
 =?us-ascii?Q?alEJmUyT84atH7/l0IQFcYg7a+OkQAlLZ3fJmpSwoh7hxkkU6nVvO+kkVsi5?=
 =?us-ascii?Q?4k9WZWPWQSDq0wJd75xSEFUvlO1WcKUsGNbD5AHijXH2+W1X1dcZwTEPMf5M?=
 =?us-ascii?Q?Q0/3cR+R4FnODIvLMff0hC4Z5T1OX2h+fU62rYYQLiotdVnWz8WIGsW++egT?=
 =?us-ascii?Q?wN307Am/rZsFSCsQoO+GvUam/LoUM6yd6rUNuDE/8il8aOqUVca1VCp5uSlP?=
 =?us-ascii?Q?4ol6bEr859Ke60iNMwK4TBlcCMUdTYpOVqRsqD0NrJI/k3bT3efBr5z6Yr2E?=
 =?us-ascii?Q?l/mdDUNUa/K+zxmrvrUqzSs2JIyjl8LUccvvXKV+Ylzvas6SSQSFFBtg81w9?=
 =?us-ascii?Q?cWLBEMixiOYdi/IXu5edKp+/6MdQE+z/s5GrNvEMrgmyVgQghvdlMAkd7dfu?=
 =?us-ascii?Q?+urs9yxUtstknPKXZNOmgmylhK3qQ6F3wykIa7CkPbB5Tvgeuz3aUQb2RaQg?=
 =?us-ascii?Q?Y9XlRR0q+3RRfJZltPrV0DWeAq12JIfTnsOGyhr54IZ0XhmniqIUaBX/Wh5B?=
 =?us-ascii?Q?6Ilx4oaDe2N3dI8F++zXPWT7yXx2VP+oCAQ3Kd2+TnuL8DNi4B+m7JhRbv/W?=
 =?us-ascii?Q?+BsszMeHQkEplat+YuHqW9fZSvWX2NpEtnOiG3Y8VgPtaOHJmzMmYW2wkxKg?=
 =?us-ascii?Q?9g0+RmcfJGr35A/G9FXy+HVGMYx4+eoaD5EleXNz36hWaBw4ccWVlM5ctrPV?=
 =?us-ascii?Q?Hn0nw5sCqwf3bKbCOvRltEftWjxruhMfW8MopFYaLErfx5f6WRV48URo9kJO?=
 =?us-ascii?Q?L+9pF9EcKpz0n++GyT9lIaW/W8KqToaq0hFOKUlFEAOSznX1RpyXKelNPAjU?=
 =?us-ascii?Q?pZ0447OIHSf0TtYOAI3RJuaUkMk9pTj3kv3ffao/Sw3/I8WF/XuHrm8Rmezf?=
 =?us-ascii?Q?IE4iqgyoXM5g05U2P2oRiUSeQgTY3Tm54hyfVNwKhCsMGXB9OimPw5bN8L1u?=
 =?us-ascii?Q?xFcGa1i3zIophegdfV1frZJuZKIxT645vsIMqFp4NehYF/70ITKUy0GoYJFW?=
 =?us-ascii?Q?yx50kf4PSDVWp5iHknNac3WuiampHgUhiRppY0AZ8L8DWD+m/jbkJo85EyQd?=
 =?us-ascii?Q?g9dVKquNHKjmBwluEUd7EOObDRzktx8kDsy1doLpZ9l7arMTS+fuQavfinCz?=
 =?us-ascii?Q?XCV3cGgCZsdTEOxCMWI8/XcJkfn3lXx4yuIAmKw8Lak8f1xHPghrNSVfwoqq?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4569bc8-3a0f-40e3-6ce5-08dd45b4eedf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:56.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNe+WU/pnFJ8HnGg9BTxx9ke28Jdi0cwHHaeU/ceGqc22dcbi8I7031QjxZOwHKwoSBnwW3ATWmgsHcDXG+0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17148

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

A replacement inside a mirror URI for a local path should use a plain
replacement and shouldn=E2=80=99t use a placeholder without PATH or BASENAM=
E
replacement.

A replacement inside a mirror URI for a remote path should use a
placeholder to match the whole path to replace it and shouldn=E2=80=99t dep=
end
on the implementation which wrongly replace the base name with the base
name of the downloadfilename.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5d247f6a9..3d8b932ac 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1027,7 +1027,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch_file_mirror_of_mirror(self):
         self.d.setVar("FILESPATH", ".")
-        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ file://=
/some1where/.* file://some2where/ file://some2where/.* https://downloads.yo=
ctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ file://=
/some1where/ file://some2where/ file://some2where/ https://downloads.yoctop=
roject.org/releases/bitbake/")
         fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/bitbake-1.0.tar.gz"], self.d)
         os.mkdir(self.dldir + "/some2where")
         fetcher.download()
@@ -1056,7 +1056,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     # BZ13039
     def test_fetch_premirror_specify_downloadfilename_specific_uri(self):
-        self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/relea=
ses/bitbake https://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/relea=
ses/bitbake/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher =3D bb.fetch.Fetch(["http://invalid.yoctoproject.org/relea=
ses/bitbake/1.0.tar.gz;downloadfilename=3Dbitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz=
"), 57749)
--=20
2.39.5


