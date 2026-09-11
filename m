Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD209C88E4A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:59:57 +0000 (UTC)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36786.1789124390684556137
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 03:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=C+1LKhjf;
 spf=pass (domain: cisco.com, ip: 173.37.142.90, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11412; q=dns/txt;
  s=iport01; t=1789124390; x=1790333990;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=LwrhlkzvM3Xp5Ormo3Bth1qUGXA9Dwg643Y3bIvY7VA=;
  b=C+1LKhjfYZW1IEtOG+kyphYTwvMP+rkmJpiJC5MHR15LiTiNMAi1Au7P
   DcmJxIYhdCBmmlu0NYU5w/xrpe3lLAhtu3fxjnzm0TSdii1zvR2u3xgfQ
   Ms3+1lNai7U4SbQccom/C03clZaUc1RI2w/oH+sXSJZU/lkx06CLcwd1d
   Rj+AVXU+nUk4d8k6i9e8Z5R2dSunOP3L2+91+IEkFXpmsdp4lZksjIAji
   WgECBGkdZO1OPhVGFyQNPbitxXq4dZDj3G6pduOWEX2MeGjf4+bzhOfoa
   rKXjcCxfholSMjVu3vvxdUV6WOM19ljNrUrogBrE3j58zFnoGtJ/HJjKv
   Q==;
X-CSE-ConnectionGUID: fyPYjWrKQoKt1lzE5JGX2Q==
X-CSE-MsgGUID: rUDjxaFiSjCmHXOt1FxjzQ==
X-IPAS-Result: =?us-ascii?q?A0CXAwAp3qNq/5AQJK1aHgE8DAILOoErgT0BMFOBCAKBE?=
 =?us-ascii?q?RJJBIgfA4UrhliCIQOeG4F0Cg8BAQENAi4BBR0EAQGFBQKOBQImNAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGTw2QEgEBAQEDAYEIAgEIE?=
 =?us-ascii?q?QQBAQEuJwodCAIEARIIgnkCgh0WQQMBAg64KAKJSxo3eIE0gQHgOxWBOIU/g?=
 =?us-ascii?q?x4BASqBNYJdgSMZG4RhJxuCDYFXgjE4PoJhBAEXgUiEE4IwBIINFXoSG4IxG?=
 =?us-ascii?q?nGBF4IthT+HLlJyIgMmMywBVRMXCwcFgSMQMwMgCi8tAhQNIg8aBS0dcAwnE?=
 =?us-ascii?q?g8dFxEeWBsGBRIgKkFDIwMTK4IjPyMZNnqBCV6BKylhAhAXRi4VgggCglSBI?=
 =?us-ascii?q?14CAUlDDgdFUwknQQMHEkwpIggFC209NwYPGQMEgTUFjhgHWh+Be2E+DTo2B?=
 =?us-ascii?q?BwwMBgIOgQHGAEVHwkrknuPWY5glRcKhB6MIoc9hgGIMheEBIFXiz2ZVZkII?=
 =?us-ascii?q?4I2izGWAYUNAgQCBAUCEAEBBoFoPA2BTHAVgyIJShkPjmCIV8cGeQIBAQEGM?=
 =?us-ascii?q?gEBBwIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:Os0gWhKNL3D57sIyIdmcuVQyDhhOgF28FgcR7pxijKpBbeH5uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:eBDyM66KKQvfL5pwdAs+GQxRtGTGchMFZxGqfqrLsTDasY5as4F+v
 jAcX2zSOq7cN2D1eoolOoTjpkgPscPRzIUxSQc4rCBkZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqajNNsvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eM5wgy+RIG0J38
 t8EcTQfQ02hqNLs+efuIgVsrpxLwMjDNYcbvDRkiDreF/tjGc+FSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0En1lQ/UPrSmM+zmGLhfjtDs3qepLE85C7YywkZPL3FYIeIKoLbFJ0P9qqej
 nj702bpCz8bD960zBq11W71qP/NjxquDer+E5X9rJaGmma7zG0PAhQVWB63rOe0jma6WslDM
 AoT4icooK04+UCnQ9W7WAe3yENopTYVX95WVul/4waXx++MvECSB3MPSXhKb9lOWNIKeAHGH
 2ShxrvBLTduq7aSD3ma89+pQfmaYED58Udqifc4cDY4
IronPort-HdrOrdr: A9a23:V4orCKGt/01LqjJLpLqF4ZLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhJ03I+ertBEDyewKjyXcV2/hcAV7MZnichILFFvAH0WKm+UydJ8SczJ8T6U
 4DSdkFNDSYNzET5qiKgnjcLz9j+qj7zEnCv5a5854Zd3ATV0gW1XYBNu/0KDwQeCB2QbACON
 634M1BqzC8eXIRQPiaKxA+NdTrlpngrr6jRQQJKSIGxWC14A+A2frXAhKY1hARX3d1x6s+8W
 /Kqgr95q+ymfC2wB3R2gbontprcd3apedrNYipsIw4Oz/sggGnaMBKQLuZpg04p+mp9RIDjM
 TMiw1IBbUy11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFst6g55DeBex0TtigDg86t
 MI44uqjesSMfryplW72zEObWAtqqOAmwtmrQfUtQ0HbWJRUs4IkWVVxjIlLH5JJlOL1GlgKp
 guMOjsoNBLbFidc3fV+kNrwNCqQzAPOy3ueDlYhiRQuAImwUyQCCAjtZYidntszuNPd7BUo+
 vDKahmj7dIU4sfar98Hv4IRY+tBnXKWg+kChPYHb3LLtBPB5v2ke++3JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTcmDxodC/BzBSHi0GW2F8LAS27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH/
 K+IohfDfPvJXbnXYxJwwr9UZ9PLmR2arxehv8rH1aV5s7bIIzjseLWNP7VObr2CD4hHnjyB3
 MSNQKDUvmoLnrbLUMQrCKhL08FIHaPj66YOJKqitQu9A==
X-Talos-CUID: =?us-ascii?q?9a23=3AGfV9/GqF+pDKf6+1QxVsYsTmUc40Skzf823zGki?=
 =?us-ascii?q?bFT9tWpDIa3Cgopoxxg=3D=3D?=
X-Talos-MUID: 9a23:mp7KoQaFeIh75uBTrQLAhiFrGsZT4Y+rKHAqjcwoq8uWDHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2026 10:59:49 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-07.cisco.com (Postfix) with ESMTPS id 9D1951800034F
	for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 10:59:49 +0000 (GMT)
X-CSE-ConnectionGUID: 6Lb0Fk2fSGGhK5eqCdNkxA==
X-CSE-MsgGUID: j+VdaweoTDy8fyf6GNSUsg==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208,217";a="61207143"
Received: from mail-westus3azon11012021.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.21])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2026 10:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc/3l/lRkl+CeWAwqxpuV8YpdG1d5kk5kmKDgDII/iiyyBf5i00oNPfedTwyIY/85UyUZL2eD36+oQNY945+XfEoPsjrdUZ87bjIuHUcywfqeCQV8WGqLdfOiKZ1vtiWi1pne43pfGaxr9jj29dAUFvjmZkkXyGs7KdrKOLxme9Gbo51DoUXUxgotJz/dne7nARs8ruMb4Xip5YARwWPoFslUu0HY8CNe3QiQkvJSqrQiQLx28JnAxmFPjsdIOFL5hG8Iw1ouMu+Aj/MVtkvtdaLgpH2dNE3W7BB7gWKFkVEtLYhggoD47w63soPFM8+pio2MRU3zAWjxt5vMynMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwrhlkzvM3Xp5Ormo3Bth1qUGXA9Dwg643Y3bIvY7VA=;
 b=BtcZ3oPkmi1O1M69FCpZqClOvYh7n4zWMDkWPnPLJs6qOfjsaaFvSz4IkeXBgTqCjTu6XrEFIRWO9X2Qb0SzEnJSJYgPrWnkNaXTHDDFQ4wu6uSafZYuLEyjnh3MvWOrpAFA2r6RZxFZrqG9KKVYGbwyvscbnRHERXQb8C26qNbCUuPbH6AOcOp4uigjZXTDqnE1JmQnZhBy69Ukgiqh+o04qJNmpqxdCJyXJrJVvUM2RA6efGfLcgBM3lgKSSMb/Hu3YR00c0KvnizqLzpbnWCvCSA9ytuBx7mPY775cmt6lYMelD8KLvCu+FcYxLHNaWc7jEp4zE9zuA5SFirjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by CH3PR11MB8547.namprd11.prod.outlook.com (2603:10b6:610:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 10:59:47 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:59:46 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones when
 using premirrors
Thread-Topic: [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones when
 using premirrors
Thread-Index: AQHdM7u93YDDR9xguEGYgLnSEPKwP7bHcs6LgAC2roCAASgdzg==
Date: Fri, 11 Sep 2026 10:59:46 +0000
Message-ID: 
 <DM6PR11MB39626A2819D0DF214D37C454CBBE2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: <18CEBA5A9DB58325.510612@lists.openembedded.org>
	 <DM6PR11MB39626186CF03268680D049DDCBBF2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <93ae42005a26c1b0aa1525875394585bbc65b265.camel@linuxfoundation.org>
In-Reply-To: 
 <93ae42005a26c1b0aa1525875394585bbc65b265.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|CH3PR11MB8547:EE_
x-ms-office365-filtering-correlation-id: dc876b0e-3486-4390-506c-08df0ff3cb09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|8096899003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 g7hS4+It2eOuBlCx6qTH0IrsjveR9n+hdWwnB4huOVzHSzplBdm+BHFWNZROBsJngSkUTvYRUk7bM/sx0X9nnF1u2JD8nL2IVTeGuLWc/OTj6Ixa1EWQoEjJ+vKBy6aSG79ux8P53ry0TcjSaUlruUHVuuC/eLZInvnmRjZIZoCX1da1gFfp1JlmWbD6pREf7M1vkFA0A0Y6+A85paYgwnxD9SVgVUbU1cDQFwDp0JW+abWs2B7w8+D8g3iEv+4yuCqc2n4OgoiWljtJTjxe09eDnXgLIqaVFPTwAkqQCm6U0zkcyNQfMppYZZ3SqWMDKWPotSskeOFDX+1iTZczCIbX6tXIcQRezMU11y87aGIL9eMYGsSTReBkhWwdMF48tFgWv5bf8tuTWegq9d6z+5CJSR2rNOaW5LkQ5j0NYQ9AZD1UBdQZ6cqK+P8/xiptfr1Lzv5PHRlSaflh77jiGfftTmxg62TbwLNFhDcTg/uW5uO4gppQaQjwmjmZR2DxCN5+H0MCj5sUE5gJJT23iPEYG7UXE6axQtKZxyequaOEX3+Y6AYIKdSzzr9LuH3QQLCtdw3sGD4kjj6q6Tu76uVYrF09c7CD24g2+FOWHzXKA1dpIMAV3VYTdTvZwGhnmMwhA2Oee0WMBC15wile+zW5MNELXA/7oRusWMlpMJc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(8096899003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?i0bMf4fNz5Edaxbtw+sdOqmt0oQqRqI3nsVqIFJAjA4m/98q4wxuEiNu3UD6?=
 =?us-ascii?Q?c7z5QszwmTlIj+zyx5u+Ak6oQF4JfJ+e73lSGhSaNrVYTz0aDKnz38i37DSQ?=
 =?us-ascii?Q?cUMTusyP+9K13z/EGYz2MvrCBP+nFSZ9y5RVLc03hqdntia4C7Ac9XAvBqPC?=
 =?us-ascii?Q?gD1dgPoBeZQHe7YBXSdcj96OYRUX1aBz+XlheW4BrLBh86x1rUjA2XIyq4yA?=
 =?us-ascii?Q?9D3rUH3sWz/o5HOURJxYI1jb0c8begBNdsPqP8oSiRXCdc4OgHuiOZfCCGUg?=
 =?us-ascii?Q?J6VSj8lbad1NIUq7J0K4ONcTbhzAxl0mjRHcx0Q7JG5MCB6kJHxjIEwX4RUd?=
 =?us-ascii?Q?T6Zq+ll40i8JvR7dm1B15tLe5d4400YfxpxQtlnetdcPdSPw5erKP1rD6cjy?=
 =?us-ascii?Q?WbI31sSmcHF6nQWzhi9ENuJUuBXoaSCqmCClUP2l2tZzuKBYabMlvhOIv9eE?=
 =?us-ascii?Q?UrMBn34fuJwUJ2O9SmOVqFug5g6vX9hkQeTQc0yVap866TiBOq03VFxohjiK?=
 =?us-ascii?Q?QC9jI/kLSdwEEpdL8Xw5CBnaVhMB+SugyTDpYCTQVozL39qFJog/HdNkpR97?=
 =?us-ascii?Q?X1mNhBCFRv9DFs0Fa4a1AMe+GkS15ncSnejIFkIfRT5BVWb+C14bcLo7IKtT?=
 =?us-ascii?Q?8wuIHSWLC6j2F6HyQHrIc2PrP4a8Zom3R4AgEPD98Nh/8XEs9IO+Hm03Jwlc?=
 =?us-ascii?Q?aV54sk1FTTwWClRF2eA9nci+3tz/2Y7zXD6JXl2AHB4fA8kFDVDZCXbMUcnK?=
 =?us-ascii?Q?fjGSGsFNmbPpceymDTA8Bc+RrMopU+sAR/n7adX5KljhLVBml4RHlNCOXEqV?=
 =?us-ascii?Q?Q36BcBni9DvopK90xm+ajqiGJZhJItFIg/nB5tavhJn3Fy3B1d4j46kpTYh1?=
 =?us-ascii?Q?PXdObmbm1EzxWJ5Gv8wUX+z8l+CE4Fm7CrhiNoAi+U0mXQ8R+fAaxDfPSYCc?=
 =?us-ascii?Q?n+bl2IMuRj6rL+N9/cgtvq49vf4r6bYS9fn1VuSP5VpnhGcoctqg8G9Ui1ce?=
 =?us-ascii?Q?iZBgwceWEXtHExICQk1cTUAralqJ1Xz30ZspQxp1gxl3SbT/mDOyEsSCF1FO?=
 =?us-ascii?Q?Sfd54nI+yF0QBzz5lrnfSyKLvYLO57SrwXOyxz6XmvDy8IufB9ek9mxF1kWs?=
 =?us-ascii?Q?y5Xp36swcV1rbXc+tXP8uyb7nhFwbn7ey5tTDZMbOnKQOIE+S1aRTwgEvmfd?=
 =?us-ascii?Q?U9KCgkHL8QBsosYjOpU4+bxmSbS+N65wzY7pnjloUYfws/zQ4yLb3CMLVAoe?=
 =?us-ascii?Q?EF0UYnKbCzdpoKDMDnjC0fmTl88Tr8JYjJ1DXtP5B1d86r8PfJhY/ax88y8o?=
 =?us-ascii?Q?egkbOsAVwdk8rS5wQL+QHZhyR62cQSkrZsEUYOh9exLv36QqXSsSe/8JUmDi?=
 =?us-ascii?Q?jvMtR+Avnz62633q/Qn45HhFDkvWMreMeyne9IAa3XpLcbJYffKd3Dn29Yjg?=
 =?us-ascii?Q?f8+4ZqjCSsueAdrQ0FQZV3RTlB97RMjvM0ZS4o3J2+ZaavTaODU15SNlIzNd?=
 =?us-ascii?Q?bz79jQbsrNuqh9yBx03En2YJwHflM6KMGrBpHSyLJ4GDVsPZ2qzFKDJU2ccw?=
 =?us-ascii?Q?Umnq/lfW3ak3TqMvDf54j8EAm5ZMLGjC20FiOwnlb/k1murlgl/MZwr3VXPK?=
 =?us-ascii?Q?/z58uVaZofu6C6eLcn1wxKDsAvPxjHryWrN+T/z5Tylxt0nAq0LfxomjKbqP?=
 =?us-ascii?Q?OBsbM0eqMzILePwCVWWKf33d1uVMlxpvgCXlcWHzrJ7PqBh3?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB39626A2819D0DF214D37C454CBBE2DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	1+OrJk8PVqMR4/TV8jmgXXjZNwnCa7qJc53Dw77ElIrKEbVUMa3v6fIFJKYHqtNSEbWJqktPAW7rxzMZv42HLilgoOwF7mlXWxVDr5MFqbWrDP+9nM+jkeHAeyv8JsOMphEWIAQngg+deqOnwnhfZ+pcnEOHvYhMndgV7vIKpAhz52lIJaOrVnIEdiJBTnL31WTr9+1ZolL0YrNhKcpzidmEdo/2mQnR6LiuEtl5LjlXSTNq4+QA2cnP9h2mbFZQmnyVZMZnOd5cLQgWL2kjKeHp1zhBAmUJe/gq5kG7jYwsTqiBesGc4nEkaRd6I3jYYDrZ8ZscHgBQjjojq5znhQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc876b0e-3486-4390-506c-08df0ff3cb09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 10:59:46.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yDfsYiSkl1XjxebDX9QhsH3+PFwnA1HdvYo9mBZzD7dO0jn7JQ6XZ4PlshNmpq7nFODJqoSy+THjpJYqwdSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-2.cisco.com [173.37.147.250];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 10:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20181

--_000_DM6PR11MB39626A2819D0DF214D37C454CBBE2DM6PR11MB3962namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

  Hi Richard,

  Thanks for the feedback. I agree that deleting the existing clone is not
  appropriate when DL_DIR may be shared with other builds.

  The origud reference added by 58872250 looks like a useful way forward.
  Instead of replacing the stale path, I will look at making the successful
  mirror data available to the original fetch operation so that unpack can
  use it directly. The stale clone would then be left untouched.

  I will also investigate removing update_mirror_links as part of that
  change, as you suggested.

  I will rebase onto current master and update the test to verify that the
  requested revision is unpacked from the premirror while the stale origina=
l
  clone remains unchanged.

  Thanks,
  Fredrik
________________________________
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> on behalf of Richard Purdie via lists.openembedded.org <richard.purd=
ie=3Dlinuxfoundation.org@lists.openembedded.org>
Sent: Thursday, September 10, 2026 7:19 PM
To: Fredrik Svensson (svsvenss) <svsvenss@cisco.com>; bitbake-devel@lists.o=
penembedded.org <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones wh=
en using premirrors

On Thu, 2026-09-10 at 06:27 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
> A gentle reminder about this patch. It is still listed as New in
> Patchwork, and I have not seen any review comments.
>
>
> The patch prevents a successful premirror fetch from leaving a stale
> Git
> clone at the original download path, which otherwise causes a later
> do_unpack failure.
>
>
> I noticed that bb.fetch2 has since been renamed to bb.fetch. I can
> send a
> rebased v3 if that would make review easier. Please let me know if
> the
> approach needs any changes.
>
>
> Patchwork:
> https://patchwork.yoctoproject.org/project/bitbake/patch/DM6PR11MB39625BB=
95AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com/

It definitely hasn't been forgotten and is in the queue. I was trying
to find time to provide helpful feedback rather than just saying it
wasn't right.

Firstly, I don't think the fetcher should be deleting data like that,
if it is stale, it should just pass over and ignore it as something
else my want or be using it. For that reason I couldn't merge this as
is.

I do appreciate you're fixing a real issue here though and therefore
the question is how to do that.

The fetcher has traditionally struggled in this area and it isn't been
clear how to handle things from the code perspective. The
"update_mirror_links" was one way we've attempted that but it is
clearly flawed.

I'd note a recent change I made for sort of related reasons may be
helpful:

https://git.openembedded.org/bitbake/commit/?id=3D58872250f72f5760b4126552b=
dec5497f5a1a1f4

I'm wondering if we can use the presence of "origud" as a way to build
any mirror link when the fetch succeeds and maybe remove
update_mirror_links entirely instead?

Cheers,

Richard



--_000_DM6PR11MB39626A2819D0DF214D37C454CBBE2DM6PR11MB3962namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; Hi Richard,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Thanks for the feedback. I agree that deleting the existing clone is=
 not</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; appropriate when DL_DIR may be shared with other builds.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; The origud reference added by 58872250 looks like a useful way forwa=
rd.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Instead of replacing the stale path, I will look at making the succe=
ssful</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; mirror data available to the original fetch operation so that unpack=
 can</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; use it directly. The stale clone would then be left untouched.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; I will also investigate removing update_mirror_links as part of that=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; change, as you suggested.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; I will rebase onto current master and update the test to verify that=
 the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; requested revision is unpacked from the premirror while the stale or=
iginal</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; clone remains unchanged.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Fredrik</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> bitbake-devel@lists.o=
penembedded.org &lt;bitbake-devel@lists.openembedded.org&gt; on behalf of R=
ichard Purdie via lists.openembedded.org &lt;richard.purdie=3Dlinuxfoundati=
on.org@lists.openembedded.org&gt;<br>
<b>Sent:</b> Thursday, September 10, 2026 7:19 PM<br>
<b>To:</b> Fredrik Svensson (svsvenss) &lt;svsvenss@cisco.com&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<b=
r>
<b>Subject:</b> Re: [bitbake-devel] [PATCH v2] fetch2/git: replace stale cl=
ones when using premirrors</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, 2026-09-10 at 06:27 +0000, Fredrik Svensso=
n via lists.openembedded.org wrote:<br>
&gt; A gentle reminder about this patch. It is still listed as New in<br>
&gt; Patchwork, and I have not seen any review comments.<br>
&gt; <br>
&gt; <br>
&gt; The patch prevents a successful premirror fetch from leaving a stale<b=
r>
&gt; Git<br>
&gt; clone at the original download path, which otherwise causes a later<br=
>
&gt; do_unpack failure.<br>
&gt; <br>
&gt; <br>
&gt; I noticed that bb.fetch2 has since been renamed to bb.fetch. I can<br>
&gt; send a<br>
&gt; rebased v3 if that would make review easier. Please let me know if<br>
&gt; the<br>
&gt; approach needs any changes.<br>
&gt; <br>
&gt; <br>
&gt; Patchwork:<br>
&gt; <a href=3D"https://patchwork.yoctoproject.org/project/bitbake/patch/DM=
6PR11MB39625BB95AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.co=
m/">
https://patchwork.yoctoproject.org/project/bitbake/patch/DM6PR11MB39625BB95=
AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com/</a><br>
<br>
It definitely hasn't been forgotten and is in the queue. I was trying<br>
to find time to provide helpful feedback rather than just saying it<br>
wasn't right.<br>
<br>
Firstly, I don't think the fetcher should be deleting data like that,<br>
if it is stale, it should just pass over and ignore it as something<br>
else my want or be using it. For that reason I couldn't merge this as<br>
is.<br>
<br>
I do appreciate you're fixing a real issue here though and therefore<br>
the question is how to do that.<br>
<br>
The fetcher has traditionally struggled in this area and it isn't been<br>
clear how to handle things from the code perspective. The<br>
&quot;update_mirror_links&quot; was one way we've attempted that but it is<=
br>
clearly flawed.<br>
<br>
I'd note a recent change I made for sort of related reasons may be<br>
helpful:<br>
<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3D58872250f72f57=
60b4126552bdec5497f5a1a1f4">https://git.openembedded.org/bitbake/commit/?id=
=3D58872250f72f5760b4126552bdec5497f5a1a1f4</a><br>
<br>
I'm wondering if we can use the presence of &quot;origud&quot; as a way to =
build<br>
any mirror link when the fetch succeeds and maybe remove<br>
update_mirror_links entirely instead?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB39626A2819D0DF214D37C454CBBE2DM6PR11MB3962namp_--

