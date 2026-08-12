Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C9C5B572
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 17:00:48 +0000 (UTC)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.202.1786554047070030207
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 10:00:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=cARKHrPl;
 spf=pass (domain: cisco.com, ip: 173.37.142.91, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8424; q=dns/txt;
  s=iport01; t=1786554047; x=1787763647;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=mZbYCmJqF49V7v/ErSRQrDkgOaBhb8EogdpBzPkiBtQ=;
  b=cARKHrPl1mKM157VPJQAymdUYTsJZX2YDyAGz1hU5PRZUPODd7kjhqwe
   vOZaR+QPigfPnsQP2DL+t7chIaBVYsgXWU/ZPrSIF5pppy9SmjErbyx6n
   w1Sky18bhcYfHlMA+OIY2m5DeuR+1fDBf8LEv6YWqySvGHlYkPTXm0yuJ
   NE/5TVs047t3hKekVYVLPSAnfZkl8zJSrwT/w0B64g/vH3XIwil+80z1h
   yoHTspUXMq+zjIMIBNUa7s5B8Jj6xcxw/UQC5+Rsq56hgIkgEIDT/DFR1
   uvyDMxWVWwh9W/TnKsa76JxT52qyPbsVC+B1v+sLbNGgmm20ifBtXmM3b
   A==;
X-CSE-ConnectionGUID: O91IltUhTMSY1kczEIJ1CQ==
X-CSE-MsgGUID: RZKNNEaBQQ+q7y3HrVp6Rg==
X-IPAS-Result: =?us-ascii?q?A0ANAADGpXxq/5AQJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAWWBFwYBAQELAYE8ATBTgQgCgSFJhjqBaQOETF+GWIIhA54bFIFgCg8BA?=
 =?us-ascii?q?QENAi4BDhQEAQGDToE3Ao1nAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4Thk8NhloBAQEBAwGBCAIBCBEEAQEBLicKHQgCBAESCIJ7gh0WQ?=
 =?us-ascii?q?QMBAg63bwKJSxo3eIE0gQHgOBWBOAGFPoMdAQEqgTWCXYEjGRuEYScbgg2BF?=
 =?us-ascii?q?UKCaT6CYQQBgUMchBOCMASCInoSG4IxPYJqjQ1SciIDJjMsAVUTFwsHBYEjE?=
 =?us-ascii?q?DMDKi8tI0sFLR1wDCcSDx0XFx5YGwYFEiAqQUQjAz44gUgCgXU/Ixk2fIEJY?=
 =?us-ascii?q?YErKmYCEBdGLhWCJAKCdoEqA14CAR4LbT03Bg4ZAwSBNQWNGwdcIIJDAQJSB?=
 =?us-ascii?q?gEaBxQqASAPgQVQLaMJR44Zk1mBPgqEHoo+gWOIYYRdiDIXhASBV4s9mVSZC?=
 =?us-ascii?q?COFMYg2lTRMhQ4CBAIEBQIQAQEGgWg8gVlwFTuCZwlKGQ+SI4UTxwZ5PQEBB?=
 =?us-ascii?q?wIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:EekLER13Pfb09hn/smDPmlBlVkEcU/3cNwoR7N8gk71RN/7l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUTdY
IronPort-Data: A9a23:Hi8OYaOQ4Yi/CUzvrR35lsFynXyQoLVcMsEvi/4bfWQNrUpz1jJRz
 zRKCmzUPfaOazOnLtAjb9uw9h4CupfRxoNmTnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV7lV
 e/a+ZWFZgf1gmQsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69I/VWAyIbAYxsNMMDhN/
 u41CRJURSnW0opawJrjIgVtrs0nKM+uOMYUvWttiGmGS/0nWpvEBa7N4Le03h9p2ZsIRqiYP
 pRfMGYzBPjDS0Un1lM/E4wlguqunWLXeDxDo1XTrq0yi4TW5FwpjeW8aIGOILRmQ+1vrGW+g
 E/P1V3AQQhFJYe/0wSdrEij07qncSTTHdh6+KeD3vRrnFeaxWFWBBAIWF+TpfiillX4XMpSL
 UER8CcioaU+skuxQbHAswaQqXqAuFsYHtFXCeB/sF7LwavP6AHfDW8BJtJcVOEbWAYNbWVC/
 neCnsjiAnpkt7j9dJ5X3u38Qe+aUcTNEVI/WA==
IronPort-HdrOrdr: A9a23:/ytAtaCZTT/iUDflHeilsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdvZJhBo7y90dq7MA3hHP9OkMUs1NiZLXLbUQeTXeVfBM7ZskHd8k7Fh6FgPM
 VbAtJD4bTLZDAQ47eZkWyF+pQbsaS6GcuT9IHjJgJWPHlXgtZbnn5E42igYypLbTgDL6AUUL
 Cb4c1KrSehf3M4UuSXb0NuY8Hz4/fwuNbDexApOz4LgTPisRqYrJLqGRmR2RkTFwhI3aoj9m
 b9lQn47LWIsv2wyBPQvlWjoai+nuGP9vJzQOi3zuQFIDTljQilIK57XaeZgTwzqOazrH43jd
 jluX4bToROwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCvBGmZlSfnLimgkdVZBHoe
 B2NlCixt5q5CD77WPADh/zJldXf3+P0D8feCgo/iViuMUlGedsRMckjTJo+d87bVLHAcYcYa
 hTJfCZwupKelWHaH2clGxuzNuwGkkXJH69MxM/Ugj/6UkKoJi/pHFonvD2kho7heEAYogB6O
 LePqtykrZSCscQcKJmHe8EBdC6E2rXXHv3QSmvyHncZeg60kj22tbKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34BF3Wu4xjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeX/
 qoIppZD/LqMGOrE4dU2A/1XYVUNBAlIYcok8d+X0jLrtPAK4XsuOCeePHPJKD1GTJhQW/7Cm
 trZkmEGCyB1DHdZpbVummkZ5q2QD2MwXtZKtmuw9Qu
X-Talos-CUID: =?us-ascii?q?9a23=3AcIVCimtESNMZgTs8DPsvRCvk6IsCIyT8yGvtI3O?=
 =?us-ascii?q?dMlcwS7aHZH6yoYhdxp8=3D?=
X-Talos-MUID: 9a23:DC3W8wny8I/A4n0yibEAdnpYBuROxYmnInk00oxZqpKkLxJoZQ2S2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 17:00:45 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-07.cisco.com (Postfix) with ESMTPS id D5A1218000BCD
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 17:00:44 +0000 (GMT)
X-CSE-ConnectionGUID: lDjRddOARuafsnG+3B+Q/w==
X-CSE-MsgGUID: ZZRD4I68T5Sy2hHMg5adpA==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208,217";a="58319119"
Received: from mail-eastusazon11011055.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.55])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 17:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oed00yJqNPLuGGfpTFGyzw8BAtkf5QMHP7EBDgzvE3j/yPcswE9iFYh44IJB7fk89XsT9brtQflm8/TEYRWbIqrsmwDs0L8Bz1Gs+CUQwr1fywcQgO22D734H/cGb6yfFXY81SfBVeXxpXK2lkRzG5OpgYzsFT1Msy+eiWQMv71APytSGi/peJAjxd7PDyiWI92MaIeO0aSCCsXTlrYS4bV3GTVtRi0Pw3wnYLXu1AdHAT27gtmRVMBIQXqZ7wMPt2TlrGpm4S5GyaLu2NovgBFkUWhlUWUrl+MbS8wgR4WOtomZJs8E4jmMuDqKZoc+2F77nmq1H99UBlwrhtQ9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZbYCmJqF49V7v/ErSRQrDkgOaBhb8EogdpBzPkiBtQ=;
 b=MOfLxj3vEW63Pq1wkjGU1JujXsk9TAbhWEnSOtjVFpA1Pe678Jb31Rx0AzksUGX3cTsi5I+BHBbOYP1hyd9DRzf48yBbd/GhHk6pyNzvtiHiu+tGdSyBa0jmiLC4b4dqrRvP2R2ONfulitR0vpUGZ/7kxiOKhqBV99tcxlvj6KdSh+Yn+8OpIjeYb9yY5tFr/a8ghey3QULOVXXxcYeSiHf2+kK0Jf6vns0NEYKOqFR7zSr3qsmHt2cd9gzc2N6KckVl8L+/7jlekLAEa+5DBgkapxogmVdQgseE8k/+xLzGtoTDpc+Sd/hheRSX5liWqvHMmymfQL0hPeYzXWm5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 17:00:41 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 17:00:41 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: reuse cached HTTPS
 connections
Thread-Topic: [bitbake-devel] [PATCH] fetch2/wget: reuse cached HTTPS
 connections
Thread-Index: AQHdKjIcRsOrUi4UUESHej0HaYuU+LaaaqYAgAA41dE=
Date: Wed, 12 Aug 2026 17:00:41 +0000
Message-ID: 
 <DM6PR11MB39622631465C058DE729DC36CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB39629DE24C8A6EDFBBF5B89ECBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <DKN0784SKJ24.PJP5ZNBXS2UO@bootlin.com>
In-Reply-To: <DKN0784SKJ24.PJP5ZNBXS2UO@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|CY8PR11MB7337:EE_
x-ms-office365-filtering-correlation-id: 73af0dc6-4ba8-4ca9-fc8e-08def8933df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|5023799004|10067099003|6133799003|8096899003|4143699003|13003099007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 FiZKqveEpK1MeaCons4+egBHeV67ch0vFnAE61fdj9K7Bdb6+vEPiC+SSlaLbwfzcbGaDkW5tm85W7+8Q5zSMeLx6UvYbVCXpxa5ZYOHIfjrxGdBE067rdmCMoFQ4gWQUzExfW+bB6XR4dygeXQVkaRK7L2TVMY0Ljm9ILXdj3elD9r/09hqeqbL/RvGBYd3zQpneTL8DaTYlzkemceBACsVk+S8lAxW9Ukwi06mHx4W4Fm9I8ZKTyIVumzXFcFT/l9KkTuyXdW8Mm3eo/MO2IS4ipOzwabZIK0Mp0Uu53PiFNACIQ1B7wpqx0BgQqV8sCzGNqqXgRgLzE55aKIe8/GSu+Ggz8VA1G3HBajlt4J2oTW9InPx/necdF4pARNkfXJtUw7dFvGYN0qolo3xzxcPjmgAGqvGV8tocmCrgVViF2J9HmLDPAmj6NUxFRQKpXLtWAFQYiF7Is8UC10x2pNvkYTVYvM+iUUVoBXlKwPOt/1r3xpYUnahC9YRe3sK+VyE2QMPWJqZM0QgT8I4SeWp/CfE3P43W0DVw76yiq/rApH9SLEoHBoOQMLoDhqriWCN7PHQRwazHf8W2h9zBjF7MHEW2vMU5wH1bkqzNP37SYtmcgKjX7KkZCmTd2Idt+JIeWXgTGjzBVW1NoRVZ1FBkmNqpbsDIoew7qaioMg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(8096899003)(4143699003)(13003099007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6Evc89ojKfExEt8xSyTnoD4iVd5kk92d1goFrxgC5++wiJe19urRL1t+rnB3?=
 =?us-ascii?Q?c7tUa/15/ZkuDeUArQVPvMFevbLikU2NQ7TJhlWUf1Y9ZvBioLJ9cOCGZRmM?=
 =?us-ascii?Q?sGPwf4zThP7cMpRHSsKD+1qszNfUSlKWuVNIMYCIvyKxR0tpNjUxJkkNmFdq?=
 =?us-ascii?Q?LiHz7ikyeWCH0jWDyg7xqIbtSD3HjFQyBclKQ8dI+qJ6FX2ZmYHpapp7Exgg?=
 =?us-ascii?Q?J94WD7Y4lodCoNwG6KjIRu22IANryA1bHyGQfyCC4zxBudootXCeozD74R2P?=
 =?us-ascii?Q?r6tYNPs5WG0/C00Ey2E2ncnZdMy2ZVPYAA7fev3cEG5MevVfUf4Aq6ElcHve?=
 =?us-ascii?Q?Vx1kMDSJVhpFMlVbcFRPLFebjvP783G3fYDIqVfaGXNwEu2GrnovaB/8Eyso?=
 =?us-ascii?Q?47g9kBY/aG+nNLendYL+tdNNiHfUvBq7/WlGQf+DkFab6yYmml7UlZmVJWDz?=
 =?us-ascii?Q?j+ElEPbCSxVvyZaMWe8ifvrYkuRQBJoNg4PzRh1W7iO9v/sWWyXSWiHbw86u?=
 =?us-ascii?Q?hVoNzJt4+tkZKkfrwlL049csTDR9ktnu1jyv15Br/PFImKVQGfcV1OHbLN7Y?=
 =?us-ascii?Q?pilkZAaDyTC6tQUGjRuyl3lMBc8wY0+w+S3JXpLGRrkOl2EMQX1IWiGLWboI?=
 =?us-ascii?Q?g63W7WteoNuAQw0dik1GcQEAdBKqjp7icGSHnM5z8+5aKhC5gXdoF9QCSUMF?=
 =?us-ascii?Q?uvsLe/w/MwW0vX4DwciJ6da+91Db+axZ3IkBplD/+2BUNqcuRo5cLoZ/jBWS?=
 =?us-ascii?Q?0VU4Rt6aEOQHDb4T//qV7K1/7eYhyCLocDNkvI75wbAM6Wl9NjejkZUC1XM7?=
 =?us-ascii?Q?QCqEfQ9XMrvt6EKAE1jxctWGt6y5MudLBD6fzsd5zkC43XAFmjeSCu0y4dUl?=
 =?us-ascii?Q?O8anGMaudmtprtesWKdFdGjrqFD52vDxa3jfjzcIbzQwaQgOpHLJt6ECdGi6?=
 =?us-ascii?Q?KlOwdn02HSfiErRyiztesqBTA5fCzEald5S3KyvQ6Oex6HqNV1wR+b9c8pbo?=
 =?us-ascii?Q?vizx8hwxtCVtylHbYdWxZDtYgtD3qaEeNZnc7dbLL4taIA73se0DUleMez2m?=
 =?us-ascii?Q?y2NgEChvFV1FhTtSrnyF4rOUSV0IvlydK71DhOR1GuIKHrmxCQKaitThEd/p?=
 =?us-ascii?Q?47/dqgZqaRbPNCYQ8kEc37fcA6nkTpqWc3vx7++zIVJaCEa3JUEyRiG/1zRW?=
 =?us-ascii?Q?fUTlw142BEHuNCZIEVeieAHo10wdF3G1ZzPaNZkgIjIg9iIUnDQ0XkMOVMYQ?=
 =?us-ascii?Q?NPiAKr4Yb69vxAF03MVqQo0afKMb7rcFNYSSUW2IvpkMfjGCuPCkkuPfG58I?=
 =?us-ascii?Q?2ypzoEIbZxE59VRdC7lAwwfmBEkjd1i03QOBsUGvdvMi7ZdIxS7krR/21zTw?=
 =?us-ascii?Q?opbstZupLzobpqClv9TGdbrf08CFmGGCDMo+m+aT7rHhlrbBlTa6Qn29BnnG?=
 =?us-ascii?Q?5gNUnw/YdqXmJJufhg/2hTVWAsv+T5PNNL/GnQlOfyT16oU/5oI5xFLpYkLW?=
 =?us-ascii?Q?hPn0ErxuQGs/zUCinjZRbl5Z+Ks1ZIO7SJFVBgfrTlMtGme0ERjha3WXcxkl?=
 =?us-ascii?Q?ABkwQVjWzqC5HVZ2F3F43r+2M4RN3SWn9WJesVMgky42UkzdYafXC+OyEpMm?=
 =?us-ascii?Q?5O9E3y4a3mKBwR9nPfUhAkwsKc1vx0pehV6iZrIkdW8tO+2KeDRnkPB21026?=
 =?us-ascii?Q?4LXJnZbSYMTiBYZQpaVt7hUzEVnB+QfzUeVYrQ6bKXzm+CJ2?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB39622631465C058DE729DC36CBDC2DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	BInfNrkscjdpVFfkDU10hbSAMUIsBuuhPkteXE3IOxoaGFdMocNBaPvehwrswQVQVbwcd+Wn+aaZxOiUZeGz+/mwSG1tMm3fsHr9jon9U1fadAeG9xjsMNPh61NQhCqeTY1Cu/JCEo5Mc9KGbr4w3Lb5srrGI/OTT5+KfA2PlB/zOVrEUgW7kmO6GnP9k2SBaK/XEstMj+sf5E4vJcHRa7iPRMrD9esNjrTElvnQtdp3XjVdy/9K5JK0sjQU5M+s4u15Lx3CsE+FlJSh2GipypRmIK2yWAJgKOF2gC1MK3wPcjTkbJe5r3aqq6yZfvzNGiiCvz9z4eGTNzjD1DUNEA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73af0dc6-4ba8-4ca9-fc8e-08def8933df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:00:41.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbCWXIFv5uxTagwaUQLBY4bOBJlmGlfWJex3CZM+cRYFIj0d4ltHJ/3+0HLkJa8WZqhTv/cOWBLJzD/VyaqXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-2.cisco.com [173.37.147.250];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 17:00:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19917

--_000_DM6PR11MB39622631465C058DE729DC36CBDC2DM6PR11MB3962namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Mathieu,
Python 3.12 removed the HTTPSHandler._check_hostname attribute, I'm will po=
st a v2 patch shortly.

Kind regards
Fredrik
________________________________
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Sent: Wednesday, August 12, 2026 3:36 PM
To: Fredrik Svensson (svsvenss) <svsvenss@cisco.com>; bitbake-devel@lists.o=
penembedded.org <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: reuse cached HTTPS connec=
tions

On Wed Aug 12, 2026 at 10:17 AM CEST, Fredrik Svensson via lists.openembedd=
ed.org wrote:
> The checkstatus() path reuses cached connections for HTTP requests, but
> uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability
> check therefore creates a new TCP connection and performs a new TLS
> handshake.
>
> Add HTTPS equivalents of the existing cached connection and request
> handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and
> extend FetchConnectionCache keys so HTTPS connections are kept separate
> from HTTP connections, different certificate policies and CA files, and
> different proxy tunnels.
>
> Add a local TLS self-test which proves two HTTPS HEAD requests use one
> TCP/TLS connection. The test also verifies that a connection established
> with certificate checking disabled is not reused after checking is
> enabled.
>
> In an ABBA benchmark against BitBake master, 4,283 remote sstate
> availability misses averaged 761.639 seconds without this change and
> 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x
> speedup. The benchmark had no matching mirror objects, so it isolates
> availability checks rather than download and unpack time.
>
> Signed-off-by: Fredrik Svensson <svsvenss@cisco.com>
> ---

Hi Fredrik,

Thanks for your patch.

It looks like this is failing to build here:
ERROR:  OE-core's config sanity checker detected a potential misconfigurati=
on.
    Either fix the cause of this error or at your own risk disable the chec=
ker (see sanity.conf).
    Following is the list of potential problems / advisories:

    'CacheHTTPSHandler' object has no attribute '_check_hostname'.
    Please ensure your host's network is configured correctly.
    Please ensure CONNECTIVITY_CHECK_URIS is correct and specified URIs are=
 available.
    If your ISP or network is blocking the above URL,
    try with another domain name, for example by setting:
    CONNECTIVITY_CHECK_URIS =3D "https://www.example.com/"    You could als=
o set BB_NO_NETWORK =3D "1" to disable network
    access if all required sources are on local disk.

https://autobuilder.yoctoproject.org/valkyrie/#/builders/2/builds/4382

Can you have a look at the issue?

Thanks,
Mathieu

--
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--_000_DM6PR11MB39622631465C058DE729DC36CBDC2DM6PR11MB3962namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks Mathieu,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Python 3.12 removed the HTTPSHandler._check_hostname attribute, I'm will po=
st a v2 patch shortly.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Kind regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Fredrik</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mathieu Dubois-Briand=
 &lt;mathieu.dubois-briand@bootlin.com&gt;<br>
<b>Sent:</b> Wednesday, August 12, 2026 3:36 PM<br>
<b>To:</b> Fredrik Svensson (svsvenss) &lt;svsvenss@cisco.com&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<b=
r>
<b>Subject:</b> Re: [bitbake-devel] [PATCH] fetch2/wget: reuse cached HTTPS=
 connections</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed Aug 12, 2026 at 10:17 AM CEST, Fredrik Sven=
sson via lists.openembedded.org wrote:<br>
&gt; The checkstatus() path reuses cached connections for HTTP requests, bu=
t<br>
&gt; uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability=
<br>
&gt; check therefore creates a new TCP connection and performs a new TLS<br=
>
&gt; handshake.<br>
&gt;<br>
&gt; Add HTTPS equivalents of the existing cached connection and request<br=
>
&gt; handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and<b=
r>
&gt; extend FetchConnectionCache keys so HTTPS connections are kept separat=
e<br>
&gt; from HTTP connections, different certificate policies and CA files, an=
d<br>
&gt; different proxy tunnels.<br>
&gt;<br>
&gt; Add a local TLS self-test which proves two HTTPS HEAD requests use one=
<br>
&gt; TCP/TLS connection. The test also verifies that a connection establish=
ed<br>
&gt; with certificate checking disabled is not reused after checking is<br>
&gt; enabled.<br>
&gt;<br>
&gt; In an ABBA benchmark against BitBake master, 4,283 remote sstate<br>
&gt; availability misses averaged 761.639 seconds without this change and<b=
r>
&gt; 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x<br=
>
&gt; speedup. The benchmark had no matching mirror objects, so it isolates<=
br>
&gt; availability checks rather than download and unpack time.<br>
&gt;<br>
&gt; Signed-off-by: Fredrik Svensson &lt;svsvenss@cisco.com&gt;<br>
&gt; ---<br>
<br>
Hi Fredrik,<br>
<br>
Thanks for your patch.<br>
<br>
It looks like this is failing to build here:<br>
ERROR:&nbsp; OE-core's config sanity checker detected a potential misconfig=
uration.<br>
&nbsp;&nbsp;&nbsp; Either fix the cause of this error or at your own risk d=
isable the checker (see sanity.conf).<br>
&nbsp;&nbsp;&nbsp; Following is the list of potential problems / advisories=
:<br>
<br>
&nbsp;&nbsp;&nbsp; 'CacheHTTPSHandler' object has no attribute '_check_host=
name'.<br>
&nbsp;&nbsp;&nbsp; Please ensure your host's network is configured correctl=
y.<br>
&nbsp;&nbsp;&nbsp; Please ensure CONNECTIVITY_CHECK_URIS is correct and spe=
cified URIs are available.<br>
&nbsp;&nbsp;&nbsp; If your ISP or network is blocking the above URL,<br>
&nbsp;&nbsp;&nbsp; try with another domain name, for example by setting:<br=
>
&nbsp;&nbsp;&nbsp; CONNECTIVITY_CHECK_URIS =3D &quot;<a href=3D"https://www=
.example.com/">https://www.example.com/</a>&quot;&nbsp;&nbsp;&nbsp; You cou=
ld also set BB_NO_NETWORK =3D &quot;1&quot; to disable network<br>
&nbsp;&nbsp;&nbsp; access if all required sources are on local disk.<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/2/build=
s/4382">https://autobuilder.yoctoproject.org/valkyrie/#/builders/2/builds/4=
382</a><br>
<br>
Can you have a look at the issue?<br>
<br>
Thanks,<br>
Mathieu<br>
<br>
-- <br>
Mathieu Dubois-Briand, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com">https://bootlin.com</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB39622631465C058DE729DC36CBDC2DM6PR11MB3962namp_--

