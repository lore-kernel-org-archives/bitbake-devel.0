Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FBEC79FB7
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 06:27:23 +0000 (UTC)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7761.1789021633771743957
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 23:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=XGo6aAzs;
 spf=pass (domain: cisco.com, ip: 173.37.86.77, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=21151; q=dns/txt;
  s=iport01; t=1789021633; x=1790231233;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=LaU36Synqd7qkimI1AZNWNXq1Jr+9mwKBpm3JoP7xrc=;
  b=XGo6aAzscyJRlDM6tjN0LnjOQa3c7gpJamYKS1HzoY+ze8Yk3BTBGDyl
   tmukEJb1z2rbPzgbn67T9lgAaWUd+8L1yI7Vkg7O7EJ07KsXlkOTRtRCK
   7yl18zzbgimHejY0rhcacIIH6jmcW00iLUq4Oa83EZCHU4HjBRq3rHQsk
   d+ZsFpC19rvI0ziu47/YD+nE1T5uguLEG4hMwRGa2WkLdxNogq5Uukuph
   jHriysVONWUtL3+JHEayThBlcKguZ19EyFALnXsCd0QOjwvRZ8F4dyDja
   AXOczHjlZzg5Osi0uhGtLdlgRw478/91UH+AuBPnhvdIimz34nfql87j0
   A==;
X-CSE-ConnectionGUID: hte9AM0WRPGfexuX1nrnRA==
X-CSE-MsgGUID: yBqvQkXXT2qpjGOGTL3SgQ==
X-IPAS-Result: =?us-ascii?q?A0DrAgD+TKJq/5L/Ja1agS6BK4E9ATBTFnICgRESSQSIH?=
 =?us-ascii?q?wOFK4ZYgiEDnhuBfg8BAQENAi4BBR0EAQGFBQKOBQImNAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGTwEMkBIBAQEBAwGBCAIBCBEEAQEvJ?=
 =?us-ascii?q?wodCAIEEwiCeQKCHRZBAwECDrZ3AolLGjd4gTSBAeAvAQsUAYE4hT+DHgEBK?=
 =?us-ascii?q?oE1gl2BIxkbhGEnG4INgRVCgmk+gmEEAYFfhBOCMASCInoSG4JLc4kAhyFSc?=
 =?us-ascii?q?iIDJjMsAVUTFwsHBYEjQwMqLy0jSwUtHYEjIR0XER5YGwYFEiAqQUMjAz6CJ?=
 =?us-ascii?q?T8jGTZ6gQlegSspYQIQF0YuFYIIAoJUgSNeAgFJQw4HRVMJJ0EDBxJMKRgLb?=
 =?us-ascii?q?T03FRkDBIE1BY4QB1ofghBGBwEVXhAKASsXOTARBwgjOhYfDQ8sokCOYJUXC?=
 =?us-ascii?q?oQejCKNPogyF4QEgVeLPZlVmQgjjWeWAYUNAgQCBAUCEAEBBoFoPA0egS5wF?=
 =?us-ascii?q?YMiCUoZD5c3UcY1eQIBAQE4AQEHAgcOAwuBaJF+AQE?=
IronPort-PHdr: A9a23:/SyKaB/zsu9pFv9uWBDoyV9kXcBvk6//MghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:ErP+vqOdqERV6yfvrR36lsFynXyQoLVcMsEvi/4bfWQNrUorgjAAm
 2UWWWjTP66KY2KkKtp0PIy1oU8BupbWytdgTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV7lV
 e/a+ZWFZgf0g28sbgr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/VyARAfGNUnwN5YD2xe6
 MxBLioLVDnW0opawJrjIgVtrt4oIM+uOMYUvWttiGmIS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMnwsYDUXUrsTIIkgh/mlgGLkWzZZs1mS46Ew5gA/ySQsiuOxaoOOK4PiqcN9j2yBu
 FvFz1TFWAgCNvO45gahqUmjv7qa9c/8cMdIfFGizdZggUGZz28eTREbS1a/if24kVKlHdVHJ
 koZ/yAjoaQ/+AqsVNaVYvGjiGSPshhZX59bFPc3rVncjKHV+A2eQGMDS1atdeAbiSP/fhRzv
 nehlNLyDjspu7qQIU9xPJ/Nxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:y5O3GqnTMmAu9ScZykGpmo+BgSfpDfMliWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj+fZq9z/JICPoqTMmftWjdySeVxe5ZnPDfKlHbaknDH6tmpN
 tdmstFeZLN5DpB/LzHCWCDer5KrqjkgcWVbKXlvgpQpGpRGsddBnJCe36m+zpNNXB77PQCZf
 2hz/sCjQCNPV4QacO2DGQEWe/sm/3n/aiNXTc2QzQcxE2rlz2H1J7WeiL04j4uFx9fy7Yr9m
 bI1zf++riitP+DzBrd3X/47phdmtfto+EzSvBkjPJ7FhzcziKTIKhxUbyLuz445Mu17kwxrd
 XKqxA8e+xu9nL4ZAiO0FvQ8jil9Axrx27pyFeej3emi9f+XigGB81Igp8cWgfF6nAnoMp33M
 twriGkXttsfFH9dRbGlpz1viJR5w2JSL0Z4KguZklkIM4jgXlq3NUiFQ1uYc899WnBmfEa+a
 FVfbHhDbBtABKnRkGcmHVzy9qxWXl2NBKHTk8e/vGx6VFt7StEJ49y/r1Dop/Gn6hNEaWt64
 n/Q9dVvaALQckMYa1nAuAdBcOxF2zWWBrJdHmfOFL9Ccg8SjnwQrPMkfwIDduRCdQ15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIRGmmRzzixsxX+pA849THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umKWf1A45G0wD3RpEXI3gDV88evMo9Rju104j2A5yvsvaefOfYJbLrHzphUmTjAm
 EbVDy2P8lE5lDDYA6PvPEQYQKbRqXSx+MFLEGBxZlg9GEkDPw4jjQo
X-Talos-CUID: 9a23:fI4RlG87A8C75TQffnWVv04IF5EMVyXi9k//LUKoFFYwTqeTc3bFrQ==
X-Talos-MUID: 9a23:ox0Z4Qr6FLtKMFm90pcezyBILdlR4JSeNBoUiZcpnOa4EXdLNA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Sep 2026 06:27:12 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 9AD23180004A9
	for <bitbake-devel@lists.openembedded.org>; Thu, 10 Sep 2026 06:27:12 +0000 (GMT)
X-CSE-ConnectionGUID: w+9nAlY5RTywvsxhJ+m1Pg==
X-CSE-MsgGUID: ckTqaT1cTJaX1roSB1RMKg==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,271,1779148800"; 
   d="scan'208,217";a="93420999"
Received: from mail-centralusazon11011026.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.26])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Sep 2026 06:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWYKv6uQBr1VRtM6Mp0CaLJGvURgfE4dvYMX/RmBOZbY9G+jTp6s8n19zDppT8741Uo4ZdSU99dONb1NswX93qY0snVMtM2N2ZkGzUwIx54IiI1Y/7pGJDbSSmK46oCUz/NOlay84JjgVeos7ueU42PJA0r3gAvXtCY4V8l2/px/HestasKVcDcHoLISLHwYFqq2kjUY165/wiL08v6Blr6xh3+8w1Wfg4Ijw1E+CuxPaj3ih8gBZ5WefIpOqkvTOmgyBHhSmv23emw1iIxxueoXyN5V/TB9EU+JSRCMZ1uXhF8KRfeRR8JCBLDKiHI/lfn3BF4YpmIyUQWBkcJz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaU36Synqd7qkimI1AZNWNXq1Jr+9mwKBpm3JoP7xrc=;
 b=K1SE0tLkUz8Nvfjela/fCgL0k3ToaEjcnecaIe+roWtcK687xI69PPhh0LQU5Kscx69EecBAIJ3R8TKL0fEqB/qxQ8b+oTtvB0fuMNcYLOGSV8jwdKewp5NwHzaRYhCDEF/phCTdjFy/APqkfyXLmV6kGJ+mfI18AxLOaAabskBMds6S7UZQ8A0UpwU0TVY9D97nyMuEfo7HKAwgPd2qUlsDfwcDzlVqF973ff8+hc6nxtLTnn5EtWmv6U8Qi+pDWJQun5fwI7tlcR8IMI90sA8/oNPrtcfDpdmI9z1bRywG4nZnK1QKiAXYfdUo/EzTtQUNstab6C+i7UhZOaBTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by SJ2PR11MB8298.namprd11.prod.outlook.com (2603:10b6:a03:545::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 06:27:10 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 06:27:10 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetch2/git: replace stale clones when using premirrors
Thread-Topic: [PATCH v2] fetch2/git: replace stale clones when using
 premirrors
Thread-Index: AQHdM7u93YDDR9xguEGYgLnSEPKwP7bHcs6L
Date: Thu, 10 Sep 2026 06:27:09 +0000
Message-ID: 
 <DM6PR11MB39626186CF03268680D049DDCBBF2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: <18CEBA5A9DB58325.510612@lists.openembedded.org>
In-Reply-To: <18CEBA5A9DB58325.510612@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|SJ2PR11MB8298:EE_
x-ms-office365-filtering-correlation-id: bdd1ebcd-82ef-4853-a5c4-08df0f048b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|3023799007|22082099003|8096899003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 mtRnI/Wk+voIwxC+HHlm09WFdybabeztARgqAoyFzxDZppgbKsofTIWozOAtq6oLc6kARfgw4zFy6jJPOmiKGQL9Wto53gNvAce//kpXYM/mGQ3x887oKz+4EVU91i89bjhicvTxzp2HdP7iI9KzZPeQQHNeGOWZK+iFPGHqcWlJNTdzADZYUj2aPKKLgkBTYo4wLvNfrfZl6oLhMrrl77sYmXQ3LtrzK+yW4vtOVqACgikwPaxqGllm0g/sg+g/4H8ca+8JHZff38UIpyYRCpgLipIAP+2iPM0jfeUvVU8tOjq5Th6OS1MP6bCmIo25oc7wygGZ/Ki01mI79MDafF2hJJFBg1qcY/o7t91XnRTi2wu7C7ONHIx7U8JtO3CHZp9NIzwR2PmzxRwLIS3UilhelS5qmt9/kWhhzYKHO3nq9szb0fwaP6+qps57xQ0A9eHeDeSxc6QLfrdCYcX8t8PNGHszoo/vvUnNPxDIgXikeiNK6k2wACXV2sevZXmBD/w095FbYIZE8P4rBNcll/mWv+KmJ8UmRLRUc8RAy0AZDca8jG3MkrSat+8liDQnNpOw5DJ1LQOr/c2jBtbE2+X+M1u42UIP/9cIZGw1T5eiuC4Hb/Id+1fqltsnSgdAtUqEQG39AL3F0anxlPPPCo0zsrPA4lHuLgDEHtO94N0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(8096899003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eh+j31MfXAaDvEvWlexHTUbCbM3Aq3CAOnagsbDJshIjkaaLnzo3FPBY8SBs?=
 =?us-ascii?Q?wawMP5KhoHWOUTLUtE+43QkKtF0ZXOjzcGm7ZJhKUTU1F4VRyMQ2iej/xsr1?=
 =?us-ascii?Q?cMHt5RiHQUTSVkUQfMpktjFCwznBMoPEzltU0EhFXlvJAQ6/02ZAq/zahug3?=
 =?us-ascii?Q?7+ObRalG91N+EsvLBAPgUtmgfRHmGsgP0p2jWrHxQqSvq5buvXUsxQq3Cp+y?=
 =?us-ascii?Q?9y4JbEhItbuV4S5aWwETbKSIalnpNkjdFqWOVRrMhTEiShBpXrbeqHzQ9HbD?=
 =?us-ascii?Q?sQCeAm+mJPUG6wT6CY1o+VkGuncnLNwhOjPhqFqCuDygudZ2kLYZNsU9sG0f?=
 =?us-ascii?Q?6Pi7zLBP0NGnv/gm1FYapn+SLz2YznvxNXnPxXdEMyDsH+ObDvi76jDYr2AE?=
 =?us-ascii?Q?ZKiDO7S1EzZ3Q/uZJpIN4yW9EZfrN9eM77e69YdKbt7gkcFx15wL38FMVU2o?=
 =?us-ascii?Q?mVWL6xoQdCWgfoOaDu/ENKqo62Q1EJ4SPvYm7y1X1U24cDgvWA1wHJuV4bLu?=
 =?us-ascii?Q?bDOX2KPQpQQy4nQyEZL5LHQErHLXAz5ZoaGcgFY7NMdFCJ8cCdpjcoywaOVF?=
 =?us-ascii?Q?Y7kmRKbG+JJAAaO8b/lMSakQYVmuYDScE+G6l59evAIT1D+Qgm05S3beJK3c?=
 =?us-ascii?Q?CMgI4FKieuqxWdPa67m3j6bVFT6Jyt7um2Hi2E20/CwISoD4LU9lc9OyXWjE?=
 =?us-ascii?Q?w6BR8j4cN0MVz0fQ5LR1kS03pvOvybFhmRQqatpUNcBKe1kROpFGn5JEeXU7?=
 =?us-ascii?Q?whkE4VaNW6MHs0sVSLeekzBljixiaJU1+QpHR7A+5w965LQAEJvaV6Q34+z6?=
 =?us-ascii?Q?ABBbSqhP7/+85BEWJE2+BD3asynbqC1O5odqRsQKwDipfsyG8VMg9sq3y+EQ?=
 =?us-ascii?Q?8o41Twqu5rshtx547lGI7Z1nUhUvhdofcodoCjkG8Hq5v2D9O+tqsEFG3q9V?=
 =?us-ascii?Q?GJkZM/R4Bhc/ZwsFgmT6r51aPbTN/q4hd7RtXHcvHQi5/1baufUOGbIeUQsQ?=
 =?us-ascii?Q?5mMoXedi146radAGxOY9LxhcL2zcZ6oqHKgPE0UmW7JBsrAzn1EM8PZDhakw?=
 =?us-ascii?Q?NVsG8t4PrNefIZpb3bMRPEJXQ46n+bNz78cHkBB3zOFrpso6u6bppUR11IJD?=
 =?us-ascii?Q?s6oxd9W87LxoraavsxXCXQwKxoszZnJyY+WTv94bsM9gyff6qxrtN/ETTl4o?=
 =?us-ascii?Q?RwNeTmA6GSH8V5bUkHKebjLICvnnTPgFTn1ETMlmX7/ALzLeqsGutzR7eaUX?=
 =?us-ascii?Q?g0GuWY8rCmVSp5x/IUKxEO2oT87GWFCrjXfZzwMsAjHqf5KRQv+tIdezi3nl?=
 =?us-ascii?Q?EkcNZO9xV8cjUHcvx+W237R9YoTD94MnJaty0E3G+UbOdEzI6JDeFNf2/d9l?=
 =?us-ascii?Q?mcxSAGUGe6uQ/ET6pFDfhwPsJgPFWx/zAqoVy0TCMfX1BbgyRMdIKr9Fc+zu?=
 =?us-ascii?Q?+5f3JDtrV09wZ89eR10N7+ZqyBdw6Tow5028xFrhCzZZ27CPAwa8I1TlVVTr?=
 =?us-ascii?Q?H1xqoDX6F3EUNJKVQmmLlE2CddhkE6qCHDCIEw4e53PdbAlznNECGJsxglFk?=
 =?us-ascii?Q?XZu4EIsLn6nJkXpU/fwsIj7TyiUcV/wW+COzh6JTD1nshU03TxJ2Qg1b38Du?=
 =?us-ascii?Q?ISB97jPforWLuDzNJstd/rX9WFgZSov/iniH559LWbd3n45CgTA/BzIQYrTX?=
 =?us-ascii?Q?teHroW6I9Nz9Lwynj7xCuiPDXKReUzdzeEVQwC1R1COeohFx?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB39626186CF03268680D049DDCBBF2DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	1dtgO921B/RCU0GBQtQTKg0WILgfPVTieLkxbCvqOQUnhSthg5Bnoth+IbHvfSV9L9APup+oZWNA0uuZ4eJ/28jMY5D3Joe04FODhh4aDoV9JNwaewKb0LPAHovTw2C5F5fi06Y7nKOXS5eU6eDuhhP34Y3bgZOF7IiWJMtzwlhMtdGhkbzVDZaTOCdTv/bZPii2In7qoXqxJIoAH87t97jPU3abJ2LT0gkL6c9mc0hGZnnIK3SvTbECKaAgeV9REJXbvTKW9Vd3xmx68k9TFQlIDY2+vHE1JkRJVcTl5qF41pXBZ20i3Gq5N2qFlfSzxcROQ1GEIWDqnAOe8ZI4XQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd1ebcd-82ef-4853-a5c4-08df0f048b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 06:27:10.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNHB9xf+XOIwDMBMipOQKfCCYehEQWxtOOvkbxYpXwqGHDmaBn6geKVQAJRgcetLxDC6bPm6mcBO+msUERItdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8298
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-4.cisco.com [72.163.7.165];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Sep 2026 06:27:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20178

--_000_DM6PR11MB39626186CF03268680D049DDCBBF2DM6PR11MB3962namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

A gentle reminder about this patch. It is still listed as New in
Patchwork, and I have not seen any review comments.

The patch prevents a successful premirror fetch from leaving a stale Git
clone at the original download path, which otherwise causes a later
do_unpack failure.

I noticed that bb.fetch2 has since been renamed to bb.fetch. I can send a
rebased v3 if that would make review easier. Please let me know if the
approach needs any changes.

Patchwork:
https://patchwork.yoctoproject.org/project/bitbake/patch/DM6PR11MB39625BB95=
AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com/

Thanks,
Fredrik


________________________________
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> on behalf of Fredrik Svensson via lists.openembedded.org <svsvenss=
=3Dcisco.com@lists.openembedded.org>
Sent: Monday, August 24, 2026 1:29 PM
To: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.=
org>
Subject: [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones when u=
sing premirrors

A successful premirror fetch can leave an existing clone at the original
download path even when it lacks SRCREV. The fetch is then stamped
complete before unpack rejects the stale clone.

Pass the datastore to update_mirror_links() and remove the original
clone only when the Git validity check says it needs updating, allowing
the successful mirror to be linked.

The new self-test creates a stale clone at the original download path
and a local premirror containing a newer SRCREV. Without the fix it
reproduces the UnpackError; with the fix it verifies that the mirror is
linked and the requested revision is unpacked.

Tested with bitbake-selftest on Python 3.11, 3.12, 3.13, and 3.14.

AI-Generated: OpenAI Codex
Signed-off-by: Fredrik Svensson <fredriks@meraki.com>
---
 lib/bb/fetch2/__init__.py |  4 ++--
 lib/bb/fetch2/git.py      |  8 ++++++--
 lib/bb/tests/fetch.py     | 42 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9cb268be..68a0225f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1150,7 +1150,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):
         # This may also be a link to a shallow archive
         # When using shallow mode, add a symlink to the original fullshall=
ow
         # path to ensure a valid symlink even in the `PREMIRRORS` case
-        origud.method.update_mirror_links(ud, origud)
+        origud.method.update_mirror_links(ud, origud, ld)
         update_stamp(origud, ld)
         return ud.localpath

@@ -1692,7 +1692,7 @@ class FetchMethod(object):
             except FileExistsError:
                 pass

-    def update_mirror_links(self, ud, origud):
+    def update_mirror_links(self, ud, origud, d):
         # For local file:// results, create a symlink to them
         # This may also be a link to a shallow archive
         self.ensure_symlink(ud.localpath, origud.localpath)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0bb2ea39..a1f9cb33 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -353,8 +353,12 @@ class Git(FetchMethod):
     def tarball_need_update(self, ud):
         return ud.write_tarballs and not os.path.exists(ud.fullmirror)

-    def update_mirror_links(self, ud, origud):
-        super().update_mirror_links(ud, origud)
+    def update_mirror_links(self, ud, origud, d):
+        # Replace a stale clone which would prevent linking the successful=
 mirror.
+        if self.clonedir_need_update(origud, d) and os.path.exists(origud.=
localpath) \
+                and not os.path.samefile(ud.localpath, origud.localpath):
+            bb.utils.remove(origud.localpath, recurse=3DTrue)
+        super().update_mirror_links(ud, origud, d)
         # When using shallow mode, add a symlink to the original fullshall=
ow
         # path to ensure a valid symlink even in the `PREMIRRORS` case
         if origud.shallow and not os.path.exists(origud.fullshallow):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f..65483570 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -616,6 +616,48 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         self.assertIn(self.recipe_dir, dir)


+class GitPremirrorStaleCloneTest(FetcherTest):
+
+    def test_premirror_replaces_stale_clone(self):
+        source =3D os.path.join(self.tempdir, "source")
+        os.mkdir(source)
+        self.git_init(cwd=3Dsource)
+
+        testfile =3D os.path.join(source, "testfile")
+        with open(testfile, "w") as f:
+            f.write("first\n")
+        self.git(["add", "testfile"], cwd=3Dsource)
+        self.git(["commit", "-m", "first commit"], cwd=3Dsource)
+
+        recipe_url =3D "git://upstream.invalid/project.git;branch=3Dmaster=
;protocol=3Dhttps"
+        self.d.setVar("SRCREV", self.git(["rev-parse", "HEAD"], cwd=3Dsour=
ce).strip())
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)
+        ud =3D fetcher.ud[recipe_url]
+        ud.setup_localpath(self.d)
+        os.makedirs(os.path.dirname(ud.clonedir), exist_ok=3DTrue)
+        self.git(["clone", "--bare", "--mirror", source, ud.clonedir], cwd=
=3Dself.tempdir)
+
+        with open(testfile, "a") as f:
+            f.write("second\n")
+        self.git(["commit", "-am", "second commit"], cwd=3Dsource)
+        revision =3D self.git(["rev-parse", "HEAD"], cwd=3Dsource).strip()
+
+        self.d.setVar("SRCREV", revision)
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=3Dfile" % (recip=
e_url, source))
+
+        fetcher =3D bb.fetch.Fetch([recipe_url], self.d)
+        ud =3D fetcher.ud[recipe_url]
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+        self.assertTrue(os.path.islink(ud.clonedir))
+        unpack_revision =3D self.git(["rev-parse", "HEAD"],
+                                   cwd=3Dos.path.join(self.unpackdir, "git=
")).strip()
+        self.assertEqual(revision, unpack_revision)
+
+
 class TarballNamingTest(FetcherTest):
     def setUp(self):
         super(TarballNamingTest, self).setUp()
--
2.55.0

--_000_DM6PR11MB39626186CF03268680D049DDCBBF2DM6PR11MB3962namp_
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
<div class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
A gentle reminder about this patch. It is still listed as New in</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Patchwork, and I have not seen any review comments.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
The patch prevents a successful premirror fetch from leaving a stale Git</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
clone at the original download path, which otherwise causes a later</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
do_unpack failure.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
I noticed that bb.fetch2 has since been renamed to bb.fetch. I can send a</=
div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
rebased v3 if that would make review easier. Please let me know if the</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
approach needs any changes.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Patchwork:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
https://patchwork.yoctoproject.org/project/bitbake/patch/DM6PR11MB39625BB95=
AC43D3A3D7335E2CBA02@DM6PR11MB3962.namprd11.prod.outlook.com/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Fredrik</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> bitbake-devel@lists.o=
penembedded.org &lt;bitbake-devel@lists.openembedded.org&gt; on behalf of F=
redrik Svensson via lists.openembedded.org &lt;svsvenss=3Dcisco.com@lists.o=
penembedded.org&gt;<br>
<b>Sent:</b> Monday, August 24, 2026 1:29 PM<br>
<b>To:</b> bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.ope=
nembedded.org&gt;<br>
<b>Subject:</b> [bitbake-devel] [PATCH v2] fetch2/git: replace stale clones=
 when using premirrors</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A successful premirror fetch can leave an existing=
 clone at the original<br>
download path even when it lacks SRCREV. The fetch is then stamped<br>
complete before unpack rejects the stale clone.<br>
<br>
Pass the datastore to update_mirror_links() and remove the original<br>
clone only when the Git validity check says it needs updating, allowing<br>
the successful mirror to be linked.<br>
<br>
The new self-test creates a stale clone at the original download path<br>
and a local premirror containing a newer SRCREV. Without the fix it<br>
reproduces the UnpackError; with the fix it verifies that the mirror is<br>
linked and the requested revision is unpacked.<br>
<br>
Tested with bitbake-selftest on Python 3.11, 3.12, 3.13, and 3.14.<br>
<br>
AI-Generated: OpenAI Codex<br>
Signed-off-by: Fredrik Svensson &lt;fredriks@meraki.com&gt;<br>
---<br>
&nbsp;lib/bb/fetch2/__init__.py |&nbsp; 4 ++--<br>
&nbsp;lib/bb/fetch2/git.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++++--=
<br>
&nbsp;lib/bb/tests/fetch.py&nbsp;&nbsp;&nbsp;&nbsp; | 42 ++++++++++++++++++=
+++++++++++++++++++++<br>
&nbsp;3 files changed, 50 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index 9cb268be..68a0225f 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1150,7 +1150,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # This may also be a link =
to a shallow archive<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # When using shallow mode,=
 add a symlink to the original fullshallow<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # path to ensure a valid s=
ymlink even in the `PREMIRRORS` case<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; origud.method.update_mirror_lin=
ks(ud, origud)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; origud.method.update_mirror_lin=
ks(ud, origud, ld)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_stamp(origud, ld)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ud.localpath<br>
&nbsp;<br>
@@ -1692,7 +1692,7 @@ class FetchMethod(object):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ex=
cept FileExistsError:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pass<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; def update_mirror_links(self, ud, origud):<br>
+&nbsp;&nbsp;&nbsp; def update_mirror_links(self, ud, origud, d):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # For local file:// result=
s, create a symlink to them<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # This may also be a link =
to a shallow archive<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.ensure_symlink(ud.loc=
alpath, origud.localpath)<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 0bb2ea39..a1f9cb33 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -353,8 +353,12 @@ class Git(FetchMethod):<br>
&nbsp;&nbsp;&nbsp;&nbsp; def tarball_need_update(self, ud):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ud.write_tarballs a=
nd not os.path.exists(ud.fullmirror)<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; def update_mirror_links(self, ud, origud):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; super().update_mirror_links(ud,=
 origud)<br>
+&nbsp;&nbsp;&nbsp; def update_mirror_links(self, ud, origud, d):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Replace a stale clone which w=
ould prevent linking the successful mirror.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if self.clonedir_need_update(or=
igud, d) and os.path.exists(origud.localpath) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; and not os.path.samefile(ud.localpath, origud.localpath):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.util=
s.remove(origud.localpath, recurse=3DTrue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; super().update_mirror_links(ud,=
 origud, d)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # When using shallow mode,=
 add a symlink to the original fullshallow<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # path to ensure a valid s=
ymlink even in the `PREMIRRORS` case<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if origud.shallow and not =
os.path.exists(origud.fullshallow):<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index a1e4b45f..65483570 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -616,6 +616,48 @@ class GitDownloadDirectoryNamingTest(FetcherTest):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.assertIn(self.recipe_=
dir, dir)<br>
&nbsp;<br>
&nbsp;<br>
+class GitPremirrorStaleCloneTest(FetcherTest):<br>
+<br>
+&nbsp;&nbsp;&nbsp; def test_premirror_replaces_stale_clone(self):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; source =3D os.path.join(self.te=
mpdir, &quot;source&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; os.mkdir(source)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.git_init(cwd=3Dsource)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; testfile =3D os.path.join(sourc=
e, &quot;testfile&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with open(testfile, &quot;w&quo=
t;) as f:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.write=
(&quot;first\n&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.git([&quot;add&quot;, &quo=
t;testfile&quot;], cwd=3Dsource)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.git([&quot;commit&quot;, &=
quot;-m&quot;, &quot;first commit&quot;], cwd=3Dsource)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recipe_url =3D &quot;git://upst=
ream.invalid/project.git;branch=3Dmaster;protocol=3Dhttps&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.d.setVar(&quot;SRCREV&quot=
;, self.git([&quot;rev-parse&quot;, &quot;HEAD&quot;], cwd=3Dsource).strip(=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetcher =3D bb.fetch.Fetch([rec=
ipe_url], self.d)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ud =3D fetcher.ud[recipe_url]<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ud.setup_localpath(self.d)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; os.makedirs(os.path.dirname(ud.=
clonedir), exist_ok=3DTrue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.git([&quot;clone&quot;, &q=
uot;--bare&quot;, &quot;--mirror&quot;, source, ud.clonedir], cwd=3Dself.te=
mpdir)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with open(testfile, &quot;a&quo=
t;) as f:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.write=
(&quot;second\n&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.git([&quot;commit&quot;, &=
quot;-am&quot;, &quot;second commit&quot;], cwd=3Dsource)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision =3D self.git([&quot;re=
v-parse&quot;, &quot;HEAD&quot;], cwd=3Dsource).strip()<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.d.setVar(&quot;SRCREV&quot=
;, revision)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.d.setVar(&quot;BB_FETCH_PR=
EMIRRORONLY&quot;, &quot;1&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.d.setVar(&quot;BB_NO_NETWO=
RK&quot;, &quot;1&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.d.setVar(&quot;PREMIRRORS&=
quot;, &quot;%s git://%s;protocol=3Dfile&quot; % (recipe_url, source))<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetcher =3D bb.fetch.Fetch([rec=
ipe_url], self.d)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ud =3D fetcher.ud[recipe_url]<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetcher.download()<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fetcher.unpack(self.unpackdir)<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.assertTrue(os.path.islink(=
ud.clonedir))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unpack_revision =3D self.git([&=
quot;rev-parse&quot;, &quot;HEAD&quot;],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cwd=3Dos.path.join(=
self.unpackdir, &quot;git&quot;)).strip()<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.assertEqual(revision, unpa=
ck_revision)<br>
+<br>
+<br>
&nbsp;class TarballNamingTest(FetcherTest):<br>
&nbsp;&nbsp;&nbsp;&nbsp; def setUp(self):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; super(TarballNamingTest, s=
elf).setUp()<br>
-- <br>
2.55.0<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB39626186CF03268680D049DDCBBF2DM6PR11MB3962namp_--

