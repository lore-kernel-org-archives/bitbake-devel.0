Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658FC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 18:48:07 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.72])
 by mx.groups.io with SMTP id smtpd.web10.54152.1723488480352855277
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 11:48:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=DQHFwBFv;
 spf=pass (domain: axis.com, ip: 40.107.103.72, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptRp5hevoTGNNOZVt4BpDfUy/KnSHmsRXhV5g3KLgrSBBhFJUaEU63Um+Gzoo5JTNMXcT9tlrkJtFqMI037T25Rj/FVsFfkyOt9fHc/2CuA0egxtXPjJwuOffVoGkRvNNM4hmmTNSIN2kyACMPlgHrcesuBXCU3ysHccbGYM8f1IiJyZjYJ9VACM3tO7NBPT1tNvqFW42t9LG4LYfGXykXV+H8cHHNeM5MSy1f2xzuQdP8V3o+yJJieVFsXYAJd3vB0Xgju/fDpArwVkTih/6R5Wv/RDuNThFz4Ow8E6jtSvbjpnT04DTVJC/aUDjWGivSxfoGVBlxXwX7QSvZ8zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmg0KNLh/jfR8osK1wl/z/jCJBedzbDfLdv7Lak/uWQ=;
 b=v+Um1+f475Ft88tQXACrE5tM2Zii+vIzeKBYNNLLhkYrvMsIzrGd/QeTETNfTazGDXRXxQ9o20wPq27qXzGVtTDBVZrFjEkSVSdR/T45ozwpQaIfQ/rgwp8bhirKYZfR32NbKLGcTlkpkb03u51/r0fG7Ajc0EChduvkS8MHNMsyhHK6FRH1euCy3R6+XDqXaGTIG410T4iGna0k6MnZSjP45AvcITADzmyc4FhcxppJ2q4U/hHDg6UtDTGRIyLa5dBbn53aZQ1rH3wyD8jjKXxoYU11/iiRGP/PTXegAQZyWJqwshgv1+Jz5ZNdfKp44leQakD4f6ne1mMYOWPXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmg0KNLh/jfR8osK1wl/z/jCJBedzbDfLdv7Lak/uWQ=;
 b=DQHFwBFvwIhD6+/4ID96ik+iShWZQJ4vm7IRcFfpoEeFsXefegHeNqCsRfvBVA0W/O1bhOEGulo6TZ9XZczUuyvvUsS5DRJUo4ta2egGOuMYok97uzNTPuFcwqIr6MVzUMkGwKoqV3KKLwXqNl0xiBjTBkJkOgpHcg/WHA+0kp8=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by GVXPR02MB10933.eurprd02.prod.outlook.com (2603:10a6:150:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 18:47:06 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 18:47:06 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/4] cookerdata: Separate out data_hash
 and hook to tinfoil
Thread-Topic: [bitbake-devel] [PATCH 2/4] cookerdata: Separate out data_hash
 and hook to tinfoil
Thread-Index: AQHa7M/UrjpxQg0Z/EyQG28ryHxAnrIj9Ywg
Date: Mon, 12 Aug 2024 18:47:05 +0000
Message-ID: 
 <DB5PR02MB10213CCD9092A702CAE596C88EF852@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
 <20240812155335.904273-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240812155335.904273-2-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|GVXPR02MB10933:EE_
x-ms-office365-filtering-correlation-id: d428ad2c-5af2-43ab-322a-08dcbaff29c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tS6YBMjUe2Im6xo9db0yKPAK6BuXsYjtZ9N+kV0MlpldalOrH/OYU5/yeSsK?=
 =?us-ascii?Q?sBbw0dpZc23HQm1ZmFxbvKfxDNCeSdKI9AVdXz/3xbtI4HjUvXuXi+9eNNL2?=
 =?us-ascii?Q?1PeSTcYXvTEwm0jhhJWMFMNYkCndbc+f1IiK/+8scexZ68A9j3Dv5kQIEwkc?=
 =?us-ascii?Q?cSLRxf9NcoAWLLEjIKH/oF6VqWeUTxsjepoFa++zonN8JkJTjzjNfd22dQ/R?=
 =?us-ascii?Q?rI0xKL8DhPV8kP6ab7RoJaP/+HqHmNPG/3k1ZJ9zLNevTHYzdprO3auUl3CQ?=
 =?us-ascii?Q?SXJUoFbZ1dF1bCApg0SdrmkuuKH9W1M1arJhAh1PNAWALU6XReIb6p3Z5+F2?=
 =?us-ascii?Q?EaO3vO3/m3atSGEsrg3DWq0XACpu/7P0l+onk4psJOMntCHQwJKhstdEeI5K?=
 =?us-ascii?Q?/CqSfmgYVmsxGAQ4XQGcEYPfyQO+1eVjnvLJ7QJyfKAoyrUoRBmZTqpOXVgQ?=
 =?us-ascii?Q?chePeAgWVuP5fKX87u70L/vl8HYEolhks0iEzeJDqhwfhfpMQ3xgg6ojX9qP?=
 =?us-ascii?Q?siFVi30uteIodBcK8XHk9vnj9N0JNxV9o/wBlqmLXXfjF1ZN/nYIDRZWZuHh?=
 =?us-ascii?Q?Ulxd+bFV5hzs+aCYKKbIQ8CR4tryDRmswHzzHafKGRczKKkQItzRrkBq+Lso?=
 =?us-ascii?Q?cHSN8UcYIQ3f1MxzQ2jFPDp8cHCWY2EFmYhnjrNthNI49U72OruaHVSm2wJV?=
 =?us-ascii?Q?IsYMsaOO4553Sdvhhpq65ZMKuyQoBNwavlxMNAVDgmUrg7eGMEWpgfvpTCY5?=
 =?us-ascii?Q?528C2SsmkdccqYJiIQUSJgDXmykl4Oix36kftuL8NiVdyWYMTmpC18W3WPYz?=
 =?us-ascii?Q?A4KYY6RpHL754fk6Ze+5nDvqiVb59CqZeZEwe4TBq8NOs1RJDvj3/KDTBS/i?=
 =?us-ascii?Q?S0kj9GP0i/g33eifD+JBqxOd3efXvUCNk0hbyr0fyVrDPx5TBTKiG4qxZGzB?=
 =?us-ascii?Q?KctwZCtR1bA6XMVb/D8De38cGf6BQa3IkeNAIvV1CDwb1Q4JemAFHmzA3bAv?=
 =?us-ascii?Q?kfQufZN7jAzJsXwPE09hcdArfs9Yn+hhsTmd3PT+s2D34usTFwPviWSRp7cr?=
 =?us-ascii?Q?XQlca6DTEauKBcePKhim32/X+7azu4rZq0Lxy2fCSlbtM1HOE+fPzkdb7Vz9?=
 =?us-ascii?Q?B0OyHkgiPgWiaA9nS/JBMMxa0eTQnPwa7cFInp4ZkNMXLIsPiVFR1UgzLA08?=
 =?us-ascii?Q?xwcAh5knkS5gKKc6x9gQcerQ306QZ0zYX4HNsC6GgWK8ZXPO7FoL7ddULVjR?=
 =?us-ascii?Q?8aMApf2QE2SMLrZu+0fafFeDltuRxjuUS9HsUahc8CA+jLF/mGMRDMxFHtX5?=
 =?us-ascii?Q?sogD/8iNSfT4X7GAxXqSHhuelqVYGLh8knOWjImCYNHlKSYRP5Oh1t+KZ2HC?=
 =?us-ascii?Q?diS+oVfqZS1wlAPQXvNFZXmNx+iqXOvmzRO+yIuQtIfbJd4tmA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KOiMkHPRx4N7e6963lJrwMYIlQbUESWftE7Qi/p9B35J+JCaOcOZ4gpJRGHp?=
 =?us-ascii?Q?s4oG/YlNtE5TwphH9v64tyI3bvEajFxkYWRKHl0Iiouf0/O3b8KEGWFbGNf+?=
 =?us-ascii?Q?m7Ow3t7XIWaVp3HBDeErXg98mk/bXOB1TWRMay2cG8zohgzwLO6JccYuf/ss?=
 =?us-ascii?Q?EAdvUEyqtZpUr+6Eycr7vs+UAjL5L6MXSDfvfF902FNm5UF9IyP974wDFtjY?=
 =?us-ascii?Q?ymTNn8674OjbVVU7gAuMzs2NbYJumGNP0MvBXDzHCdR0Lf34urVlLlBDKc8x?=
 =?us-ascii?Q?v+mINsEHtwIQfiEosSJEj/l8ot/JFfdaQAlFPhkNACNKaAkKsKs6wTxtExWJ?=
 =?us-ascii?Q?mi3PZwZU6li3nsZAAoLwPRRTwGp4fnAHgE6remqp4m23gCnhxSUc6mBxkbwU?=
 =?us-ascii?Q?axXbxxH38zBZfqUFE+neIULJL76qM2aEWAu4XCwNR3+DoU04/2tNHt9npLXx?=
 =?us-ascii?Q?TZudGX0Ud97088GmtXa08g7A785478v9tbKL75J90WBr2NZqFFT5wLTygg4j?=
 =?us-ascii?Q?0B01flkOnznzWW0nql2+uftBIZ5Ctep4btlZDal4uyWwgPWngUQvSsvgF0Xl?=
 =?us-ascii?Q?EZuCGDaj//sKFpcHcAVGqEhRbxyKMWZ2TRiLa6ziBc89NKTsXMogkSn/LYUy?=
 =?us-ascii?Q?FhqSyBrURR+yfsdGt41vU+whojtNQpjudh9aOtQhXEhkIg/mUXciBUg3Orbp?=
 =?us-ascii?Q?GeySmV2xwOdOchML/zd7ZAOxZzioKbkW0pm2xCNVFGBImGF+drbKjD7u15q1?=
 =?us-ascii?Q?AzIEqDIm3+baLsEb0tX4+79l9Ew7rGBVv3d2HPhhmkrE9sE/P4wLMNbjzs0e?=
 =?us-ascii?Q?bH9xXibrtAnc23UJk9P7mT9JEmB0gLSMNuhfpY4cNe7Qc+fQ1bz4RI1pW/VN?=
 =?us-ascii?Q?b6ZY8E4GLYuqhgTmSiBMckElgZ0G1nKCe71DKf0Tk21lRm88yNEv/5nqDgB3?=
 =?us-ascii?Q?OIWzTh9q2xiUhyLsEupbi0M1tQVhaFz9tAepMuRd7lw1I0njRsKSAf1Uj3EC?=
 =?us-ascii?Q?3/IdjkTk8IweWoeCE2nBJNkXjQBWWmiMUNHUF3MckOtO5o/mgueJOBRGsWy0?=
 =?us-ascii?Q?J9kYagDM09owjaqr+E5aYmDofLYnzavHCoQY3onkqy6WE/UbALFIFS46all2?=
 =?us-ascii?Q?30Bm4qQ0cKlEbBGhUV3L3/97yoDBjEJFyViVXKZvI+7IPzJaA/I4aderKeJN?=
 =?us-ascii?Q?4KTquyr/zLoCtAOvukAqGfluHqXfwLCWShsCIBcdjJSf8YsS/bzuzDsxcjVH?=
 =?us-ascii?Q?2intOq9Tf51D6FgRiXBqveRPZnQtfeb5zj9KsyuRwBxsJq3v0uVMdlyeStil?=
 =?us-ascii?Q?Ys2rfnvMWsQkcXBqaHlx7mJ0ADoX4XM6nrUPv1yz+XcchNZNYhn8XqKK/+F2?=
 =?us-ascii?Q?FlJe8LcVHgp/UiFXTxoNbsjs0UDtBABRRXvqH5skNqLlPuCzrmZdThotoR+s?=
 =?us-ascii?Q?4Y80AtY6+Fox7Y0hHJbxzSKMKjCadh2LZRz1UjbnyHqLcSB6c9AK9myRJ51y?=
 =?us-ascii?Q?oC98ZBUjYhgVWYO7yJDH9kFX8ShFuQxnkn3m+dEtfjkqGBK0yCxRl7toaTEQ?=
 =?us-ascii?Q?RCJWZUsVeeQf4yEMzk4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d428ad2c-5af2-43ab-322a-08dcbaff29c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 18:47:05.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jSHH336vJAo/RPkEiZfg51mhEVWYyM/nK4+7Tyll4E8DB96BYsCie5tM+U+vdgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10933
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 18:48:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16475

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 12 augusti 2024 17:54
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/4] cookerdata: Separate out data_hash a=
nd hook to tinfoil
>=20
> Within tinfoil, the user can write to the configuration data but it won't
> cause the data_hash checksum to be re-written, meaning cached parsing
> data can be reused when it would now be incorrect.
>=20
> Abstract out the data_hash code and add it to the invalidateCaches
> command, called by tinfoil.modified_files() meaning that tinfoil can
> instruct bitbake to update the caches and re-parse if necessary.
>=20
> Also move the data_hash entirely into databuilder and drop the copy
> in cooker as obsolete and not needed.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py     | 10 +++++++---
>  lib/bb/cookerdata.py | 13 +++++++++----
>  2 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 6754f986bf..31fee2bead 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -281,7 +281,6 @@ class BBCooker:
>          self.databuilder =3D bb.cookerdata.CookerDataBuilder(self.config=
uration, False)
>          self.databuilder.parseBaseConfiguration()
>          self.data =3D self.databuilder.data
> -        self.data_hash =3D self.databuilder.data_hash
>          self.extraconfigdata =3D {}
>=20
>          eventlog =3D self.data.getVar("BB_DEFAULT_EVENTLOG")
> @@ -370,6 +369,11 @@ class BBCooker:
>          if not clean:
>              bb.parse.BBHandler.cached_statements =3D {}
>=20
> +        # If writes were made to any of the data stores, we need to reca=
lcuate the data

Typo: recalcuate -> recalculate

> +        # store cache
> +        if hasattr(self, "databuilder"):
> +            self.databuilder.calc_datastore_hashes()
> +
>      def parseConfiguration(self):
>          self.updateCacheSync()
>=20
> @@ -1338,7 +1342,7 @@ class BBCooker:
>          self.buildSetVars()
>          self.reset_mtime_caches()
>=20
> -        bb_caches =3D bb.cache.MulticonfigCache(self.databuilder, self.d=
ata_hash, self.caches_array)
> +        bb_caches =3D bb.cache.MulticonfigCache(self.databuilder, self.d=
atabuilder.data_hash, self.caches_array)
>=20
>          layername =3D self.collections[mc].calc_bbfile_priority(fn)[2]
>          infos =3D bb_caches[mc].parse(fn, self.collections[mc].get_file_=
appends(fn), layername)
> @@ -2112,7 +2116,7 @@ class CookerParser(object):
>          self.mcfilelist =3D mcfilelist
>          self.cooker =3D cooker
>          self.cfgdata =3D cooker.data
> -        self.cfghash =3D cooker.data_hash
> +        self.cfghash =3D cooker.databuilder.data_hash
>          self.cfgbuilder =3D cooker.databuilder
>=20
>          # Accounting statistics
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 0649e40995..3ad5cf3dd0 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -254,9 +254,16 @@ class CookerDataBuilder(object):
>          self.data =3D self.basedata
>          self.mcdata =3D {}
>=20
> +    def calc_datastore_hashes(self):
> +        data_hash =3D hashlib.sha256()
> +        data_hash.update(self.data.get_hash().encode('utf-8'))
> +        multiconfig =3D (self.data.getVar("BBMULTICONFIG") or "").split(=
)
> +        for config in multiconfig:
> +            data_hash.update(self.mcdata[config].get_hash().encode('utf-=
8'))
> +        self.data_hash =3D data_hash.hexdigest()
> +
>      def parseBaseConfiguration(self, worker=3DFalse):
>          mcdata =3D {}
> -        data_hash =3D hashlib.sha256()
>          try:
>              self.data =3D self.parseConfigurationFiles(self.prefiles, se=
lf.postfiles)
>=20
> @@ -279,7 +286,6 @@ class CookerDataBuilder(object):
>                  bb.event.fire(bb.event.ConfigParsed(), self.data)
>=20
>              bb.parse.init_parser(self.data)
> -            data_hash.update(self.data.get_hash().encode('utf-8'))
>              mcdata[''] =3D self.data
>=20
>              multiconfig =3D (self.data.getVar("BBMULTICONFIG") or "").sp=
lit()
> @@ -289,11 +295,9 @@ class CookerDataBuilder(object):
>                  parsed_mcdata =3D self.parseConfigurationFiles(self.pref=
iles, self.postfiles, config)
>                  bb.event.fire(bb.event.ConfigParsed(), parsed_mcdata)
>                  mcdata[config] =3D parsed_mcdata
> -                data_hash.update(parsed_mcdata.get_hash().encode('utf-8'=
))
>              if multiconfig:
>                  bb.event.fire(bb.event.MultiConfigParsed(mcdata), self.d=
ata)
>=20
> -            self.data_hash =3D data_hash.hexdigest()
>          except bb.data_smart.ExpansionError as e:
>              logger.error(str(e))
>              raise bb.BBHandledException()
> @@ -328,6 +332,7 @@ class CookerDataBuilder(object):
>          for mc in mcdata:
>              self.mcdata[mc] =3D bb.data.createCopy(mcdata[mc])
>          self.data =3D self.mcdata['']
> +        self.calc_datastore_hashes()
>=20
>      def reset(self):
>          # We may not have run parseBaseConfiguration() yet

//Peter


