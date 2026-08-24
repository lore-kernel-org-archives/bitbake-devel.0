Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EFAC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 11:30:05 +0000 (UTC)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14422.1787571000067750022
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 04:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=HVtbNU7f;
 spf=pass (domain: cisco.com, ip: 173.37.142.93, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5385; q=dns/txt;
  s=iport01; t=1787571000; x=1788780600;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eCQC98pI7XUP4Wr89RBc9pnhsYSnbppDdyHuuczgLnQ=;
  b=HVtbNU7fiUO+665JAaLLcmbw8kAaqMqaWo0Nko5gVAVtv79n5dA0TGzK
   X/BF/4k3alcnQ9rBpAmi+0FLkEHCi0HJ4rk9G/djiNXwIKd1EUVqXm9uD
   5cGDNMs094ohl4uUbz1RAdxASTrR54DPNdM6NPnJlxL1KMlbHJmKU70Pg
   kDc5e1NzlroxXClN5DEyMQK+8geazrpv9Ph8v2iB7rwRPVHvL928sFTgH
   yn3AusZ8ylYOnR3uaJxZ/2YjuVpHGAWRWnaR0QPge40MnOEr349vA/0TD
   4L9/RNWVArekXOu9Yb//EJMXBT2dLC5ODcAZ4lmdaKxQcA7cv5YV0omCY
   w==;
X-CSE-ConnectionGUID: 7GUZzpq6TWiTxqv2eHLZBw==
X-CSE-MsgGUID: XcV59yqeSuaU9kGYTN9wJQ==
X-IPAS-Result: =?us-ascii?q?A0BcAgAMKoxq/4oQJK1agS6BK4FuUxZyAoEhSYgjA4Urh?=
 =?us-ascii?q?liCIZ4egX4PAQEBDQIxIAQBAYUFAo1sAiY0CQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFgQ4Thk8BDIdsAX8nBBMIgnuCdAMBArcFAolLGjd4gTSBA?=
 =?us-ascii?q?eAtAQsUAYE4iF4BhXiEfCcbgg2BFUKDJ4RFhBOCMASDLoREgReNf4FKHANZL?=
 =?us-ascii?q?AFVExcLBwWBZgMqLy1uMh2BIz4XNVgbBgWBHYEohBAjGTZ8gQlegSspZRIXg?=
 =?us-ascii?q?QmCBwKCWoIFAgFJQw4HRyILbT03FBkDBIE1BY5UH4F6RgcBFV4aASsXOUEHC?=
 =?us-ascii?q?CM6Qg8spDyhewqEHowilXAXhVulEZkII6NohQ0CBAIEBQIQAQEGgWg8gVlwF?=
 =?us-ascii?q?YMiCUoZD5gHxjV5PQEBBwIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:jcpFLRYGwvv8WoT6hK/QS/H/LTAchN3EVzX9orIuj7ZIN6O78IunY
 ArU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+WXU=
IronPort-Data: A9a23:EqRxjKB59egauRVW/3Xiw5YqxClBgxIJ4kV8jS/XYbTApGh0hWBRn
 DNOCmuAOKuKa2T0ctB0Ydu+8koFupWGyoBqOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA//h2YtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEnNpTPlMuJNMkxedLEXhQr
 /E4DAIncUXW7w626OrTpuhEj8AnKozveYgYoHwllWifBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxAMmoHgBfoO3WjPn8MFokgkeGznVH0ciZTrxSeoq9fD237nFUvjeewb4CIEjCMbfVeoBvJt
 3vLxHnwP0AZG+2j72ua0Ev504cjmgu+Aur+DoaQ/P92ilSQyykfBQMbUXO/oOKlkQi5Q99ZJ
 kke9yYioKR081akJuQRRDWxpHqC+xpZUN1KHqhisUeGy7Hf5ECSAW1soiN9VeHKffQeHFQC/
 lSIhNjuQzdotdWopbi1r994cRva1fApEFI/
IronPort-HdrOrdr: A9a23:dtTIL6xGttBjdeTAs8ZOKrPxP+gkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ5OxoWJPtfZquz+8I3WB3B8buYOCGghrjEGgM1/qY/9SNIVybygc/79
 YtT0EdMqyLMbESt6+Ti2fIcadE/DDtytHPuQ6q9QYUcegcUdAY0+4WMHf9LmRGACN9Kd4SEp
 2a6sBbpzymV0g2Q62AbEUtbqzonfGOsIjpTyInKncchTWmvHeF+bT6Gx+X0lMkVS9TwbAtyG
 7BkwbozKSuufO2x3bnpiDuBpJt9+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquM
 OkmWZgA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqY16NghqA+7E
 t45RPdi3NlN2KFoM073amOa/herDv3nZPlq59Us5UQa/pGVFYbl/1hwKocKuZ/IMu90vFoLM
 BeSOfB+f1RbVSWK1rdvmVp3ZiQe05bJGbffqDH0fbliQS/WxtCvhAlLMBzpAZwyLstD5ZD/O
 jKKaJuifVHSdIXd7t0AKMbTdKwEXGle2OEDIu+GyWRKEg8AQO6l7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBDzVZ0Wn9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRsnWQe
 y6Np5aC+LqaWHuBYFK1QvjXIQ6EwhXbOQF/tIgH16eqMPCLYPn8uTdbfbIPbLoVS0pX2vua0
 FzKAQb5P8wm3xDdkWI8iQ5AUmdCnAX1agAY5Tnww==
X-Talos-CUID: 9a23:5ykc3mPBS/EKqO5DBwZaxlwMA54ZTXzh3G7OeUKYLVRDV+jA
X-Talos-MUID: 9a23:tn5PBQhhyRa6CrAMwSsviMMpBMxWvvW/EU02jJw76sqrBBBWaii/tWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2026 11:29:59 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 05453180001AD
	for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 11:29:59 +0000 (GMT)
X-CSE-ConnectionGUID: hpNafb4kQMqPY5tTp6XekA==
X-CSE-MsgGUID: 9byEg1+ySuueZYZUUGHSTg==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,240,1779148800"; 
   d="scan'208";a="84435369"
Received: from mail-westus3azon11012023.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.23])
  by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2026 11:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7ccCTA+yG+3zzXZIE0dBMEEtMxoCjnn+P9wjFgqvyOb3Mwmx6e4Xoc5cGJrqO7sfyPYZ4FnS/LSDtkcTELlFA4ga6Z+Oy9bytWC0wf7rOQfnfQhvEsQCRBnLtU0VcP2E0qJfoDbzWsIhWzb4W9GobBSxFM9NEafrZIOoRIYt67ReBF1GTIPBWfIX9CA9im4K+gusAUcZGJCWWqul8NOetBV/QHagba4s5AeSpoJXQ6/5QLY7Y+AJ06AKElxmqN45WNydKq9WmqwlNZZU1CKBx6sQydQJ1pgLtx+yzZ+MCdfPlEHz/EIEg3ZBRnqB9/tpxgAIbsHxUFY427j9tgGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCQC98pI7XUP4Wr89RBc9pnhsYSnbppDdyHuuczgLnQ=;
 b=qflJTD0g6LVEj0RTbiun9aZrdOmRLYYjQkZo04szEqmuLK3UMx/j1b5WU2rpEArNkzqXD2YyPe/O8bdZGzqU9eAvsZ2ndEeQx26p7ZaTUb1Q4uMy9MEHPnXHh17EJ5KcHVO1523VIcH2XT1Q9sMPy69HWdbRIYQ4xbzfulUi/sGuy5iDv3lX9wHY+sFLTGGfSkJWtk16un7+CIvGIaQxUgAq3qc6ZaFtvppr6MVZC+mqSeW26q3uNLZ20yU7PlC0Idk4rpgY44itULT7luT0y8LGMCzT7oUjbO2TW84RLMHQ2Tb+VFxdwlyw3ztBPKtg/reuuNu+Vvr0s2osV+G+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 11:29:57 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:29:57 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] fetch2/git: replace stale clones when using premirrors
Thread-Topic: [PATCH v2] fetch2/git: replace stale clones when using
 premirrors
Thread-Index: AQHdM7u93YDDR9xguEGYgLnSEPKwPw==
Date: Mon, 24 Aug 2026 11:29:57 +0000
Message-ID: 
 <DM6PR11MB39625BB95AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|MN2PR11MB4584:EE_
x-ms-office365-filtering-correlation-id: 7004c82e-fe20-4943-7843-08df01d306ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|56012099006|11063799006|3023799007|18002099003;
x-microsoft-antispam-message-info: 
 ZvsUE5f3Kq8joIeXN2X5Sc2eXYjCDR4+g/mFqJRXRYXNwziVRnvjuJh6FzvQof6A5o7ZS2ciDuN1+vgPQ04pc/SShYZVuVbQtoDeL3HAGKkIa+zWfeLqjYk+ZkSTpLrUBkrWcYYvh03Rktq0siDn6Q7pn6027YMZER7k7Nud/ggvyYUVODMSXsZMm0NQFfDMdGySAHg4KET/c/B0UFlhESmwvYRVW/dZACtXqkRxCqTGF3O5m1+KcqYDVV8MqJlJpdUniyWeFD1tYKmDbxgCr1eVoST81cy4QPK8W070tZN3GTL7pkwZEfY45qMywgGsek1EFiM9ZkpuvrDNswJ33eoIRoUTbOC04KRi/YGIlaICToHBKnHrzpzwPXb6VVf2XrA6SOxIf3Jb47du7xSh56BgtAOlHarHYeDirRVICzSOgZ/6xvyzTimimZs58eTdconB4JresvlAhw6KkFRpV/PQsqlSO+J2QmNkVl9GMpqIqj5/+wUs4kzC7KGK3e7fhPPiKkHe3nW/O5j79HYQEHMIWELgsE2/t0Jsol2+ODOhWaEufBFfgZ0myYZX1QwD2FSzuFPXXwqh7qC6heViZczmMQLu3KTkmQ15ozxWVOHOkA11auH8JKahJDSrkecIIzSH9oES6q+kL0L5m5Sa0CL/B0duGFj9OhX65tm0ac2P1+Gj7V4M0zpEHY8ADZ1ctAeAvTFe8jvvgxWIGGTWsxY4LAfSgJY3a1029bRd84E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?LsOmNxyFYdDbo8P2d7lJsfHQiGrVSJJnCZnAr5OwGHIgueeFWz/TsSCgSx?=
 =?iso-8859-1?Q?dFrK5AZScIQTWNeI37o1lThza5PF6kRD+MOBgbvA6NE9bPwSnWkrnFg7IA?=
 =?iso-8859-1?Q?L37Fmo21TyvYXQ9gO93y+agvQB3zL/+b/UmKVINc122/jhElWXMPs8humX?=
 =?iso-8859-1?Q?1p/KsF8+9neZBdlmYLRw58Y4eW9bNpjZtZ1Y7+v0ETOuVIf3FAJMeF3o+5?=
 =?iso-8859-1?Q?EGUHCaJdBTxa0n91nDubBCiJ6BxUAK6LSVqljJC+VX42aBaub8/o4ImuT/?=
 =?iso-8859-1?Q?rNJDFIs/nidcEvrKlhIPN9d1bouJR5yd9jSqArfbPHopvRmni8RGQQzLmY?=
 =?iso-8859-1?Q?SkekLHTWi9Z/lj9TTdN8vSfQzgqZkxZdWA/jGmSjEjnwiLRiZvatfl9FEK?=
 =?iso-8859-1?Q?nkTrb98hJa50IBFydfNO8ioB0RIKCcJdChPcKIJk51r+Cjf6SZGRnIbwYd?=
 =?iso-8859-1?Q?OKph+o/MQBL4XbL3LQkVydaijo7i3kBOX4mEbHweUmgu2fvgzOULkhKtIk?=
 =?iso-8859-1?Q?O2UcVi6mP5WihhiVODtkuCA3cdt4/XllJSqSXh5CVyYIFnXRCp+62KuAEv?=
 =?iso-8859-1?Q?R5UpoHbVD0k+j1b9jB/t68Ve62icgb7FP1T+gbLrqYPg5SFWwQLrtAfrqt?=
 =?iso-8859-1?Q?sTmmgJ/es5brLqotSuQ9KTqzrRV7d+hzKImXlrDUOaXcKNc3/Tf2R+m8Zu?=
 =?iso-8859-1?Q?dXTOiXpw+kHYxZZ3STcXEGMBf5xEL1A4Qd7uDDhoymfpCgQPmgbtaun4MF?=
 =?iso-8859-1?Q?+/RRSinM7xUJ1WtgAjlZKO4uVCtOu0TFPhpqf+wt/SpPBocDAP4pYdexQj?=
 =?iso-8859-1?Q?rfDt5oGf7NKnrc1vy8dPTvJ69xnSHFj8oiHKEM9hOtdoIzYau9TbZR/M/A?=
 =?iso-8859-1?Q?/BmVY/Bx20YM//YLs6JqjDFzkqGBC8e30mIQGIIRdq6ZQBJER6vsazEaSP?=
 =?iso-8859-1?Q?HsnoCrfMQtAa+Ym/A0AvcJMrOrGKDUQh/HZqS3eHv38gtK1VRFVoJ6wKpy?=
 =?iso-8859-1?Q?1Qv3k5HJId9urHwW1ZCIHj+05z7M/qouHKEf8qy52x9vW+g4enhmmgzOY1?=
 =?iso-8859-1?Q?dOT0ZpiKGKqQQaYqhS1TVAri11VTpwJez6K8kHqOzbAOrU+XmmO4d5XLHz?=
 =?iso-8859-1?Q?Ev2Nwizay/48unpcznMXBodzGqkmMqqD5O5xI0byjWLKgopbuxhXLiL7mC?=
 =?iso-8859-1?Q?Ti7+ROKz8iRsxaiDjfZfD6HvOpEyeln07oa6wL4S+qba4QbPJtfNgdxr6G?=
 =?iso-8859-1?Q?Ni9Ir2eh6P1BsZddnjGBs/IrnHUmUns4w5nQDFw8JJc6YIn+FMow5AB+aU?=
 =?iso-8859-1?Q?oIpUuW96SC7vh5il28OAQuifwHfEAlCDrnn9v85+j3A/2NRPIQ4isWMqCD?=
 =?iso-8859-1?Q?aP27exeEmHpspyVsNOBhj52TiswzlCRz3uUCFUMA2HGT4z17TuHP4ng0dR?=
 =?iso-8859-1?Q?2maubufuP2q5NdJSaDvx99vidvuaRoh8zUZHOuAXJrHKHmLw16ZrBVLGP6?=
 =?iso-8859-1?Q?OrPdOS0ZSY9P7VmWTI5dlsQalB3bV2b9KZhnC1naimwFIUt6JqI7x2edHD?=
 =?iso-8859-1?Q?ULFYVgg3uerLhQzcJ1dhSpRbLAbhbE6D9YMgEk1xtcPqK6JTuRoSINpwbi?=
 =?iso-8859-1?Q?W28C/3bsZsrx6IHA4QMbrC7rrVMN7nTZQioUpTQOpPsikma07XW0skNNc3?=
 =?iso-8859-1?Q?Ub5Q9aSoEL5UWXXfTEs7/R8Au0jVHVcWksYuD/SfDlab1CZEB79uDpiqpH?=
 =?iso-8859-1?Q?2of08bThgop8S9+xMMl122ElRoV0+zERomXwTgb/SI22PC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	g4o9F6i/SEnAW+BX/Ho8O3a2v7Qgt5K0OZ2BdYCaNRxDusxK5S0jMAKZF4yg56vUMU6PBEF4sjoioQsq6Zn2woDpPzXs7HU1bjQPzzd/HnsnvoJ8EZd3D/NsPkx1h/6KRRdVV+7rQ+O6l4ms3ijdNMZyHvNa5b/EFLutQ2aAOg/VmnXiUxT1YJ9n6Zyrg7ngCeFxco/PwsgVIRfG2FXyiVxyIdYOdT5PzF7WBNJXd7VAkoBn1AIquVsVVSCcKb2bcEQF8pLd/RTlWdt1tBtiA8T/oMrNEgekHz4QXUnDKDeO9hAnM/WdS0vZyJvoC6wUuvtWi2V8/C393HcOWi55Yw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7004c82e-fe20-4943-7843-08df01d306ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 11:29:57.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NF6a0QM5jCsGSrBSOfj8EIhN7t+5UO5QG/OgVRxD6V+fOML+BsE7vwznY5sCOLh0aNiB+RZ/gotOC9jPcGgQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-4.cisco.com [173.37.147.252];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 11:30:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20025

A successful premirror fetch can leave an existing clone at the original=0A=
download path even when it lacks SRCREV. The fetch is then stamped=0A=
complete before unpack rejects the stale clone.=0A=
=0A=
Pass the datastore to update_mirror_links() and remove the original=0A=
clone only when the Git validity check says it needs updating, allowing=0A=
the successful mirror to be linked.=0A=
=0A=
The new self-test creates a stale clone at the original download path=0A=
and a local premirror containing a newer SRCREV. Without the fix it=0A=
reproduces the UnpackError; with the fix it verifies that the mirror is=0A=
linked and the requested revision is unpacked.=0A=
=0A=
Tested with bitbake-selftest on Python 3.11, 3.12, 3.13, and 3.14.=0A=
=0A=
AI-Generated: OpenAI Codex=0A=
Signed-off-by: Fredrik Svensson <fredriks@meraki.com>=0A=
---=0A=
 lib/bb/fetch2/__init__.py |  4 ++--=0A=
 lib/bb/fetch2/git.py      |  8 ++++++--=0A=
 lib/bb/tests/fetch.py     | 42 +++++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 50 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py=0A=
index 9cb268be..68a0225f 100644=0A=
--- a/lib/bb/fetch2/__init__.py=0A=
+++ b/lib/bb/fetch2/__init__.py=0A=
@@ -1150,7 +1150,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):=0A=
         # This may also be a link to a shallow archive=0A=
         # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
         # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
-        origud.method.update_mirror_links(ud, origud)=0A=
+        origud.method.update_mirror_links(ud, origud, ld)=0A=
         update_stamp(origud, ld)=0A=
         return ud.localpath=0A=
 =0A=
@@ -1692,7 +1692,7 @@ class FetchMethod(object):=0A=
             except FileExistsError:=0A=
                 pass=0A=
 =0A=
-    def update_mirror_links(self, ud, origud):=0A=
+    def update_mirror_links(self, ud, origud, d):=0A=
         # For local file:// results, create a symlink to them=0A=
         # This may also be a link to a shallow archive=0A=
         self.ensure_symlink(ud.localpath, origud.localpath)=0A=
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py=0A=
index 0bb2ea39..a1f9cb33 100644=0A=
--- a/lib/bb/fetch2/git.py=0A=
+++ b/lib/bb/fetch2/git.py=0A=
@@ -353,8 +353,12 @@ class Git(FetchMethod):=0A=
     def tarball_need_update(self, ud):=0A=
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)=0A=
 =0A=
-    def update_mirror_links(self, ud, origud):=0A=
-        super().update_mirror_links(ud, origud)=0A=
+    def update_mirror_links(self, ud, origud, d):=0A=
+        # Replace a stale clone which would prevent linking the successful=
 mirror.=0A=
+        if self.clonedir_need_update(origud, d) and os.path.exists(origud.=
localpath) \=0A=
+                and not os.path.samefile(ud.localpath, origud.localpath):=
=0A=
+            bb.utils.remove(origud.localpath, recurse=3DTrue)=0A=
+        super().update_mirror_links(ud, origud, d)=0A=
         # When using shallow mode, add a symlink to the original fullshall=
ow=0A=
         # path to ensure a valid symlink even in the `PREMIRRORS` case=0A=
         if origud.shallow and not os.path.exists(origud.fullshallow):=0A=
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py=0A=
index a1e4b45f..65483570 100644=0A=
--- a/lib/bb/tests/fetch.py=0A=
+++ b/lib/bb/tests/fetch.py=0A=
@@ -616,6 +616,48 @@ class GitDownloadDirectoryNamingTest(FetcherTest):=0A=
         self.assertIn(self.recipe_dir, dir)=0A=
 =0A=
 =0A=
+class GitPremirrorStaleCloneTest(FetcherTest):=0A=
+=0A=
+    def test_premirror_replaces_stale_clone(self):=0A=
+        source =3D os.path.join(self.tempdir, "source")=0A=
+        os.mkdir(source)=0A=
+        self.git_init(cwd=3Dsource)=0A=
+=0A=
+        testfile =3D os.path.join(source, "testfile")=0A=
+        with open(testfile, "w") as f:=0A=
+            f.write("first\n")=0A=
+        self.git(["add", "testfile"], cwd=3Dsource)=0A=
+        self.git(["commit", "-m", "first commit"], cwd=3Dsource)=0A=
+=0A=
+        recipe_url =3D "git://upstream.invalid/project.git;branch=3Dmaster=
;protocol=3Dhttps"=0A=
+        self.d.setVar("SRCREV", self.git(["rev-parse", "HEAD"], cwd=3Dsour=
ce).strip())=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        ud =3D fetcher.ud[recipe_url]=0A=
+        ud.setup_localpath(self.d)=0A=
+        os.makedirs(os.path.dirname(ud.clonedir), exist_ok=3DTrue)=0A=
+        self.git(["clone", "--bare", "--mirror", source, ud.clonedir], cwd=
=3Dself.tempdir)=0A=
+=0A=
+        with open(testfile, "a") as f:=0A=
+            f.write("second\n")=0A=
+        self.git(["commit", "-am", "second commit"], cwd=3Dsource)=0A=
+        revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).strip()=
=0A=
+=0A=
+        self.d.setVar("SRCREV", revision)=0A=
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")=0A=
+        self.d.setVar("BB_NO_NETWORK", "1")=0A=
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=3Dfile" % (recip=
e_url, source))=0A=
+=0A=
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)=0A=
+        ud =3D fetcher.ud[recipe_url]=0A=
+        fetcher.download()=0A=
+        fetcher.unpack(self.unpackdir)=0A=
+=0A=
+        self.assertTrue(os.path.islink(ud.clonedir))=0A=
+        unpack_revision =3D self.git(["rev-parse", "HEAD"],=0A=
+                                   cwd=3Dos.path.join(self.unpackdir, "git=
")).strip()=0A=
+        self.assertEqual(revision, unpack_revision)=0A=
+=0A=
+=0A=
 class TarballNamingTest(FetcherTest):=0A=
     def setUp(self):=0A=
         super(TarballNamingTest, self).setUp()=0A=
-- =0A=
2.55.0=0A=

