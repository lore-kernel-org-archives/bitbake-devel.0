Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B56C54E90
	for <webhook@archiver.kernel.org>; Sun, 25 May 2025 15:27:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.87])
 by mx.groups.io with SMTP id smtpd.web10.11043.1748186868520563457
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 May 2025 08:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=BEhprvOE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.87, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGyDFhJnTn+CKGA0t3RnCG72GqM5WXSwR8989q0MOeVc+bUXq4zM9kDdXt4jQSj/HEC6J2UrMUKZOgj3bnIcudVGeaYW+Tf6/+6m83pY8fm++vlwfTU/XBq/JvRY5udcJ7yPkJyDfSoGqWAd1MmAoVDMBEhjjaXjVwKP7aEMw8VQfLPzxNg0J15iOfoKVtMr4g8zk7rshE6FzPVV46QTbym3ouDmaug5v0n7zE2MrtRmZrrzsOYmxz5VIiQ+dHrWXCONmcMgitbdjW0pF3tXYppcc1hQkBvacbH80giIF5A2XfwcjvxvR9z429NhwMcp+yNbA7UwCgsLdZ4f51N+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dbq1AuFAmWTSp6OHRxliPkeszSq/Iw7RBa9797HcWY=;
 b=WE+6+1OvJnDszT96wPf38fKl2dH+HqwpBNcDBD+3oHiUQbLecg4M+EZt11p/z9uEOit727sJ65Zi++q6YQe/R0fc33yArB6OYCiZcmseQ0v7GSjiqLeCYPD5Bglaa+IgaqHg8XGLaiziB5JCXgu0JaRBDp/BlPaOzEqsq6+TbibnYsyIvFbUysvIVuHQWlnd9LkbA4DSMIic08+vgnJ8p/6yvo/xr1LNAsX3zAH7Hh/qLjGEDTFwMLpB3SL2kY6EWDfeqIE8MCC0lYDYKk9LHedg/TfL8qy2O/2nNgdYtSCmnEGloJwXma+SC9SBu1/fCFJk9lR+nh8AUnlqYWPEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dbq1AuFAmWTSp6OHRxliPkeszSq/Iw7RBa9797HcWY=;
 b=BEhprvOEsbbAhZsYgpIZVD/u7EoSxy9lY6iYS/MwR926Rn9y0BoZqKXL3ETvFTxGFPxnMLnPEgMpy71jinbcXo8bhOnkCD1Sblcu9hjHnu7Xp/a9Ld9trRUzYEwO+29e357Rwtts1TJ0WWMQIL4pmaHWAdKPIvClVZCy6pcxAjqTKhMXuVyB/gMRvBCj0KXcX1O6BhX/PpKl7BmuA8W5sjG85Fh5+MhUajWbbx3/zEUhOECmZGhAUU8zvbHsd19NHCgUcIQpQlEXG/4kKaeMu9CBFq64iAOcPpgmUNXnKknbciA5Mq0dZiUnxHGa24sQ3TTXAv1+GYfozj6BGvMzhA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Sun, 25 May
 2025 15:27:44 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%7]) with mapi id 15.20.8769.021; Sun, 25 May 2025
 15:27:43 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
Thread-Topic: [bitbake-devel] Why doesn't BB_WORKERCONTEXT cause task hash
 mismatches?
Thread-Index: AdvL5Q968bqCFz3UQxqpJVzshsFbIABZFM+AAAwz6FAAA3fvAAAAWZ+g
Date: Sun, 25 May 2025 15:27:43 +0000
Message-ID: 
 <DM8PR12MB5430F245759657ECF0EDA7BD8B9AA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB543079199282BB54BBB054B68B98A@DM8PR12MB5430.namprd12.prod.outlook.com>
	 <4dbdecf888d3d81cb0bc81d172c45f410e8b5667.camel@linuxfoundation.org>
	 <DM8PR12MB54301F0296D2101CFAFF2E168B9AA@DM8PR12MB5430.namprd12.prod.outlook.com>
 <516644857309fdc44a25bfcd51695e9b527e1df0.camel@linuxfoundation.org>
In-Reply-To: 
 <516644857309fdc44a25bfcd51695e9b527e1df0.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=6b250abe-29b0-402d-948f-ef758c09f3ee;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-05-25T15:27:05Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|MW4PR12MB7143:EE_
x-ms-office365-filtering-correlation-id: f0e59611-0bf5-45b4-ea95-08dd9ba0b1e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cVFSc1JzcWdsY1luM1MyMFViRStyR05Jc0d5cTRpM3BJVTJPN3Vjc1VqV1hB?=
 =?utf-8?B?UitMS2J2eXRFbTdDcHdYWmJvaVVOL0lYb0lJT3haNjM0NDRTN0pPcHdqNjk2?=
 =?utf-8?B?SzhaMXZGa01WUVQxUS96Y1ZwSWtsUkp4SGVKTEd4UlZMaVNRSDVPU0FKSis5?=
 =?utf-8?B?SC92R292Z0IwaHdrUzVrOVFrd3BOekhORUhPVU1uem5IVXp1Ly9ZOUQ1Q3RS?=
 =?utf-8?B?S1lIYWZQdkd3UitiVkpQWlNLNit1Q0Q2eUY1Q1NWOEE4L3BUUW1FdzZvN3dl?=
 =?utf-8?B?U25tNXdmUmZqWTUwMkh0QVluK050MzNYZnlRS2MvMWIrN2VJUXBlR09wU1B6?=
 =?utf-8?B?aGJFR2xwaVk4czJOVVFwVXpQanNlcDRDakhQSFBFREY5WGxpN1kvTWpkSGdR?=
 =?utf-8?B?aGpDQ04wb0pQSjdBZEk3QTFzOFlQQjVRazdibGlTdi96N2lTZGorU1JDOThX?=
 =?utf-8?B?b2Y2ajVtaTRMN3hTNXErQUlqYmlFMHppSGY0M0R1b2ZTM1lRVkk0NC8rL1Rk?=
 =?utf-8?B?NHYvblBGUThBZHlhaUNHQTkxVUxCV2EwTzRXbVc4azlqK1lVQnh4VTg1M09z?=
 =?utf-8?B?TDhaOU1PZ0UrUllHbmxJTE50NHd6ZkRpcS9Kb21va3JhenllOHJQQys0T0tC?=
 =?utf-8?B?QktYeDZoYnp2dFhVZjJuakp1UDFRaFRvYlhTVmlBYWFSY1BEMHd1SnZtQlNk?=
 =?utf-8?B?TkgwV0xhalF1d1AxN3kzK0duUzFOcHc5NTNVNDVRMTNzR0N1Yms3UWhFMEdD?=
 =?utf-8?B?ajN4K083RjY2dFJhMVRsMEptRDdDL2RLRUluQ0F1MkZueWxIczhQSEtUQzhR?=
 =?utf-8?B?WmRlSTR4LzdiWUpCa2kxdkpGZDVsREFpalg2R2FFVDczamhETllWU0Ryckd2?=
 =?utf-8?B?dEZFb09zWURnOEhUelA4RHY4V2ZqclY3VW52UThqZ3lJQlM3a1NiaFVGei9N?=
 =?utf-8?B?b3lxaWczcnZEaU1uZFQvblNyMzJQRUVWNGFTWDg3NTdoa2NObUhhRHl5am42?=
 =?utf-8?B?cjFkM05JTXZQM0xsT0dINlZQdCtpOFBBdkp6ZlZDVS8zL3NRZE9XKzJHRU14?=
 =?utf-8?B?UU1XQm5ScjR1VDlaVGpRMU9MOSt3NTNmY0hnZkh1dFozZWdYckhqYlJjMC8v?=
 =?utf-8?B?Q1pFY29paklPU2xocTRBcTV4RE5QdTdvUTFNMnowWEM4ZmhrSDhtQU9MUkwr?=
 =?utf-8?B?amo0blZZRHhiWXZXRHlBdEhtMUdLSTJud0kyY0daQjAyOFBRdDJpZG1UWkNy?=
 =?utf-8?B?ei9TL0FCU1dJYUFjVHVSdW1vWERPVlg0S0FUanFHL24rbnNhOFZsLzdOdjV3?=
 =?utf-8?B?MVdTekhwbGl3SXZmMkpoTVJtRmoyN05XZER3eW93QjhocEgyWXR2TGtQeXdt?=
 =?utf-8?B?eElabHhkd0VaV3Z6RmZTVHdNMkhVMnZKWG92OHA5TitTdDZzR0hQVGpQankz?=
 =?utf-8?B?YVZ6d1p4ZjdMNVJuVkEwbDJ6ZXhCQUNYek0vNGkrUDNDVUxmM1BhcUJ5UVlr?=
 =?utf-8?B?N25YeVRtRE85OUhIQkJzdTBEQ2pOTWNmeS8yb1NZSzBGT2JjTzFvQzcwcVVK?=
 =?utf-8?B?dnkxOEtUa1N2SkdSazZvTHE5RStCMVhqbURwV1MxZjVFRVZnWTZINGszQ3hD?=
 =?utf-8?B?ZlJsMXowL0tzK25jMlYwRkMxdWVTRXZYdzNZRFdCMXRYTkh3WCtpVDljNkh5?=
 =?utf-8?B?aGVrWENXcEEvbFh3L0d0NW41MlZnaW9QSTltQzh4Nnh3Mno1UU5JcTVpaTBl?=
 =?utf-8?B?TWREK2VET2FWMUI4cGxXRWhZNHpCYWl2Tno3WFJwSE1ESWRzWGM3L1dpL1lh?=
 =?utf-8?B?UjN1QWduc3h2RHVsSnVlQldET3JZUlh2TUhycVdyVytPYTJDM2JtRnJmWjBl?=
 =?utf-8?B?UHJuQUdLVHpUMnZFZi9FckxjeStNTVQzazBTbWk3M1k5TUNNMkI4SmFUMkNZ?=
 =?utf-8?B?dFE2cHRGc0FmUm9tVlRjMmVjM3c5a08yTkYxeW9iTWQrajJCbWYyVldOYkxz?=
 =?utf-8?Q?QaPuxtz7pI2eF9gzMuujuo8Gwltsl8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UTZPeS9HbmtsZW5iUDBiRGRQbWZwZVFJY1VHeDc2aURQaHRFY2lUUXh1VGZ5?=
 =?utf-8?B?RWJyK3BwZWNaMlpKdS9aTmNrUklHckxYei8vek1keTVjditzNFFwTFllZngw?=
 =?utf-8?B?VkZkcWtqYUY5bnNzSG5YekdYRFFWcE5IR3VQR0pXc3NVU2MrTTBMLzVXOG9q?=
 =?utf-8?B?K3AyS01yZlZhZEI0cXp5MWpKS2VGQ2NDbWFmNktmYnZ2TERmanNuK1dmR2k0?=
 =?utf-8?B?Wi9RelpXQUdkaHNid0lmQnZiS0VKbEFhWjl5MVI5T2xLejFzaFV4ZStOcHor?=
 =?utf-8?B?dlRXdTV1UTA1dVhBdVk5MkVYc0RycFUzdlVGczVlT3BMS041dXI2MVUwUkVz?=
 =?utf-8?B?ZEhRT1VUSGpMU0hTYjBBWVV5WlRYZzF3QkRNMk9saFQ1V0sxYi9aSkhHS1Aw?=
 =?utf-8?B?aDVOODYzS2hLZnc2ai9kSEdwUHE4d24xN0FZTG1LaVdCdy9ZdUoxQThHV1Mz?=
 =?utf-8?B?Tit6enRuWDJwazBvK1VOc2RpS1o1STRoQWRYSStBeGZPNDBaZm5JQ0htWGdO?=
 =?utf-8?B?bzdlRENldnRPRVhuS0F5VlNzQzBUdWNybms3dnNZR3E5TUdZZlB5VjVyYndj?=
 =?utf-8?B?N3ZoVDNnOEZHRDZiMnMvVTRqUU9oVVNDNCtPSHN5Tmo4VkpYOEd4dWpYZGhx?=
 =?utf-8?B?NGE5WTliaFhqRWtvQU1iMDlLMVI3SHhQNU90TkZnQVRDOU5KcEtNYWsvTjRD?=
 =?utf-8?B?aEZ0K0pPMEJabkgrUG5WSUh3eFlZSThJMXhid2xYZmphQWR2amZKZGtxOTVU?=
 =?utf-8?B?OVRrQ0Yzdmo0a0JjYTd3WG1OWjlTME1UeGpBck5QRXBOM0Yvc3dIUEpBMncz?=
 =?utf-8?B?a053eGFjYlJEZzVYN2RYM0x3c0tiOWRXeFZ4djlQNk5IcmVzK3lVdXBKekJY?=
 =?utf-8?B?d3JBN2k1eW1lMzEzRkQ2U1ZqTDNranNMUGJjVUFkV1hvSVEwVVlRcXc4ZXEr?=
 =?utf-8?B?b0MyRG1IQnR1QWdiYWMvK0RBeS9rQzZmaEE2cWJqY0tkS09DUnhVTTVvVHFk?=
 =?utf-8?B?RWs5ekl5UStHcWNmYStFSFFQc3ljNUlUWmE0K2FobWVwbjlKbXlmL0IrbzUw?=
 =?utf-8?B?ei9yVXpMWFFSbjJhWnhReWY5RHh4NzhQZWRIMHI5SjBEd2RraHVzL2ovcXJP?=
 =?utf-8?B?S2hwc1d3eEE2cGd2NzgwTUVvQnR2TWxkK21Na08yTGRwdlo2M2xlWGw2T3RU?=
 =?utf-8?B?VENZcXRDOG10NTdpYzFCRGs4WkJ6elIwaGtWMVV0WHJRUnlZL3hPNFBZQjRR?=
 =?utf-8?B?SkRNK0Z5MlZrNDBSRk1aNWpuMXhUTzJkY3hBa2owY2NLYzFFNGtPZWtVUFQx?=
 =?utf-8?B?dEVBNjhhUlp4ZFRGRllZSmxpd0pGc285Vnh2UG81VkY1bHl1WGF0N05MYUY4?=
 =?utf-8?B?cmI5TGN4M0d2TzloeDVFM3oyOStjeFFMQkxIZXRMSTlxSWM0YkpPQkJNQ0xQ?=
 =?utf-8?B?cXRUeCtVNjFmSlliOUhEK1RmVXIwcTA5WEpEeDRyRUlLd2dXdnRlQlRvTzZz?=
 =?utf-8?B?Zzc5WmFONGUrUG8veGpCaXIwQTdLb0tiVjd6R0RFT2Z6UmluRWN0djBuRTdR?=
 =?utf-8?B?cEpnb1M1SmJjb0l1VmN2YkRZVFBKYy9GL2sxOFRyRjFDZVdyMlFyUExrS042?=
 =?utf-8?B?eXpXQ2dVSFhQZDg4NzcyRHlZQjBPWDNybE9KaTh6UlJMSmR0WGFOM3g5VXFS?=
 =?utf-8?B?akJVNTBjd013VXZNUHdKaWNNaXBuMnVGUDdwVVBMRWV3ZWxVRFZib3hXN25T?=
 =?utf-8?B?Y1Q1VElaU0xoWVcrR3J6R2VLbmFWUkdsVlZ2ZlFOVno1OWFqWTZ6Y293NWJn?=
 =?utf-8?B?SmR4WVZ1clhWZ2RFaGJFUFFGazJ4MXVLS1hnYVFTTUxWV0pPSFFWdjM0aUVS?=
 =?utf-8?B?RWlvaU9OSnZhQ1VzOTlOcDBnbFYwei9TbEh0dmFVbEpnL3dzdUMxU2xmWjFP?=
 =?utf-8?B?T0p2TEVMcmpqVGtnOWJHdXByWk4zTTVPMldTcjl4ekwzd0V0TmhSejRRMm9D?=
 =?utf-8?B?bHBnUjgrc0hvTFByS1JhQ0UxUGR5OS9zUkQyMkoyK21rYnZXZVd6d2hEZlE2?=
 =?utf-8?B?YmRuNDNzc1FWcTFlalcvbGhRbldJcyt2OXZPSUtJbjV1WVp3VDlTQ2h5VnN5?=
 =?utf-8?Q?wIPWfLWRQNmL+8FQFk+Ck3rrn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e59611-0bf5-45b4-ea95-08dd9ba0b1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 15:27:43.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFK6zRbOb7fpplpj89EtKsW+Zr+ARJuCrf+rau5VGM9SV96z4SWSg4jqZDRzQ5dmBz4syYyG3GWnvAqVcNlE0sMSXZnBEtG8O0JIj1ejwa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 25 May 2025 15:27:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17640

PiA+IFNvcnJ5LCBJIG1lYW50IHdoeSBkb2Vzbid0ICAnQklOX0ZJTEVTJyB2YWx1ZSBjaGFuZ2lu
ZyBiZXR3ZWVuIHBhcnNlcyB0cmlnZ2VyDQo+IHRoZSB3YXJuaW5nPw0KPiANCj4gSSdkIGhhdmUg
ZXhwZWN0ZWQgdGhhdCB0byB0cmlnZ2VyIGFuIGVycm9yIGFuZCBJIHN1c3BlY3QgeW91ciByZWFs
IHdvcmxkIHRlc3QgY2FzZQ0KPiBpcyBzbGlnaHRseSBkaWZmZXJlbnQgYW5kIHlvdSdyZSBqdXN0
IGdldHRpbmcgbHVja3kuDQoNCkdvdGNoYS4gSSdsbCB0cnkgdG8gY29tZSB1cCB3aXRoIGEgc2Vs
Zi1jb250YWluZWQgZXhhbXBsZSB0aGF0IEkgY2FuIHNoYXJlLg0KDQpUaGFua3MsDQpDaHJpcw0K

