Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C6C982D6
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 14:06:03 +0000 (UTC)
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40364.1789653954801652066
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 07:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=Lfini+48;
 spf=pass (domain: cisco.com, ip: 173.37.86.80, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=880; q=dns/txt;
  s=iport01; t=1789653954; x=1790863554;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pAGBdDLqItjbRnhpivlN7aW6gIdSMujLKEnF+CpHg7o=;
  b=Lfini+48j9f1M/cgtebnOZATuuPfWT2Jb6sysgWAEnzK01OzPyK7ea5S
   yMTZy2vWOxfaUttfiG2VWulAZOuPYhG7RnN65Oq0BqVSL3G4fV4firM5R
   PuTgdbJFnseOSSdZyB/Atyymk2fDpfjsO7jkffJ0Fd7F3rzy6W+bA813n
   tarPTrISp0DEDeADRXrEwaJaL8UjsH4dNHihrYNEffgmb+1BJ5WqPafqn
   WK/YbrM3AYrrQg+R30Z0AG2vZOb7lYWBBw941FP8zVtWHzMrdH6mGAseT
   QpaaY+1SIhgc/+nL7nx0eT3it4KUqZGBp3LZH0Xu9BRAWFmO/0FppumLB
   w==;
X-CSE-ConnectionGUID: 7GmfmnmCSlWjTnexQ5cakA==
X-CSE-MsgGUID: 9CXuF0ubSxe5nlni4qgj8w==
X-IPAS-Result: =?us-ascii?q?A0A6AAAD86tq/5H/Ja1aHQEBAQEJARIBBQUBZYEXCAELA?=
 =?us-ascii?q?YFtU4EJgSWIbAOETF+GWIIhnh6Bfg8BAQENAlEEAQGFBQKOBwImNAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXJATAgEDbB0CAQhGMSUCB?=
 =?us-ascii?q?AEahW8DAQK3bgKJSxs3eIE0gQHgPBWBOAGIXQGFeIR8JxuCDYFXgjE4PoRDA?=
 =?us-ascii?q?oQTgjAEgiKBDJQ6UngcA1ksAVUTFwsHBYEjEDMDKi8tIw88BS0dcAwnEg8dF?=
 =?us-ascii?q?xEeWBsGBRIgKkFDIwM+gV4/Ixk2eoEJXoErKWECDhdGLhWCCAKCVIF/AgFJQ?=
 =?us-ascii?q?w4HRVMJJ0EDBxJJKSIIEgkBExoyC0ptPTcGDxkDBIE1BZFMLWIdMRFdJaZio?=
 =?us-ascii?q?XsKhB6VA40PF4QEpmmZCCOCNqETH4UNAgQCBAUCEAEBBoFoPIFZcBWDI1IZD?=
 =?us-ascii?q?949gTYCBwIHDgMLk2YBAQ?=
IronPort-PHdr: A9a23:qC2lqB8mMEbsaP9uWBDoyV9kXcBvk6//MghQ7YIolPcXNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:W8FWUa5/BuM/8azhrx+i+AxRtGfGchMFZxGqfqrLsTDasY5as4F+v
 mAaWWvSa67cZzTwKNx/YISy9EpU6pWEzdExSQJkpXxgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqajNNt/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eYqId9ONxBEp18
 cMaFDYAfinejOu16efuIgVsrpxLwMjDJogTvDRkiDreF/tjGcCFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkESUrsUIMpWcOOAnWfkbTBes0m9rqss6G+Vxwt0uFToGIePIY3RH5oOwS50o
 EqX1FTkLEkHPuePxGeD9nSt2vbAn3PkDdd6+LqQs6QCbEeo7mYSFBcfVlb+rfSnh0qWX9NEN
 1dS/TIjq6U3/kGnQtTxGRqirxa5UgU0QdFcFag+rQqK0KeRu1bfDWkfRTkHY9sj3CMreQEXO
 payt4qBLRRksaaeTjSW8bL8kN94EXF9wbMqDcPccTY43g==
IronPort-HdrOrdr: A9a23:xl8/Jqu/P77PphsMgCeVcmHF7skCeYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwR5VoIUmxyXcH2/huAV7EZniohILIFvAv0WKM+UyaJ8STzJ846U
 4kSdkDNDSSNyk1sS+Z2njDLz9I+rDum87Y55a6854ud3AWV0gK1XYeNu/vKDwPeOAwP+tBKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg9n8PMP4G
 LFmwv26uGZte2nyhjT7mnX755HstrswNlOCaW3+4kowzPX5TqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1iQGF4Xii7B8er1vZjXOIi3rqpsL0ABggDdBauI5fehzFr2I9odBH1r
 5R1W7xjesUMfqAplW52zH7bWAsqqOGmwtlrQfVtQ0HbWIqUs4UkWXYxjIMLH5PJlOg1GltKp
 geMCiV3ocnTbrdVQGYgkBfhPqxQ380AhCKBmIGusCTznxquUoR9TpD+CTa9U1wqK7UjPJ/lr
 n52qgErsA8cuYGKa16H+sPWs2xFyjERg/NKnubJRD9GLgAIG+lke+93FwZ3pDiRHUz9up7pL
 3RFFdD8WIicUPnDsODmJVN7xDWWW24GTDg0NtX6ZR1sqD1AOODC1zPdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXYJExRf3VZVeIWQXFMcVptE4UVSTpd+jEPyhisXLNPLIYLb9GzctXW3yRn
 MFQTjoPc1FqlumX3fp6SKhLU8FunaPiq6YPJKqi9T7krJ9RLGkmjJl/GiE2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AqBxVmGmpDW+5EQbutnjdKSiXVv7XOSLyyXnVJUq?=
 =?us-ascii?q?TMmJWSoGTRE+ppahtkOM7zg=3D=3D?=
X-Talos-MUID: 9a23:p0DyDwmW/SdhW5+PQxVmdnozH/d1zfyzAnsdnMgAv8+FaTV/OWeC2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Sep 2026 14:05:54 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id D8EBD180001C8
	for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 14:05:53 +0000 (GMT)
X-CSE-ConnectionGUID: +NfdIRbORf2Gzbdb4XKlsQ==
X-CSE-MsgGUID: 3XcPuCb9Q2mcY8GBCHwsyw==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="70354189"
Received: from mail-centralusazon11010019.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.19])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Sep 2026 14:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2tK13yjU1n02Bwli8FiuktWq7REeN703MOZFjxKbIARRG3ck+jQLWRZ0fjwdUR7KsqyrDxBG9hIS7zx9Y308D0aXYpKCUM9MnTdAz4UdiuFc7Iw8+qZneF4KF4Rt85SKwv743sdPMuj8/Q0RCemStbTgw1+o/AOGLcYYkkGVTNNvjGsmv1i8mKeJlnzhLo7eyV9muy9Al1haUiQYKahS7Unoo01FJrmyDueeV8r2KoXgbrk6Njc04yuPSX+JEicsC/E+Z5EYu/seT3nUfIY0004RdqVdaQzCZOM8Mmmj4cTUUcF9TZLUFoLtLgGOL3k+po66fSzHGqmEEmPSvdf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAGBdDLqItjbRnhpivlN7aW6gIdSMujLKEnF+CpHg7o=;
 b=YooidJ7/qSKBhxykdSK7Qs4nH7mog7dAlnXsL+OlqO9GV5lQ+BOx0vmYLAerYLW4GWT6ywcj3JQNcbalap40HSOM2mqLqz7Vh7l4OGwxijXtO+ilqxsbWjAtVpxaEthUEeq82eedKykYHJ+T7Ygz6OqOaYTde/jIPTy6+GSJjs/p+rWp+NErj90Xi6sMkQJWTc4mBYT0eeEfbIyIsDr5/CEL3OIeFp/GpHYRGnAGTRtP2ml1LhPsPreUpr7K7S8MTWUT1ZZaYuPeIwpGsJZczftMGlyltjWD5nG8W09UaaieREtYGXhWUJUGk1FUaskwSLNQiW9zeIVYzHldRd46rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 14:05:50 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 14:05:49 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3] fetch/git: unpack from premirror when cached clone is
 stale
Thread-Topic: [PATCH v3] fetch/git: unpack from premirror when cached clone is
 stale
Thread-Index: AQHdRDXrwr9uhxYuSEeZA19OEZk54bbStCiAgAAeKWI=
Date: Thu, 17 Sep 2026 14:05:49 +0000
Message-ID: 
 <DM6PR11MB3962C3B7731F3653247433CFCBB82@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB39620862AF1ED3401C93F429CBBB2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <83ebfdbf46526c150dcda4d027a5217800113c36.camel@linuxfoundation.org>
In-Reply-To: 
 <83ebfdbf46526c150dcda4d027a5217800113c36.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: f7480d15-8c55-4f60-e871-08df14c4c72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 jbUlcFX63qopgTMIm1KpK9JClMvrRacuh1JEqOAYCfWgfGeSKWYfhbxMHmZ/wRN8doevMbGhFfUkpwZyccFhUfcQRKan6DkikrzF5lmM7IGdmSNpSb2W4UYtUOpaOAA27YQkAto9lO6vTQFSPPvvGSnU0Ke1vLGROQzoERg1f6TryzoGs7GVcAFBylm8WVcBP4ukZNkJtoopqua1f39v/Wb/0t3KJK5pVBmvhcf+v5BHOETqLvDasY5w3e2LEDW6ZmRSJbkPxzGG6mVSIdifSWq1aspNWhzrU2OR86p63zdS/lcpT3xAZxQkp83QjuLTZ7lJZEF+WwrhLGMDKUOwlzZIxBcF1aeLsbhtYQ6g3TukDcMIhsHdXUuwN1RpHHLk0buHlK0ZrUe+KlqwYEGHvfw+FsZUBHcDlN0bhAV0EzthN3l0vKegltwWWQwLZKDSAkBfdCk+xPqy1CPLXV5DXqzczc/A1uk4g3VZfaRGpkh8c4UQgYSqZ36ym7vMpxOBNKZEwMhJvIILNBDQfAr5SIhhe1YfzuyKCE/dNaGso23CHy+vnaFl4delg5VzyXBddIQyZ1Rup02JeWG/WQioAv3x3gD6rP5glSsa2fsfmAx0v+ntnG5cZd3X8uIFQ4Db5tPatQqyHzRUTmtEgGD1kGCqofoLLZG2RFR2nrR33yNJUtlmNTix1uywMrZi9WzppF2gpvwKbVYhxh0VxhEW8CwxkxjFRhOW+70z+HjCOIg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?lUmtpNOXZTiDzoWOyKZNoqqYC4+d0w0NwjNw/qBCa8vvnbH9RKtfcO+PhL?=
 =?iso-8859-1?Q?NaiR6rJGzAGLQtNmwrDpQ7Ohq7U2uS6i3mMwVaBFkXliCP6Ksc7nCEoTzO?=
 =?iso-8859-1?Q?cbkeuV4Xc06l0SdMm0YGepHMIH29lZw2KCauPplUrhr7d3nKD6uRbpKJWG?=
 =?iso-8859-1?Q?LiSnpCrVQFe4lUv4snLO7my0KJDgADEMLf8/GZN+csrCYaWBRGk2rGZQQM?=
 =?iso-8859-1?Q?dskJBRap2j1kcXbxAqUI0D3jdD8OFlz3I6AMUvTNJhwR68aE/Lo8lA7j0V?=
 =?iso-8859-1?Q?3mI/cpwchY6d1VYF9rMnWURk3rqbLTyt35HrMVfcolOQn3Y/1uyvayo5G4?=
 =?iso-8859-1?Q?INUTVpNkv5FyHO1KnZytuPXPpJdDAVTKffI+z1c84Vj3xCk7zJZL1+rLdq?=
 =?iso-8859-1?Q?fR3lVdy33mA7JqxBgZGXnLhnoOTyBBxcaiZUexHanRMasQmQqekhVk53io?=
 =?iso-8859-1?Q?6MVbWaG7SL2c1yRX4X7PxTHI57Cvk3cl/8SbPqKA/5l25CmO4Vypl+ZSaz?=
 =?iso-8859-1?Q?tLoQy7gzDjxI9CK+n9IaS3B7zioAOoeArCA9kCNC/TYjPBfM28tOm1vq+A?=
 =?iso-8859-1?Q?K7VE2K2xnVxA2B+xZAEEa8jjt2XovXIjOuD4hrftBOmmHgKKoe+UQbhfsP?=
 =?iso-8859-1?Q?lpq43VaFVkZl93fnYcIJrv5BSejZrTCedN5edHv2Fq4ll8ASF8tXceo6T3?=
 =?iso-8859-1?Q?Edg/MfhR+oGw0RzHm+3SEAorogOAPkW2wopurca/PsGvHQkWkvTwDCnFaF?=
 =?iso-8859-1?Q?r49b8B/rrPf5bIKu5k0WQZGFVxyLuTkA8wqLBW2PmtYDV65d1/8+vucw05?=
 =?iso-8859-1?Q?GKBOyfTfx/CUNrsxHKr58821QCwUj22/p+WLAP3W45/fBGIDpotQYFsi/A?=
 =?iso-8859-1?Q?sR7krK89HAgz4HpR3s4+CDXbKeh/tZybWrF/pESgoExD+UxcI3FjB0vpfg?=
 =?iso-8859-1?Q?bl6BgSlJTxTjj6TuEtFfVappgHejtNqSE+lra8MAMHBH6HOZBPXDcZLzrH?=
 =?iso-8859-1?Q?EoS4PNvgMXhCJa2So23dGs3BEPzSFqQWgtwgmlzaxX6R2XsxfdX8XD7UiN?=
 =?iso-8859-1?Q?9cJvhO2im15xgj3wc2/G1LP9Qj5kl6/UITwdGr25VZPABETizegHH35Gua?=
 =?iso-8859-1?Q?TfVM783Fh9ZsYccutUy7h06WuPou2IlOODnRSfyAXNBV0vbpEgqK+CKxHN?=
 =?iso-8859-1?Q?rsKVZayeSzTlx0uQgJtMVDyq4fTA18BLQE3XWe9oyyUjlVdp4BZD3FK5HJ?=
 =?iso-8859-1?Q?Yk7UnirZ9Ayym4M0mfOPr2VsalUMjxy1AYj9dwI3nPTeFPEICBSZEvCq1v?=
 =?iso-8859-1?Q?8H2W2zyFpXc/qVNuAPpQVs3yo83QQxaN7SIQteOBsO7RTQbDf5Tjab6o6t?=
 =?iso-8859-1?Q?8kUN/V3iw7M//MbfC97pjRfv3nz4rICmOfZemIk5EC/qC33rDrUH2gG1NV?=
 =?iso-8859-1?Q?9+nSCNvy6dDYgfWGSCB2t0ZjUBaO21UqqRhQOKIpARCmWMXmiJrBN1txFP?=
 =?iso-8859-1?Q?mnHJvXEuLFQ3lFpLfZcNHbcwKRyXCABUqadALFvSGCQQ2AlHNTk9kqKg2E?=
 =?iso-8859-1?Q?4vscqL/vh2+hy3u5qXPjzha4xF0BxF/TJzhmvv71LVnH5q5vO2EcBFrRS3?=
 =?iso-8859-1?Q?dSLqIDDqWMThEMR1SXox79xYwH7MiCNBrDOvzwfn3AYoWmOhgtiqtvE1eP?=
 =?iso-8859-1?Q?Z+X3kb3WhT0L8YrWGzocG8/KsyTj/EpFlIPixFRIkgIRNkWxAsm7Y8Me5B?=
 =?iso-8859-1?Q?gyGknoeoMDAXpaV6ZESPk3WngrMHaWEgd0UrvnTOsotzKJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fIN8sp4AYai95RmADpw72hmrex33J/Ra6EzP8sF2th4ZTxiKm3rcJf7XxA32ZZrHJFltKfSw4IdHW00I69rl0LnDvLsbbdx2jXdhFE/X3b5NJUaXMm31l3r99ZGwuJ5Zoa53O06O2HWjJnI0JMOhMU4k8nvVEYzNsrVELHWI7Jcd/xoGdju+e2ye06g23Cghe7iCLpwWs3spshqxN/CkwoxjAS4wLstfLBsAkpx2fC9rPFtS1uwA/ddhtt/RCAKNtJHJs7ofDDDmm/NPbujrKTUUG6fF1PTsuYm70fqCouHKpd9GMRJii9shc3IHoggCnwNRm5Log1fc6OzrOxpOMQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7480d15-8c55-4f60-e871-08df14c4c72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 14:05:49.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DB/GCMdNN4eJVq1QEHIDNuZ3Hde9IaIYurppNWuaYYZ/rXLgq4FyGegLaxUfyaeMlYvVlehZ4PPLQqfYcx+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-1.cisco.com [72.163.7.162];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 14:06:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20220

Thanks for reviewing Richard,=0A=
I agree that reporting an error would be safe, but it would still leave=0A=
the build broken until someone manually cleans the worker's download cache.=
=0A=
This is not great for automated CI builds.=0A=
=0A=
I would like to investigate the other option you mentioned: after a premirr=
or=0A=
fetch succeeds, update the existing clone by fetching from the premirror cl=
one=0A=
while the existing download lock is held. That would preserve localpath,=0A=
without deleting or renaming either clone, and normal unpacking could then=
=0A=
continue.=0A=
=0A=
I would add a test which verifies that the existing clone gains the request=
ed=0A=
commit, unpack succeeds, and the premirror clone remains unchanged.=0A=
=0A=
Does that sound like the right direction before I submit a new patch?=0A=
=0A=
Kind regards,=0A=
Fredrik=

