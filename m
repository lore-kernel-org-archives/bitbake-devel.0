Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B4C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 20:18:39 +0000 (UTC)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21607.1786738717494106894
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 13:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=E9RXiplp;
 spf=pass (domain: cisco.com, ip: 173.37.142.93, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1546; q=dns/txt;
  s=iport01; t=1786738717; x=1787948317;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qWIeFacxDj7F6Dp10cACscNr2MBeK7XCCC+6+htv5Xg=;
  b=E9RXiplp4h4yQzBjSTfVdHaQs5iAL1k2WS4aOEUf3bdl96zre7WIKX5v
   kD7tB9Z3rqwK5Tii2AYX/uoir0t1Hvs/4ii3SEo3MfMUj+NQxZO9rEIDJ
   cvVvPSQTa7ZYm5Rf+PlGNpmvia+e4TqOPdgNTU/LoQlZIoJsJURRpjJIB
   tmX+0x5Y+tzZcVoir1PEq0Dir6DOcl1cB68WxxhNFNHA378TAUEZBBOBW
   wmfnH5UWOTVE2Vy0qgHlD6rqnl1iJgJnC0LwPoLctSy3ukIxsM7ucKwah
   ERj7hyv0/SqPnyt1/ZMHDq6ehBSaqNSO9/PMXxknibXhosx69qYAYK2Fy
   Q==;
X-CSE-ConnectionGUID: GNJq/2YuTVWwyYOkLdBAYg==
X-CSE-MsgGUID: T8VaZddxR4KjFjfiq0NJEA==
X-IPAS-Result: =?us-ascii?q?A0AeAAB7dn9q/5AQJK1aHAEBAQEBAQcBARIBAQQEAQFlg?=
 =?us-ascii?q?RcHAQELAYFtUxZyAoEPEkmIIwOETF+GWIIhnh6Bfg8BAQENAjEgBAEBhQUCj?=
 =?us-ascii?q?WkCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGTwEMh2wBf?=
 =?us-ascii?q?ycEEwiCegGCdAMBArgkAooceIE0gQHgLQELFAGBOAGIXAGKdCcbgg2BFUKDJ?=
 =?us-ascii?q?2mDQhqEE4IwBIMuhF2OO4FKHANZLAFVExcLBwWBZgMqLy1uMh2BIz4XNVgbB?=
 =?us-ascii?q?gWBHYEohDcjGTZ6gQlegSsqYhIXgQmCEgKCc4IGAgFJDAttPTcUGQMEgTUFj?=
 =?us-ascii?q?hAggkUCgQQKLJVakVyCIZ9aCoQejCGDCZJnF4VbpRABmQgjqHUCBAIEBQIQA?=
 =?us-ascii?q?QEGgWg8gVlwFYMiCUoZD5gHxjV5PQEBBwIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:tf2r+hQQjKV4uagguhH8CeZI69pso47LVj580XJvo7tKdqLm+IztI
 wmCo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:PcOXD6PcVB66zZ3vrR35lsFynXyQoLVcMsEvi/4bfWQNrUongmQGn
 WAZXjrVPPmJYmX0e4x2YYrl9kJUv5/WytJkTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV7lV
 e/a+ZWFZgf1gmIsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69pILlhxZ7wFxthIHnB/0
 v88JBokXx/W0opawJrjIgVtrs0nKM+uOMYUvWttiGmGS/0nWpvEBa7N4Le03h9p2ZsIRqiYP
 pRfMGYzBPjDS0Un1lM/E4wlguqunWLXeDxDo1XTrq0yi4TW5Fwpj+OwYYWOKrRmQ+1pzniRl
 G7K716lIRM0NtKe0GKj0F+F07qncSTTHdh6+KeD3vRrnFeaxWFWBBAIWF+TpfiillX4XMpSL
 UER8CcioaU+skuxQbHAswaQqXqAuFsYHtFXCeB/sF7LwavP6AHfDW8BJtJcVOEbWAYNbWVC/
 neCnsjiAnpkt7j9dJ5X3u78Qe+aUcTNEVI/WA==
IronPort-HdrOrdr: A9a23:sBkoNasqw7VMO2PNbNMJ/agu7skCZYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRZVoIUmxyXcH2/hsAV7EZniqhILIFvAp0WKM+UyaJ8STzJ846U
 4CSdkzNDSTNykBsS+S2mDReLhQoqjjzEnCv5a5854Zd3ATV0gW1XYBNu/0KDwQeCB2QbACON
 634M1BqzC8eXIRQPiaKxA+NdTrlpngrr6jRQQJKSIGxWC14A+A2frXAhKY1hARX3d1x6s+8W
 /Kqgr95q+ymfC2wB3R2gbonttrcd3apedrNYipsIw4Oz/sggGnaMBKQLuZpg04p+mp9RIDjM
 TMiw1IBbUz11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFst6g55DeBex0TthgDg86t
 MJ44uqjesTMfryplW42zEObWAsqqOAmwthrQfUtQ0YbWJRUs4JkWVVxjIrLH5JJlOF1GlgKp
 ghMOjsoNBLbFidc3fV+kNrwNCqQzAPOy3ueDlbhiRQuAImxkyQCCAjtZcidntszuNNd7BUo+
 vDKahmj7dIU4sfar98Hv4IRY+tBnXKWg+kChPaHb3LLtBxB5v2ke+A3JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTcmDxodC/BzBSHi0GW2F8LAU27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH/
 K+IohfDfPvJXbnXYxJwwr9UZ9PLmR2arxchv8rH1aV5s7bIIzjseLWNP7VObr2CD4hHnjyB3
 MSNQKDUPmoLnrbL0MQrCKhKU8FIHaPja6YOJKqjNQu9A==
X-Talos-CUID: =?us-ascii?q?9a23=3AZZoOEWjN2mljKR9FyZR1O00gTjJuXVv/1TCKElK?=
 =?us-ascii?q?EN1l2WYyySnuc0opVnJ87?=
X-Talos-MUID: 9a23:/mKzVQVW7Y2ArhXq/AO8ujhQOMt42fiNCm4Pn5Qf4++mGAUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Aug 2026 20:18:36 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-07.cisco.com (Postfix) with ESMTPS id 61914180001FD
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 20:18:36 +0000 (GMT)
X-CSE-ConnectionGUID: Tigz79qcTBGxJn4XGG+oZw==
X-CSE-MsgGUID: K1uTYzCLQraYn6eJdUQC/A==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,222,1779148800"; 
   d="scan'208";a="62969547"
Received: from mail-eastus2azon11010052.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.52])
  by alln-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Aug 2026 20:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYWUxzMxkGsqkTZbJ1ViK9o+dcMpoXlERFdStb970Vuo/TvuMt02/nm1JBA1uDkmRlU9VJ/laUVeNHpEejKGMCNVQPTCqihx2VQelLzbFTTCD2GqGHUh3YXpMk5Z1kN7sn5iQ0SoWQ/AkSAA0SDtEAUoR9250N5+iE6hjJmu3UNckajz6UJwjdLSVl00mtKrUnBoDzCVT5bqjs/bWw8TW07cqrPfKOvKmEJHW9tSxQwWJ9HTtVfCbPBJ8xL3qNNXSPFgsuIoCGrZIl4Jc3WZftgoyCPNMoypZNnkgLuhsMxjGQ5nXsTF554+gaSKLS+AwDDjaI1YcGxL8E/zGHruFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWIeFacxDj7F6Dp10cACscNr2MBeK7XCCC+6+htv5Xg=;
 b=CphZMMt5GCodPLd3DiupeQ6T8MroDSHmccII9vhmZA2KVV9kVP7UJ18F1YuQeVo3kFqJ8m6H2Ms7Y2Rx+4DNFPOjOGa2b1sYyjPZ0E8DMESq2foyMFwOJbzx8lb2zjhgBxcuWunLWGXw0/7owUqCvDpR3LNAw9pvU3aYYSUFUi4woFgFSQhP06fKKuMy6kY2bwwkIpw9LcHM93UGeog8LVLZ8k0Duu7vyWz+JRaC2PqjndorW4ARzpGL/+u2eqYuvvlRBMwTJH4W5bXTNHh+aWEZBFQV/l0myPiDhlo8wK36mAFkMoETiPF94yPEYZ5Md3sS/WQSgjHYtll39R/rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by DS4PR11MB9601.namprd11.prod.outlook.com (2603:10b6:8:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 20:18:34 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 20:18:34 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] tests/fetch: report OpenSSL certificate generation errors
Thread-Topic: [PATCH] tests/fetch: report OpenSSL certificate generation
 errors
Thread-Index: AQHdLCnTSN88whG+xEuWObCeYbQa6Q==
Date: Fri, 14 Aug 2026 20:18:34 +0000
Message-ID: 
 <DM6PR11MB3962E55724AA2F8BCE00B58FCBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|DS4PR11MB9601:EE_
x-ms-office365-filtering-correlation-id: fa38aaf5-198f-4f40-044e-08defa4137b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|11063799006|56012099006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: 
 nYedSGsFOnUrPEQPNWxR+JKNCkSxxqL2102NzrU3b6TIF+59C1EHS0rK8Q/LYpt3J2cTM99Z2k5A3xMqo5pD+cnWdX8WXdIgjG0Tn9EmoR9wQvjUC1+FqtVH06vpkCKkmpc1qx78nMYhrYV4WkK6rcxjwtYrXvLSVu96Em5sm0qbNkElqINeFjN9qpBhXPyL+UJNohmBlRbGwLUJyWW9LhWAVfKMAWu6/AetImgpIW7VIM2+v+2dyN+VVd/0trrl5MRMY86k2rXSGn0uYft3axlwwlYoA6hLE77bRYT3hm7MCNvJwnVBsyTLQyK81Y8tdq7QIENUuHhxyrjjzfNr7045DgroGZ+vQ57gsglbS+MNhDUYayeFtITOWNVfv6zvOEmIbIRlbMYJ6rYcJL1uaGxyBeCNxIndLTAiH4qzwtaoe7vqpLZvd63Tp1QCmiuIkwVRLtGT9F6zXoGaVkkNko3QPR1Zt9qoNVftEAcNw5qlEV6Fg9cEZirZRJQQiMVMteLMtTK4x5V+Fyt3QYmRIENyvaEoj9hMNoNMPOjYu+RHdxhWFFoqHZefMw1c6oUKjJ67wB701X8VKkLo81zWXOwz3+zBeHm30mdY/WKQ6rny0wj54zq0PRTgSo0nig9/qMfIUJ8YAUUbkEljxBUTz+eIlwzcbn+uRzcWUWQmd8DsYgHoAOKWUdEzj+g2EsSE9gkrCnvSVbJV2STfi5j0N7Dcn9+tZpZtXCnqIQiBf3k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(11063799006)(56012099006)(3023799007)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?M3qpvwqSNjf1E58+1yXDNtdBDB3eH9bJpZcHDG0Z4ZzzR/66E5REVmhkD1?=
 =?iso-8859-1?Q?toauKaSXP1BhD1l7qcEm8+cgl25I4x3uMK9DHA8ZmS2ZD4+3iZ9kgkDzeP?=
 =?iso-8859-1?Q?65FaVGjheUip01XNxZXTNgCMdI9SbCTzb8BKK3mPAaL2isrWFKbWSEDRWp?=
 =?iso-8859-1?Q?0JT3S57fRVw+Wy19kuFfl0qPHrmPCo/j00gYw5xgrmwu0B3VmFI4yEyewA?=
 =?iso-8859-1?Q?HzUk/T+wSVsCI4zHSpz2eCH2ohAD7s36RkdSBJcjilHaRZSgn9IR6EMyrq?=
 =?iso-8859-1?Q?ndWfY+JrX39ESXf5JEwm0fwQkSu6tzF88AwKeQsMEis7M2EeTUSKyjHsIo?=
 =?iso-8859-1?Q?8O6CUgWkM3C3nGesOdjJ9nKzfjhW3p5Ho1RqHooz+dnZcyoikxVTt2nXHn?=
 =?iso-8859-1?Q?HF7Jo+3f9eXsZEigW4HUwldHNFnG9kp6fha8uCnJ+wEXcLEDEI7RZ2lpb1?=
 =?iso-8859-1?Q?NT/2b6tHtr1RueqEnv1H82j+Bmw0I8G+OhoXwJyvsZkOYoY9oMT+bZwbIH?=
 =?iso-8859-1?Q?czCJxSZhyxe4bcYwMn5hfp6B4T5pyzVA544gcRed8ND/D5648qHrRRdFc4?=
 =?iso-8859-1?Q?LWJskwN2+E0mK2fQcoYM7gJNsmrMiCCZfZn+jLGvi206/m9ux6kZ/CBoUY?=
 =?iso-8859-1?Q?PwMtX0CyhCWWXYTgahdz6karK4pLIE4eQROTxHpl17JOcuLwenKkWD7Abu?=
 =?iso-8859-1?Q?4G+P0OkBVx6MNwrwJJZAT2KqdWJrL1Xhj8q0ToUP6yFRYodboyWXaqCB67?=
 =?iso-8859-1?Q?GLs4iqA5aCJyS8isbxAyBgf98cwV4NtTLyQh1uh50OOcOk6uOGSWQdEEdE?=
 =?iso-8859-1?Q?HzD6QJAuIQUJJht1H7/DWo2vsoPx/L7qbfwx8Z9mS8nja92qtH9N1W6p9l?=
 =?iso-8859-1?Q?QWzwwYgZ3ijknDKy3qDsy75073jVxty/X/sQEVVmOl15WUzRbBfRPLk58o?=
 =?iso-8859-1?Q?pKvCZR3GzriTyIDJGSn8bWLPDsIsAjxaU+9yN0r1Ss6W3aWhWiVIBDTc8h?=
 =?iso-8859-1?Q?eKOMGmHMYmAZlttmj0mgTYhRaumxgpbg41CkRm9os5jq6rDl4TRhtkhcmX?=
 =?iso-8859-1?Q?8zDkX6xrSdyFcGg/WwypYO/rsqsIBxd0fyXyVlo09EHkt+BADIcqdQPuCS?=
 =?iso-8859-1?Q?BPM9ZDzKqtpoj4X/TkCimOCZKix4v7aVMaJGHoCtf4k7GRkFjqaxomqNrX?=
 =?iso-8859-1?Q?5QPzinb5TKepHfz/BBNGxdaLqyUwM5zzZ1vhg7XrnPYQmYEPgb0/mAt1NP?=
 =?iso-8859-1?Q?JRrjJig0EvgW+xYXgzUsaanXxZHZYe21gqYs9RB7LVt7yJPZex16iJ4pYc?=
 =?iso-8859-1?Q?KhvxzjYrGeI92+MM4FxL//vwOhsrAqkXZnLWIjcQ+rA3EKBmpm8hHqgv1r?=
 =?iso-8859-1?Q?uJe3Na1aVyQcnKVbtsksuSaRJRtB1DNiBQoaLliSkEocfBbv7J7WcYgkFx?=
 =?iso-8859-1?Q?I1dN5DKg8Nckrin5DIxRJXlcMYd0jpwkregC4lcny3xxzdOTDL0cFCfKWr?=
 =?iso-8859-1?Q?iaIBWCmycS2V7YZ/5NxUCl8HPYXpaOR4fWOMnMwZJ4EqE51xHgpvem6KF3?=
 =?iso-8859-1?Q?BQ2AzZf7AXDy6Wa6O5kNG+ilqtG5mpPqOddXCfST4KYs0502d2LgiGZ9RY?=
 =?iso-8859-1?Q?k3MJadQYLgwgj7lSXsi8K1v2bSWiG73V9GYo5UTZqJHp4wdzqUNngtApAi?=
 =?iso-8859-1?Q?32HWZI9Gt/oBGCr2vyAWKOlm6TtOAcbJnoovRhLIdaKVFOhQ0y+J++JQaL?=
 =?iso-8859-1?Q?Ufpn7yKmpQwIl+11qhOMbj0xQ857RGBFikN9YMgXE3biaZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	NTmkFvW1WQXN2W7aXxZc3aSZtjXWXg7P5OYD5dDZXnWMuA5WY/yFEurCWA9ZQJYkaehOMmNf1Sop/8rQyPQ3zIG63qE47RJ+Se8FBd9x9+3T6UCaE/P/AFIFnB9A75FZFaoh9SD7L6eJjUBc0o+I2cu4lfzPryuGtr0/FSxIOetQHIoYCiE8ybNX0y9EYdu+PS0DF8neJ06EysPI2kU65TxUCRPz1hsXzhO2TOAPhj6rrrV9Aj273sxY4ZdY75Jp4fUYv69kvitLNgsQ3PEQ4wiWf8YyJ/Sx0H9XWadxZ/DNLJXEWxaS5hBauHd6JiDWp3hhGVvlmaP40K+mQQbJYA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa38aaf5-198f-4f40-044e-08defa4137b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 20:18:34.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEaXmDk90eG5HSsN7jyUaDed+Xt4qYz85k7yYHW02FjuU+zkdU8I9Tb9viVKmaw71TsMMCVRKIRRRDSVuV+HVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9601
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-5.cisco.com [173.37.147.253];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 20:18:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19946

The HTTPS connection cache test suppresses all output from the OpenSSL=0A=
certificate-generation command. When the command fails, the test reports=0A=
only its exit status and hides the information needed to diagnose=0A=
worker-specific failures.=0A=
=0A=
Capture combined stdout and stderr and include it in the assertion failure.=
=0A=
=0A=
Signed-off-by: Fredrik Svensson <svsvenss@cisco.com>=0A=
---=0A=
 lib/bb/tests/fetch.py | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py=0A=
index fd064743..a1e4b45f 100644=0A=
--- a/lib/bb/tests/fetch.py=0A=
+++ b/lib/bb/tests/fetch.py=0A=
@@ -1812,11 +1812,13 @@ class FetchCheckStatusTest(FetcherTest):=0A=
 =0A=
         certificate =3D os.path.join(self.tempdir, "certificate.pem")=0A=
         private_key =3D os.path.join(self.tempdir, "private-key.pem")=0A=
-        subprocess.check_call(=0A=
+        result =3D subprocess.run(=0A=
             ["openssl", "req", "-x509", "-newkey", "rsa:2048", "-nodes",=
=0A=
              "-keyout", private_key, "-out", certificate, "-days", "1",=0A=
              "-subj", "/CN=3D127.0.0.1"],=0A=
-            stdout=3Dsubprocess.DEVNULL, stderr=3Dsubprocess.DEVNULL)=0A=
+            stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.STDOUT, text=3DT=
rue)=0A=
+        self.assertEqual(result.returncode, 0,=0A=
+                         "openssl certificate generation failed:\n%s" % re=
sult.stdout)=0A=
 =0A=
         server =3D HTTPSServer(("127.0.0.1", 0), HTTPSRequestHandler)=0A=
         context =3D ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)=0A=
-- =0A=
2.55.0=0A=

