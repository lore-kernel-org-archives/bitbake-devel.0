Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E99CF649A
	for <webhook@archiver.kernel.org>; Sat, 28 Sep 2024 07:00:32 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.92.49.98])
 by mx.groups.io with SMTP id smtpd.web11.9180.1727506826095922038
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Sep 2024 00:00:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=kjHgmO7z;
 spf=pass (domain: outlook.com, ip: 40.92.49.98, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmTKOUiuAc7cbU+Ez/m0UHMyL5XNeSiCHXnL13Okfr3SThPX9p/bGLCC+lSRMRkp+U5/oCbWR+vkRaaqOUPs87XelySSZtBY9f7wOCie5STWRnXrm4vKXQ/le+mERcH8+mk6L72dN5a1+iMkM6xeWOAftukAwC7AarQaZyK43exSfxhM0cFCv0rWzX+IWlXWqmt+bZOWZwzgUl3Q9DIPSBHG4nLqnYs0J3mEvLwAx2NhsKosTeulbRYWeOxpQwslsVVNCmEi9QWX7DyWcmOlUmhEyyPWDVC0UKYTe0nPkZMFNatjkGGQoESXmTEJaLPsVZcFL9hFFzHO7v5GUdEQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ov3C355UgNZCnsJLM5d16CGXQSJGnBNJ/E87CwBzhI=;
 b=dzcp/wWkGGmPRQ/fwWWnU2Rd2fN0D3SIvoxs8550SqGCZUBqwZD0XDqtQ6JbkszzQoRFB0+PZpdMgy890+3GtB3qMeo50FWdfRmhOWIPuud9JWcTUVhfJkgRQDKjvwFzjA7lkIMxmDErn3ts8JRgu6eN6vjrEAtKBtHtstVl/KgkJWvfJTbB+aQVVWRXJ1N9++3HjGWOg9RMUbEdt2BqqJmT0JLMsiqmgozitbvZZ08sDab76QQYQCHS3i96GW2FxjxexpqOIRMVp+Y4aLsYCs3G0exz8+RsKBqwV5VM5iMQ94ns0yjCw6a4q1OPg1rgn7t7xKoZV0wV/gPEcl8EQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ov3C355UgNZCnsJLM5d16CGXQSJGnBNJ/E87CwBzhI=;
 b=kjHgmO7zwuNVuY8/HCddNBe2oGx6PT7ZW+F3HHCOQyPrcG6yDR5rLXrCh9IwdzxPLrhehlvZR0lZqxa5bp1vkZtXLxVlQ7aoNIDs9OQfFMoJWVqIE5JzR/t/GcHGCipYfAtPBu83RuP/FQoY5iOM49wuhFfQlLnUI53UOKRIbPVQJK64kZo4uHWZnZ19AxUvzJm26pplWjxl1KRIb2POLkWvPF/B1gkldMJCG8kNpKpZsNirPTV2DEEuZ0pYNbvigL4cXvcuLrH/W94dyBTGXwcdxfI7AUjJLiKIc4WNemPX0SrFBMx4oJA+m0jMbNZ2rBZIOOrwr12gaciI2htq5w==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 07:00:19 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8005.020; Sat, 28 Sep 2024
 07:00:19 +0000
Message-ID: 
 <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Sat, 28 Sep 2024 09:00:18 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 2/3] bb/data_smart: fix override syntax warning
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <73b7a342-3cf7-4fcc-b73a-a7add197c89b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|DB9PR07MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: dad54c37-37c1-40d4-fde6-08dcdf8b3703
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|6090799003|19110799003|461199028|5062599005|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	9Cmc+wgpYYeGwlc/VOA1oF2Rw1ofuHxOe6OjIZk07cHUr1fG1nAruBrsCEULqsjhnDbGugyALOKmk4TZusVrdoWSffqoO4UzvXI2f9yhLBHxnumCv/TxZRmfMFoRrfMuO5WXya9q/VLwxF04hNjVGK9m+yata+v163GzTdfgnOSNS9effi3u7mE97+xTIl9a2lKbyYstsGfceG6waBV+1AiYrcOc6DxJJw9f7o79ESb85MtF3DiknPcTpN+Cpa+VABW1lTVMzaOajho9RF0W+68gPsMK7QeuTfu7DyBibKJROdC072SZIvnJupEBKm++nWCA2vV7tQnnkaasLFo0oPHY3kCT1myuaqscLlHbDdaFjC8OqbbNQH7xfcnh7USRBiY5LdPRCSJo9nW12NazoV3Zi6r8KrceozSy5nXALotWgN7rGYOj12bq4aszfw+d5MuJFftJJX1WkNfOLLWS+jqsGDPy2IlG+tQbnFsjZ1bumiA7y2gpbD2Sjv6j1023S1NypjqFqPStMQbkkcrU7cUThkhDYwwnDNrVryoFu5tbQ4fee4C11NbZMlkUNTQpTRDS+otYNxLctQlu44ASlM3Gvz8THcwnh+EL1vm0bt1c4IqTQxXRw8tnuOetId7d5kMEuXDcxoOFNekIKcQLWLZda5JrH12OMZzZIUBm+K3WlpMHdnGQVbFEiQfibjIMVbFXfmZQ2wTq6a7ElN5DXtlAgnZkTxJj78bEWRbSW3PB5z/W18rfcbleOSEttT1YS8B7fFeoEzIr1pAuLeYSObt4z6K2FCmuBtT0syLT4as=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXJuSmVWSURSWE4yQWdvSjFQbkFBd3NPZzdUeW9NMWRld0laQUV6aEZGYUk0?=
 =?utf-8?B?ZDRIWXZzM1M2YW9FVnZzWGhqSzhWSzYrVEpnNVZuM1hBKzdQNkJxdk9Xd0xz?=
 =?utf-8?B?U0lRQmE2V1dQZGJlLytsd203MVMrRDVwTUtYKzd0ZS9XTDBlaWZIcWd6N0xK?=
 =?utf-8?B?ZWZxNmkrcGpXMHFwSVBNcEoxb3NsakNYN05YL1J2QU1xa1M0eHlMaEt5a1gz?=
 =?utf-8?B?WUMvNFREd3IrNTN4K01DMlR0R2M2aWtxZXBORWd3bVlpYjk1S1Vya0xKUmFt?=
 =?utf-8?B?NVdqTllvQUpnaEE1WU96M3E4OFA4aDgwRDZHNk0rKzUyZ293N1RnRUVFbmhG?=
 =?utf-8?B?bnI1T2E4ODR1VEQxN2t1bUtWU1BaTXNJVHBCdEw0RU9sSjMyZTFRUUY2b1hJ?=
 =?utf-8?B?dGlMdEFpci9ZU3dMdWM4TW5FSm0vTjJYOHQyRnVJWVlFU0RVVDhEZlZqREox?=
 =?utf-8?B?RTRWcTZ4TFJ0VmtRcWVmZDJXK3ZFTmx0TUV5VzhFMUVrR0hOMk0rc2w4Z0NM?=
 =?utf-8?B?ZFI0bkN0MGpNaEwwWFVybUh4aHc5MmFJWDg3c01NMDJ1bFJucUhmNlNnTTA0?=
 =?utf-8?B?R2UrWHlxRkZYRWw1VlkxakY1SDRraEpJbmt0NDVyWlhjanRROVZJWWwzd0JC?=
 =?utf-8?B?OWgwT0gwSGlRR1BJZ0wrMEJaN0J3WmVwVmluaXcvNFVLK3Q0bXVKS0VCNVhz?=
 =?utf-8?B?SUlTUUlYSDZCVjl2bUhRUUtOMVBvT2xhNGMvQVJ6TDBlN0dZeHBGZVhwV3Z0?=
 =?utf-8?B?OWZxNzVqbXd0ZVBUVHFLK0hJUnZxcUFEaXhTa1RMZ3VCSVR4TEYrL1dKdVVP?=
 =?utf-8?B?V0duVktIdUJta2c0c3k5NGxyRDBDV2krTG1MVGNXRlJzVklZbm1scFhFUGQ1?=
 =?utf-8?B?YlpTVHFNMGp4WHAwcVdPZG1lQXB6TWR4bGVOVXNhdm0xclFPTXRlTFlzZzNj?=
 =?utf-8?B?ZjJhcUtJbTJGZ05LM0FEWk1qaGlvMUZtSGVNc2tWSWtDUDZCVllrMnlRaDB0?=
 =?utf-8?B?SXIzbmljTk5JY291dUdZcWNRTjBSOHJNZU1CM1phZVpBV3MzUm16SWREZWpl?=
 =?utf-8?B?ajJwWGR2cklqTVdybjBQVExMMW8vR2xDOU9yS0c5dmpzQUthQXFaSmFsVkZC?=
 =?utf-8?B?NGdlWVR1Y3haYndVUDlWSXk1dHZ0U2NCd2hTeUptVnBnTHB3a3dMby9TMExS?=
 =?utf-8?B?YTRPWkVwc05uSlBRSFMzcHNyWXM2OENrQldadWRxZnVVMWZXcW1WZUt1QlFC?=
 =?utf-8?B?NC9KQXpTeDNhRmE2MTZ5SUh4MmZ4UDdKcXJEYXRPRGZTa1Y2RzFGTGNiMXho?=
 =?utf-8?B?Q3dPcWQzS21jMTFlelc5ZG1lb3YwRlRQZWt0bFUrTUg4eUZBelBBRWdZdCs5?=
 =?utf-8?B?WnZIcm5Ycm1mb1U3MDJaQXVuV2hqSkZTSEpUcysyT2lxeno5UVYwL2VzSFkz?=
 =?utf-8?B?R0Nlb0tHTTVvQVlLL2tFWDA3bmZxOTRkcUxmQ1lQVlYvK2pMZWVCVlRNS3ZT?=
 =?utf-8?B?OWVQa2ZGRmVVc3pVcjFBUmhqMVZkS3ZJMTBJOEJobW00WEN6aGFaY2ZvOEN1?=
 =?utf-8?B?MHhzMmVYSDNsdUZFazg3VGowbVpNN0U4eDEyZisvVEg5cGRnK0dFNkIzdkdl?=
 =?utf-8?B?ejZaK053K3NhTWdVZlVTWHhqbVB3UHIrTkxoNnFNZEQ4ZUp6UmNDRlh6eXZu?=
 =?utf-8?B?MXJjTWNLMzBhN2dGSDcyK3hiTTFqWHl0cmszQzRNRnRIV1ZGSm9RTHMxTEtC?=
 =?utf-8?Q?y23ozygJY/EkBdBbkWz/a3cE/hN4fL4+72lW0OR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad54c37-37c1-40d4-fde6-08dcdf8b3703
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 07:00:19.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 28 Sep 2024 07:00:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16613

when defining a function do_removesomething,
the parser warned about

Variable do_removesomething contains an operation using the
old override syntax. Please convert this layer/metadata before
attempting to use with a newer bitbake

correct it would be to search for a override operator at the end
of the string or for the next operator.

To avoid running the expensive regex search on every setVar call
the current "cheap" check would be have to be triggered,
before the more precise check is run.

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
  lib/bb/data_smart.py | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4e15a43c2..0523744de 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
          return var in self.overridedata
       def setVar(self, var, value, **loginfo):
-
          if not var.startswith("__anon_") and ("_append" in var or 
"_prepend" in var or "_remove" in var):
-            info = "%s" % var
-            if "file" in loginfo:
-                info += " file: %s" % loginfo["file"]
-            if "line" in loginfo:
-                info += " line: %s" % loginfo["line"]
-            bb.fatal("Variable %s contains an operation using the old 
override syntax. Please convert this layer/metadata before attempting to 
use with a newer bitbake." % info)
+            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is 
not None:
+                info = "%s" % var
+                if "file" in loginfo:
+                    info += " file: %s" % loginfo["file"]
+                if "line" in loginfo:
+                    info += " line: %s" % loginfo["line"]
+                bb.fatal("Variable %s contains an operation using the 
old override syntax. Please convert this layer/metadata before 
attempting to use with a newer bitbake." % info)
           shortvar = var.split(":", 1)[0]
          if shortvar in self._var_renames:
-- 
2.34.1

