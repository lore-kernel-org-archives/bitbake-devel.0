Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FBCF856B
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:13:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.54])
 by mx.groups.io with SMTP id smtpd.web11.6434.1727943189596188967
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:13:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=hUxO7s65;
 spf=pass (domain: outlook.com, ip: 40.92.89.54, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl5d13ATxq9d7Uig95k2OWiVHPOluZyCudUt9e9oXFujgBKzG0c/5NJN0TSIJNcLnaIHVfRm8bss8Fa8bbfTGfvQ46SejtQplql0hliyHTNrfHQGPAWLas+wXa4KhxJWCFI7zLNiatx+EkpEuIOqxF9j4H7tM004rLNM1PvRwHvnIFafuFH5k+g6GfV1AKuXwMV3HJG9tFVXYBNvB/ILd5gKqF/66KJMNQTpIX+vvLycjuVulr0kpHv83WFIiy/mtnvusNvXI2XeVkjFIjD1q+1hX//ati0rCuF+E1kiPTNvNDTlotBQFMZmktHyuUs27lVDy5HSqqdSret+wmah0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JORyDp21KTXiJDU+0vsztEUCZGdGX0ygidfK5A3SGt0=;
 b=BHv0ZGHFP/uYRrCL2GR1hUuo+sEscGfXgd++rgY1DBBOP3pdP5QMqH5NVhEs8Twwi3qblnLaAdB/rju4M+VMrHLoSNOKQt4mA19Vmij5KRi60aS89mGKSlNnT9hpSeaMab3aCNXxNFMQaMAcnAsAkaJ/EKOMX4ZJZ8n8yN1+QxZ1NtMY/kpzEq7sB+hau55YCKLpuxO/Ilhm5AVGZSYGeK0bLrwWe8CI1wvDhjVM8sXvctLk+P8Nxgioo60dRrvVHrKkkorw7BE+APZPq7apvlaMlsO6tbJOE9R1N5R6ShMtuvB2+5ep3wNhW4Rle78hw2W2Xv/1aolYh2WC5YX7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JORyDp21KTXiJDU+0vsztEUCZGdGX0ygidfK5A3SGt0=;
 b=hUxO7s659HFUa5qiY7isr0XI5CJ7M9/3v4TJ9T2koYwHaM9MSF4/LNJyf+MLqT+YAF561lvV2ArK/6oegH35rH3ZZtpCtDjjrSdq6Sq/sUb3NnFX9H19UOXbJsA1DP4X0IsU18nwwaelkr3sQY9JQPieUFydnYImUQTKohYVlwGPf6PmN0DDEnHFCvXhRsYbkCK5N12j6IsIz+CqtijXztzZU31QdP43kZHESfX+/cGMSh4v4zOItG2EK09ycaY6j0ALoclh240UAV1n0QpKTRmuzwxCDV+5pcexSKrirCzfQ/fgPcqRnUGLHFppCCzpDZ7RcUZJn+ZZcF5G8KI9zA==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PA4PR07MB7615.eurprd07.prod.outlook.com (2603:10a6:102:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 3 Oct
 2024 08:13:06 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:13:06 +0000
Message-ID: 
 <GV1PR07MB91208331D8081625E6258F97A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 10:13:04 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v4 1/3] bb/data_smart: remove dead code
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::12) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <23dd9278-0f34-4253-aa34-dec974672442@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PA4PR07MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 1985446b-5efd-496d-41e8-08dce3833595
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|6090799003|5062599005|7092599003|8060799006|5072599009|15080799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	rXcuwD/SKFffr01yNgx5ob6FXGK1FQ7Tb5rBTzX5+WmxuP9narUNyeG498Nwqk2xSyYbJJOzogVme4AQcXao5OMsnkzOO6pNzmOeKZsVCcLmW0fnxPAdFkbeeN04Y6Ga73uvzmxXkB7uFnXOCRz0ggvSi0XOlsvBa4zt/GQIrJ0W09pmkELl79rlW17zUHLMB2+K/a9rryBwf+AAW5IFU0oCOtv8tYxwPP14GTc4UBtFiYmIcwVsks0OEMQTrpIGFI1VDZNFAWl6rHh++NouWlLKlu9Nke7bQZOHOWk4P0/gdW2XZ72AcohvVwT5TiYhznQwdlhMktAd8wssyKPiWzM7u8lqa03clw6scJiqIKEdc4jXnUq9vaDbtNhjJuYClATvzz/kPnXRqLoir+gw5f6V3OFvECBvUv/egVdGiuzpKFVTQ1L5plOA8ZIstH1mNToHyrVsm0eEmhbl9nRWQSC/J32E1okRFvsJ48bj9BUY/ym7m06arV008sBmUzc1ZlbJyDdhLDH6M+FSRMb16RT4c20qxIVDZ9HaXvHR61oVW5xJocDiB7mLbCYoifEwapajp5Rr2KVGF2xaBtnY8b15x+ZfxLy8yVSs3oYsm5+Oz5DzP0ITJCL0Bd9CWMn2CmJ9+6vDnFuMKGlTZOfH45pnf8IRN+1KW07IQywfWbWNP81nkxt2iI7XORh077LnmYQieQztRGX+LZOp/ACiRzT1vYrAezgq/NQY51rw8o4xXLZIESb33vPICcB2qO4giOFA08CsypTnK+17KnZ1TWO6tgsIzVsI78aR2Hyx9NE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGZLdHRQQm0yKzVZbHJMUitleFNoVWJLdGpmZkRCc2oxUmF4TE11QjVPbkk2?=
 =?utf-8?B?THpwL2NGQjEwVnFrblNqUmpCeWI1UzBaMHpEZSs3RXdHbm85THUvQ2l2ajlr?=
 =?utf-8?B?SFBXdmRUcXZnNCtub2NQWVJ0aWQ2YTlIZVI0OHZjaTk0VjhOVTh4N3JPeWYz?=
 =?utf-8?B?VjIrbUEvTmNZL3R2OHlEeHJQcjJnNWtNVTQwWlZYelhYTjhRVlE3c0dBaTE3?=
 =?utf-8?B?bFlIZk9tZG1DQXltTHNtWUQ1bGsveFZYZUdOdUN5WGdkTkVpZXV6cm1iWUxw?=
 =?utf-8?B?NXNweE5ISVdOa21xdis2d0k2VlQ2eU1LcXc2d29ySTBtaTNwdzVHWG5aZ0po?=
 =?utf-8?B?ZUk1dS9SaEhGUWgxUTRWemxPRjh5S1ZZR1o4NTZUamNSRVZLcCtKMVY2TlZD?=
 =?utf-8?B?UHE4ZkhDcmZNUFlLbngvK3Jabm5yNmo1SEpWb25XVE1kcCsrMVZSY3hmdDFV?=
 =?utf-8?B?WWVOckdwNUcyY1R4dCt4S25VdjR5MG1vWCtMMG1lWVBCTnhHa2ErcFRYS0JX?=
 =?utf-8?B?SG11K09mdlVwem9tT3ErRmQ0WGpLTU9HdEwzNXdFSFpTNzhRVXJMV3lVZzdN?=
 =?utf-8?B?ejBRRWduTDE4cWlqcGFvVEhwVmdDbDZTcElteFN3T1VlbkIzTFJnRFNlZ3lw?=
 =?utf-8?B?WGxPNmtWUUFtM0hZVndJV200T2hmeWk2aDZrV0ltWTRYalZ3NTVISUJyWWFy?=
 =?utf-8?B?enl1UEpLeEl5VktYYXByOUNmL3BiTENBMXdCcjNZWnZIczBSbXUyV09XMHNv?=
 =?utf-8?B?WDN6Y01hV0xnM1p4Rm9VNTNNV3kwOEtvRGxJN1BLcGRFcXUzek40cXd5ZndH?=
 =?utf-8?B?VGhXcGk4QjlxTFRCVjhWM3dmalFyVnhBbTJDaUlBeE1pVVhzRjZxZy9MMmEr?=
 =?utf-8?B?dFdveHJBNWs3ZXpxSGcrRU1CS1p6THV1S3VIRlc5bnFZZEVHc053Y1V0aWx1?=
 =?utf-8?B?OW84N3l0UUFrMEJvVlpYS1ZWdm9EdVdzZUduVVp1bUJ5MmxxUTVER3NBUndt?=
 =?utf-8?B?ZkJnd0pmWFhTVDQ4WWJXZGhyWU41a0lvNzJGa2lVL2JESmcwcmJSZU1saWkr?=
 =?utf-8?B?VzVtd0NLS3l2cmdkYkpZaDlsem5YSWJQZDJ4T1M1QWtpajdEbnVtNjE0Q2VB?=
 =?utf-8?B?SmdUM2tXMDRWVXNzVmVzWFVkdnVxM0tyemkrdEhkcmNMMTVSWkxHczlNOG1h?=
 =?utf-8?B?TU5iTWZJRklpcHdtSG9sU1VDVWIyUmFOQmZIeE9sNENYaDE4VGV0NWU1OVFw?=
 =?utf-8?B?cG50bWpPWmp3VHlxMWEwdG1HdzFqamZXb21XWWxkL0ZFankzMHJpRnFXNk9x?=
 =?utf-8?B?U1Q5b3QwbVNqa0pJNFpvemRZVDdTVnRCZG5vcWd6cEs3K3BGQUNoZ1NyNHY4?=
 =?utf-8?B?amlndVRneE9lWVZpYTV3S3hCSWYzaWJoenh3WGJsUXdURUx1SDZUZXNKenZV?=
 =?utf-8?B?TGV6OGpSZUxtUkcwVmhKV0NmWkJoNzZHWjhiRFhIK2MvU3BtZzdoK0FzMEl0?=
 =?utf-8?B?SXpoNWpHR3ZGMno2SGl4RjZYZ3I5SzFNWCtrbTVTLzBYdEZPSVVaRDNyMFBi?=
 =?utf-8?B?OVNOM1drYVl0SEF6ZXNYTHJrdlVXMkcwTUVXT085bmV3RXpMZXFJSURxNWU5?=
 =?utf-8?B?ZmRNMEJENmZHMVhtTytRTzRJY0JxSmhjWTM4S1RYMElOanMvZWp4RS90SlU0?=
 =?utf-8?B?Vlk1RmowWEdFVmRmZWFlbzg3MzRvRFFoaUdxN2h6ck5LYjhMVTZRUjEzREU1?=
 =?utf-8?Q?JT4qSUYO/cXbAE2+yI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1985446b-5efd-496d-41e8-08dce3833595
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:13:06.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:13:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16627

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
  lib/bb/data_smart.py | 2 --
  1 file changed, 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c6049d578..4e15a43c2 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -320,7 +320,6 @@ class VariableHistory(object):
              else:
                  o.write("#\n# $%s [%d operations]\n" % (var, len(history)))
              for event in history:
-                # o.write("# %s\n" % str(event))
                  if 'func' in event:
                      # If we have a function listed, this is internal
                      # code, not an operation in a config file, and the
@@ -540,7 +539,6 @@ class DataSmart(MutableMapping):
          return var in self.overridedata
  
      def setVar(self, var, value, **loginfo):
-        #print("var=" + str(var) + "  val=" + str(value))
  
          if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
              info = "%s" % var
-- 
2.34.1

