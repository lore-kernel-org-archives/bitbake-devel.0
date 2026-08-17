Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B197C5DF66
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 14:14:50 +0000 (UTC)
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31441.1786976081075347110
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 07:14:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=i5/+d8i6;
 spf=pass (domain: cisco.com, ip: 173.37.86.76, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6896; q=dns/txt;
  s=iport01; t=1786976081; x=1788185681;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=u79uG9MP3muCDHSuTJlBYbWlWlHsQsOFUHlkhoHevEc=;
  b=i5/+d8i6nsL0YZ3o93a0TZIZpB3mXcvtHz2nmBlJTIY62sYH7B5wNGqf
   uZMnZ3SJcBlLqfkvBJEpDMgvhByqtXkUySNaSqnFRWCPBEQ0uur6myqkv
   PVLQv+R0bPRlfqMLz3FJedrLZJ+QqL/ZwxdAH9TI/ofQT+aQ2bXNVxdH5
   sFIMm/OrX/a2bR103E7mlLZsTzTo2ra35gAFht7sbjkBuYh963QuW9BG0
   PO9iu/aQ/W6H5X/nuzDSyBpZ8K9nK+6JQZFf5lIFFzz0xVjXMU75d1Swb
   Fq+VBPSnHghv2x9orLk2DqQBQGoxJZ4tQprEm7z42csz6+TOVLeqgblBz
   A==;
X-CSE-ConnectionGUID: fOpspr+uQ9qt671e7pUzSA==
X-CSE-MsgGUID: Ttv4hzGHQy+Wma2+4O3fCA==
X-IPAS-Result: =?us-ascii?q?A0CgBADSFoNq/5T/Ja1aHgEBCxIMZYEgC4E9ATBTgQqBI?=
 =?us-ascii?q?UmIIwOFK4ZYgiEDnhuBdAoPAQEBDQIuASIEAQGFBQKNaQImNgcOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchloBAQEBAgEBfQsCAQgRBAEBL?=
 =?us-ascii?q?ycKHQgCBAESCIJ7gh0WGicDAQK8SAKJSxo3eIE0gQHgORWBOIUFOoMeAQEqg?=
 =?us-ascii?q?TWCXYEjGRuEYScbgg2BFUKCaT6ERYQTgjAEgiJ6EhuCMTuITYc9UnIiAyYzL?=
 =?us-ascii?q?AFVExcLBwWBIxAzAyAKLy0CFA0iDxoFLR1wDCcSDx0XFx5YGwYFEiAqQUQjA?=
 =?us-ascii?q?xMrOIEIQQKBdT8jGTZ8gQlegSsqYgIQF0YuFYIKAoJzgSheAgFJDgttPTcGD?=
 =?us-ascii?q?hkDBIE1BY0rB1sggVRxAQJZNSoBgVpXAUWiQ4F8oXsKhB6ZX4gyF4QEjRSZV?=
 =?us-ascii?q?JkII6NnhQ4CBAIEBQIQAQEGNoE5DCmBWXAVgyJTGQ/ePHk9AQEHAgcOAwuBa?=
 =?us-ascii?q?JF+AQE?=
IronPort-PHdr: A9a23:oXDd0BEuALxZ9eEKCQR5XZ1GfhMY04WdBeZdwoAsh7QLdbys4NG5e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:q2ff1qjQ2dRzO2m4JNgrD3JUX161PxEKZh0ujC45NGQN5FlHY01je
 htvCmCPOveOa2TwfNl3YYi/pEkA6sKHy4VlHlY6r31kQ39jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeCULOZ82QsaDxMu/vc8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUW3f5sGXsN6
 MVJMSxTMUmO2PqL0omSH7wEasQLdKEHPasFsX1miDWcBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgd/5JEWxI9EglHkbSZGpVSOvoI84nPYy0p6172F3N/9J4bSH5kLwxjBz
 o7A11jlHE0aJvO/8CvGzXel3KyTunj1c6tHQdVU8dYv2jV/3Fc7AhwKX1K4rLy1h1CzX/pbK
 lcI4WwptaU0+UmhQ9XxUhH+p2SL1iPwQPJKGOE8rQXIwa3O7kPAXy4PTyVKb5ots8peqSEW6
 2JlVujBXFRHmLaUUnmasLyTqFuP1eI9dwfuuQdsodM53uTe
IronPort-HdrOrdr: A9a23:5Bz3oKwkruvLLddzOcVhKrPxJegkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ5uxoWJPtfZquz+8K3WBxB8bvYOCIghrSEGgP1/qH/9SkIVyDygc/79
 YuT0EdMqyLMbESt6+Ti2fIcadE/DDEytHUuQ609QYKcegeUdAZ0+4PMHfjLqQZfnggObMJUL
 Cnyo5soT2mdX4LbsK9KEUkcoH4zeHjpdbNWzJDIwQoxjWvoFqThYLSIly1zx0eWzRAzfMY93
 TZkwv236Ons/uq4B7R3W3e4v1t6ZXcI914a/Cku4wwEHHBmwyobINuV/mppzYuutyi714sjZ
 3lvwogF94b0QKQQkiF5T/WnyXw2jcn7HHvjXWCh2H4nMD/TDUmT+JcmINidAfD4UZIhqA+7E
 sL5RPai3NkN2KFoM3P3amOa/isrDvznZMWq59Xs5WYa/pGVFYel/1GwKofKuZwIMuz0vFWLA
 ApNrCc2N9mNXWHcnveom5jhPaoXng1A1O6Z3JqgL3P79CT90oJknfxA6ck7y09HJ5Rceg228
 3Udqtvj71AVckQcOZ0A/oAW9K+DijXTQvLK3/6GyWtKEgrAQOFl3fM2sR82Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjpg23ek1hpTsAL7wdSGTQlEnlMWt5/0ZH83AQv
 62fJZbGeXqI2fiEZtAmwf+R55RI38DV9B9gKdwZ3ue5sbQboH6vO3Sd/jeYLLrDDY/Q2v6Rm
 AOWTDiTf8wmHxDmkWI9yQ5d0mdDnAXp6gAYpQy19JjvbQwCg==
X-Talos-CUID: 9a23:qBJy8mGwUrGZuXjPqmJp01YPAtpmb0SM1WuOfBa1Vn5UWoa8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AkhZ+gg2c4Y1qkhu1FFF+tkpHhTUj37iwVEAfvrU?=
 =?us-ascii?q?/qoq7MCUqeGu61zqca9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Aug 2026 14:14:23 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPS id C32AF18000149
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 14:14:23 +0000 (GMT)
X-CSE-ConnectionGUID: mjS+uvlKSASZoaBNAjJw/g==
X-CSE-MsgGUID: QyEY6FpoTHKsQVU8mq+M2g==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; 
   d="scan'208,217";a="77418068"
Received: from mail-southcentralusazon11012022.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.22])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Aug 2026 14:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgcNN0C9hgPt+zI9XlRZOHb+6bFR8O3tYbTptArxPMO7RnY2FuFke3Z1dJ+6HQf+5app1Decf5SK89NYr5x8YcrxMVUEP60IKaqDJ8AgehSC09MH8QMTAdaQKBRnwLImwt1cQFK5T3Wd9ypPLPKoVWkwiwgjTv69QEH/pvx/+B9PlACOI1SA6AjvQKlNhzCk/IN++1vqupA6UTPWEveOHI6aOGfK0InhNUhdJCSP+npSyudoIMB1taEXsahSfh6HO2N9URF6leBwCoA/NE1WlvJOsi7IaTS2zcr673Jfdzn47ETsQty0h83yucCgIDB7v7hFOQVQP4xbY6GAjcO/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u79uG9MP3muCDHSuTJlBYbWlWlHsQsOFUHlkhoHevEc=;
 b=vKkic0oQMfKLpHqYzdc2Tib4v58EO1TT6TceGoeBAYQywK1mEAXzeSwkvn1+Bng9rweKlPizfsg7DQP4wSikCYD3i4Cj4Z7aBL6B5MLKDIGctBcYHXkKlLlzJGPKnKR4LYScXWjVUFeTE9hM+s1fNnOaqvfmr4O7bDK9yUnFKzssie3h7HPj8OcH9yeWDJrx6Vk31koNjtnXO2Hpw3tcB5RRGrveCVdESgAvU1CSDtBCBHK7pG+HFQ2Jf5addtEZJks8KES3A23VIrt0QVayNRIRRrbdHDNsUAqg9VrDtAKZxOp9HYBK85nRNpS2BW4JwjD4ciL1HM9Yf6mI2NfiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:14:13 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:14:13 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: 
 =?iso-8859-1?Q?Re:_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS?=
 =?iso-8859-1?Q?=A0connections?=
Thread-Topic: 
 =?iso-8859-1?Q?[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0con?=
 =?iso-8859-1?Q?nections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7aiSJ6AgAAG970=
Date: Mon, 17 Aug 2026 14:14:13 +0000
Message-ID: 
 <DM6PR11MB39628059FA2D29F9B3F74295CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=910e671e-f650-4ece-ba89-b6868c0f2a60;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-17T13:46:25Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|MN0PR11MB6060:EE_
x-ms-office365-filtering-correlation-id: 69dc65f1-350f-4f26-1078-08defc69d0a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|8096899003|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 ETjMmcE+Zw2QHkW0MoiG5hNZdrkcF2fYThx2k5DZhB1cg3NX984RdLsI4nQ2Q72TZums05vBe07j5A+e1oiNdaX/agvqc4D6XmOWM15wf8itHhUpLXqbHv5IvHQ2VKmOzfNj3m9aeIKVudlK7YFrhig2SiovzY3Jud19aeKlMq3f+E+sf+CxXuTtANJeAcfZf6iiMqTPghhfBmd6MuD7NPLG8FZwR6b78d6NQEPKde4xQd24t/TDAAvaS1J1Le9VXaqgobzM/Fx7+bxsoFqfxCMWoKI4vvw/CfUzUUDWvnFrAWVk1e9nrXEoeKnehjKTOhE53Pax/UosPjEYYkKUE27u1fsO7PgYG3Kc8HnETzZqOaq6mQqY0DGwT4v25z0DEWkDvfKHSAqW1aXLJFdiqGZor+xfRrhE0DggEsWuDzPN174UM+6ZMtxmCjnrEn/DAbFxXF670nQ34/kmeE7Cs/kRdM5atcW/TA6RYcUBxOr7lYrMYcrzTA1LhZNSWykdbuR1EVxvQuMpRzHAJC57cWUNgUM1I1ujPipdpP73FUkzuUOD6Gq5asohslK+/cEUN26qti+PhJxnMmupurC75h0tvxNSOmlEQ1FR62MuMOMWG7jyJfCnjWz50izH2fyoLF21KRSFTx+TddBrW/4wxJ+Wu7pcyTDa/r5ljUbPUAyXZe+vscKdXul10BeJfJlFVu55TpmXQOUETG6uzi+jll+cjAHEndw267jrktg3eHE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(8096899003)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?F+7urf8lNs9VhuYHnOM5CWCcz30DOWAEclbmj9nQuRHb2B9NnAgOBtwe4N?=
 =?iso-8859-1?Q?Cxu8Icn4gKtWNmxE8y8o9PHTptK5Pzt+WrhywipoD7PfJnB3z2/pJM1I/6?=
 =?iso-8859-1?Q?8isBhu+S0K+XwXUCDuzQlVNM1jN0WXqSpKToJlfHBC3TCXayn62FuFx7Pe?=
 =?iso-8859-1?Q?LNtFoRo0smZWhDzPph6VcwsMWuyCrpmUKT3UeZVOh4yRcMrhQXH6Py0A/p?=
 =?iso-8859-1?Q?mDBdzXBIHE9UlNf/WPG5dHw6JOpLKzULSmZqG3am93G8hx9jwMnFU9MHCt?=
 =?iso-8859-1?Q?1Ya/RhriDCyJBwEPTdcF27MeAO/jf9Ok75cX7XOKIkE6AMW7II6lma0Wrn?=
 =?iso-8859-1?Q?xTnquJTCr7hX1yUQp2yRbe/++TIfUz6y1msj8wNhPpGPw5WXYaDZSOfSCn?=
 =?iso-8859-1?Q?8helBTrYiJ3mw58yqO2T15yoj1caPTcSg+fIlIjC5oijeHt04qlmWMJDET?=
 =?iso-8859-1?Q?sPNXBhL+z3TTHqs1MwI6DxUDzcdaalkLyn+EOgdTfbMgv/q6VeftXX0sDX?=
 =?iso-8859-1?Q?rAnThGdy0umDVhjyHhKRAN9uDMCo3diDnWiqMMWvMwPmFJEVojnM+/VV+p?=
 =?iso-8859-1?Q?spZg3up7cTwI488rh5ewxQ/sECSvf2pN2HEUeN6+z+Cn1J16u1e+2I5zV4?=
 =?iso-8859-1?Q?q60vggAgVE1qgiZ29U+GCbJKtvQAP8+9nB2myZOgczhBtColYOKxpV1DUE?=
 =?iso-8859-1?Q?P47LWf8/H/CjswPVhnA5FDeEIYSwwPVC46028MpIZxNzjuGHhD20rZAxxT?=
 =?iso-8859-1?Q?wMknbH2ThAZTsQadXwlB5UAQb9iWP3iaPcqNAM5oTyeGvbfRyPIJzqLf+v?=
 =?iso-8859-1?Q?DtVBcTdU48KqepS+eWkmCyM+4IWyhewr6blSdVOxiXLgcJoUev4lqzA/Ep?=
 =?iso-8859-1?Q?H//owMt/wBcXa5i2Z9GgZJQb2/kv7gX3PkuYFuKSUh9e1cYWs7FcRXibb6?=
 =?iso-8859-1?Q?+6Y1DgXx35B5D8hoU/av094jcNDFwgLS4TwyavMU20yce9neUAtxlrwx3t?=
 =?iso-8859-1?Q?HjL7QQpGXh8AadoySDIQTHuV5OiSKsGtJUdwC+17PDmQUcgxmeKu+fuxDj?=
 =?iso-8859-1?Q?+3DxQFZfFVwxUrMxFAx78RCpT30+PD1Ln6FRMbZyIdunZ5BhMBBtyKvdeE?=
 =?iso-8859-1?Q?M1esijU8pdxO56ud/CXbw4zDVrnMlvMSCeMGVYq//Mu2WJkpo5YAi/BS/z?=
 =?iso-8859-1?Q?5G7I082ZVcBmGqTrmnE5Ru5M5tGwDEhKfy3ujZHbZBtUg5ixN9jfgOdgRe?=
 =?iso-8859-1?Q?A0QYYTebhxKSr1iHWbfWL95C9G8/An17SzHWw24AnKkaQdbzG4RAbGSmHx?=
 =?iso-8859-1?Q?9NWsOCIysW/RwNIX/OXPLdMw7tXXKOYkf54VvdNOKXRJE65TtmI72mtVPG?=
 =?iso-8859-1?Q?oqNMZEbFDGu58W2Ej+rlgKa9b3Onvb720EbEHqLiYpT4iFaYgP3u0xlCwD?=
 =?iso-8859-1?Q?Tvx40ogonZ9SCUHYUD3Szon5k1f9G7whO0tDBEMhGB4Qf7TqokUT5LJCJs?=
 =?iso-8859-1?Q?TUg+HuVkwhpclVfioEjQprjukdqkb6imJ5v0B2CnRMTtVgfQZSFZgTrsrz?=
 =?iso-8859-1?Q?ZVcf7tRT8LL4eWQx6sZibQAv/J6q5KwCWWzYxgsrCH7KHG5o5mFdeIrXX2?=
 =?iso-8859-1?Q?Aq9MiTDnZnMoBnZ8Hod61ZgzeKNT6kccdj/XxpohS96/VnMVT5brLM7CC5?=
 =?iso-8859-1?Q?yTZmhMiDKjsgxcfbAWEVVHHrKGfen9CEstXnN+q2lD9LwOMZ+mUDrj0Nyg?=
 =?iso-8859-1?Q?4DmN+Jo4ZBIwGXZFhP01xU2mh+pUSNnUQ/qosPBPP7zCpm?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB39628059FA2D29F9B3F74295CBA72DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ndmKBX0izSIm9uLf/znXJsw/Oc03+UeZGAtsNOPBwII6huKwHw3hGlkcpVA2QNmTN6/CN1Xckf754RdCK9Ty64f7XJl2j4GV5rvBsYrKOVkRNNYHrfo3tGbrG+0bq81giu44KdtR4w2yxfBo9s37rFIczlLiwhW3OLjD1sc3ZVbt5rDAF2cEk4iQanmMKX37jL3VDb8JO0h0McfmQ+DxmbLWGOYVtcZN79vuLOhQRtyVssFcWEhEfo7bBbovcE8tu/+qJmJMLLjQUfmmwJIkBXjJfagvncH7UxHrbdYVLSOBVeAgp5kv5eRU+95xs/Nihb2A7tdMVbZIlDBkhjY4tw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc65f1-350f-4f26-1078-08defc69d0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 14:14:13.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0q8UrI9hfM/wuwUSppt2Vuk8588DWQcTx58WvMk7LapSvzReb9uswwUJNV7y2P1pekXZfQNICLQaVncVWeNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-3.cisco.com [72.163.7.164];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 14:14:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19971

--_000_DM6PR11MB39628059FA2D29F9B3F74295CBA72DM6PR11MB3962namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Chris,
Caching the SSL context should provide an additional improvement, especiall=
y if
context creation takes 100-200ms on your system.

Please do send the patch; I think the two changes should work well together=
.

Cheers
Fredrik
________________________________
From: chris.laplante@agilent.com <chris.laplante@agilent.com>
Sent: Monday, August 17, 2026 3:48 PM
To: Fredrik Svensson (svsvenss) <svsvenss@cisco.com>; bitbake-devel@lists.o=
penembedded.org <bitbake-devel@lists.openembedded.org>
Subject: RE: [PATCH v2] fetch2/wget: reuse cached HTTPS connections

Hi Fredrik,

> The checkstatus() path reuses cached connections for HTTP requests, but u=
ses
> urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability check
> therefore creates a new TCP connection and performs a new TLS handshake.
>
> Add HTTPS equivalents of the existing cached connection and request handl=
er.
> Preserve the SSL context selected by BB_CHECK_SSL_CERTS and extend
> FetchConnectionCache keys so HTTPS connections are kept separate from HTT=
P
> connections, different certificate policies and CA files, and different p=
roxy
> tunnels.
>
> Add a local TLS self-test which proves two HTTPS HEAD requests use one
> TCP/TLS connection. The test also verifies that a connection established =
with
> certificate checking disabled is not reused after checking is enabled.
>
> In an ABBA benchmark against BitBake master, 4,283 remote sstate availabi=
lity
> misses averaged 761.639 seconds without this change and
> 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x speed=
up.
> The benchmark had no matching mirror objects, so it isolates availability=
 checks
> rather than download and unpack time.

Funny enough, just last week I was also poking around in this area using vi=
ztracer to do some profiling. I was preparing to send a patch that just cac=
hed the SSL context creation, which on my system costs 100-200ms each time =
(since it has to load the certificate store from disk).

Thanks,
Chris

--_000_DM6PR11MB39628059FA2D29F9B3F74295CBA72DM6PR11MB3962namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Caching the SSL context should provide an additional improvement, especiall=
y if</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
context creation takes 100-200ms on your system.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please do send the patch; I think the two changes should work well together=
.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Cheers</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Fredrik</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> chris.laplante@agilen=
t.com &lt;chris.laplante@agilent.com&gt;<br>
<b>Sent:</b> Monday, August 17, 2026 3:48 PM<br>
<b>To:</b> Fredrik Svensson (svsvenss) &lt;svsvenss@cisco.com&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<b=
r>
<b>Subject:</b> RE: [PATCH&nbsp;v2]&nbsp;fetch2/wget:&nbsp;reuse&nbsp;cache=
d&nbsp;HTTPS&nbsp;connections</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Fredrik,<br>
<br>
&gt; The checkstatus() path reuses cached connections for HTTP requests, bu=
t uses<br>
&gt; urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability chec=
k<br>
&gt; therefore creates a new TCP connection and performs a new TLS handshak=
e.<br>
&gt; <br>
&gt; Add HTTPS equivalents of the existing cached connection and request ha=
ndler.<br>
&gt; Preserve the SSL context selected by BB_CHECK_SSL_CERTS and extend<br>
&gt; FetchConnectionCache keys so HTTPS connections are kept separate from =
HTTP<br>
&gt; connections, different certificate policies and CA files, and differen=
t proxy<br>
&gt; tunnels.<br>
&gt; <br>
&gt; Add a local TLS self-test which proves two HTTPS HEAD requests use one=
<br>
&gt; TCP/TLS connection. The test also verifies that a connection establish=
ed with<br>
&gt; certificate checking disabled is not reused after checking is enabled.=
<br>
&gt; <br>
&gt; In an ABBA benchmark against BitBake master, 4,283 remote sstate avail=
ability<br>
&gt; misses averaged 761.639 seconds without this change and<br>
&gt; 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x sp=
eedup.<br>
&gt; The benchmark had no matching mirror objects, so it isolates availabil=
ity checks<br>
&gt; rather than download and unpack time.<br>
<br>
Funny enough, just last week I was also poking around in this area using vi=
ztracer to do some profiling. I was preparing to send a patch that just cac=
hed the SSL context creation, which on my system costs 100-200ms each time =
(since it has to load the certificate
 store from disk).<br>
<br>
Thanks,<br>
Chris<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB39628059FA2D29F9B3F74295CBA72DM6PR11MB3962namp_--

