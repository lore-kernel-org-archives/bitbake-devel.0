Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81606C5B572
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 17:04:08 +0000 (UTC)
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.294.1786554240792293007
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 10:04:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=ajLA/BL8;
 spf=pass (domain: cisco.com, ip: 173.37.142.94, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11342; q=dns/txt;
  s=iport01; t=1786554240; x=1787763840;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=mc0ELW5hfqVYZ+MGeVxFQrh2kWqiNhiHpkwMMxavzPY=;
  b=ajLA/BL8u0IGcQnx076cBIqTziH0gK6loAmSsZbjgK0Xx1K9sUMEKB3Q
   mcdF/VAJQBAREXeqQYA5QHDRjBLEIlnH3QKA7UOHHLslv2psJEBRIKmLb
   +g0XZlgFDTcGz6aYrktOLEDUt1zWZ+w/pvB7Ug4O/fBJ95oi4u459SvKe
   +GXGEMKv9Gj8zW+a46IY4x9ylYvBHmsVL/8DbD05EEImuFrTgJsIZt03U
   siJQj8dxCrZ6OW8xDyMocKuqoCSbHHCIR7XgEcrbdVCejNoyGmKM+8+z5
   i8cofRF+NZZfgMleno9K459F4FfVLoBFJKZwvKE6v8pQqiHiZ0Biu5va5
   g==;
X-CSE-ConnectionGUID: ODOUdFENSYCEw7y5iZLtkQ==
X-CSE-MsgGUID: UYfC1dMdS7WrbMFgBaCRUQ==
X-IPAS-Result: =?us-ascii?q?A0AoAADGpXxq/48QJK1aHQEBAQEJARIBBQUBZYEXCAELA?=
 =?us-ascii?q?YFtUxZyAoEhSYgjA4RMX4ZYgiGBFp0IgX4PAQEBDQIxIAQBAYUFAo1nAiY0C?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Thk8BDIdsAX8nBBMIg?=
 =?us-ascii?q?nuCdAMBArd9AolLGjd4gTSBAeAsAQsUAYE4AYhcAYV4hHwnG4INgRVCgjF2h?=
 =?us-ascii?q?CsahBOCMASCIoEMgkiCFIEXjQ2BShwDWSwBVRMXCwcFgWYDKi8tbjIdgSM+F?=
 =?us-ascii?q?zVYGwYFgR2BKIQ2Ixk2fIEJYYErKmYSF4EJgiQCgnaBKmECAR4LbT03FBkDB?=
 =?us-ascii?q?IE1BY1+IIJDAQEBWSEUKgGBIIERkwyReaF7CoQejCGVcBeFW6URmQgjo2eFD?=
 =?us-ascii?q?gIEAgQFAhABAQY2gTI8gVlwFYMiCUoZD5gHxjV5PQEBBwIHDgMLgWiRfgEB?=
IronPort-PHdr: A9a23:M6rTVRZLWHnCr8dAqgiEFib/LTAchN3EVzX9orIuj7ZIN6O78IunY
 ArU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+WXU=
IronPort-Data: A9a23:/p5y3q9r6nc4IkVMGWnNDrUD3H+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2VNWW6OaPqPNGGhc9EjaYTi/ENV75+AytNlT1c++3xEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mvyyHjEAX9gWAsYjtOs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kREaol9shaJ1p/3
 tEHdyFQbyKnm+GPlefTpulE3qzPLeHiOIcZ/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cOHWjOX9PYH46tPy2nWfydSZDgFmUvqEwpWPUyWSd1ZC9aIaFJIPRHZU9ckCwm
 1PI1D31Jx0ha+OFwx+r/VilrdXypHauMG4VPPjinhJwu3WZx3AZAR4bEFe2v/S9okq/QM5Eb
 UsM9ywjqKI/+ECmQp/6RRLQnZKflhcYX9wVF6gx7xuAj/KKpQ2YHWMDCDVGbbTKqfMLeNDj7
 XfQ9/vBDj10u7rTQnWYnop4ZxvrUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:hyCuyax3JTA+StmuEV1tKrPxP+gkLtp133Aq2lEZdPULSL36qy
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
X-Talos-CUID: =?us-ascii?q?9a23=3AKSlyNWvtu3SCWJfK2cmcyWQ76IsCXlrgwFn9BXS?=
 =?us-ascii?q?JIkt2F6zISG205KBdxp8=3D?=
X-Talos-MUID: 9a23:bokDkwmiK//D0t1KM6PudnpfBclDuqiLBHtSro8MnueLHyVbAQqk2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 17:03:59 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-06.cisco.com (Postfix) with ESMTPS id B12D118000255
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 17:03:59 +0000 (GMT)
X-CSE-ConnectionGUID: 3rNRDeo6RUijwDpWfPt+WA==
X-CSE-MsgGUID: zAIn70ZkRryqwsFkJ4YgTg==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="83503717"
Received: from mail-eastus2azon11011042.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.42])
  by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 17:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8q3AChgOtWc/r8oQWbqMMLcICyH6v+M8rTRznFKNX8QYJwlo8JLnC/imn9Oj0Ek7F3g9bFgnk559VmIilbUSzFkXZA6+tiJOZdxdkMfd2+/KnsoxJh64DzzuD9nQvHitpt6tCKv5IPTzRsGXQYIg8C9bLrw84U2Xx81arBFUseP/ckd+skWoIBzLOOhl99VXwcKQTw+/4sSM+euJDRlHYcOV9qo8iLUhwrDAOwe1QtV6uy10NRw7KeUSNF8WeNUeeuYFK5XmD0HbWHF+RjczIaprq9e9KwPS8MZolxp4bKvcJ0K3RIwRe0a95+jMvOSlSy0IMBcDRK3b3oXPTGWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc0ELW5hfqVYZ+MGeVxFQrh2kWqiNhiHpkwMMxavzPY=;
 b=VZlaUyH3tiSPb2+faJO2Gyk1kaS+Aw+GM+mypLFdEJWac8FWhsC+3jDJPGOsR306EMK3WXabNi/pLpjKng1y6NtgvMs+4I7En3YnUxYGEKiZatIPBugKRfgTeA7Fst+vD1vCYeNLmU4uH7DiiAXLhV0PZfAJcc1bToR5lC5Lo5Sk1JiX8tb+/4Pzwc8zxCW3pTkwJrI5T1FeC4cgySRHwpuKiP0+X2YSJHh7n9x5MJTzfFFTK5SZgm/4hvPFme52Sro/8Bzm2UpzA89q0jRRW+putyU6wge2HORoE2SGBb3jlRBot33PdsF8HdHGu63gQeaSuBZUnGZaweE9Whf5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 17:03:57 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 17:03:57 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: 
 =?iso-8859-1?Q?[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0con?=
 =?iso-8859-1?Q?nections?=
Thread-Topic: 
 =?iso-8859-1?Q?[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0con?=
 =?iso-8859-1?Q?nections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMqw==
Date: Wed, 12 Aug 2026 17:03:57 +0000
Message-ID: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: 7601d747-236b-4467-5a5b-08def893b2d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|18002099003|56012099006|3023799007;
x-microsoft-antispam-message-info: 
 U0CnEkl/iu6EwLSQdA+xxaXOWKafEQ6hVmSiwVdp2E/5oKQae2BbmBvqzsyU6bAOoKxNUHdGHc9zaAUnCGaNitBtw6XPhkSTv76zcyTGXYFrPWRsHgFA1BavSYRlupI0QM/sTvTCDd/RebLmleetDkEIKj6fxeHpvi25BZ2Z5GOOrTe5MOCP4R2T3fxpBQreqjfM+JXYL+tOCi+lOqPbkp/1YpD4DS2xsTICze+Wp4LSdFwEEd/TpOaGQalQCF1HuOTuH9jBYvCCil+i7kCXMc1efCGhezp25mdxJTCrR/oEZ6VJwDq4zxnSshA/U83OQV8gAhaD7S4SgyCkUQXOOApUi8ey4lzdBMhXNxrrHmPE2QCmNjCB6L5hG1YVVe+rr5kM38IyjAW8YoIPo9KWOpvzQfzP1trySGFaGMBmgXWw68NWD3LTH2EvpThFNKO0sfcYonjDpjUa+lTv+czQY4KJh9/Pcp1Sxgu/HU5EcoDJFUYSd6LpfW+VazYfWmlodHvzHd6dMcR93vAmAvDpe8T8hU5XJmO0Fqhl85cHN+reHk/au+iOJcughMRHJZpGlfq1pwkKy6jUGn3o4qmxkF4yIFez7LU4bYkUTZ/aJJmLxHPzTYsW2oqDzD/PDvGqJtRGmc6Jq6inUXhESoymcdALKEJEh7Z9H7JFhHApOsYmRVKmdTKkMy7uWAKUl2YPTgABoByWyNjWbLmqwX9/By2XpwJSRw3RhgsbzEMXG6E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Mw/D7B4mjvuDfAs7M4LEYtNx5YU4/Bs5z1YGBrgf0AhX32srUy26P2sSst?=
 =?iso-8859-1?Q?tv+VWClxK5vii4Nuh0wUNHt0XdmVyyKuc8rXlyet8wO5wKSy7ZaBq60sV2?=
 =?iso-8859-1?Q?R9XrrpS72F1Yur6HjOMjLh55iW1TM1xWRji7ZNQl45Q0Aea2mUt8c8xdsb?=
 =?iso-8859-1?Q?l063Sd2Vdc/s0angtjaoZxxpHy1hE5L5db3ifqrUl+O1kFkgmGNrKiS12S?=
 =?iso-8859-1?Q?DFVPwyFD3f5gCLvuTdXJ8joSqP1zRxOKVrjOIW7a5NPFmvVAaM0UraED1Q?=
 =?iso-8859-1?Q?oldQKgA/0ve7jQJZBOhYy8eiIU5GfMIQ9xDjdUaKGNVqR+UGDFTG2ickt/?=
 =?iso-8859-1?Q?rQI6hXbYZgqTpQ9g+Y7c/c5w9MCVE4BJpX9lDlZkY5xikgBtuanGRpk1Ea?=
 =?iso-8859-1?Q?w+ae3sXabxBZE5qwRGTaR5mkIVGWwwobnKzXqRGazTj2kC/eOUwRsRQJsT?=
 =?iso-8859-1?Q?vmtQzOzLqjBI+PlOgSTcWWuyKIvG+68DUYTDGh61ZtMMN4xsyKhB1D8JDz?=
 =?iso-8859-1?Q?PbE8gan2GPpmesZgpDI9zbJ9qZfRXVsSPwth0c0i+fh6I4jfSH0ULw6Oqi?=
 =?iso-8859-1?Q?MEL98uJ85dHMM7bYOwxRzqBweaDU3PHWUXn05pV3cfYqOf/8ktWvEpIgER?=
 =?iso-8859-1?Q?/YbfR/UQQSqDDNvIdvRklnppPuMUF5m2cG4ei4lgZFcKurrXWqpSPdtiIT?=
 =?iso-8859-1?Q?FVEIU+Bg9VKwbZnAfTjo0nV2RMqxGLtSC1lxAxL+p4fxp8aJ1u5sO1tKLT?=
 =?iso-8859-1?Q?BRc3IvKIKGG+iF+vSIv+sG0bSgZCMSKTqjclSCP9QcNiw/c4bV18R7L35P?=
 =?iso-8859-1?Q?QW16ul0USyAaNN9KWsssdeJOcsSHqfD9d/GjfiD4O7FkH7a0HAC2OHxcNL?=
 =?iso-8859-1?Q?L4J1/o0jkjTb0LCgL5WYL/81gxSUHwaAZ8m07l+d/7lazGSKz8dKL1v6Rw?=
 =?iso-8859-1?Q?hZpEKy24goxsAW1gSqJ3ggEmaY2hCxwVadYaOoXkKQzA4RjMhZWM7nBsNr?=
 =?iso-8859-1?Q?KCslawJVShWeAEAnmECtNWMXwlLmtXglFGV6NPdmp3yxWGxNNw8w8EyWkr?=
 =?iso-8859-1?Q?nAFIkvSy6LS+zj88/8BpEcJcwF8TWxEzut7MotZE9i1g7UCDC2Iygz0ZbG?=
 =?iso-8859-1?Q?vO/tuCbJLYvFx1Ou6fx6dSTmcgdAjzrppViohYsKGPxDqTJalGoGfDHU/2?=
 =?iso-8859-1?Q?os0FjOLVLuT/TA8535lyiaB44kubERn1AGdMKG1RlFphbNcDIirQnCGvZk?=
 =?iso-8859-1?Q?prS2wDYIzS1FhqKnwW/CtOc7hVksXE2vCbFwwoNLqGtOAdW/eexZUSHndi?=
 =?iso-8859-1?Q?MivituX5UxjOBjAbyabnU2w2maao8VANKHXLfFDQQr1qNoYDe4hD1jsqOP?=
 =?iso-8859-1?Q?e6wtCJXlSZxejiFVtD7MuNIlMeGn36zkrffBPQDWiNMyzHmnG89F09SaU2?=
 =?iso-8859-1?Q?KdpQ/9b/uwDK6OGX9h7rQAVFAsTFhyANbA70+ZXeaHWG8rntgdnn2BB8UU?=
 =?iso-8859-1?Q?8qTh664G5FUKLAIaNt5miMfu8B0LCGs717DA/tZ2Wv4vQ+4Ulvt1SBRh7V?=
 =?iso-8859-1?Q?2DmzWRMnYRgFocYjJpgL/GzY4HWXBD2LFQO9REEvfyZ6rOo/O3LaTsGFX6?=
 =?iso-8859-1?Q?IdpUVcRILbPiMCNGsLDaCwXwkbfOnGijrRKy3s4Z41c7nYcW/qXR+oN17d?=
 =?iso-8859-1?Q?iQqZXCLjwdStP2BA9bfLVKSyh8d6urzPJu5+KsJTtwjeYQ0rhbCu6Episi?=
 =?iso-8859-1?Q?rCxBCf9O6meJfYwSe7Msq8eoc3z4ZgE481O9PqEgNkbatO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	qtLtm/rVOujDxSriq94RXnc2DwrAVmnr3zrpFiQen8rwpZUoyb6AU+iCftDLu+ET0Rjqp8FdW1BjY4ptKVwvUgULiD5tLI5YvKwH6VcAIYFWts118slQxaHjvZ1TXp010S6+7jIcpUd9F5kM4aY4G/vZFCosoyynD8Gv01wLM/qiDLNrl9UEuI1zN9BfrvqDF/pk8qc+N1FeyAARm8GoSsaeUuMbob7KMo75PtScdeAdDSZ9GBZf6h8gj5cknrwypnt1e1WTjxynEiSn5BAFD2zmSe/q6anMDASwxLisG5lLCCfjJZROm25sYO3DRiy6jjvvNk+esEVN5E61tnHKIA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7601d747-236b-4467-5a5b-08def893b2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:03:57.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tg6AZxeAeVqSTUJlqtiJzVbnFSNam5Qln47Lhs4tajK/giEzDeaKgCqNi+neQLiaDFR6RngbfDNGKUpYPt430Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-4.cisco.com [173.37.147.252];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 17:04:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19918

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
Changes in v2:=0A=
- Avoid urllib.request.HTTPSHandler's private _check_hostname attribute,=0A=
  which is no longer present with Python 3.12 and newer.=0A=
=0A=
 lib/bb/fetch2/__init__.py | 18 ++++++-----=0A=
 lib/bb/fetch2/wget.py     | 56 +++++++++++++++++++++++++++------=0A=
 lib/bb/tests/fetch.py     | 66 +++++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 122 insertions(+), 18 deletions(-)=0A=
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
index 141c2d06..c4534b05 100644=0A=
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
@@ -265,10 +293,20 @@ class Wget(FetchMethod):=0A=
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
+                                    context=3Dself._context)=0A=
+=0A=
         class HTTPMethodFallback(urllib.request.BaseHandler):=0A=
             """=0A=
             Fallback to GET if HEAD is not allowed (405 HTTP error)=0A=
@@ -370,12 +408,10 @@ class Wget(FetchMethod):=0A=
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
@@ -384,7 +420,7 @@ class Wget(FetchMethod):=0A=
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

