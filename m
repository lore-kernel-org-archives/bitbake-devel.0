Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A61C5B56A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 08:17:17 +0000 (UTC)
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3020.1786522628246086787
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 01:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=R9A/bNaA;
 spf=pass (domain: cisco.com, ip: 173.37.86.76, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11232; q=dns/txt;
  s=iport01; t=1786522628; x=1787732228;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WmOn/FVAxi1T52oHuhXQB9idLyuJtV2pWzRqyM2ud6M=;
  b=R9A/bNaALiXiqcDmyG9xR7NmvDpTfPCKQY1ZXFRz2IZ9x0NbiJPG/KeJ
   eqHFOfbAU+z6ZnhD6jczGmyvu3ldWgVaKuYz77xfbsa3UxvjodO4pnGW1
   LHuJR7CiTiW+7jS+Hj2jpK4Pm58LtcFD05VuMObzha064jR0nsDOYHWd8
   oX1E1xTZT793HbrlDPAbnPBGMENZlD+UP2fYGXj14AP3jfM6XzdVtvUA8
   EQhCrTDmtbcKk6MhpfPIUm+MgJFAxeYGrgXAVvknDZVTKvOxv7pvwPDCy
   hROuVrMLWP9LEVem5ONou8iLZ2SmzAL7fJu5lePfsvP4shrW1wWCWBJUT
   Q==;
X-CSE-ConnectionGUID: JX/XsQgxQVWhzo+jA4pncw==
X-CSE-MsgGUID: aOEgUyoTTtuit1qbRk5/oQ==
X-IPAS-Result: =?us-ascii?q?A0AdAADJKnxq/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQFlg?=
 =?us-ascii?q?RcHAQELAYFtUxZyAoEPEkmIIwOETF+GWIIhgRadCIF+DwEBAQ0CMSAEAQGFB?=
 =?us-ascii?q?QKNZwImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZPAQyHb?=
 =?us-ascii?q?AF/JwQTCIJ7gnQDAQK4KgKJSxo3eIE0gQHgLAELFAGBOAGIXAGFeIR8JxuCD?=
 =?us-ascii?q?YEVQoIxdoQrGoQTgjAEgiKBDIJIgjSBF40UgUocA1ksAVUTFwsHBYFmAyovL?=
 =?us-ascii?q?W4yHYEjPhc1WBsGBYEdgSiEaCMZNnyBCWGBKypmEheBCYI0AoJ2gS1iAgEeC?=
 =?us-ascii?q?209NxQZAwSBNQWOJiCCRAEBAVkhFCoBgSCBEZMMkXmhewqEHowhlXAXhVulE?=
 =?us-ascii?q?AGZCCOjZ4UOAgQCBAUCEAEBBoFoPIFZcBWDIglKGQ+YB8Y1eT0BAQcCBw4DC?=
 =?us-ascii?q?4FokX4BAQ?=
IronPort-PHdr: A9a23:lDxigx+IJCrDSP9uWBDoyV9kXcBvk6//MghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:DSr4FqiThIszVPlQQjSBQWHLX161PxEKZh0ujC45NGQN5FlHY01je
 htvWmiGOq7ZMDP2edF0bd/k8hkD7ZeDm9ZkHlE6qSw3EyxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeCULOZ82QsaDxMu/vZ8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU6yqFHGlhB5
 cUmFzAfaVOBrr6uxrmkH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQZ/5JEWxI9EglHkbSZGpVSOvoI84nPYy0p6172F3N/9J4XbH5sPxhnHz
 o7A123eLx4nJduj9SaY8271n+X1nn68X7tHQdVU8dYv2jV/3Fc7AhwKX1K4rLy1h1CzX/pbK
 lcI4WwptaU0+UmhQ9XxUhH+p2SL1iPwQPJKGOE8rQXIwa3O7kPBXC4PTyVKb5ots8peqSEW6
 2JlVujBXFRHmLaUUnmasLyTqFuP1eI9dwfuuQdsodM53uTe
IronPort-HdrOrdr: A9a23:OqGdwa7mOkzNYaAQywPXwduCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQwdcLC7VJVoMkmsiaKdhrNhcItKPTOW8ldAQ7sSlrcKrweQfxEWldQtmZ
 uIEZIOcuEYZGIS5a2VkWvIdurIq+P3lpxA8N2ut0uFOjsaEp2IgT0JbTqzIwldfiUDL5w/E5
 aX+8pAoBSdWVl/VK6GL0hAddLu4/nQmrzbQTNuPXMawTjLoSKj6bb8HRTd5REDTjNJz44l9G
 jOgyb56q+gv/zT8G6S64bU1ftrseqk7uEGKN2Hi8ATJDmpoB2vfp5dV7qLuy1wiP2z6X4x+e
 O84isIDoBW0Tf8b2u1qRzi103LyzA18ULvzleenD/KvdH5fjQnEMBM7LgpMicxqnBQ/+2U4p
 g7ml5xhKAnSS8oWx6NoOQgYisa1HZcZ0BS19L7wUYvCLf2I4Uh0rD3tHklbqvoWhiKprwPIa
 1JENzW4upQfBexanDUuXQq/fmXN05DRitvhiM5y5aoO/88pgEj86MVqfZv70so5dYzTYJJ6P
 /DNbktnLZSTtUOZaY4H+sZR9CrY1a9CC4kHVjiVmgPLpt3TU7lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lSVKV/NFgjF24Vb/dx0q7f8TL3kPWmKT00vidKpp7EaDtfAU/
 i+NZpKC7voLHfoG4xOwwriMqMiYUU2QYkQoJI2SliOqsXEJsnjsfHaau/aIP73HTMtSgrEcw
 8+tfjIVbB9B2yQKw3FaULqKgPQk2TEjOFNLJQ=
X-Talos-CUID: 9a23:f181EWBv1+CxXo76EwtXs34PI881S0PizGXXYE2RVX5vQ6LAHA==
X-Talos-MUID: 9a23:7luIJQmFmGob7gzrETvednprE+pn3rWpNHwRjJQa4tCODy8tfDCk2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 08:17:07 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 2569318000223
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 08:17:07 +0000 (GMT)
X-CSE-ConnectionGUID: uGjFsJAmTAusZhO6UK1BDg==
X-CSE-MsgGUID: eoAlhJYHSqWy19Wgku0fEQ==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="91680384"
Received: from mail-southcentralusazon11011025.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.25])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 08:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7EfrX/YBYta4Qxc6h3OcrUi5ADnY12+FmILjSO8MmAztXl119uHSdVtg4xs7xa9fUqclEvpPLTJW0i/ISafSBJ2c8e6as/J31/V6TQn6i80YwLqmQ3YioLjFGeugz2Hu0Xc392Bwl5kMsS5nTUBiXgQKZweuCHfn4pB8N/JhAmAD7cHHRTrTT+mCYJ6zYaSCOBYy980lvcvT7t29kdM2f+c1f96AEXAk9mOKS6mVoleaNh6RYfYv1DTK6E06V6QaiUC37Bs+rJ7+5XF8y3bdV2Ndgf+E/J/gELyzqRbWxsOw44wF3chRbG0gmQtY0Nh30y2WtEVb2PIAoHxu7MePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmOn/FVAxi1T52oHuhXQB9idLyuJtV2pWzRqyM2ud6M=;
 b=FT4n/Ym/KmWlp4F6DPnB3DrO94ZQxX6+7hGuMnFO5C8/ToeIcb1Vw8IX4yIYTk/fHDR05haHsUwFu0umF0hczjmOKbc2r4IT9RNSkygAofxH0jGm4uAmMDovFjxHjqLZMVfPvdBCmf6O0Y8SPXq2ZdRLEuPnj+WbeN5o/N98t9LDKbwM2BAE2CH40M0E7VGj1ppMiwGudAtGK7HZrhxI6S43lcYn6C9gEyIcHaPj0HnWhZKxCKI3GKaAnc8J7NjWbSP2n8qerScIjHfZ5gf8A1tVb5qsQs0Zs4Whbor8CWcrmzRLK/NMB8MxCbI3s+cUP2S9nn4hlsR6woj3YNyXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 08:17:05 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 08:17:01 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/wget: reuse cached HTTPS connections
Thread-Topic: [PATCH] fetch2/wget: reuse cached HTTPS connections
Thread-Index: AQHdKjIcRsOrUi4UUESHej0HaYuU+A==
Date: Wed, 12 Aug 2026 08:17:01 +0000
Message-ID: 
 <DM6PR11MB39629DE24C8A6EDFBBF5B89ECBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: 3b05f413-b423-49e5-70f5-08def84a1632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|38070700021|56012099006|11063799006|3023799007|10067099003;
x-microsoft-antispam-message-info: 
 j25w23MvGpbBTAQjKpxtPgnmXodU/E5AYeuPD6x0yGc/n2srhMpIIgkxaRjQR/sk2xyeSMuJXUGWZ5WZ6J6mL7kgvVdEPLmJbdPAGaQdJXHeOmFZOEv2d82M569xNd3Q0Be0VjJu0MyEkYrquGlEgRTpbd4Ea/W6HsfvIk6d9WwSQTHpLIMPGYLqvdHhM8+IAIdWrVwoG7pX8lBLeCrZIlLvplqlB3FIqhuonf2TJTiRoCz6eGOV+zSSvOUYbwJoFGglObNDc+lzF1eXf5EHTtjtSYqtGAnN0VBRjYRsbEqCOHc5wuRjyJ6Y6yhpnXiaLT8L4W+d8EPJuBB4Koum1W9HykZCtg+xlslL65UryvqP8Wik6qGyBiBnzmZk6+15Ij/NnjzdRPuJUzQVIrYuliGR90Z4ypZcfxNKqZM5k/+3qmeePbHVDWeCG4Xngj+lP0Ale7uNrAw2azQX2MeD1TRrICCn6exd6zKexCpMbaYhaGAh2VSjhbhfNGyhcUAIB7gPiY+VnKq0aQOhr6zLe/nNC5DFki7w78nsh1h8xIIKxbXA6d5y2M1+Cf2oRH1wiAKqZTQ72lTCUN4SUU/LO3b5xY6CFIX5YQNGLN5W50ntzcPEQoL+osa5FWU84U8P4NelKf3IUG0sC4vyNd99U943bCi1rMF+HefCClEYzfWf64D/O/rsFrGKssnbFpF7S/DcINYRSf6PgInef0EVpK88ccYxbw40vetceobFg4A=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(38070700021)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?v5FiqrFmkJIhQa6vnmsieRdRUPA23tvL/NUAmj7UuqgZY8GzMOPmchOzEe?=
 =?iso-8859-1?Q?CYo3zEBvTWKdbzJP/Fylmz5cr0ylm2rXMo4/Rg7LlVMtFWVMXj8WuZ3DNT?=
 =?iso-8859-1?Q?4GfGHxYN/utcZTKw82Sr7zxkxezbfCEY39RZeqMN2IBNClZlOe4U3af+2U?=
 =?iso-8859-1?Q?jzdXS1jZSFqCb8EjdDEMJA0mfS3XxTUAfcLMBsoo3hlvFtkLQSvg1WPPpd?=
 =?iso-8859-1?Q?y1iaudDNwmerRlAVdEFfFrymUbB33W3qX3LNzP6mYK7sVsYqNx94sjRzTe?=
 =?iso-8859-1?Q?3Z6s1aRcEEcu2s9+JEYUtHuz+9fkLX5p7zBuwcplQTcgzs/XITHyPZ5h1g?=
 =?iso-8859-1?Q?430L959JZtr6TVFDp8c5en2GlVJlLLo4bSvtLAdjNz5Gt/SwerM5QWs0aY?=
 =?iso-8859-1?Q?jUnPswiBshJkSgWZoOF+vBE/U2DkjXmB1mcuim+Uw5jnn2lkVKqklpLgw9?=
 =?iso-8859-1?Q?G6jdFwO3+ef+sXEB2z5RLw7L5/uWYSZkcCJSlOeg7Ao/LNJOWVWfEAAiTW?=
 =?iso-8859-1?Q?fhohQsRXulCnk3Si7b38rATo9m9TwAIeVLXVNTTSw0UqbF/8j6RnHIWczc?=
 =?iso-8859-1?Q?0pHQ+T9dcQqzv8Tm2KfNQzS7xkBFc/Rzo31s01CoP67H24uNHmIUbHvA+y?=
 =?iso-8859-1?Q?U9hFewKeNQ3Wgy1Vkf6Pxq2wuD/6vtZW4UoLb5zzlblxBwOLF9ryTai+x5?=
 =?iso-8859-1?Q?8ueAwB34F/79+zCyLAOD44jhBhJj4zvxtape5cv8OtF/UVD1k+FnhQhDCK?=
 =?iso-8859-1?Q?fQXoNPnjR6pWQCg9nQtvog+++U4bGl9iTl5xqVd5VMhxm4WRO/vT2xaKd/?=
 =?iso-8859-1?Q?tlLEqQcd3vnX39Lxeu+77LkA2MdZcMnMsd42bRHWgRZ92HDaDXAcZC9GsO?=
 =?iso-8859-1?Q?iYX1hC0DvOcwPbbVhisVr+ok0LBblDlkBkzPxLZNN+3UBuLHDtpup224QV?=
 =?iso-8859-1?Q?9i1PaihG0xtmHTEt/4QZ9zVcfpnyf05xAkNFMqczq/REHBw2VQGobRc6ds?=
 =?iso-8859-1?Q?NEHeznpRVoi6y/v0XP1DFPVojUl+y3a5thkTMQXiuiajvrdazRh1gm4bt/?=
 =?iso-8859-1?Q?dgOmhiQ0EpNGGkt3AaSpzbWQ5Jrv/80o4vtIL60HvvKyuXGnCEulAOWAyB?=
 =?iso-8859-1?Q?jEs/wYHtIj3mwIPku4KCku/9czv/Y7z9wlIzvTIyPPIpqeqyjUqXzu9DLv?=
 =?iso-8859-1?Q?TMFGe/YV8RqTjhbOcRDbH8po/YDtvva3gdxYFKEVUYTxWjLAKj4Y7MADVw?=
 =?iso-8859-1?Q?APNjvH+E++jWRRvhQgoTgqhbS5W42JNw1CEe7QCIHJaY6WJZsp9DaqFjMN?=
 =?iso-8859-1?Q?u0Y7Lw1PmM59yRg6xjdgc/mEY9aEfLab39ByL+xQENhYk9vRt18U4os9Bp?=
 =?iso-8859-1?Q?CX7DBG7jxaZKusavp1NJrAsYGjn9XIgm2XNcuGWaILk3AW5TADSdq8Ed/Z?=
 =?iso-8859-1?Q?fuHACz4vbY/O6M4Q1CoZFUeJ01c2rXWvuonxBsJvvEvd7ljb0DbaBxSPly?=
 =?iso-8859-1?Q?kRTrduzFMzWYM5uXqmOKFKkpBKSR8XJFO4oqHm7XJyQgSBmLRdIdNF80hv?=
 =?iso-8859-1?Q?QdxMmpYZ4K8uS4WCm/aYUNGfDdjiAz2UYvKozUCBGEi0bomYYw0OJG1Zxr?=
 =?iso-8859-1?Q?agkC7weRlsupM6S64eqk9emqVR/BRuoTtny6PHouuoWXoG3MBYpHGqwCpQ?=
 =?iso-8859-1?Q?mclqk5IJwHqi3eWPp06j/nqTNlg+T4oF7IEAOMUmVwqBuPQbUUrLDBSuxY?=
 =?iso-8859-1?Q?+DAybe8ggjCMmZ0RV/GYhmZRoh7Gc8ssjfFEMQGltgsRMa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	oLTWY1uLmp+o8uQEsB5EHLnJHGcqoajb5TD8dMUYputMpJ++LgnsplFmNdrYoCY+YcGA0M5TvFNStB+SNRFf055fVKYAls3tRAo75rvs/MJIs8t2TTUpjh3kokytqpSgn8v6FtYxbkV8X7LmkVHITWj511Y4wsI4F5Jgdr80Scc9adQIRhxhBvOws5eqO1lojchpOdXZdPrTM9o3CSD35evVxRaIzXVS6Yei3x/HypFAZD9duNG9IyAbn/ZUvzqgH6P89sVzRdBVerNw5XUyaZCF/k59ax4MG7RAjqp3dwyW06YcYmwJD6fsTjMyivF/renzluEXyzdGeG39K1TEZw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b05f413-b423-49e5-70f5-08def84a1632
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 08:17:01.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umvxRuc+0B5gMB7b//UYYy0bktEkOKOg4INrCyCmmtHESH8hDYlQxcTfJ6QL4L3Yj9c43oTSk1spa1gzVL/RLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-4.cisco.com [72.163.7.165];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 08:17:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19913

The checkstatus() path reuses cached connections for HTTP requests, but=0A=
uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability=0A=
check therefore creates a new TCP connection and performs a new TLS=0A=
handshake.=0A=
=0A=
Add HTTPS equivalents of the existing cached connection and request=0A=
handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and=0A=
extend FetchConnectionCache keys so HTTPS connections are kept separate=0A=
from HTTP connections, different certificate policies and CA files, and=0A=
different proxy tunnels.=0A=
=0A=
Add a local TLS self-test which proves two HTTPS HEAD requests use one=0A=
TCP/TLS connection. The test also verifies that a connection established=0A=
with certificate checking disabled is not reused after checking is=0A=
enabled.=0A=
=0A=
In an ABBA benchmark against BitBake master, 4,283 remote sstate=0A=
availability misses averaged 761.639 seconds without this change and=0A=
254.742 seconds with it. This reduced the check by 66.55%, a 2.990x=0A=
speedup. The benchmark had no matching mirror objects, so it isolates=0A=
availability checks rather than download and unpack time.=0A=
=0A=
Signed-off-by: Fredrik Svensson <svsvenss@cisco.com>=0A=
---=0A=
 lib/bb/fetch2/__init__.py | 18 ++++++-----=0A=
 lib/bb/fetch2/wget.py     | 57 +++++++++++++++++++++++++++------=0A=
 lib/bb/tests/fetch.py     | 66 +++++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 123 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py=0A=
index a5772f8a..ea007f36 100644=0A=
--- a/lib/bb/fetch2/__init__.py=0A=
+++ b/lib/bb/fetch2/__init__.py=0A=
@@ -2127,26 +2127,28 @@ class FetchConnectionCache(object):=0A=
     def __init__(self):=0A=
         self.cache =3D {}=0A=
 =0A=
-    def get_connection_name(self, host, port):=0A=
-        return host + ':' + str(port)=0A=
+    def get_connection_name(self, host, port, connection_id=3DNone):=0A=
+        if connection_id is None:=0A=
+            return host + ':' + str(port)=0A=
+        return (host, port, connection_id)=0A=
 =0A=
-    def add_connection(self, host, port, connection):=0A=
-        cn =3D self.get_connection_name(host, port)=0A=
+    def add_connection(self, host, port, connection, connection_id=3DNone)=
:=0A=
+        cn =3D self.get_connection_name(host, port, connection_id)=0A=
 =0A=
         if cn not in self.cache:=0A=
             self.cache[cn] =3D connection=0A=
 =0A=
-    def get_connection(self, host, port):=0A=
+    def get_connection(self, host, port, connection_id=3DNone):=0A=
         connection =3D None=0A=
 =0A=
-        cn =3D self.get_connection_name(host, port)=0A=
+        cn =3D self.get_connection_name(host, port, connection_id)=0A=
         if cn in self.cache:=0A=
             connection =3D self.cache[cn]=0A=
 =0A=
         return connection=0A=
 =0A=
-    def remove_connection(self, host, port):=0A=
-        cn =3D self.get_connection_name(host, port)=0A=
+    def remove_connection(self, host, port, connection_id=3DNone):=0A=
+        cn =3D self.get_connection_name(host, port, connection_id)=0A=
         if cn in self.cache:=0A=
             self.cache[cn].close()=0A=
             del self.cache[cn]=0A=
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py=0A=
index 141c2d06..ad98d967 100644=0A=
--- a/lib/bb/fetch2/wget.py=0A=
+++ b/lib/bb/fetch2/wget.py=0A=
@@ -151,27 +151,54 @@ class Wget(FetchMethod):=0A=
         return True=0A=
 =0A=
     def checkstatus(self, fetch, ud, d, try_again=3DTrue):=0A=
+        check_certs =3D self.check_certs(d)=0A=
+        newenv =3D bb.fetch2.get_fetcher_environment(d)=0A=
+=0A=
         class HTTPConnectionCache(http.client.HTTPConnection):=0A=
+            def cache_id(self):=0A=
+                return None=0A=
+=0A=
             if fetch.connection_cache:=0A=
                 def connect(self):=0A=
                     """Connect to the host and port specified in __init__.=
"""=0A=
 =0A=
-                    sock =3D fetch.connection_cache.get_connection(self.ho=
st, self.port)=0A=
+                    sock =3D fetch.connection_cache.get_connection(=0A=
+                        self.host, self.port, self.cache_id())=0A=
                     if sock:=0A=
                         self.sock =3D sock=0A=
                     else:=0A=
                         self.sock =3D socket.create_connection((self.host,=
 self.port),=0A=
                                     self.timeout, self.source_address)=0A=
-                        fetch.connection_cache.add_connection(self.host, s=
elf.port, self.sock)=0A=
+                        fetch.connection_cache.add_connection(=0A=
+                            self.host, self.port, self.sock, self.cache_id=
())=0A=
 =0A=
                     if self._tunnel_host:=0A=
                         self._tunnel()=0A=
 =0A=
+        class HTTPSConnectionCache(http.client.HTTPSConnection):=0A=
+            def cache_id(self):=0A=
+                return ("https", check_certs,=0A=
+                        newenv.get("SSL_CERT_FILE"),=0A=
+                        self._tunnel_host, self._tunnel_port)=0A=
+=0A=
+            if fetch.connection_cache:=0A=
+                def connect(self):=0A=
+                    """Reuse an established TLS connection when available.=
"""=0A=
+=0A=
+                    sock =3D fetch.connection_cache.get_connection(=0A=
+                        self.host, self.port, self.cache_id())=0A=
+                    if sock:=0A=
+                        self.sock =3D sock=0A=
+                    else:=0A=
+                        super().connect()=0A=
+                        fetch.connection_cache.add_connection(=0A=
+                            self.host, self.port, self.sock, self.cache_id=
())=0A=
+=0A=
         class CacheHTTPHandler(urllib.request.HTTPHandler):=0A=
             def http_open(self, req):=0A=
                 return self.do_open(HTTPConnectionCache, req)=0A=
 =0A=
-            def do_open(self, http_class, req):=0A=
+            def do_open(self, http_class, req, **http_conn_args):=0A=
                 """Return an addinfourl object for the request, using http=
_class.=0A=
 =0A=
                 http_class must implement the HTTPConnection API from http=
lib.=0A=
@@ -185,7 +212,7 @@ class Wget(FetchMethod):=0A=
                 if not host:=0A=
                     raise urllib.error.URLError('no host given')=0A=
 =0A=
-                h =3D http_class(host, timeout=3Dreq.timeout) # will parse=
 host:port=0A=
+                h =3D http_class(host, timeout=3Dreq.timeout, **http_conn_=
args) # will parse host:port=0A=
                 h.set_debuglevel(self._debuglevel)=0A=
 =0A=
                 headers =3D dict(req.unredirected_hdrs)=0A=
@@ -231,7 +258,8 @@ class Wget(FetchMethod):=0A=
                     # If it still fails, we give up, which can happen for =
bad=0A=
                     # HTTP proxy settings.=0A=
                     if fetch.connection_cache:=0A=
-                        fetch.connection_cache.remove_connection(h.host, h=
.port)=0A=
+                        fetch.connection_cache.remove_connection(=0A=
+                            h.host, h.port, h.cache_id())=0A=
                     h.close()=0A=
                     raise=0A=
 =0A=
@@ -265,10 +293,21 @@ class Wget(FetchMethod):=0A=
                 # Close connection when server request it.=0A=
                 if fetch.connection_cache is not None:=0A=
                     if 'Connection' in r.msg and r.msg['Connection'] =3D=
=3D 'close':=0A=
-                        fetch.connection_cache.remove_connection(h.host, h=
.port)=0A=
+                        fetch.connection_cache.remove_connection(=0A=
+                            h.host, h.port, h.cache_id())=0A=
 =0A=
                 return resp=0A=
 =0A=
+        class CacheHTTPSHandler(CacheHTTPHandler, urllib.request.HTTPSHand=
ler):=0A=
+            def __init__(self, debuglevel=3D0, context=3DNone, check_hostn=
ame=3DNone):=0A=
+                urllib.request.HTTPSHandler.__init__(self, debuglevel, con=
text,=0A=
+                                                     check_hostname)=0A=
+=0A=
+            def https_open(self, req):=0A=
+                return self.do_open(HTTPSConnectionCache, req,=0A=
+                                    context=3Dself._context,=0A=
+                                    check_hostname=3Dself._check_hostname)=
=0A=
+=0A=
         class HTTPMethodFallback(urllib.request.BaseHandler):=0A=
             """=0A=
             Fallback to GET if HEAD is not allowed (405 HTTP error)=0A=
@@ -370,12 +409,10 @@ class Wget(FetchMethod):=0A=
         # Avoid tramping the environment too much by using bb.utils.enviro=
nment=0A=
         # to scope the changes to the build_opener request, which is when =
the=0A=
         # environment lookups happen.=0A=
-        newenv =3D bb.fetch2.get_fetcher_environment(d)=0A=
-=0A=
         with bb.utils.environment(**newenv):=0A=
             import ssl=0A=
 =0A=
-            if self.check_certs(d):=0A=
+            if check_certs:=0A=
                 context =3D ssl.create_default_context()=0A=
             else:=0A=
                 context =3D ssl._create_unverified_context()=0A=
@@ -384,7 +421,7 @@ class Wget(FetchMethod):=0A=
                         HTTPMethodFallback,=0A=
                         urllib.request.ProxyHandler(),=0A=
                         CacheHTTPHandler(),=0A=
-                        urllib.request.HTTPSHandler(context=3Dcontext)]=0A=
+                        CacheHTTPSHandler(context=3Dcontext)]=0A=
             opener =3D urllib.request.build_opener(*handlers)=0A=
 =0A=
             try:=0A=
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py=0A=
index cd50c37a..fd064743 100644=0A=
--- a/lib/bb/tests/fetch.py=0A=
+++ b/lib/bb/tests/fetch.py=0A=
@@ -1781,6 +1781,72 @@ class FetchCheckStatusTest(FetcherTest):=0A=
 =0A=
         connection_cache.close_connections()=0A=
 =0A=
+    @unittest.skipUnless(shutil.which("openssl"), "openssl not installed")=
=0A=
+    def test_wget_checkstatus_https_connection_cache(self):=0A=
+        import ssl=0A=
+        from socketserver import ThreadingMixIn=0A=
+        from bb.fetch2 import FetchConnectionCache=0A=
+=0A=
+        class HTTPSRequestHandler(http.server.BaseHTTPRequestHandler):=0A=
+            protocol_version =3D "HTTP/1.1"=0A=
+=0A=
+            def do_HEAD(self):=0A=
+                self.send_response(200)=0A=
+                self.send_header("Content-Length", "0")=0A=
+                self.end_headers()=0A=
+=0A=
+            def log_message(self, format_str, *args):=0A=
+                pass=0A=
+=0A=
+        class HTTPSServer(ThreadingMixIn, http.server.HTTPServer):=0A=
+            daemon_threads =3D True=0A=
+=0A=
+            def __init__(self, *args, **kwargs):=0A=
+                self.connection_count =3D 0=0A=
+                super().__init__(*args, **kwargs)=0A=
+=0A=
+            def get_request(self):=0A=
+                request, client_address =3D super().get_request()=0A=
+                self.connection_count +=3D 1=0A=
+                return request, client_address=0A=
+=0A=
+        certificate =3D os.path.join(self.tempdir, "certificate.pem")=0A=
+        private_key =3D os.path.join(self.tempdir, "private-key.pem")=0A=
+        subprocess.check_call(=0A=
+            ["openssl", "req", "-x509", "-newkey", "rsa:2048", "-nodes",=
=0A=
+             "-keyout", private_key, "-out", certificate, "-days", "1",=0A=
+             "-subj", "/CN=3D127.0.0.1"],=0A=
+            stdout=3Dsubprocess.DEVNULL, stderr=3Dsubprocess.DEVNULL)=0A=
+=0A=
+        server =3D HTTPSServer(("127.0.0.1", 0), HTTPSRequestHandler)=0A=
+        context =3D ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)=0A=
+        context.load_cert_chain(certificate, private_key)=0A=
+        server.socket =3D context.wrap_socket(server.socket, server_side=
=3DTrue)=0A=
+        server_thread =3D threading.Thread(target=3Dserver.serve_forever)=
=0A=
+        server_thread.daemon =3D True=0A=
+        server_thread.start()=0A=
+=0A=
+        connection_cache =3D FetchConnectionCache()=0A=
+        try:=0A=
+            url =3D "https://127.0.0.1:%s/test" % server.server_port=0A=
+            self.d.setVar("BB_CHECK_SSL_CERTS", "0")=0A=
+            fetch =3D bb.fetch2.Fetch([url], self.d,=0A=
+                                    connection_cache=3Dconnection_cache)=
=0A=
+            ud =3D fetch.ud[url]=0A=
+            self.assertTrue(ud.method.checkstatus(fetch, ud, self.d))=0A=
+            self.assertTrue(ud.method.checkstatus(fetch, ud, self.d))=0A=
+            self.assertEqual(server.connection_count, 1)=0A=
+=0A=
+            # A connection established without certificate checks must not=
 be=0A=
+            # reused after certificate checking is enabled.=0A=
+            self.d.setVar("BB_CHECK_SSL_CERTS", "1")=0A=
+            self.assertFalse(ud.method.checkstatus(fetch, ud, self.d))=0A=
+        finally:=0A=
+            connection_cache.close_connections()=0A=
+            server.shutdown()=0A=
+            server_thread.join()=0A=
+            server.server_close()=0A=
+=0A=
     def test_wget_checkstatus_same_origin_redirect_keeps_auth(self):=0A=
         server =3D self._start_checkstatus_server()=0A=
         server.redirect_url =3D "http://127.0.0.1:%s/b" % server.server_po=
rt=0A=
-- =0A=
2.55.0=0A=
=0A=

