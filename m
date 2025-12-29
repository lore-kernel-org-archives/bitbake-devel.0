Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ADE92734
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 16:10:13 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45945.1767024607013615912
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Dec 2025 08:10:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=BZg3Zc2R;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.2, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0geEcCOU02UZvFCtLMPKm9P8xtectuLrYdmWDnN9JxKKNzh6C2dxPCKSK9GPc6RzeqvragzpQuTo6EahPNhyk/Sb2UmSQmqfRh4PbKLWh5HsUdhxDTFomgNfZvDrD7a3/6NqI1JBXTovvydeRatzVgRVKqa4vNT2rtp2w1ttXFTzUp+YXcrbRlhiUPu0hOfSMqSv1BYBd0hl8G8bs3rQHCUX2pK/VrOmu0ggXjesEsIDqTAuNXLt6Ff3T5+0eGRHjpd58UHuVqrKxG4gDUEkoM0LuDBN+Tu4qXOEEFpHIWTMTc9kw0jPIIi5WLqCC7JYKOsHghU1xoCM+Oae+XbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hlhVMGIexql4QQxwS836UPanHxOpbjT7oPpmQpscsU=;
 b=Xb6y3Eg5RLAYOFWXqXSf8SGgHwaiqDIKL5vdHdyH04l5hVYLruFVx8w30jQfHsVLxSTJz+KApOCf9V9tdKqnp0RTHhDJOwGIOTlZVj1JFI3YAEHA/OXaANd6dOu8fZtWw+uKmiyUuXgPby8/20M8AOVwrWFa1zgYkZb4XAM+F3uUY1dMpNaXRLuP5DQmp3z3hGSFd8huV0Im25KXGwHNVaBi1QZrC0R6kB6+tkgRvWrhZeYnjV/N59oPn6BG9vIGjGxbi7jLjJMtsSypt9O5oPTw8pF+u2o+J91N5J3nOB1Akla9fdEf5pYelDqTWrYUpcjjp1gQls2MLcsmvaf8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hlhVMGIexql4QQxwS836UPanHxOpbjT7oPpmQpscsU=;
 b=BZg3Zc2RUdY4PrhkQa30ObfGxPg20z/rGwZT7vZju5PSpRPk7uvIczOHW7IX9R01KK56A4pv/cac25FEYFLFGRZPIMTi5NB0cHEaRbK72DU8fxf+A4NQy3RkYumSpLC8sJGAKRX9FzBikPfXUMdvXf5ouVA6bOX5tedXWR7XWxtieKiSpc1A7mOXis4v1E9DShvtIudX6IdVdTPzIhHPDQS4i9wX7wX7Wpa0bBdV2CCaSX9CTtRvzFErcgAjP8uhGNDMac6Cb9nGmG2Y+ocMTRkV/qj+UTSJmhDxiBw8ZTPKPMt0fi4Jatm8gll/RUxsUb1uODZvxCdRudwA+dgyIg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:10:01 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:10:00 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: pyenv shims + BitBake hosttools 
Thread-Topic: pyenv shims + BitBake hosttools 
Thread-Index: Adx415cdh1CwzkXcRHygW9uthvYAdg==
Date: Mon, 29 Dec 2025 16:10:00 +0000
Message-ID: 
 <DM8PR12MB54301B655114617AC2E13A5B8BBFA@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=56675f97-ede5-4740-ada4-fa17e5a932db;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-12-29T15:26:56Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA1PR12MB7566:EE_
x-ms-office365-filtering-correlation-id: f9f67077-180f-4123-16dd-08de46f4b827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|38070700021|8096899003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Rx0r6TpOWRtTL4/nkO1HNJPBkP8kNMb83VQfAc559BeOiXoiOZ8tY+rdcBSD?=
 =?us-ascii?Q?fYT7mrMi4Uqt3g0x2sXsP6skDXHzw++L2eCSD4cKqb/RGGToYWQy/v+0v2gf?=
 =?us-ascii?Q?WsQd+8JAChymFwbbecvNSNnNK0zmkqoFl4uu+MzEWyW7egilRRvzhBwn8R3A?=
 =?us-ascii?Q?QjwX1NjTn0JZ5bs5/WVwT5RKdIu8/Wj9QLXaowXbEySY6Qt2p731NlCfQFb3?=
 =?us-ascii?Q?A/BnJquzsvNpmgJ+eWyVCUuJcQiGWw2aZ6u34iKFF116K9jvr0wDA/nMfmgQ?=
 =?us-ascii?Q?cY8SqdbX6M9x9MQ0JNm1YoU7AGDaKF6Q5X7KZlw6JFzj4Wk1rIX3wSikoo2H?=
 =?us-ascii?Q?Py2z477KOROjMa35k5ji4jxaAQmXqUa9QGlrVVuabaQ6Ar0jmUZjWsCFKrg5?=
 =?us-ascii?Q?Jytv95FkI07KOPCh6slchdxNyAm3shSayqz2jSAvexbOsEETIcqr8OYdV1xu?=
 =?us-ascii?Q?GNaUbeV0uayu6ut9N/oMgvsMGhEkBiaxtSS82QjFKgl5/ty63/ML3YOnSybE?=
 =?us-ascii?Q?goy2ELdPqgnt5fXRn2LzT/BcTym6BRjzFsyLrjhDZsTxjgLfxATu2/F3wzJ7?=
 =?us-ascii?Q?fTzK5MwrWiRIrRAFwcRsFul1v9480GuywFU64WePYgmCi6n+Tub/7UVM4NOh?=
 =?us-ascii?Q?ZmdSdb64HP2wnlRYWqbV2mWmck+AXDb9QcYCVfqipdWPPwqhziZVKVI0Ek3d?=
 =?us-ascii?Q?KWu65SfzpQsJsd6NfBzEiU6gn6njjCafDc0e3KKWe5uF9VzJ2zswlfzn4lEt?=
 =?us-ascii?Q?l1KuboEbezMkMM9qlpNWzAiKp9MYvkZ/g27roGRnvkuK4HqSDEqw4vUybWbX?=
 =?us-ascii?Q?a9pA+E4zNP/PIWbGwtO5F0kNOZtEIBq2gTtAaOwkeWbem3sSWups4pUTBp8z?=
 =?us-ascii?Q?E4b1pFe/XhZGlBcPuBVwLIPUxjrKLWgmOyERrff/eXa5TyLbOR7lINa0hME3?=
 =?us-ascii?Q?YTLQ4XmYWJWSzw8dx7VkXDWFcb+M7W9GEq4bSn3t4vDjehiT3ylHm6lNfbLF?=
 =?us-ascii?Q?+G7I6OMp9V+iQZsyM9mOCtaaj32D/6CrGJDSlf72phcV21iJV8YZc8lN5Xvc?=
 =?us-ascii?Q?JPq8jYtzVYnXzRfNmdE2U78dVShp4qve4x08TAw6SIb33H0FUC+QY/nLrFJV?=
 =?us-ascii?Q?89xS1fxoOpaCD1OcvSzNovKPeAICYcIHrsyryYTX/8faF2cix6qdhXAnXhvv?=
 =?us-ascii?Q?oqAU4R89rkDZ3HwagvH72kbL56IGHMNRiMfBA+mK7FX43gllygNWNs0YHoM5?=
 =?us-ascii?Q?UHvP87Q4i49Ra279iMP641tOKInFuDwuIb3FRZPSx1wFPu54rpovXCvLW0Xi?=
 =?us-ascii?Q?+jLb1lqncKt6Rq2PKhH98RSNxuQc2tIwiw4zsHEihAylyvGMpLWByVyzgCV+?=
 =?us-ascii?Q?kAVvr4VXjTrGy7hGgCeO8v/ms8c7rlUDKXHWS+7u+0bV6ZUvs6VECUen1u0Z?=
 =?us-ascii?Q?n3Z6Fbxe2blfDBiASxcv8mo57cc8a1TJHECF/2j4LU32fuxiKljgOYl5dvlq?=
 =?us-ascii?Q?YMpSGlGHfFrZh5xoO4NNe+OjUAnP8SVks6pA?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Qt/W+pFAVFTy/zCfEK2hiigukuIxqgX9NCeq7eW7cOjkyj95xJI/J6kPyGY7?=
 =?us-ascii?Q?CgXpp5LGa3TczZoS7PBZLmZKmsUjQ17RhN8TciW1jLQ8umjAbDkfxp1DTPhu?=
 =?us-ascii?Q?J7szf+S6wRk/ZjgDa4qiRMyNf16jj1DuAEswbbFIIbExJaYQMVq8hHMN3z6C?=
 =?us-ascii?Q?iKE2SDUx/z6Ka0liQytWy2rpkDhSIvKY5ZK6hBZKt9YBeiCBQe+s2cHaDtlc?=
 =?us-ascii?Q?E5UVnyysnowwCciqaF2uG5C4nljzTHsSpOX/jBbp6Mf+Fy0XKOG8810Gzppr?=
 =?us-ascii?Q?jaoeqdpnKrv1RrrnSQabKyjYs/RIVDmpvoVKK43IyarwZBv2hKtENPsvREGc?=
 =?us-ascii?Q?oMEePiNnYN5nBXUty/1sHDBGwQVYkczNrwaaHABRYSaJmTxKTc/cBVUSRa2F?=
 =?us-ascii?Q?vcD0xyYEFiQiZ2lxvXHRjCOSOQzIxoEDyfe7iMA/JpXVSJkdgCizBDkjpTDf?=
 =?us-ascii?Q?EvyFkJUR2cZWNVpd8Fb7hP5fLemATVlMi7Qa8tMFi4bFoVUWm2cnLRmEkYXn?=
 =?us-ascii?Q?boWumsyHpf+2WdplcnlpGjKofgse2EDou6Zc1+umDF6dLtPx5LQouU5aQn3Z?=
 =?us-ascii?Q?e2VaVIKSU99aYYLfIHbx0vQipywMnkwPW+pJMqrDDz0UuDTSwpM/wISzk/vn?=
 =?us-ascii?Q?exw5LbkY9i/ZCg/rVQEapmO49R8iG40F5noZj5JRnlc8XcXFAe5P5UsOOk/z?=
 =?us-ascii?Q?Die3D0d8kATLS6nyA96ozB8ikQSckCu8aV9yuBUZ7dArbWN8gBeNNlRKPo0U?=
 =?us-ascii?Q?q5crbJYQ6xGY7iuA+bo9trMlAxDNU9AIb22133u4pbyF0D5FCI8pu3CjmmUX?=
 =?us-ascii?Q?LJcjlr6GyNZaHLIDN0G94SwIiPsiqWjXJT2jKOzQxWKeeNyqvZguZzx3/kd2?=
 =?us-ascii?Q?Ks7DSKoUxZEPf/GC2337WNPLmCgiRwbCdV7vCwXdkACwDMiGH0JR1ap+Z2rX?=
 =?us-ascii?Q?LCPvCOf4wVrdAYGIJtrJGJfFVodkmvD5iP2s4gCQEDxsOvqlj4Je0X9YvTWc?=
 =?us-ascii?Q?okBr3+8czANRpez5sLgRhgf/zXZb6W9SPtJHoTiS/Gjm6K/kubxikZKughJi?=
 =?us-ascii?Q?/pFGl6jPHALZMxu2YzfbZvdzgydVCmwGXnftX0oDMV5jkI0YAOqnumRUwbsx?=
 =?us-ascii?Q?rAwDaH3/oxt2eMHqhWcCYt2uGY8nvJDP7PjpMZa+oIZiWe651POgqZjXORL8?=
 =?us-ascii?Q?ucEJQbn9KYM4sOWhSw1TPolLZ5bKy9RkUExLd93ebJs0PwSgBiTUoe/PjIM9?=
 =?us-ascii?Q?XHq2uiUI7cPIXl3Ku4Wpz4xsO3ZJpXhdaXmaDd8xlJudI8pfmZ4VBtR0b0zy?=
 =?us-ascii?Q?SSHeNFviJtxflP3WwcGt39qmwW3xnML2S5eisXpNGoJGxjUQskwj6cPYeE6q?=
 =?us-ascii?Q?4cWWCs1rMg1GIzSmcs55BWDxf03NlcoybDPI/Z/++Yl/CYx4o3fg5JPr4tr+?=
 =?us-ascii?Q?9dPHTZS5GrIqBnnJdj1OfNPIQ4aeZfsDVKIbsqMbN00BRhabfQ+5RBUgpWsv?=
 =?us-ascii?Q?TRlkp60HZL+bbfGJLCycUxuyhj4jhG0SziA5MBT34haeEenNMXvUaS8IbdIC?=
 =?us-ascii?Q?6s+fkrlJ060jkhP0U3a78wMfBhlddkyVQ2CrDlaHbJ2s7KENlqU9lafWgma/?=
 =?us-ascii?Q?aLV6SASePKOexigvGyNdpsxImNpncl+bf8/IEhMLHcd3JH8/8wEySmjx+EFO?=
 =?us-ascii?Q?4KO6KN4akxdaft46vpVqYHZM3S+NqYvEYIPrqLSyI9YFc8LcSZQQoCWuzwOm?=
 =?us-ascii?Q?GXH/sl5RzQ=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB54301B655114617AC2E13A5B8BBFADM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f67077-180f-4123-16dd-08de46f4b827
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 16:10:00.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lizhp9Xcbu/cCDBc2O5dQUmJM31Ch/IiXbCk5DYp2YJkT0375VzD0Ple3rNMy2k5FpaJQr9AW6FxAH3KP1tRWWiIShB+eW3fO2Paw/gj39Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Dec 2025 16:10:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18655

--_000_DM8PR12MB54301B655114617AC2E13A5B8BBFADM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'd like to start a discussion on how to make pyenv (https://github.com/pye=
nv/pyenv) work with BitBake.

For context: A few weeks ago, I created a fresh instance of BitBake (using =
bitbake-setup) on my development machine which uses pyenv to manage Python =
versions. I ended up hitting this infinite recursion bug in which workers h=
ang forever during a build: https://bugzilla.yoctoproject.org/show_bug.cgi?=
id=3D15733. The infinite recursion itself has been fixed in pyenv (https://=
github.com/pyenv/pyenv/pull/3375), but there's still an underlying problem =
to fix.

pyenv works by prepending PATH with its own 'shim' directory, which makes '=
python3' point to a shim script:

$ which python3
/home/laplante/.pyenv/shims/python3

By default (and for the sake of this discussion in general), pyenv is confi=
gured to just use the system version of python3. This works because the res=
t of PATH is left as is, so pyenv can look up the real system python3.

The issue is that BitBake also manipulates PATH. In worker context, it wipe=
s PATH and replaces it with ${HOSTTOOLS_DIR}  (i.e. tmp/hosttools/), the va=
rious sysroots, etc. When pyenv tries to lookup the system python3, it cann=
ot find it, since it's not on PATH. (Previously, pyenv recursed infinitely =
trying to introspect the only available python3 on PATH, which is just its =
own shim).

pyenv is graciously willing to help us implement a solution. See here for a=
 couple proposed solutions they gave: https://github.com/pyenv/pyenv/issues=
/2696#issuecomment-3675110945.

The solution I'd like to propose is that BitBake exposes the original PATH =
as an environment variable in worker context. We already have BB_ORIGENV, s=
o I think it'd just be a matter of 'export'ing it. Then a small pyenv plugi=
n can pick up on that and resolve the real system python3. I'd also like to=
 enhance BitBake to detect problematic pyenv configurations and offer the u=
ser a link to the plugin.

Does this sound acceptable? Or does anyone have an alternative approach?


Thanks,
Chris

--_000_DM8PR12MB54301B655114617AC2E13A5B8BBFADM8PR12MB5430namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1389498936;
	mso-list-type:hybrid;
	mso-list-template-ids:-1908363400 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1673098290;
	mso-list-type:hybrid;
	mso-list-template-ids:933939300 67698703 67698713 67698715 67698703 676987=
13 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi all,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I&#8217;d like to s=
tart a discussion on how to make pyenv (<a href=3D"https://github.com/pyenv=
/pyenv">https://github.com/pyenv/pyenv</a>) work with BitBake.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">For context: A few =
weeks ago, I created a fresh instance of BitBake (using bitbake-setup) on m=
y development machine which uses pyenv to manage Python versions. I ended u=
p hitting this infinite recursion bug
 in which workers hang forever during a build: <a href=3D"https://bugzilla.=
yoctoproject.org/show_bug.cgi?id=3D15733">
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15733</a>. The infinite=
 recursion itself has been fixed in pyenv (<a href=3D"https://github.com/py=
env/pyenv/pull/3375">https://github.com/pyenv/pyenv/pull/3375</a>), but the=
re&#8217;s still an underlying problem to
 fix.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">pyenv works by prep=
ending PATH with its own &#8216;shim&#8217; directory, which makes &#8216;p=
ython3&#8217; point to a shim script:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">$ which python3<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">/home/laplante/.pye=
nv/shims/python3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">By default (and for=
 the sake of this discussion in general), pyenv is configured to just use t=
he system version of python3. This works because the rest of PATH is left a=
s is, so pyenv can look up the real
 system python3.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The issue is that B=
itBake also manipulates PATH. In worker context, it wipes PATH and replaces=
 it with ${HOSTTOOLS_DIR}&nbsp; (i.e. tmp/hosttools/), the various sysroots=
, etc. When pyenv tries to lookup the system
 python3, it cannot find it, since it&#8217;s not on PATH. (Previously, pye=
nv recursed infinitely trying to introspect the only available python3 on P=
ATH, which is just its own shim).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">pyenv is graciously=
 willing to help us implement a solution. See here for a couple proposed so=
lutions they gave:
<a href=3D"https://github.com/pyenv/pyenv/issues/2696#issuecomment-36751109=
45">https://github.com/pyenv/pyenv/issues/2696#issuecomment-3675110945</a>.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The solution I&#821=
7;d like to propose is that BitBake exposes the original PATH as an environ=
ment variable in worker context. We already have BB_ORIGENV, so I think it&=
#8217;d just be a matter of &#8216;export&#8217;ing it. Then
 a small pyenv plugin can pick up on that and resolve the real system pytho=
n3. I&#8217;d also like to enhance BitBake to detect problematic pyenv conf=
igurations and offer the user a link to the plugin.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Does this sound acc=
eptable? Or does anyone have an alternative approach?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Chris<o:p></o:p></s=
pan></p>
</div>
</body>
</html>

--_000_DM8PR12MB54301B655114617AC2E13A5B8BBFADM8PR12MB5430namp_--

