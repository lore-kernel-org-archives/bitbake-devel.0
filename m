Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE8C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 03:50:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mx.groups.io with SMTP id smtpd.web11.20043.1716781809989338165
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 May 2024 20:50:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=Nhldi9c0;
 spf=pass (domain: intel.com, ip: 198.175.65.15, mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716781810; x=1748317810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iLl/4v1pm8qxRjSimlW4tm2eHO0+x0wrHkEvsTsIkSY=;
  b=Nhldi9c0/iZYpelsJL13cn27cyBF2kl4acw+qDzCrZ+hYyCRj6BV+2aX
   ZSp6CZzKjYp/qoQ1tKLbFe5m3v94NnDy8/1UiRW0P3W7H+3YW5T18X5v9
   W43xWUFGYmcHV/hOr3llxezZbu/2zobYg9AJ9RtND/h78dON7n0yoEk7/
   zhbr0HovJjRk9GXpC/CPDUKLffEJTNs597oYjYHLJuNg1jEUvkcNU9N4y
   GDc2SZStFuMQUOJHSNROgbGNExigF4D/FLECnWuDk5fraYUl+jZnX0tz8
   b6Zu1mvlE+/6hRauuxjSHBLPuUWx1O69w+L+tuK5oGk2kVyI7QGHPo+SR
   w==;
X-CSE-ConnectionGUID: 5SHHA4biQIanXOvPp+5hjw==
X-CSE-MsgGUID: wdDUwjaLQR6rRsdLGeo3YQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16871603"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="16871603"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:50:10 -0700
X-CSE-ConnectionGUID: 97gTEkW4S+SkTgXmFyWBJQ==
X-CSE-MsgGUID: /qUO0A8yRd605CFyQUNC8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34704932"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 20:50:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:50:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 20:50:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 20:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWFPPpgbEpKSP1jvZ5iEyaUkcojs2SH2cBxEbFpn+wPRrd2GTXnBHPRh/Q6hk81jq3NLaeWAnBIwDKlLcy3Ufss0/lBK4wmKOvYUcxaukW/3+rt2+ZpnnX8BCpIuKHzqwU1bWrfuUaH3awC7jHzQQkICHP0seK5A3wPKpxl96IK7Pm1n7AlQfCXyu0wcfxhqB95uKJuCZXWCAjCB6SfB6Pvw3fDGDOgb+XNJoHsoVCHinWIXICw+tAeCa/f7y9kYucom5g+WCQz5tOaf/oGyggQ2jVVK7mcXNuDPfGYS0ykk4O2OoUK9c+5ZTM4SwSBpGanLGN5px1olAM3hbSJ8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLl/4v1pm8qxRjSimlW4tm2eHO0+x0wrHkEvsTsIkSY=;
 b=Xot1Oqy9c/NqqnMTLlc74mgOhO9vjkr5DT0FQGRDSkjcjU7ftVjeNo9R5ssGB1U0Yr3AaEETQVo78V9bVaYyh3oci2Qw3KB/SiWHWMAsYRJrGoI/ygla27IMwRGkvp+mIqHbFn0N/hsOqRuHduptVfZabBpsgX0yvHQ3K6Wcz5WPM8tkFv0JP6lROE/ZpPa4AG8wUtumoRdfdQ0L1aO8fG3unWw36p0KQ1D7nqKJPW2u6GOf57YH4FLOQzhwhRe+5RxUwChC3FaBsxV1/zJjMPtOkKGoQPpKokfCdtwnBohguitCi4ZQ1Q09s+dC/47Ev/kyStOQfvyTDqeztk5qBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) by
 DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Mon, 27 May 2024 03:50:07 +0000
Received: from DM4PR11MB6430.namprd11.prod.outlook.com
 ([fe80::9378:e70c:77ca:d46f]) by DM4PR11MB6430.namprd11.prod.outlook.com
 ([fe80::9378:e70c:77ca:d46f%7]) with mapi id 15.20.7587.035; Mon, 27 May 2024
 03:50:06 +0000
From: "Mittal, Anuj" <anuj.mittal@intel.com>
To: "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
	"alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "mlynch@hi-techniques.com"
	<mlynch@hi-techniques.com>
Subject: Re: [bitbake-devel] Dependencies ?
Thread-Topic: [bitbake-devel] Dependencies ?
Thread-Index: AQHareJpmEPn+DIu7k2rdMND7kZnzrGmbbMAgAAMiQCAA/vqgA==
Date: Mon, 27 May 2024 03:50:06 +0000
Message-ID: <3a15c1e4247e35bf8578f0ff55418a414409fbab.camel@intel.com>
References: <lfcT.1716559062178660500.wc5p@lists.openembedded.org>
	 <afdd4a7a-8e55-4519-9ce6-7d09e50c0d44@cherry.de>
	 <CANNYZj_XF0cXbK-nVeK=xpd8_XC07j-FC8rovvips085M1OMHQ@mail.gmail.com>
In-Reply-To: <CANNYZj_XF0cXbK-nVeK=xpd8_XC07j-FC8rovvips085M1OMHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6430:EE_|DS7PR11MB7931:EE_
x-ms-office365-filtering-correlation-id: c1dad83e-1506-46ef-ed48-08dc7e001936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?U0txUDY2M1RjOVZHUVJzcWcya0ZRdHFaOFRCSmdKdmF3dVlYdW4yb3VLWDdR?=
 =?utf-8?B?Q1Jza1BBTy9XamJJVUZMc2Evd2E4TEMrSUxra043Vmd4UEd6ZzF5QklGVTVO?=
 =?utf-8?B?L0ErWFlKd3RRYkhvRUdpNEMvRHRxRm1ja253ZGQ1eElwS0xRZUQ5WTFTSTNY?=
 =?utf-8?B?b1diOWtYZVo5OUdMTEZacVNGY0JNejcxa0d6T0g0emNUcVlURk55aFFxMzdY?=
 =?utf-8?B?OTNrZXJ5b3Z6N1hGQUdFbFVEbGlGMzJhUml4dmo2bDFVRnJzQmxGSVl3Y0hW?=
 =?utf-8?B?dEd0b3hPcVJuSkxMMTlic1VaaDIrZTVtc21pUEpPMDRNVGsyTzFoWlBmOENP?=
 =?utf-8?B?TmJ6YkhhK1ZiUlE4eW9tK2IrcURPWGhmd29xZlVSOVZHWUY0Y0VpeDVWbWti?=
 =?utf-8?B?UTJabWFMMzNYQ2xneUJYMVlmL1N2b1NUWnJFQzErWjEwOENlMkN6Sk9HM3ZL?=
 =?utf-8?B?by9hMXJDR292Lys5ajhNNlNiOTNKSEluYUJZWHdoTXRGTkxieU16SHRhQmds?=
 =?utf-8?B?aTMzWGZDTS84ZlM1QkxIL29aNEZrRzNjOWZrdHVYT0s2M05LcUQyNU5rK0Fl?=
 =?utf-8?B?ckxvazNBenhYRnM2bmhzcXBEY3d0U2hmU0FOYkFlTUkxK3picVpuSjluMnBK?=
 =?utf-8?B?OXVDeWhEU24wTEdkeS9DN2h1b0JlbWNpbVdrNzQ0OFVyaFEzRVVUbzJNTG1l?=
 =?utf-8?B?dlFYNlJQWlpac2xxbmhZMDJWVFJnSlNsR3RLaEFQQytsWHprZTZnQUFoTFBp?=
 =?utf-8?B?SjRCSGYxR2l6cko3RnhqYklodDJjV1ptdEx2cVRUMFFhR2NVdDNabXBXUjdO?=
 =?utf-8?B?NU5WaDd3dlNVdWUxa09LWDFRSDA1S1gwZGJkYlRIbW1DcUVHdnpSdlEwZVBV?=
 =?utf-8?B?ZFlVNmRacHNScXRteGZGeFRHOC9EMFhKcS9FVS83VnBINjF2Y3RBcC9TcDcw?=
 =?utf-8?B?YjZublZtV1dCTzBnMVVxbXNKK053eXhIdHAwSDBOZXpiM1RlSkxleDlSclRE?=
 =?utf-8?B?RWxHaEtiSjlQTzczYmx2OWl1bTF4aThhOGRRWnJSZFpyZVlhRHFKeE1FZDh4?=
 =?utf-8?B?RGd5ZGE3V2tDcFd4WndTNXNYa0Z6K2xNVEUrSzhGV2RjVnAzbVNCZ2lnK1RK?=
 =?utf-8?B?RVZnN2ZsR01QckpqZVhVREJKalJTVmtFZ0diamNKeHRMRjZ1WGIrbnN3Vmtp?=
 =?utf-8?B?Q1ZLcXkxLzAybUV4bFkwN2JKSHptZXFrMWFRdlFEQmpHRlgzZEF3WTdIZ3JE?=
 =?utf-8?B?ODdzaTlQQ2UzSWM1clEydkRtMEJCSndTbTgwWTZWdlRIMEpxQUgvc2NXSC9B?=
 =?utf-8?B?R3drQ1BKQWx3N1dteGlZVEt4ZkQ5TXBkc2JHeEUwZ0xXMEsrc29pKzh5MU0v?=
 =?utf-8?B?UCt1d0tYWlVidGlnWGVKQWxKbGs4amZUOERNckoxcVFXcXJCcisrb05SaEd5?=
 =?utf-8?B?cmQxOENuZDhGNVVFaFR6MDlRbEpXaUpWNEtweGRQTGRXcjhJcEhhejQ0VUJl?=
 =?utf-8?B?OGlLVHNtNmxGUkpZN1dleXl4OWdsR0ZDcDViNDFzMk5TMzdyblMrdkN4QklO?=
 =?utf-8?B?cDdWN1B4M00ybStmeW1wQUdrMG01c24xMVlsUDI0YXBTSFhnMlRISG95cWdm?=
 =?utf-8?B?UHVrS080R2I0bUZuZHFFZ0JnRnZ1R3NPc0wwT1o4Zm9zeEtsaFlvTjBCNllj?=
 =?utf-8?B?bVAxV0UrS01rS0Qvd09TU1RCVDlHd293Z1RxdzVTcm1PZGpRNStHV1Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V08vdXZ4OStKTmpyeW4zZTVmMi94bE44eDVVdkdEQWNYVTZiWStYVC9mQ01J?=
 =?utf-8?B?U0NVOGVLeVpsYkhnRTY1ZzZQdzRuQ2phc3JxMThuSnk3akNJaXo5blZvSGNs?=
 =?utf-8?B?LzNYLzdFVFRDaEhtTm1Yc01hRmlLdzZ3dXhEdTlYTHNyN0hnUE1qRnBvSjRy?=
 =?utf-8?B?VHNqdWZzbjIyOUx5cU53elhiMS9WWjFCTjRxNzFYNkJacjFzR05sSGlIYlJJ?=
 =?utf-8?B?M2dZYXBVYzU1VWZYK29NSW55NFFTeUFIMmVqRWk2M2dDaW1Mb0QxZEVjMnVx?=
 =?utf-8?B?N01IU1J0SldoVmRkL1lKN2hDRVBOWGliQ0FmUjVEdmRMK3RlL2NaRU14ckZk?=
 =?utf-8?B?Zm51Wm1vekVQLzVsbTFlc3R2SVZxV0xkdWtST3lQVEJodEdrSitWdm4rVlRM?=
 =?utf-8?B?ajVlSzNCdFVVdEgzanhuNVpBSWlWZ3FMdzA0eVRwTkdZdmdLbTBpcE81VUVw?=
 =?utf-8?B?eXZKd1JBRHpGL3RpUkEwTDZ0T3NLaGVCZVNIS3B6OFJFaFV5c2QzK0VaUjRI?=
 =?utf-8?B?aVlFSTU1T1ZpdzZSalB4S1BNTkhneElOUEhyOGtFTU80T3dId2grV0Y2M2dx?=
 =?utf-8?B?c3pQT1FvVldNR044alhGYlBodE1wc3pjdnhITmJ5VkhReWVpWFpLOThWZlBx?=
 =?utf-8?B?NVV3SHNycytRL2NuUW5FMVFlYml3Sm16MmJhNGt4WmRYZG83SVIveERWK0lD?=
 =?utf-8?B?eXA5d2VrYk12Ykc4cjN0bExaLzBHOW5ybk8rd0U0K0llWjlYd3pNMnNsUk14?=
 =?utf-8?B?NHBQZjU3N2NZQS9KaGZicG9iNVpjMnNmV0FzSkJSZUlnWU9XSVAzWGZiTmlD?=
 =?utf-8?B?N0IvejBTNFVVM0JocEVSZ1JIaTRLbnE2VHNMVmdvSXpxaTZteDBZL1pyakFk?=
 =?utf-8?B?MVh5NmdNTjhMcTlMM3B5R20wdmVoRk9OKzZhM25UN0xZOEJIdE12cWhkWmtv?=
 =?utf-8?B?VURYUHNsTFRxcFJFei9kNkpRMXRRYlhYZkROV2FqMDBhdmlkTGFLM3lXaEZT?=
 =?utf-8?B?WHIwZktVM0IyYWEvMDBOVFlHS3VIbTVGSkd1L29ENWRhdXN5K1VnSm9LOGpB?=
 =?utf-8?B?bWF5bWlEZ0lyNDRNVE45eXhWaGxjM3BzMWdtZkE1MkZtcGpya05Md3RuQnAz?=
 =?utf-8?B?TTF4R2xlWVVUY2NMMWp1Q2V2Y3NzRi9QS0E3TjZDWVZyRUI1c1BaVGNDclI5?=
 =?utf-8?B?V0hBd0pVRUo5M1MvTWJjQ3BMRTByc1NuaDNYTVVhOXNObEFlMWJxOThiRWRi?=
 =?utf-8?B?NmFTVGdseHRsK1FCMFNONjVqRHpwcW9VMGN1Sk1zQ1kydUprL1k1RVhmL25X?=
 =?utf-8?B?MEd0MXFhQkVtV21xc3IwbldDb0x4UlNjQ0dDeDJCZlZNQ0Q0czF1SUxYUHJ0?=
 =?utf-8?B?UjdkZGZXNTE0LzZ4cm1vbnVuMGNhTkEzdGJSOGxzQmpQVVNrREEvTEdDUTl2?=
 =?utf-8?B?Zk5GN1FBeTA3NUxDaG55bGdyUmNCMjQxVEVxMTFjUlRjOVV6S25WcmNNSkdk?=
 =?utf-8?B?SEhxWVltbWRJcHlGUUY5eEVzTUZJUU1YbkpZY1dFUSs3K1o1TUVvWE1UdG9s?=
 =?utf-8?B?dGxJNVltODRYUGpVUU9DYnlvKzZuV2ZveEVmajYxc05Wd0tpQSs2TUZocnhN?=
 =?utf-8?B?eERCVDBqUHRUNUJYSXQrallMbHlEMEZpMUY1RHJTT3FUcE8vVEpTYVl3YmVO?=
 =?utf-8?B?TWdZUXRQZGpXMWFzdzlIRkM5TWhPRyt6OENkL2tkR3gvaWJqa0NrakQxNDgy?=
 =?utf-8?B?MTYxYnh3dnJvR05xRkM3b1ZIL093V2xFVCtOMEVTNHVicW5CL0RpbTlSYU9t?=
 =?utf-8?B?amVmU2piVEFjcTlRL2h3WWkvakluNTFkR2RuWFdoNnMyUWhUZDRmTVp4Umxz?=
 =?utf-8?B?OTA1SGp6cUM4b2R2NE5BdjlpbWErVnkyRzF1SUVKUmR0cys1dlFQeEQ3Qnpj?=
 =?utf-8?B?cmNyeEsyQlpQazVwYUVRUmNjQjFHZ09QZ1V2RFAwUFZzRjNmUlN4SzJxT3Bh?=
 =?utf-8?B?cnBHdVRGZ1dsSzRhczd2dU5KOGU3T1Y4WHJhUVVOcFRNNGdXT2F1WmZKN0or?=
 =?utf-8?B?SWVRMFE4OEVZVHRHWEswaUVRd0lLUlI4ZFM4MXZldGpHWTJoOEJrZnBYcHU5?=
 =?utf-8?B?TGFGT3JBS2oydGdjTHlGSG5PN3puS01DcHFLeUdvUjR6U1UrUzJxZEZML3NU?=
 =?utf-8?B?VWx1clgrMmpJUTh1RTBoR1dHK0F1QWJGNjhqMVdBRzBGYS9CeUwvMlc2NDls?=
 =?utf-8?B?WDRaMWU3SUI2NUFtb3pJaDBoVnNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DE58DE3428A20429032ED27C1A27921@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dad83e-1506-46ef-ed48-08dc7e001936
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:50:06.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RakyPesIU/eYDSuaSxq02Fr5pY2OoatUM/kVkafmgv6XBBoW5RMkaheQfw9Triyn6xJBasSMyOXUMLWtd219zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 May 2024 03:50:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16267

T24gRnJpLCAyMDI0LTA1LTI0IGF0IDE2OjU5ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gRnJpLCAyNCBNYXkgMjAyNCBhdCAxNjoxNCwgUXVlbnRpbiBTY2h1bHogdmlhDQo+
IGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCj4gPHF1ZW50aW4uc2NodWx6PWNoZXJyeS5kZUBsaXN0
cy5vcGVuZW1iZWRkZWQub3JnPiB3cm90ZToNCj4gDQo+ID4gSSdtIHN1cmUgbWV0YS1pbnRlbCB3
b3VsZCBiZSBoYXBweSB0byBzZWUgcGF0Y2hlcyB0byBmaXggdGhvc2UNCj4gPiBpc3N1ZXMgYXMN
Cj4gPiB3ZWxsLCBzbyBmZWVsIGZyZWUgdG8gc2VuZCB0aGVtIHNvbWUgYnVnIGZpeGVzIDopDQo+
IA0KPiBOb3QgZXZlbiBtZXRhLWludGVsLiBUaGlzIG5lZWRzIHRvIGJlIGZpeGVkIHVwc3RyZWFt
IGZpcnN0LiBUaGUNCj4gY29ycmVjdCBjb3Vyc2Ugb2YgYWN0aW9uIGlzOg0KPiANCj4gLcKgIGNo
ZWNrIHVwc3RyZWFtIHJlcG9zaXRvcmllcyBvZiBmYWlsaW5nIGNvbXBvbmVudHMgaWYgdGhleSBj
b250YWluDQo+IG5lZWRlZCBmaXhlcw0KPiAtIGlmIHRoZXkgZG8sIHRoZW4gdXBkYXRlIHRoZSBy
ZWNpcGVzIGluIG1ldGEtaW50ZWwgdG8gdGFrZSB0aGUNCj4gdmVyc2lvbnMgdGhhdCBjb250YWlu
IHRoZSBmaXhlcywgb3IgaWYgbm8gc3VjaCB2ZXJzaW9ucyBhcmUgeWV0DQo+IHJlbGVhc2VkLCBi
YWNrcG9ydCB0aGVtIGFzIHJlY2lwZSBwYXRjaGVzDQo+IC0gaWYgdGhleSBkb24ndCB0aGVuIG1h
a2UgdGhlIGZpeGVzLCBhbmQgc3VibWl0IHRoZW0gdXBzdHJlYW0gZmlyc3QsDQo+IGFuZCBvYnRh
aW4gdXBzdHJlYW0gYWNjZXB0YW5jZSwgdGhlbiBiYWNrcG9ydCB0aGUgZml4ZXMgYXMgaW4gcG9p
bnQgMg0KDQpVbmZvcnR1bmF0ZWx5IGluIHRoaXMgY2FzZSwgZml4ZXMgYXJlIG5vdCB0cml2aWFs
IGFuZCB1cHN0cmVhbSBuZWVkcw0KdGltZSB0byBtYWtlIGNoYW5nZXMgdG8gc3VwcG9ydCBMTFZN
IHZlcnNpb25zID49IDE2Og0KDQpodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvaW50ZWwtZ3JhcGhp
Y3MtY29tcGlsZXIvaXNzdWVzLzI4OQ0KDQpUaGFua3MsDQoNCkFudWoNCg0K

