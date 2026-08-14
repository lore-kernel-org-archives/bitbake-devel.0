Return-Path: <svsvenss@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248CBC5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 20:12:49 +0000 (UTC)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21557.1786738366514328577
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 13:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=k2z3LklU;
 spf=pass (domain: cisco.com, ip: 173.37.142.89, mailfrom: svsvenss@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7908; q=dns/txt;
  s=iport01; t=1786738366; x=1787947966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=vjE1HCo6LuVAhNKYTudd9Phk77/HJve/YSd8xYPz3bE=;
  b=k2z3LklU2TVMvZgLemtIEMSn9Hb9jCH9ky51Hpaur5OmFW2VU4osEo/W
   4d1oiYJsp8mUdeMVdvBBo9kzb1IGbh7fv6xuEoGYDcb4UcE8hWerY5ryU
   xOgGCRdkgIJCSBk7wZwMA2ws1A/Txh5V/1OKEcnU33Uc1RKe+IFH8d9vg
   OqvQmEseZWC5HuIm6RgXJ/ZwlabarK9o/X++4JaxTQnFYMWuU/A5bK1MF
   zTyNko/NnTk2JzJA+7mBHtPM7R91S86/lRN+c5l0sF4TJcvB5lHsHSXLa
   5FuX5htCgY8vCYHpbklogDK8wZ8zVbBs83xi/X8GVM8DbM63A91p/U5H4
   Q==;
X-CSE-ConnectionGUID: u/0aDnCtSxeNQDbgs6syQg==
X-CSE-MsgGUID: l6lcYrSzSkGbvzGju2QqIQ==
X-IPAS-Result: =?us-ascii?q?A0C1BAB7dn9q/4wQJK1aHgEBCxIMZYEgC4E9ATBTgQgCg?=
 =?us-ascii?q?Q8SSYgjA4UriHkDnhuBdAoPAQEBDQIuARUNBAEBhQUCjWkCJjQJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGTw2GWgEBAQEDAXgQAgEIEQQBA?=
 =?us-ascii?q?QEuJwodCAIEAQ0FCIJ7gh0WQQMBAg64FgKJSxo3eIE0gQHgORWBOIU/gx0BA?=
 =?us-ascii?q?SqBNYJdgSMZg12BHycbgg2BFUKCaT6CYQQBgV88g1eCMASCInoSG4IxPYJrj?=
 =?us-ascii?q?SRSciIDJjMsAVUTFwsHBYEjEDMDKi8tI0sFLR1wDCcSDx0XFx5YGwYFEiAqQ?=
 =?us-ascii?q?UQjAz44gQhBAoF1PyMZNnqBCV6BKyphAQIQF0YuFYISAoJzgSheAgFJDAttP?=
 =?us-ascii?q?TcGDhkDBIE1BY0uB1sggkUBAlkqCwcUDwGCMaMJgXyhewqEHowhjT6IMheFW?=
 =?us-ascii?q?6URmQgjjWeWAIUOAgQCBAUCEAEBBjaBMjwrgS5wFYMiCUoZD44tFohzxwZ5P?=
 =?us-ascii?q?QEBBwIHDgMLgWiQACyBUgEB?=
IronPort-PHdr: A9a23:ga0Z5RQqVuYOa5C5unbLonp+L9pso47LVj580XJvo7tKdqLm+IztI
 wmEo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:+nsxqKnjIDkfCo8gGXFy+0Do5gzdJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZCGrXOquPYmHzKopwOYjko00E6MLcnYBlHFE//ik8RFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpEsv7b8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZBfou9bB0pSz
 uwVDgkhZB+Y2fmn+b3uH4GAhux7RCXqFIobvnclyXTSCuwrBMiYBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkEXUrsUIMpWcOOAnWfkbTBes0m9rqss6G+Vxwt0uFToGIqNJ4HaHJsEwi50o
 ErCoWDyMwshJuec5jCb4F2um7X2hALCDdd6+LqQs6QCbEeo7mYSFBcfVlb+rfSnh0qWX9NEN
 1dS/TIjq6U3/kGnQtTxGRqirxa5UgU0Ut5UFag+rQqK0KeRu13fDWkfRTkHY9sj3CMreQEXO
 payt4qBLRRksaaeTjSW8bL8kN94EXF9wbMqDcPccTY43g==
IronPort-HdrOrdr: A9a23:CYs3gaE/cQqsMDBqpLqF6JLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhJk3I+ertBEGBKUmsk6KdkrNhTItKPTOW91dAQ7sSl7cKrweQfxEWs9Qtqp
 uIEJIORuEYb2IK8PoSiTPQe71Psbv3lZxAx92us0uFJjsaEp2Imj0JcTpzZXcGPDWua6BJc6
 a0145snRblU3IRaciwG3kCWMb+h/CjrvjbSC9DLSQKrC2Vgx2VyJOSKXWl9yZbfyJEwL8k/2
 SAqArk+6Wlvci8zx/Xx0XT455VlNaJ8KoDOCWLsKcoAwSprjztSJVqWrWEsjxwivqo8kwWnN
 7FpAplF9hv6lvKF1vF4ifF6k3F6nID+nXiwViXjT/IusriXg83DMJHmMZwbgbZ0Uw9p9txuZ
 g7nV5x9qAnSC8orh6NoOQgZCsa0HZcZkBSyNL7ukYvFbf2roUh9bD3snklS6voVxiKmLzPWN
 Mef/00oswmMW+yXjT+onRlxsCqUzAYGxeLRVVHh+muugImxkyQCyAjtZAidrBqzuNhd3FJit
 60QJhAhfVASNQbYrl6A/pEScyrCnbVSRaJK26KJ0/7fZt3cU4lhqSHqInd3tvaM6Ag3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTITH+mVTrgx8lC79wh04eMCIbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7vmIXH1EYhE0gXiU91ZKGUYUscSptEnMmj+7/7jO8nvrKjWYfzTLL3iHXItXX7+GG
 IKWHzpKMBJ/imQKzbFadjqKgXQk2DEjOVN+fLhjp0uIaA2R/lxjjQ=
X-Talos-CUID: =?us-ascii?q?9a23=3ACGuSN2jBs74uSkV5Ql0l/YuldjJubzqFxVvWCFO?=
 =?us-ascii?q?DGWtPcZGfRkTO47JdnJ87?=
X-Talos-MUID: 9a23:ZDpLoAnJGDsxqsKKC/LAdnpmasNj0r6VGnsOvp8YqeaGKHZJIhak2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Aug 2026 20:12:45 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 6E22F180001EF
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 20:12:45 +0000 (GMT)
X-CSE-ConnectionGUID: EepgeaZLSS+bMUvw0O8FTA==
X-CSE-MsgGUID: I0ZnOQfFTE2FJiyW3DT5/Q==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,222,1779148800"; 
   d="scan'208,217";a="62012625"
Received: from mail-centralusazon11010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.6])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Aug 2026 20:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D48eTNtryPsqWHa9zdaTku/5/EXWSjnm+dORrYnV1FZBnm4G34S4oMHQLEWhl4+QcoP2HfYMVmonfbYiXMMiQjxgNEbEVgSFmMCLjOBTVtyOmpAmjlCeSCtJ8LrlDzQhqwkxGdJSTdXmSrBt3/Ya6qwwnJn/k/ljUxissmYgF3BuO7+p5LfV8nL69nNuBJ+0ZgadqqPgyvD5b8TOxQE63UgqzcC+zSS8qRTaDtay2APZo4Kn9QYK58yRFOIhapeeyC+MgbFV5of7dGcv4Om84xk64ZCFMBafEnmLkJg4tL3pOtI6kG1JH0KJBcpLVDOT47AJ2d/TOwvU6ZtxTN9zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjE1HCo6LuVAhNKYTudd9Phk77/HJve/YSd8xYPz3bE=;
 b=huR8rsO8IxoabqwHrjuAYRjl7sper9IPGx1XpvahLfv7qjOp3DWhsXgul1XAKcBv9M/nF3j8uoVxK2c12Bxgc+WP4hw7v0SPL/KCF48cun2myTNMxCRL9xYJc4BAmZ6qY677ZxSRxMofFK1g/Kp8MR8zGd1sY64f+CrxdktYpMuO9lA+XFjOtKGOQG3619kYLNq3iekXxiThRKA1mzuw+3cU2gl0ZCYY9XPzjjvS4n0Pw3aCEL2+xVWPep70BxgSmtns9RgQEEU308SkQ1Z6sU0Y6tQfmMz0A2ARPvF7j1p1Jv1fe1PqQ1aBr0Ng+ncxMKjroFuyLHo6sNpZjLynfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26)
 by DS4PR11MB9601.namprd11.prod.outlook.com (2603:10b6:8:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 20:12:43 +0000
Received: from DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161]) by DM6PR11MB3962.namprd11.prod.outlook.com
 ([fe80::47f3:254:87ca:5161%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 20:12:43 +0000
From: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: 
 =?iso-8859-1?Q?Re:_[bitbake-devel]_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0?=
 =?iso-8859-1?Q?cached=A0HTTPS=A0connections?=
Thread-Topic: 
 =?iso-8859-1?Q?[bitbake-devel]_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cach?=
 =?iso-8859-1?Q?ed=A0HTTPS=A0connections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7adiqaAgABu5MY=
Date: Fri, 14 Aug 2026 20:12:43 +0000
Message-ID: 
 <DM6PR11MB396271299B36AB33F27D6BE2CBDA2@DM6PR11MB3962.namprd11.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
In-Reply-To: 
 <02b6e335731bb1bd9ddce4ce8867144c9491a2ed.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3962:EE_|DS4PR11MB9601:EE_
x-ms-office365-filtering-correlation-id: 06aac829-f4e4-457a-be0b-08defa406663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006|8096899003|3023799007|13003099007|38070700021|10067099003|6133799003|4143699003;
x-microsoft-antispam-message-info: 
 y/BfnpKrul0Yd0/mFyOxPydOM6BUVa7C0Lq2pHkE12FzPH0Q3P/jO4eq5rMlnvhuducjE+T/I7vC0f9na6cQH0XUe9CUaRPU5R/ODi7ilJrp6uJWVqc0eVDnm81erBRYZuv5I1FH6+UF2oH5aNs/5cn6FmVOLISg6ZhOL5c9KmPWXK8GjIvF2oIvAx4bLemDTf0ylXTvNkBDVc5HoC7Gs1LsnsP9thZoTE2TtcIibOhVOblXgrfwU4E2vBJxKYTI3OAGK7CKb4okfcZUVrQ52baBHOcQYbBzOqUEh5L6JvD5pU+Jsi/OOuAKaKSnDnZ40ER4USY6ZHtUhuk2r0iddOt1/pSQo5+rtZxRzwzBIFSFKkl8mIuLOjSSliH5UWq0Y2LSs5c5LFbSzF4jL1ctpEOBqJ5WKzLCYSO0d6CpjjahMCXZDQVUoljM1n1reaKNv6IlBDKOJaCcu9bh5p8amXd+JAGheumAthTVeg+g4zwiVt8eQpApSWnIEDkFN1u4bQmDit0jW2MhCdqpxpQsxN86oU7ESY4UKJZaIy01DRyJp0KTsPE82lBOzi8caZs7rxbXmH2D2z6SQYgdr13dpuD7gNxcTk9ZSWbVyTA8vj7LTOix59PaemBsYNij5jVZdqOL4s0XP1Jd8yJJstH7TUEGrgEoAZ5Nh6uKgltkcnY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003)(3023799007)(13003099007)(38070700021)(10067099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?NtTbgAhLgXrd28uNEpn++dc8WIl06DwvLozAW1f4daDQzl2Kf0AxFEcZFs?=
 =?iso-8859-1?Q?amux7QYIcy4vOaR4QhzANFI71SWh1dZx6tE6l1Rdk9B1N6orEe3L2lLA9a?=
 =?iso-8859-1?Q?piRtqCe+oDKPzjeZ9somDdczqgaqazTEVFx3Wvu0QGO+TYoEdcEu/5bptx?=
 =?iso-8859-1?Q?NZ+ukEY/m3d6v8DsvKiSc7nsQJ8tp6w6neeZSMS1zzMUsleQDb7bLLHvac?=
 =?iso-8859-1?Q?UI7YLY6EZVN3eKssnZn5inf9yd/J5SMFpUyX4Wco9ceWPPrcfDzVYbGml/?=
 =?iso-8859-1?Q?doI/F+w4Y98vxhbOvxtzVut0uJ9YzdJj2GVU+vIvat6AZBhgKZ6k7w49Nq?=
 =?iso-8859-1?Q?hooGRj2bOC8BMlrZydhIe8lQwXI6KaDlACmtbBqA/XWeEYlJF2QjfKur22?=
 =?iso-8859-1?Q?iukyCmpio0gbu9suE6u5AZJdHUcbG2QY/o6lyUiMZAfkbdpRG86mmhHFd0?=
 =?iso-8859-1?Q?boPjM0lREXs3NEq44i3LqKgvG3hNjQQkWSvcMGQKpl0jU/4N0q+ZVWCG6I?=
 =?iso-8859-1?Q?3pR1xa6Cz7QCdlweUz6vbENiLFidXIm3qctkChKdVzb3JYXuUpvX5JOxXN?=
 =?iso-8859-1?Q?0VpWqWBh2aUzpN/5XSySj6Wj9XU7e9TNKkccz87y4ezH5lJHI358QwAJ67?=
 =?iso-8859-1?Q?mS0C9a3PTzenKpUcdjgrs+zBNpyY5QWrOOmIHSaLkwtVWbQxnApzTbiVBx?=
 =?iso-8859-1?Q?aWL3tMajqKYJEF3fu19t4gYGXB9S0xJKZ30YkEsEOb6o0PKDdAUUiuKlPK?=
 =?iso-8859-1?Q?WjKOFNZ+k2ELIZQVUGgRP8cBlIaRQc1hKNWBxx7h9r3esX2HjFCZk+y4II?=
 =?iso-8859-1?Q?xh73ldSfpX/FVBP+D4sxZ2FLVK0JAgfMbreJxfhRZowUgLVpdMVZYGDIK5?=
 =?iso-8859-1?Q?3RgI4o/+RtuSWB0bKSQXczLvcyCGbsajXpofjZ1D1Y1rfGSXZSfzblP3GP?=
 =?iso-8859-1?Q?r7Ix/D6q39kMoimJNFUz7CHLbOn14uHyYgoNKLziBBkINrOpCNqnu98YCo?=
 =?iso-8859-1?Q?FUZgVeAaq5QPn6lCYtj4o/XW2O7MBQidtJa6njeSO0QyN4lNBJpXZ50327?=
 =?iso-8859-1?Q?eRYKUEQLSwMsyp2grkXmJLucNa14pEWNVvpF8/rMO79VsR+wUrShIFlV6W?=
 =?iso-8859-1?Q?XtPbnQGYPvQRDnz5NgCBydSd7Y2N9i8kKXQpyypGNvqhwBTvbEgkOsCZ6w?=
 =?iso-8859-1?Q?KwnbI0NVnmGvnA8Hqww4A+HIF16BgeluV/rs8ZHQniBE9YDZdwBSF+Sqbt?=
 =?iso-8859-1?Q?744dHjz3GpXK0q/VqxA26kXTP/hOVhmiSMcFRtKyGPUVOB+ToGQzGTEmHy?=
 =?iso-8859-1?Q?RCZ6Q35gHrUaGNnVveFEJ/5dU7/C33I/aOo7bpcRy0A3wkoMC23QI3Ixyz?=
 =?iso-8859-1?Q?dVRL8CzZWsN4FEpMN9IQRNnrTbCrTCKyM1J7cmY5rURYcg1tasx8Vb2XSZ?=
 =?iso-8859-1?Q?e5q/YC/3UkZ+Yz87cFPra3ywWT4P57ffv/VHefXJhe2mFrp3W4ULgW1lmk?=
 =?iso-8859-1?Q?4QEQEbeD2dW6T6Hycj43/s5sMZITfomQAFo1E/EMOfbYNjYpLGkBplNfd+?=
 =?iso-8859-1?Q?5QmtWZK97A3akddWYZJhvf7m0YM0WRokuUBC5JTuK3p/P46qFUu3ui6WH8?=
 =?iso-8859-1?Q?xOl2iagbLkffR/o8gwuLzICO07u7QPSNfS02FI0gSRY/Q1cR0VPt/kFpiu?=
 =?iso-8859-1?Q?UnqzmxUScgtBkYRoycWYTiqXLwCDJBvxcWteUUkpk7CLdFpCBTgRrMCp3p?=
 =?iso-8859-1?Q?oscEC2FIl1nyQFTq5ytSoVBZ854pSLn8wu0kS0SeJ/9Qoy?=
Content-Type: multipart/alternative;
	boundary="_000_DM6PR11MB396271299B36AB33F27D6BE2CBDA2DM6PR11MB3962namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	HJBuGnDa8PRzcMSQGlwt8/ahFuPWw9TpO6P4VgF5qM540FawF3W8HwTX44LxZ/+4pwD1VRFfpy6MUN71pqYq7+JbECZBvmxtsQHIxze4O+Sv9gkfBFLsNM/6eFfqo9mc2F2RE6z4NhmcD0fkJQe9EzWO8cR0FkDcQPJmutNcFLCRZrb4AL1D3lYDEvvy3taI9hlpZUFgS2ipvBOWOdNcYHpu3juvikcBOxrICLbHlibNrRB49XM/SNgKsNno6vu9c/ZmjIbhn/H+cb4GiNuIaNXISzqP+/wTvKOOQdvIf0Uv2aYjfWLJgPewtratfFSTGTt3sIVR91WATwKcghqDXQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aac829-f4e4-457a-be0b-08defa406663
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 20:12:43.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60cuhdyaw6maXNJPAHwt/5XU9cpuRc6JJCwQX58kqgWVIxQFiZhDBLFz0CYo1dfILByIz/Q+XWJj9oz9kjYn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB9601
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-3.cisco.com [173.37.147.251];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 20:12:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19945

--_000_DM6PR11MB396271299B36AB33F27D6BE2CBDA2DM6PR11MB3962namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The failure happens while the new self-test is generating its temporary cer=
tificate, before it exercises the HTTPS connection cache. Unfortunately, th=
e test currently redirects both stdout and stderr to /dev/null, so the log =
only contains the exit status.

I reproduced the command in an AlmaLinux 8 container using the same Yocto 5=
.1 buildtools, where it succeeds. This therefore looks specific to the alma=
8-vk-2worker, possibly its crypto/FIPS configuration or local state.

I will prepare a small follow-up patch which captures the OpenSSL output an=
d includes it in the log. A rerun with that patch should expose the actual =
reason.

________________________________
From: Richard Purdie <richard.purdie@linuxfoundation.org>
Sent: Friday, August 14, 2026 3:21 PM
To: Fredrik Svensson (svsvenss) <svsvenss@cisco.com>; bitbake-devel@lists.o=
penembedded.org <bitbake-devel@lists.openembedded.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/wget: reuse cached HTTPS con=
nections

Hi,

On Wed, 2026-08-12 at 17:03 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:
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

Thanks for the patch, this looked good to me and we did merge it. We then s=
tarted seeing:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4378/ste=
ps/15/logs/stdio

which is probably worker specific and occuring on alma8 (which we do
use buildtools tarball on). Have you any idea why that might be
breaking?

Cheers,

Richard

--_000_DM6PR11MB396271299B36AB33F27D6BE2CBDA2DM6PR11MB3962namp_
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
The failure happens while the new self-test is generating its temporary cer=
tificate, before it exercises the HTTPS connection cache. Unfortunately, th=
e test currently redirects both stdout and stderr to /dev/null, so the log =
only contains the exit status.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I reproduced the command in an AlmaLinux 8 container using the same Yocto 5=
.1 buildtools, where it succeeds. This therefore looks specific to the alma=
8-vk-2worker, possibly its crypto/FIPS configuration or local state.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I will prepare a small follow-up patch which captures the OpenSSL output an=
d includes it in the log. A rerun with that patch should expose the actual =
reason.<br>
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Richard Purdie &lt;ri=
chard.purdie@linuxfoundation.org&gt;<br>
<b>Sent:</b> Friday, August 14, 2026 3:21 PM<br>
<b>To:</b> Fredrik Svensson (svsvenss) &lt;svsvenss@cisco.com&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<b=
r>
<b>Cc:</b> Mathieu Dubois-Briand &lt;mathieu.dubois-briand@bootlin.com&gt;<=
br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH&nbsp;v2]&nbsp;fetch2/wget:&nbsp;=
reuse&nbsp;cached&nbsp;HTTPS&nbsp;connections</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
On Wed, 2026-08-12 at 17:03 +0000, Fredrik Svensson via lists.openembedded.=
org wrote:<br>
&gt; The checkstatus() path reuses cached connections for HTTP requests, bu=
t<br>
&gt; uses urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability=
<br>
&gt; check therefore creates a new TCP connection and performs a new TLS<br=
>
&gt; handshake.<br>
&gt; <br>
&gt; Add HTTPS equivalents of the existing cached connection and request<br=
>
&gt; handler. Preserve the SSL context selected by BB_CHECK_SSL_CERTS and<b=
r>
&gt; extend FetchConnectionCache keys so HTTPS connections are kept separat=
e<br>
&gt; from HTTP connections, different certificate policies and CA files, an=
d<br>
&gt; different proxy tunnels.<br>
&gt; <br>
&gt; Add a local TLS self-test which proves two HTTPS HEAD requests use one=
<br>
&gt; TCP/TLS connection. The test also verifies that a connection establish=
ed<br>
&gt; with certificate checking disabled is not reused after checking is<br>
&gt; enabled.<br>
&gt; <br>
&gt; In an ABBA benchmark against BitBake master, 4,283 remote sstate<br>
&gt; availability misses averaged 761.639 seconds without this change and<b=
r>
&gt; 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x<br=
>
&gt; speedup. The benchmark had no matching mirror objects, so it isolates<=
br>
&gt; availability checks rather than download and unpack time.<br>
&gt; <br>
&gt; Signed-off-by: Fredrik Svensson &lt;svsvenss@cisco.com&gt;<br>
<br>
Thanks for the patch, this looked good to me and we did merge it. We then s=
tarted seeing:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/buil=
ds/4378/steps/15/logs/stdio">https://autobuilder.yoctoproject.org/valkyrie/=
#/builders/48/builds/4378/steps/15/logs/stdio</a><br>
<br>
which is probably worker specific and occuring on alma8 (which we do<br>
use buildtools tarball on). Have you any idea why that might be<br>
breaking?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR11MB396271299B36AB33F27D6BE2CBDA2DM6PR11MB3962namp_--

