Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C8CF856D
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:13:32 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.10])
 by mx.groups.io with SMTP id smtpd.web11.6438.1727943203740465062
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:13:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=LZVVCB3l;
 spf=pass (domain: outlook.com, ip: 40.92.90.10, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2xRVBi9qYadG846LjSbRLJjHcZuimHz4rFEyxPa7qmJmi55gVbohO72PcMRiIhysVtZ2nlXYh2Yv2SlldfSdGfZ4LHo5ecrIbhGZS01HgImyV5o2KcLgAS6MnoozHX1AlHppm8DCNsWbI6nCH7hRghxwYBIzfHNztYcBxMX+TxOpqhoWUyptnjiN+2/JNvHxHvLlRGGdYCPP5juNQPi6lvY/tdQY9MUwyVlDyxP8NTGoI8BGzAksVxEZMF/14DnyASDjN/W32B5grjVnUDdWyCSWpV/L9nEGA42QiKWCsXotXEbDPLo95zmOhve40TfzOXV1psyALDygAQkMNDT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF2gOiI/QfLCquL4ZtuYoivpq4tq2dkXEk5bewbsh/M=;
 b=VqQyS7IPcXs3e9tuD2dk0R74m+uPVnmhSsu3WSTDLhyCRtuFFhD6zjBMoCX29MTCjRsqo3fMMuAdilvwSmwqmh94cZqVEK3B+N4c4rF2ZaWlJR2Yg6s4HQWCu0Uo2c6X50e3am46MN4yHwuyWepreVSCbS1PLsuCogxcO4w5qFbzgm2MnDPN+GtXJoFgBZEkt4vkEl1fCqlTmg7rqdBsVo5NagDS7cpRFNZzUUVzbRy4TH55oz7BB11FSFvBC1U/lBWIZGZnLYGHr6OoQGqTIQoctROvMAVyzrCyg3sscPgIpUUPeHi1f7sqs5w83xR71AP5SDfzTIBgg7c2CaTkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF2gOiI/QfLCquL4ZtuYoivpq4tq2dkXEk5bewbsh/M=;
 b=LZVVCB3lC5Zikxy+1vUJHft+qjSUIPQ1DffD0NmFGe3UdE8lty03VG15JESD3LbzMsCTG7f2zvULQdONrSwnklWoaS4ieB2A9FEzLIJ36O99b3yObeMvoGEp4z7l3ZyHZ36ESwRCsqdRrGgInAvu2a2UUYDRUtKKgwGCILwgBAVjwKPr5ECrldQA6fpxjEEMWK7RuObwetoDzsAepjIiK0/6xlFHfG9FiiplsECl3qxB29BzOMbhN3g78E6HENqRna86cRnrQvIapGALR9GzBxvkfdAqvoIa6HoFNllRdgzBSvJp+b+SkIvCErXFKI0Mm31koWHjVWeWZsg3ipXxhw==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PA4PR07MB7615.eurprd07.prod.outlook.com (2603:10a6:102:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 3 Oct
 2024 08:13:19 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:13:19 +0000
Message-ID: 
 <GV1PR07MB91207B4781549380AE6B9B89A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 10:13:19 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v4 3/3] tests/parse: add coverage for old override syntax
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <ab7607e0-8540-46b6-a02f-17d83f21038c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PA4PR07MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f16f0c-734e-4274-6fd0-08dce3833d8d
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|6090799003|5062599005|7092599003|8060799006|5072599009|15080799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	qq0/tqu7wpitnsmUkj/1meUvIblxHNmRLXLnZmBg3q1n2oi7Y8jgN2S5odfuKc/r0QuD5V/9YTCjRS/S+i4le0DSUXdX+dlO4bnb3fLzTUg6q2wCxX+vj+gkZNEW8+gEa+gQ1WQJaPjt2kAInvhH96wLtnB23nAZRRp5mYI/gK6x952g8vRdIqAazeJ1T7/JsqIygNA7MrUq0sdGYvXinDESspZWi3jdvjaKgP6Eo5OpR5bBd9/Rw2WnGV2mflgdqIa1YoO5pqvq0AwQBsO/kL38/y/RL5LHUO8025ylCyKF8r4Dsw8rjRJqo3UgBQnmwk/O9NOMSk4s6fHH/OZCWcHau6/bhC5C39lwf8+LBBpMpiV3e0buPpGvu8mo4FvuQixQsM5LO61Hediz+KnI9rlr61h59J5sHiuPZ75RfyVw9SgekkTmTXAhYX5RHOHPlBDXWN0ctT+c01NQ89pqztAhptyVyxx2YrKsky8MC39PyKvyiRafbBmm8SbfI4DIS4Kbi8usPktIEpcCXrirVUBsNPvB+tS/2rjXhEk7CV3yF7hJgg4hsUcYoKJ65NJjZe8blGa35Iny3rAEa+V+468TeviEkg72k1eQgI0JWJ31Vxq8I9a/O9xMrXj+AGCyYTQf6sNeSKAHelNUBtjQuE7jwBaGdsCc4oBAFD+etUF0e31nYkgw2DBa6YIK7kttdMNAe8gRbu2C0FUtyIrQC9zvGeTxEvt84nhQpNgb2fCMGhnQQ+MOW87OqVOntqa7IBCq3ogIYRopmcuczt50WAOLaeX7dxzsHwCehJV9+wE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0tYVk40K29ueVN5dGIxUmtiT0djRHFXakthWkErM0d5dzdLZ2lQRkFSOG9U?=
 =?utf-8?B?Mkp6ZDVKOFUrS1ozeVh6TjhnS3N2T3pzaEw4MlBnTmd2UmlaZjh5NDVtR2pE?=
 =?utf-8?B?TXovbVVrSTV5SUxDMVlCMkd1UWxnZStqT0NsQmF0NVNWc0dlWFFUYWZEaGVZ?=
 =?utf-8?B?QUtWUXBIem50bUtDdStsRkFJU05TbDh2L21ZdXZTb01EVlhES2pxRUE3UVVa?=
 =?utf-8?B?QlhFVDNiRzYrWk4vV0ErTSs1YTA4QkdYSmxnODBYWEh5MDIrejB0WGRDTGIy?=
 =?utf-8?B?VnhlcThNbnQ0Q0xXRjdLbGREYkErWGtGbjIyZXE3dzA0QXUreTNLSHI2QmY4?=
 =?utf-8?B?eDM5ZnpmZllwcVA4MXlVVHZIUjdLMnkrYmh1dXluSGVDMkVwdEwvMHJGeXEv?=
 =?utf-8?B?aUU5US9sVWQvb2dybkp1andCempMcVMwdEEybXhqMHdqQzcrZnVtTUE1YXZk?=
 =?utf-8?B?VmlLRTNRTmR4eHhDZWw1SFBPNVFIU0syM0VPVEZJbEZuOHpDMUdNU2xMY1Zr?=
 =?utf-8?B?aDRhTmJwL0hTWlowSlFvWVJpbFhHblhVOUJ1WGRPdi9iMVFZMElITmlHRXkw?=
 =?utf-8?B?QnlQbEg0VEwvaUJvWE5hOW1DLzZRRlRFUTNicnpwNk9wdW1hMUJhcDgwbDU1?=
 =?utf-8?B?ZEtOdU5PZStoN25PNnhhRG5KWlVMUG81MUxtRUtlbWVhdFJMM1psd0d2S0tz?=
 =?utf-8?B?NWZ6ZHNoVkpGTVgzUVJkcUU5RHFZVGxXZ2EvK3JtKzdtRHZqMjN1WGFNQk16?=
 =?utf-8?B?Qk02VGNLQTVZNTh4eTRxRi9IMGV0Z1Y5djlWNTZNTjcvWThhZnJUOHpCN2wv?=
 =?utf-8?B?Q0M3bUZzbHpnMTRuNE1KZ3hqV0tzaEZmMmdTOTAwKzMxSXlUWnJnaml5emRa?=
 =?utf-8?B?UEt3UVZkL2JVL2xGdlJwVEhHdmNyd1plN3RBTjV6RWF5bmMwSUxydmFTTEpS?=
 =?utf-8?B?aGRrOFBFVCtscnRXMlZJYkovWm02bU0vY09odEd5R3ZBOVRqaFZVRU0rNExq?=
 =?utf-8?B?KzBqVkxnOGtXMVRGdGZlL3hPUnlyZlZjUzVodFc3LzYvMEQ1SUdHQkRSSDNT?=
 =?utf-8?B?cjFPNGZ3V2g5Ry9lL3JJU2xCQ1BQTEQweXVVM0czSzJEd1VSS1BpVTNIZEN2?=
 =?utf-8?B?VWhBT00weUhQS1d5Q0NpZEtzdmtNWlJkQktxa05SdUYvdXZZazJsdDUvaWlQ?=
 =?utf-8?B?Z0xuZ00xSGJ3UTZKa2NPTjRPUlBoL3kzeEFrT3hxY2w1WHVZSXUxU2VySUth?=
 =?utf-8?B?d2wrN0lRVVBuTUphNEIySGFWNUFCemFGQWx1M1lxS0w4VXljWlN3NmdrYThh?=
 =?utf-8?B?TU84UlhFR0lybzN6bDdlVldMckNqSWZHdzBHS05YZXdwK240RTdMa2p0SDhV?=
 =?utf-8?B?a1VJU1o5emVES1JOY0Mwb0FtRHFzT2Zod2hnU1djUGZHMk9EK3Q5SG9sWVht?=
 =?utf-8?B?RXNJTC9acnY5RE1tTjV5ZEo0TTVERHRjYUlXN0g2bGJQYnltSmVCcW5ra1FW?=
 =?utf-8?B?dHY4QkZjWTdjK3RXbFUwS1puVCtMV3dKMDhmWEgyTklydkhZQmEwVTBjclhS?=
 =?utf-8?B?eVRibVgvdXVPSEk3eUUxMWdVMW9CdmEzMDJNakN3cG1aaE1Da1JFYU84aFhL?=
 =?utf-8?B?T1c4SVJPdFU1ZURndjB1NGFxdHpHRGJIM2hEVnpmeVpnQlZBaVR1Yk1tbGFn?=
 =?utf-8?B?NE5aMTBaNGUyTDNmZ3czNUpuYk9XZS9QZ09aR3pBUjEycU5FSmZ1RkNwS2dR?=
 =?utf-8?Q?tZLd152I8/8nsQJmLk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f16f0c-734e-4274-6fd0-08dce3833d8d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:13:19.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:13:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16629

including previously unconvered tests for true failure cases of
_prepend/_append/_remove.
In addition add tests for not valid cases

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
  lib/bb/tests/parse.py | 28 ++++++++++++++++++++++++++++
  1 file changed, 28 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 410679d5a..e111747ec 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -126,6 +126,34 @@ EXTRA_OECONF:append = " c"
          d.setVar("OVERRIDES", "class-target")
          self.assertEqual(d.getVar("EXTRA_OECONF"), "b c d")
  
+    override_old_template = """
+EXTRA_OECONF{operation} = " c"
+"""
+
+    def test_parse_old_override_syntax(self):
+        for pattern in ['_append', '_prepend', '_remove']:
+            f = self.parsehelper(
+                self.override_old_template.format(operation=pattern))
+            try:
+                bb.parse.handle(f.name, self.d)['']
+                self.fail(
+                    'Pattern should have raised bb.BBHandledException for %s' % pattern)
+            except bb.BBHandledException:
+                pass
+
+    override_old_valid_template = """
+do{operation}something () {{
+   :
+}}
+addtask do{operation}something
+"""
+
+    def test_parse_old_override_syntax_no_warning(self):
+        for pattern in ['_append', '_prepend', '_remove']:
+            f = self.parsehelper(
+                self.override_old_valid_template.format(operation=pattern))
+            bb.parse.handle(f.name, self.d)['']
+
      overridetest3 = """
  DESCRIPTION = "A"
  DESCRIPTION:${PN}-dev = "${DESCRIPTION} B"
-- 
2.34.1

