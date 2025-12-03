Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FACD15DB7
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 16:55:48 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20451.1764780942428741067
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 08:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ah0ZTKh5;
 spf=pass (domain: cherry.de, ip: 40.107.162.29, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvGI8t8MGUC+a/0VOMwc92SqcE3pGmq+qg0xraIRW/fWWKy1YIsLey7uvUVln87CKou5IkzBDg+x3t7GWDrsUsCSYmvRm/l7uns6U1QtgZUhmoB008+V97q9D9AQ0RUZ4Wbi3XfD5asbga4Qpw2nWBMTIHb3LPL+/pst+ZkbRmHL2Wz7K3E+6bUrtKCrhsJKS9XiD7LApLqTpwiIfOeOY6GWr1WvFa3pXkazykB+uAFdQUsKy/1zy9Ef+m5HioxhYWx4m/xPklvNSM6VncMEAJq5+AoHtAgy8NDMqN5tgzdiOP+jFNkPlHAB2NRXuudv8iczvHz69i4H9D5GWe4O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mXTSWQgAhlqvPyPM1H3S1XPQDqjQB8w8KFDBShDyuc=;
 b=f+im4vBy6WDp3DIJ0SbfA1oGM4cI3slgxvArqBTvToFHkUDWG9PZJwCCrwVjrMR5Uzsyxnq8TgBwAGzEhbsU5DANQSXVI7mVjlIw160FpdgYJ353IYxTGMkl9QQdYJEcX+mwyY79nw+F6EL1n5r3NOpUKxy79oD3bruLgRJckF+rDiB5FjTcaD5f6DrADVM0F023KzfGew9An9me1GJDIVNi+6ctCVu8GEkBPn+QDFHA0ZokV+BBMxmFQnEtSzJGFL+Ein1H9gSkJZsbfFwaudPVNmcHgwx/FKuiuCa5dGx0FyhJJTQHF90SI898LMdrxHfAGmNeN8X1UWKg1d8oRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXTSWQgAhlqvPyPM1H3S1XPQDqjQB8w8KFDBShDyuc=;
 b=ah0ZTKh5eAYJJraQziLL3wlq8FNlBWSt7ouqVaM1RBh+aBKGChuY+p4qLMhWjkY58OpllvvT0n8yN+KR8nBq+1fE7KsNH3oku+fa3pv3CBI6OFANwI9H+cQ/X9+CQsg1s35PFEWC779x1bhBgWX+GxbQYgv8A7Phpel/IRwYamY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AMBPR04MB11763.eurprd04.prod.outlook.com (2603:10a6:20b:6f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 16:55:37 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Wed, 3 Dec 2025
 16:55:37 +0000
Message-ID: <d8437f3b-effb-4aef-973d-0f01edece738@cherry.de>
Date: Wed, 3 Dec 2025 17:55:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: extend classes and include/require
 documentation
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250918-classes-order-v1-1-3b8b75e9cf10@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250918-classes-order-v1-1-3b8b75e9cf10@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AMBPR04MB11763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce175b5-3069-4c7e-0b9c-08de328cc855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0p1WGFLS0F3STFtYnNhR0FiM1p2S3VwaXoxSmp5bnJxRkxndnh6UVVlaWZ2?=
 =?utf-8?B?RzFsbExPNFRuRnlFSlc3Q1Z6Qk53R0RaOFNCVnlNcHR1SEs4dmljUmM1TUZr?=
 =?utf-8?B?TVdvOTJpaUk5cnh5RlBrTTFtc1FOc2Y2Q05qR0FiYkp4U2ZDd2VsSndOV3hy?=
 =?utf-8?B?TkYraXlIMFpXREdWMDV1VkhzbnZHL1hyVWlnbEJ1cjVqWGNGNXdUK1dwSXhi?=
 =?utf-8?B?MjV1WXd0WThWdFhibWlkSEZDd082MEdWTUZFU2NYWkpreDhUdzcvd09LMVEx?=
 =?utf-8?B?UkIxb2NiM0xGc1l3OEZJaGJRR0RZTWQvY3Y1cy9CUFRQM0dlM3JWSGJJV243?=
 =?utf-8?B?dlRmb01BN2w3NzZXUmdWR1l2N3VISm9PUTZaK2pLZFc0MGw5WFU1Wk9ySmJk?=
 =?utf-8?B?U3hRam5tZWlCeEd6ZTFOUG51NXFmQkgrdWhEZE9NVzNDVTNmc3YwaVg5VUMz?=
 =?utf-8?B?V2FRYk5Jb2FpblJPcWJxQnZ6YTlmR1RHeGlYYldQdUtzenl2Ky9ZVXBSeE5W?=
 =?utf-8?B?a0RMR3JpMjJIUlJGSUxoUkpsSWZCVHpYWmM4bmRnSWs0RGNnQkZIcTVSZUNS?=
 =?utf-8?B?eUdWVFRmQ3VTZUtYbXc5ZC9tT3F6L04xWTZNaDBMWE9MK0xmcEpXWWNWZlU5?=
 =?utf-8?B?U0lQRHZpZ0FxUmpsc2N2dDZkeXpxVVZVaHczcURMd1A2RkZGbFZ1aDZSYXVn?=
 =?utf-8?B?RHZJNXo5azFsd0RrS0VyWGJwY00rMDNNdmZLejV5K05CNnBqK0NoVjhCSnAx?=
 =?utf-8?B?UFRQbVovZGRGL1pDK21MMUtmSVp3aThTRkl5SzN5d1plZy84VmkvTTNlM1F5?=
 =?utf-8?B?ZlpQaEorak9ZZzRKRlBDa01IcUwvTzg2VHRmM0oxYUpUMXJuYUVPNEFOWnhy?=
 =?utf-8?B?aDQ2QmRjRkhvSWhIeUdOa0V6OE1BV2xwTlZJRnNmc2VmTWRrbUM0bEdPN0Iz?=
 =?utf-8?B?SW1jS21TMUZJNnRJczFhZFRIMXVIUk5SUzlCSy9Xc3QyT3JQRFN1TnRIVWFs?=
 =?utf-8?B?TWNnVkVaVUNNaHFNbnpTWFBiNUJVbFZickxrRzB4L2tPUEhRYllYWEppaGcz?=
 =?utf-8?B?Q2dwN0Z3WFdYS2craHdwY3R4QTcwQnYvQ3BTUFNDSHdKY1VFUzFleEdXSmNk?=
 =?utf-8?B?OEVDT0J6R0xRellPS2RVRStaamk3QUtNQU53LzBSSlJPWGNVVk1FbGhXSnEy?=
 =?utf-8?B?MjlHMHJZWnJkY3hoMk5NeW1LZUtEOTNHRUpNelFyazVWTU50QXFTcE1UK0dI?=
 =?utf-8?B?cFBGbDFoQlM3Vk1nNXVNK1QzZXl3K1pqVmVrREV1d3hGUWorVktsN2xWRFFC?=
 =?utf-8?B?L2d4TFd1YjJRMncrWms4eFh0Qk4zTGlDRDlwd1ZMYVloUkRNdnBFTGhRUi9V?=
 =?utf-8?B?MzRaVzRlVVVIN0ZlRk5KRDhDcWJScGpLcGhNYm1SVFd5UzdaSlFaL3UweC9x?=
 =?utf-8?B?OXpSSC9IY2lWVmpOd2NOOERyVUVzOWpEcElGamNCL1JxNUJaUUgzUHk5bGND?=
 =?utf-8?B?N01DbEVFcWlRWFFacUU0ajd1QWtUbURKV0N0amNMUWN4NnczcHkweFo1R21L?=
 =?utf-8?B?MTI4U3ZTeks4bVVTWTRUMkxpanJja2UzbE5rM3hLVTRhZTFLcXJJRnRoK01q?=
 =?utf-8?B?VWxFM0dpK0JuaFpoRzhXVnN5NmZrYW84TUo2dkxkZm56bkk1MVZIMkZVMEtp?=
 =?utf-8?B?ZlR3bGNCelhSelhjRy9xQW4rTFp3enQ4Sk5DVFdBYWxDSmp0d2JkS1FjMEdj?=
 =?utf-8?B?NGVzZzlqNlgvbnJycld4dGdOYU5WYmhGQ3dRZExFUlRobXJqSEtTVUlRYmVq?=
 =?utf-8?B?U0lTQ1FhSE92NE1wMlpURUJ0NVdMM1d0UmVhRW55aEc1dDZQWVdLam1MMTRQ?=
 =?utf-8?B?bnl2VDFlaW8yM01TWlBoY1EzUTYvQktXSkR4aWN1ek5OODhnbHZ2dC9GN2Q3?=
 =?utf-8?Q?inERSzewOeP48oa33Dmx9qhhXdorhzBW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1lMMTd6Y3pBVlVpYUx0VkNrWDZTcUd6d21zNjBMbjBxS2F2d0RNVGt2WVdl?=
 =?utf-8?B?Q2FJcDh4OUpHdlBNRFJ3SFREY0VvTVgwSGNUb2xaMHRNNlo1SCtLMHh4Qzc4?=
 =?utf-8?B?aVlKYTMrMHAzc1dsMmR3RUlkQVNWcC93aXo1NEhLZTc5ckJHaW5lZHpqUDVm?=
 =?utf-8?B?dWdVa28wYVVyYzNNWTBPbXFTWUdHdjFoVmU3TUJuTG9hOWJEMjllYkJTMFhS?=
 =?utf-8?B?SFRMb05Zc3o1VzUyZERwV2ZpRDgxbTA3Yis3cFZVblNKUG80bFFVYlNUVm82?=
 =?utf-8?B?bURPQlFRWC9tV3JXOXVDOVBCWm5vT0JURDh0OHBnR1ZuNzhaaFNNOXJkcDBa?=
 =?utf-8?B?SHNMaXVIQXIraXdFRyt2RklWVVJrK3BXRWNTNFZ6SmgyRmNiSmU1RHQ5ZVJa?=
 =?utf-8?B?ZTFtelVkUWcyRmh6ZEFySUFybUtVNG8rRWVHTlVkeEdKazFRVVZ2b1N3bUxs?=
 =?utf-8?B?aUNWbzZkWVFDR0JQUVNwaEJ0bXJKZWpPc2FvZXNSMjUxTTVXbmwxbVcwSCtL?=
 =?utf-8?B?T0c3RjczVUdZYmxKTUd2NXNsWkVvejJGTXdlSDMvV2JZSUdTMUVtUkZWK2N5?=
 =?utf-8?B?YmpIUm01TUM4VFRuaWZveThsbEFldTZvcEVBeGNwalh4TUVxRmRxWU84Ui96?=
 =?utf-8?B?LzRZWnprSkh4ZG13MW13ZjdTUysxOENTc25SdGVJUmk4SzJvbTlYbXZ6QjFq?=
 =?utf-8?B?dzBnSGRoVVdhcXFxdzJKNk1QR3RBWjlFSDFnaFpaZHdRZWhSbEVxR0pCclg1?=
 =?utf-8?B?TFZkeWZQclpCT0dXbXAxakp6RElxa1hkUlQ2YnZyeWNOTSs4VWNlRVZESG1B?=
 =?utf-8?B?SWxsZnlZZFRMUVpaZGVRblpNN2dtaFBnVEFPMHFGTGdMWC90K1Zvb0JzREUr?=
 =?utf-8?B?bUZGYWRUV0p5bkJHc1lWZ0FmSmgwODM5blI1VlhWVk9SZmNreUh3aTN1TnlE?=
 =?utf-8?B?UHVNenJGdUtQTG9BeUVqTURkblRnVUdGcU5BcWdXU3BzMW45M0tLRENRMEY0?=
 =?utf-8?B?V1BqUnFrTjRldkRYR21ZRGJaUnd5NHNLbktKRWNSVE1zTzJGcEVsb21tRTcv?=
 =?utf-8?B?eGg1RTJSNmc0MlpxVVJWaXRrWHZvSzdFRTY2bnlkcWZWclEwSEhJQUdZbmNX?=
 =?utf-8?B?UjQram4vVm5keXg1OUQ0OFNmVWtTK0JSZVIyY1FVVGNWWklIcmhrd2FXa2lT?=
 =?utf-8?B?Wm1Od1FFVWpqR1EvVitvMGZFVzVibCsxa2ZGaThLNVF6ZnV6dUxDMC9xNjhn?=
 =?utf-8?B?NWVUTTR6M0FxWmlielZVN3ZYNGFDcXIvWFFxOUpiT0dJdlhtajZKNU00Nmpu?=
 =?utf-8?B?ZElwMFB0WUV0dnRCeEdvQjRuclo0Umt4R2p0cnNldFVaWGlhYVdIL2lFemlk?=
 =?utf-8?B?TGN5cldnaEZFSFhlVlVtMmN2Sjk3amlLUFloRnFKT3IzZHVjRUd4dzZiZVdQ?=
 =?utf-8?B?alYzM3prRktjOGc5N05MektmNlVGSFh5UWdMOWRncGhrY3V3Tm1SdlN1Q3hR?=
 =?utf-8?B?TUZOT2g4OUFtKzQwMGtqMDdFVER3VFFNdEtqc0xjYUg0L21CTTJmSEZtQyty?=
 =?utf-8?B?ZXp0TzZOdTkxTVdOS0FKbSs3SUhhc1JRdFVuR3N2aXQ2cElQY1ljRGRTbWVk?=
 =?utf-8?B?SkJyRGk1RkV3UWpJNzUyUjB4L3hiVGEzaGhWR09DRmQramM0VURhNHNtL1lw?=
 =?utf-8?B?Z1kyMW5ZQzgyN3Z1SUlSaGRpeVVndHloSXdlak5KN09hTmZPalp4d2UvTXQr?=
 =?utf-8?B?S00xWlRFbk9pdk1kUFhESksxSWRIcVFKTVV0N2xsMmkreDZVYWlxbmw2RTQy?=
 =?utf-8?B?ZlYrOFFreXBab2JiOTVjWnBEUVgrUUhHYU1oL3BOUWZRNWJJaCtJQlUwTmdj?=
 =?utf-8?B?Y0t6Z1krUUExWUx3Y0w1WlZMR1MwM25tSGhLcnpQNzZZWmR2M0YvYTZRa0ZB?=
 =?utf-8?B?YUx5Q21QZ0N4VFFzUnphRUtKWkVZbHVvU1dBUHJUK1hFMitteDZJU0NZN0pT?=
 =?utf-8?B?eU1yQ3JKWVpHUHcyWDQ1NGc0UHhlRDh5eG1naDIrZks5UFA1MzQ4QUx0dk9q?=
 =?utf-8?B?WjlVNzV4RUhNa24wQThGRnRtY3VRSzc3L0tOSjhXcnJ4TDBjRnlTS1JWc3Nw?=
 =?utf-8?B?Rmk2WkxnMW1rUzJvUGM3RktRcHhtODkzd0tyeVllQWNyVkR6OFptYUVJSUtU?=
 =?utf-8?Q?5fb98vbMj8G1OpfJRRmk9FM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce175b5-3069-4c7e-0b9c-08de328cc855
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 16:55:37.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE4aYAne38Z+ZSx+h8B5BJ06k/tqd/FrZY0cGKzjH0PI7Rk1uZWlf5dgcW+dspj8NEjWb84y/1Fg1aZPpZW5LBkaehMT2X/Eh5eBDarRVYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11763
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 16:55:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18531

Hi Antonin,

Just had the time to review this, sorry for the delay. I'll send a few 
typo and rewording patches soon. However...

On 9/18/25 2:16 PM, Antonin Godard via lists.yoctoproject.org wrote:
[...]
> +Locating Include Files
> +----------------------
> +
> +BitBake uses the :term:`BBPATH` variable to locate needed include files.
> +Additionally, BitBake searches the current directory for :ref:`include
> +<ref-include-directive>` and :ref:`require <require-inclusion>` directives.
> +
> +.. note::
> +
> +   The BBPATH variable is analogous to the environment variable PATH .
> +
> +For these two directives, BitBake includes the first file it finds.
> +
> +.. note::
> +
> +   It is also possible to include *all* occurences of a file with the same name
> +   with the :ref:`include_all <ref-include-all-directive>` directive.
> +
> +Let's consider the following statement called from a recipe file located in
> +``/layers/meta-custom2/recipes-example/example_0.1.bb``::
> +
> +   require myfile.inc
> +
> +Where ``myfile.inc`` is located in ``/layers/meta-custom2/recipes-example/``.
> +
> +And let's assume that the value of :term:`BBPATH` is
> +``/layers/meta-custom1:/layers/meta-custom2``. Then BitBake will try to find
> +``myfile.inc`` in this order::
> +
> +   /layers/meta-custom2/recipes-example/example/myfile.inc
> +   /layers/meta-custom1/myfile.inc
> +   /layers/meta-custom2/myfile.inc
> +
> +In this case the first path of the list matches and BitBake includes this file
> +in ``example_0.1.bb``.
> +
> +Another common example would be::
> +
> +   require recipes-other/other/otherfile.inc
> +
> +Where ``otherfile.inc`` is located in
> +``/layers/meta-custom1/recipes-other/other/``.
> +
> +In this case, the following paths would be searched::
> +
> +   /layers/meta-custom2/recipes-example/example/recipes-other/other/otherfile.inc
> +   /layers/meta-custom1/recipes-other/other/otherfile.inc
> +   /layers/meta-custom2/recipes-other/other/otherfile.inc
> +

I think we should provide an example for include_all directive as well? 
After reading the code, I believe include_all does NOT search the local 
path first, it only searches paths in BBPATH so I think it's worth 
providing an example and maybe notes on how it differs from the other 
directives.

What do you think?

Cheers,
Quentin

