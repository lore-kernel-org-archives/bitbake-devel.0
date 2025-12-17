Return-Path: <oobitots@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3598D66B85
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 18:24:38 +0000 (UTC)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21978.1765995874290036323
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 10:24:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=CsFlV6CR;
 spf=pass (domain: cisco.com, ip: 173.37.86.77, mailfrom: oobitots@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=16952; q=dns/txt;
  s=iport01; t=1765995874; x=1767205474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=weNNGgnifdFE4EvSxJG0eob08kwKIHxyQitf3qF3eMQ=;
  b=CsFlV6CR4eg6Ce9q5hJLabMNXmPpI0ZibALkYnk0nW17a/wie5gXlHjb
   LIN525n7Os1qfFdkgDVQft1CLY70ANQ8uDsU32z2EXVIXiNj65bTm2ktO
   ev+dJIdEjvTn2KzDGmGGndlQJk2bQtADaiEG795mKUox+Ph5roSXNXBzM
   rW5rH1qrHRSZvS2mhJ2hXW3i2Oa8Zoqm5LiPtmzNgnpBHznsKIq+8y7Vz
   7SJoBOgiD/qbilxqvghqNpfUAQ2qEDiqM8bmgSRbOp55MxrC5gRbZLrr8
   QRMTwYJLONk21TVTNnD1Vyh8HzzYeEcXPnlpDMjyqg3Qid6CtN2Jj888R
   A==;
X-CSE-ConnectionGUID: OZ6CIokxQwyPPRvLc9+AEA==
X-CSE-MsgGUID: tLIg83DpRkGhSgglDGUJuA==
X-IPAS-Result: =?us-ascii?q?A0BEAAAM9EJp/4r/Ja1aHQEBAQEJARIBBQUBQCWBFwgBC?=
 =?us-ascii?q?wGBPDFSB30CgQ8SSYggA4RNX4h5A54agX8PAQEBDQIuAQIgBAEBhQcCjGkCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Thk8BDIZaA?=
 =?us-ascii?q?QEBAQMBEWIFEAIBCBEEAQEvJwobAggCBA4FCBqCYYIdFkADAQKlNwGBQAKKK?=
 =?us-ascii?q?3iBNIEB4CiBSwGFOoMXAQEqgTSCWYEehREnG4INgVeCaD6CYQKBYjyDV4IvB?=
 =?us-ascii?q?IIiehSGH5NcgUQiAyYzLAFVExcLBwWBJEIDKjQtIkwFLR2BIyAeFxNgVECDS?=
 =?us-ascii?q?RgGaA8GgREZSQICAgUCQDqBZgYDGSISAgMBAgI6VQuBdgICBIIYfoIKD4c+g?=
 =?us-ascii?q?QEFLoEfPAMLbT03FBsFBIE1BZM9XE6CKwh6CQoBKyCCV5JjCQFEjxBHgTWCI?=
 =?us-ascii?q?YpClRcKKIN0jB6NPYgyF4VbpRAumFgiixOYRoUaAgQCBAUCEAEBBoFoPCuBL?=
 =?us-ascii?q?nAVO4JnCUkZD5IhhWTCU3g8AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:N9gCPBGHj2SX/uKxRERi5J1GfhMY04WdBeZdwpMjj7QLdbys4NG+e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:mMZi/6sDMM4GEQ3FMxGEK4sWwOfnVAlfMUV32f8akzHdYApBsoF/q
 tZmKTuFPPeKZjPwe9h2b4+0oRxUuJPRztNrHQFqqygzQ3tDgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFYTdJ5xYuajhJsvja90sz1BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw3dQpKkBJ9
 uwhNyE1Viqdo+nng5uWY7w57igjBJGD0II3oHpsy3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxHYH49tL/Aan3XdDpSqU6SubEf6GnIxws327/oWDbQUoDQFJoKwx/C/
 woq+UzlJjAVZIez0QCG3XKXieDLsQzGep87QejQGvlCxQf7KnYoIBcXSVGyovT8hkOgVtZ3L
 00P5jFoqrA/8kGuRNTxUxC05nmesXYht8F4CeY27kSJj6HT+QvcXjFCRT9aY9tgv8gzLdA36
 mK0cxrSLWUHmJWeSGmW8fGfqjbaBMTfBTVqifMsJefd3+TenQ==
IronPort-HdrOrdr: A9a23:+ToS/K4TVoEFHhq7eQPXwYiCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICPoqTMaftWjdySSVxe5ZnPHfKlHbaknDH6tmpN
 hdmstFeZPN5DpB/LvHCWCDer5KrqjkgcWVbKXlvgtQpGpRGthdBnJCe32m+zpNNXF77PQCZf
 2hz/sCjQCNPV4QacO2DGQEWe/sm/3n/aiNXTc2QzQcxE2rlz2H1J7WeiL04v4ZaVxy6IZn1V
 KAvx3y562lvf3+4ATbzXXv45Nfn8ak4sdfBeSX4/JlagnEu0KNXsBMSreCtDc6rKWE81Axiu
 TBpB8mIoBa927RRGeouhHgsjOQkwrGqkWSi2Nws0GT5fARdwhKTPapQrgpNCcx3nBQ+e2UFp
 g7hl5x+aAnVS8o1x6Nl+QgHysa5XZc50BS0NL6SxdkINEjgHg7l/1FwKtYfa1wbh7S+cQpFv
 JjA9rb4+sTeVSGb2rBtm0q29C0WG8vdy32CHTql/blmwS+pkoJhHcw1YgahDMN5Zg9Q55L66
 DNNblpjqhHSosTYbhmDOkMTMOrAiiVKCi8fF66MBDiDuUKKnjNo5n47PE84/yrYoUByN83lI
 7aWF1VuGYucwblCNGI3pdM7hfRKV/NEAjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EFDsjSS5
 +ISdtr6j/YXB3T8KpyrnrDssNpWAwjueUuy6IGZ24=
X-Talos-CUID: 9a23:X/yrmmP1KTBFBO5Dfxs5328TGdAcbWzl9E3OB0TpSk9EYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AD5TpZQwWTfMYzU5lWYcfVUVVJrSaqLiKKU9dyrk?=
 =?us-ascii?q?egcqrNRd/NDOxowmVX6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Dec 2025 18:24:33 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 6376E180002BB
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 18:24:33 +0000 (GMT)
X-CSE-ConnectionGUID: FF6ynFZyTWiuZ5uAHEwpxw==
X-CSE-MsgGUID: zM4XynvmSACiZjf/pEJ4yg==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.21,156,1763424000"; 
   d="scan'208,217";a="60230770"
Received: from mail-cy3pr08cu00100.outbound.protection.outlook.com (HELO CY3PR08CU001.outbound.protection.outlook.com) ([40.93.6.104])
  by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Dec 2025 18:24:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfoG7abHy3U1yfA4xE1OC7M/7CtM5n7BguiTZITNui6ouoM3UVRdBu0ZmSLp7pGMYIKO+ZQqXQGrCQ14U/kNaRfbkDpMuKWnvg/7rsEngC+2U6aU4LcZw5WTO3rBKotDDBL0cs1hP0jMbhOk1wypEceEo3kZ1XRS75gr2K7D9WuE9zXK0ZQ1fh9OFJS7UxysYd1dq3VWYDdFOJyp/ZsDNeONlDQ9OVdTo2ezGI9L4HeKOzRXE0eVTHrJX3pMFtLeHhnAwUCF7r80X3hD6Atg8Hy+gOoIHrqE2AoGcCGfuj3cC9StzguTQd/qscJqowZ+sISG2UQn5aV4Jjwk6kt/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weNNGgnifdFE4EvSxJG0eob08kwKIHxyQitf3qF3eMQ=;
 b=tPRK2HuQfJ208/lPfq9sU4Tzmf89YwaT+9ki5fUR7ay0vGPCxOdhPI2HTQXqjUJzzNZQOSgDfeWfURBVsfGkuc1+RAApgGRaH4awdkll/ksw4TpYrAg3PQ6+D3EiBM7o8JsOfcMO7GblAYVIz8uvX4NgDUP1RfUH2UXGrTau35XUCNLL7SoWIB/8J/dCndXgJRSIyiGP1oPoTwmjVXZLBMdJY01Hw9cUYy3E2FpffkZBnhPQPU7+5PRQNHmknhHi1UUo8i9fIqIoOuAdDyldWgqHoFxogXnXYnaLXGRlzB395EBZHvGL9RUyuFr6GYl8/f1cwtoak3fHnM7CpLu9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 18:24:31 +0000
Received: from PH7PR11MB6401.namprd11.prod.outlook.com
 ([fe80::956a:249b:d135:b43e]) by PH7PR11MB6401.namprd11.prod.outlook.com
 ([fe80::956a:249b:d135:b43e%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:24:31 +0000
From: "Oleksiy Obitotskyy -X (oobitots - GLOBALLOGIC INC at Cisco)"
	<oobitots@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "Ruslan Bilovol (rbilovol)" <rbilovol@cisco.com>
Subject: Fw: do_patch confused with URL value
Thread-Topic: do_patch confused with URL value
Thread-Index: AQHcb1sUlwK+s7A4DUeERElH/UjvKrUmJbLG
Date: Wed, 17 Dec 2025 18:24:31 +0000
Message-ID: 
 <PH7PR11MB64013779E8056343242A983CD7ABA@PH7PR11MB6401.namprd11.prod.outlook.com>
References: 
 <PH7PR11MB64018740A35A908068C72F11D7ABA@PH7PR11MB6401.namprd11.prod.outlook.com>
In-Reply-To: 
 <PH7PR11MB64018740A35A908068C72F11D7ABA@PH7PR11MB6401.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6401:EE_|DM3PPFF2E67D388:EE_
x-ms-office365-filtering-correlation-id: 733bc588-775a-4cf8-76e1-08de3d9985a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?0Lyk2FTB313glCOxEBB3sFwPEblEjd+eF7BVZOqoIZx/lVcci3eZejqI1i?=
 =?iso-8859-1?Q?aviNJC5KvkYvmojx4WvYD1wBq7uKx6wxKQ+eRH5lNsUYmc539ddjAvpLmt?=
 =?iso-8859-1?Q?zdcrsTAGMB3XJqRWxfr90vazCQaqWfRdHYbZ9MWXvuUyq+WkycE150I5Mp?=
 =?iso-8859-1?Q?nGSynpRozHWKXooFpnKob1aJXpyFfHBL4YzQ/W3ztlzsLYJS0kw91pEMxB?=
 =?iso-8859-1?Q?tPeNSbA5x1v9lDmkcycORdk75K/jCQmoybfdKryeMJPDWDU+5ZOzvC3FVd?=
 =?iso-8859-1?Q?1Q+qjjHR/dMy4vpERh9mPJN3h0HHcdYQV5VxjIyfCpYcEW6Oxo59gtW0kR?=
 =?iso-8859-1?Q?E82p8yJYYvnN4++3qppOHVIG0VNU45PSRApLzVOgp5c93zO3b2sABxO+rN?=
 =?iso-8859-1?Q?lItLHR2tEyDQWTwyDKD+kTMsDedZL1AhpezyKrBcz9E22o8JutenhvHaS2?=
 =?iso-8859-1?Q?iehPL+TBHNDYKSCBjyZkS3luBzeiMxmrdW0FKSd0doLGmfdQDlWW4fHoPh?=
 =?iso-8859-1?Q?+OHnIoIxOEOdLei6+QTv49t0uJGD7Msq681wE8uRRtjaHM7kiJdVmYA3UV?=
 =?iso-8859-1?Q?uXK3yNxcqPQaXNzQb75aoVj+Z718zRzuDjNDfiq/CP3I3bcQ8pDNkQQgsk?=
 =?iso-8859-1?Q?wVEHp0ocePKZyeZf/RkTHREquqLY0h8Mdt4nt9CC0oZIsSeaeaXlShKP3x?=
 =?iso-8859-1?Q?CrMbFoOoiUkkQpfp+Ke3f3Sp1CFgx3I6Ggh8N4wR4OzDu2XxrDJZj0+EGi?=
 =?iso-8859-1?Q?xFcAd8ERKg0Izk4s8jhUkMdgIrMujPSw7rQUpAaphPEVv7/DPuZafiuBuY?=
 =?iso-8859-1?Q?m/zEFBru0i59Cb15aOtSyyOAoBBPzLcRzG4TUMksqkpPsRJJ+KfAvoIjM9?=
 =?iso-8859-1?Q?tBCKLK4l7NIxPlz9oAstEwbjaw73rQkABKMVWmeOJBxnMjkFFyhZOIPlA+?=
 =?iso-8859-1?Q?ZnruNLM4YUl5wv7MRgR6u/n8x00bFk8VL/CsSUForEzDcDwGGYVR4tVZhk?=
 =?iso-8859-1?Q?VsVnC4IkSoxej0KOAmgQtC9bnUaBihCUkAnMiXEYKYxRRV/aVGHhndg5FA?=
 =?iso-8859-1?Q?A0wRRrtSnioDaPZ8BVvc6ijlYxbXMBbbaVLQZA+xoFb7kQEBaAQU4rl5kv?=
 =?iso-8859-1?Q?bKU3pO6868/dggQWLJFoRUWadMBWE22rxGl/sDbPR/t0fss3FylGwNHlKZ?=
 =?iso-8859-1?Q?lUH1UKFRIKI4nUPm51Z/C/q83k434iWtP67MoIB/OpSTCQZN+n3HGStLBb?=
 =?iso-8859-1?Q?nuy60KFFnF7d5/h56KA8L6OeQuWVbbeinhA07UEiMhZtTBCM3thnB9JqYG?=
 =?iso-8859-1?Q?jPMd1smiWalKFbWbOAiJNdWDGIHxZ4xElaRgGKsUVubY3zaZhtWhm1xd/M?=
 =?iso-8859-1?Q?gOhHHJGvh2HAp3vBFCVkyFCfqdd+dEOPNTT06lZ7yh+ofgJx7dGCtx5UvR?=
 =?iso-8859-1?Q?+vb68+Z6VBgrd5TOGHMTKTKl0kuRcEj+VN+jWPBRzdOIZMUXFZ7pXu6xAN?=
 =?iso-8859-1?Q?3ThwMpbZ/LlCNV+QQdS9ZJfw4Zkjq/0eL2lJKIRzZCgSsVd1LfxedoOwZ0?=
 =?iso-8859-1?Q?9jYpPn42ZyV5aiiiFRWzkQpikt+9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6401.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?I+5ckHfxRFcF3Eu4ZlJ8P9pDmFTQCyFw94K+Unvy33z92lYHBhWZv6Tpl0?=
 =?iso-8859-1?Q?I66ylWHadhOSlYYHGNbxBcz9FHERPryUmhfoz0A4YewR0LsmrH2Zv/J4TD?=
 =?iso-8859-1?Q?zNq0RhFZciLqmYOBSduuan7m0IrMcbfyil/qKiJ1m89gMe8pYKTmkqWXy2?=
 =?iso-8859-1?Q?6p9grLGM/yo351GV59iOgaToHFWaQu3WXz3dYI1ke6B9/yKOA3owXLX990?=
 =?iso-8859-1?Q?sooHZdTduXAK5hunMf0PqU7/JRSazp0LioIdh2NwscKEK0eL+WAIZ++FIb?=
 =?iso-8859-1?Q?c6cImOo84hTvcXA55iwVxbTW0akwEG10HWbYfcJWQ5upd9IpxsuSNIf8XH?=
 =?iso-8859-1?Q?bn4/8TEl6BNvZaEWUyfzX1QlY+47Nkp5j/Ta/3fZ8cg9qq7Bllu9Xtv1i0?=
 =?iso-8859-1?Q?gkZTskJl0jDV92hgEQ6EDNWGAqTtxC4Cw5zreW6UsqLlkOUcTRDmZ8PsIH?=
 =?iso-8859-1?Q?FWmF1p5UQEgWHD39MSX6E1gBNU0EK/wIsV2QaDMLRNLuCk+/UY6VhPIgfe?=
 =?iso-8859-1?Q?0RRfExgklnD3jCeBkffr2uS9n2PkOz28pJc9ZXLQKMn1XA7lXTnKHXoPsr?=
 =?iso-8859-1?Q?tUZqATUV1JTvxb9Sg2Fo6pMaA5uEMY5sqFSc3NfFJWW1t1r5NtAjTNsf8+?=
 =?iso-8859-1?Q?0tdnMUsEkPNLhTp27ywGMRnGPiRIYOrxGn3rsm+FIS44XjhO+p76IKWGnn?=
 =?iso-8859-1?Q?UTKQbMcR2P7P/k50naX5cP0NF9QCs5mX8+aDx97KQmNdYVn5uymnoWUzMq?=
 =?iso-8859-1?Q?ogeawf2kkVLvYJAcSpmrvYuUrebgkdxJQawSr8ehVSTzCSlvk/t7RzOBhi?=
 =?iso-8859-1?Q?iJxNH/rUwvzcI075RaEBeg411WdUYi1oNjlwe1069/1le4j1DSI9MJ87c4?=
 =?iso-8859-1?Q?gkajk5IEZ2pNDBMFDcQU2NLCitjK7EVDsyjf0GxKob6z2u+BpuIYz32CDn?=
 =?iso-8859-1?Q?PBdVm80RtFApescRCnQegMk/s0l8fMCSI4aGXgd20+0lYqB+8b/XA2gVdH?=
 =?iso-8859-1?Q?eFjs340XNK/vpUWPgWnpqt/Me1Qv370h40wUdH4Quc8x0l3TSFQIWBidoF?=
 =?iso-8859-1?Q?IDykdqiSPM2JNNPzKJqEaTe0VPr3NSIUdE8dinJiU66ebF53ZRjs90s+jK?=
 =?iso-8859-1?Q?v7i7I01mQimzjZOWV/UEQjbQi+LIQ7fHnDomAo1NqaTAQG759sHP/au997?=
 =?iso-8859-1?Q?W810vPfPruLLkVHuZOW4keb9DrG9SUAD1+m5U8NzKv/USlxa16KY/QKalH?=
 =?iso-8859-1?Q?eAu7SfE17NZo1eWh9wOEJD14ujwJWyyXdAqo9h8YpU1XGCexWoC6VqoZbi?=
 =?iso-8859-1?Q?2NjYxXzyVabjozHCw8aMUbx7PxKPRJxBjRVMZ4m4BALdZlvefxxVzWA/qv?=
 =?iso-8859-1?Q?yL8cBbfLbzsU5MyTGfHRoCs3FTiVJcgCnOKL9tLpMF+Y1gJz/mNZyBRkXj?=
 =?iso-8859-1?Q?p7+f2aMAUW+K0A7jeu8wpvgBKE0qHoxIn6oE+jTyb1a/kDl4i1hmCxdSy+?=
 =?iso-8859-1?Q?tGBpo30gBHLSukYmHBRCd/ooz/OFKz2EwMJzpqVcJma2mDm2KJFDxFi6IC?=
 =?iso-8859-1?Q?RT4YJdRbeDCLp5eYnukZia7c28vBpKDaYN9kwde1L8uxvzUreSl3oLf3mO?=
 =?iso-8859-1?Q?JbuOPpJHwY060=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PH7PR11MB64013779E8056343242A983CD7ABAPH7PR11MB6401namp_"
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bc588-775a-4cf8-76e1-08de3d9985a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 18:24:31.4373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnRA3EItu0CQKlGXShBOYxSYdppIjb7R8ESkJpPpV1D8Uftsvx7Ulgt8CZwlDDjOGjybJAdSlomiZkR/rIi3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 18:24:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18608

--_000_PH7PR11MB64013779E8056343242A983CD7ABAPH7PR11MB6401namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sent to the wrong list, so duplicate here.

Regards,
Oleksiy

________________________________
From: Oleksiy Obitotskyy -X (oobitots - GLOBALLOGIC INC at Cisco) <oobitots=
@cisco.com>
Sent: Wednesday, December 17, 2025 14:48
To: openembedded-core@lists.openembedded.org <openembedded-core@lists.opene=
mbedded.org>
Subject: do_patch confused with URL value

Hi,

Got an interesting case when patch stage failed.
And I would like to ask if it is a known issue and it makes sense to improv=
e logic (maybe I'm missing something).

```
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: >>> url git://github.com/pkg/diff;name=3Ddiff;destsuffix=3Dbuild/v=
endor/src/github.com/pkg/diff;branch=3Dmain;protocol=3Dhttps local '<sdk-di=
r>/build/downloads/git2/github.com.pkg.diff' all False
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: >>> url file://run-ptest local None all False
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: Importing patch 'github.com.pkg.diff' with striplevel '1'
FileNotFoundError(2, 'No such file or directory')
ERROR: Logfile of failure stored in: <sdk-dir>/build/tmp/work/x86_64-native=
sdk-xesdk-linux/nativesdk-yq/4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad=
8cc1/temp/log.do_patch.3930851
ERROR: Task (virtual:nativesdk:<sdk-dir>/distro/openembedded-core/../meta-v=
irtualization/recipes-devtools/yq/yq_git.bb:do_patch) failed with exit code=
 '1'
```

Custom yocto scarthgap version.
In my scenario I used mirror for downloads and states and build offline (BB=
_NO_NETWORK =3D "1"), so I have files

<sdk-dir>/build/downloads/gitshallow_github.com.pkg.diff_20ebb0f-1_main.tar=
.gz[.done] before fetch
and after fetch I have no
<sdk-dir>/build/downloads/git2/github.com.pkg.diff directory

check for directory failed

openembedded-core/meta/lib/oe/patch.py
```
890     local =3D fetch.localpath(url)
891     if os.path.isdir(local):
892         return
```
...
```
base, ext =3D os.path.splitext(os.path.basename(local))
```

gives us 'github.com.pkg', '.diff'

and this check also failed

openembedded-core/meta/lib/oe/patch.py
```
904     elif ext not in (".diff", ".patch"):
905         return
```

Hence, return local from function and this is treated as local patch should=
 be applied.

In works in cases when we have no mirrors and after fetch I got file

<sdk-dir>/build/downloads/git2/github.com.pkg.diff

Regards,
Oleksiy

--_000_PH7PR11MB64013779E8056343242A983CD7ABAPH7PR11MB6401namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Sent to the wrong list, so duplicate here.</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Oleksiy</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Oleksiy Obitotskyy -X (oobitots - GLOBALLOGIC INC at Cisc=
o) &lt;oobitots@cisco.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, December 17, 2025 14:48<br>
<b>To:</b>&nbsp;openembedded-core@lists.openembedded.org &lt;openembedded-c=
ore@lists.openembedded.org&gt;<br>
<b>Subject:</b>&nbsp;do_patch confused with URL value </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Hi,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
Got an interesting case when patch stage failed.&nbsp;</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
And I would like to ask if it is a known issue and it makes sense to improv=
e logic (maybe I'm missing something).</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: &gt;&gt;&gt; url git://github.com/pkg/diff;name=3Ddiff;destsuffix=
=3Dbuild/vendor/src/github.com/pkg/diff;branch=3Dmain;protocol=3Dhttps loca=
l '&lt;sdk-dir&gt;/build/downloads/git2/github.com.pkg.diff'
 all False</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: &gt;&gt;&gt; url file://run-ptest local None all False</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
ERROR: nativesdk-yq-4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e35780ad8cc1-r0 d=
o_patch: Importing patch 'github.com.pkg.diff' with striplevel '1'</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
FileNotFoundError(2, 'No such file or directory')</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
ERROR: Logfile of failure stored in: &lt;sdk-dir&gt;/build/tmp/work/x86_64-=
nativesdk-xesdk-linux/nativesdk-yq/4.30.8+gitdd6cf3df146f3e2c0f8c765a6ef9e3=
5780ad8cc1/temp/log.do_patch.3930851</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
ERROR: Task (virtual:nativesdk:&lt;sdk-dir&gt;/distro/openembedded-core/../=
meta-virtualization/recipes-devtools/yq/yq_git.bb:do_patch) failed with exi=
t code '1'</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
Custom yocto scarthgap version.</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
In my scenario I used mirror for downloads and states and build offline (BB=
_NO_NETWORK =3D &quot;1&quot;), so I have files</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
&lt;sdk-dir&gt;/build/downloads/gitshallow_github.com.pkg.diff_20ebb0f-1_ma=
in.tar.gz[.done] before fetch</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
and after fetch I have no</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
&lt;sdk-dir&gt;/build/downloads/git2/github.com.pkg.diff directory</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
check for directory failed</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
openembedded-core/meta/lib/oe/patch.py</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
890 &nbsp; &nbsp; local =3D fetch.localpath(url)</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
891 &nbsp; &nbsp; if os.path.isdir(local):</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
892 &nbsp; &nbsp; &nbsp; &nbsp; return</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
...</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
base, ext =3D os.path.splitext(os.path.basename(local))</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
gives us 'github.com.pkg', '.diff'</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
and this check also failed</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
openembedded-core/meta/lib/oe/patch.py</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
904 &nbsp; &nbsp; elif ext not in (&quot;.diff&quot;, &quot;.patch&quot;):<=
/div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
905 &nbsp; &nbsp; &nbsp; &nbsp; return</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
Hence, return local from function and this is treated as local patch should=
 be applied.</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
In works in cases when we have no mirrors and after fetch I got file</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; line-height: 19px; font-family: Aptos, Aptos_=
EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-siz=
e: 11pt; color: rgb(0, 0, 0);">
&lt;sdk-dir&gt;/build/downloads/git2/github.com.pkg.diff</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Regards,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Oleksiy</div>
</body>
</html>

--_000_PH7PR11MB64013779E8056343242A983CD7ABAPH7PR11MB6401namp_--

