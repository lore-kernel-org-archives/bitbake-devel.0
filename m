Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B4CF856C
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:13:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.49])
 by mx.groups.io with SMTP id smtpd.web11.6436.1727943199626435709
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:13:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=CulAiMlC;
 spf=pass (domain: outlook.com, ip: 40.92.90.49, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP2hwfVuKw+IiqhGDH8hMUCknb4CqsfMG2ycBspYT/d4gBNPoMoTEklxZXfVbpDYeMFSBv+RvrBhHk3woplk2x41moroFsNpeNo9e4ZSChqG0yihAWF3I0EbekXYAQdSIhooiVFM8nwkf5/0tCsTsvTn3YC0JxUccfAliclD7p9FBSg+mbQaYdc6Fm0EjoX4n7tcDtU90BLnP9JvJS5ZWQ2gpmoaos/AuvwwTHF3Q9KT2SnV01XNaT91hGe9pLmE0KaQ3nujrUubeQ5JxXEQc/4Hx47kilOmpXm5DXhinMROTxjw9KMVQ2IAjXHr493HiUuhB8+O55P/W84XQOSCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCFiEG0iaLqVjodD4Nk+bz2bKtczZeRwXL4mxX7RZ6M=;
 b=IIjBey8JgeEtpUMdETTkCGeBGqsSx8mgDvnLfXZWfchS6ZuEPcLiae5tTohyxWLn8LdBSW7+Kg4QSKRkkBx2BAYH7d59BPbnMm62yqztMzNNneXh6N4JMe6o0fVyt+56skRNBLSt4oRQy95yEk5MhMiWRCNBCesY1fBc3Ta1uQ8cgQiwENnpJnoKe0wS1e1rbfCDSlm5pX0Zv/BmtifD+lr0M8JBacFlbSqmuXwv1UfH2die0y5HIyL1M1hMNXRL3VHjG4b9jVaRJdR7oVpOfH+JC+SWw8WwJOAfEdPnyirdAFUwpQdrA15WwTTqY1Xr6YiIIt7D+0dAZ+S+tKZITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCFiEG0iaLqVjodD4Nk+bz2bKtczZeRwXL4mxX7RZ6M=;
 b=CulAiMlCbMGLeGmUGNI6bQ8bfam/As5lq11Zgx6gS9wiS+Yf4HHQ/M/egb2RM08g6+CKzIq/ppb8aCDvy136fD24zy64gk29MVdOKNokP6uIsSlEqmZCyCmpG8rKOBz7hp36Bcgx76PAkSixF2qVazP4zrgyAjCAH2hqcormHZCQSaCO7e84Wzs10cEsojfFfn6n7FLHrk0jzE96pcw3N/1/PKuGsl+heT/K8bJBIgLgYiTzviJ89biUJOqXxX0vjvAX3SBYzGPqSGXxlFr1hcWzr673VfJoRFdQivYgY724zZx69E04UnkYdwd27Nhzm91sbbzmjNRZTASJfHaqqQ==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by PA4PR07MB7615.eurprd07.prod.outlook.com (2603:10a6:102:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 3 Oct
 2024 08:13:15 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:13:14 +0000
Message-ID: 
 <GV1PR07MB9120D47783B36E780C1BF012A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 10:13:13 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v4 2/3] bb/data_smart: fix override syntax warning
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <e47e312f-95f4-452d-9627-c9f869b0a3bb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|PA4PR07MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: efcb8c18-f3c0-4eaf-0a34-08dce3833a8b
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|6090799003|5062599005|7092599003|8060799006|5072599009|15080799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	UE6Y4z/ed78rqLykYDGozWq8C9lrGPMFBo8LL3k7TeJD0Zu+byfsNsaZgTPeRL/Qd4aehjR3l55kIw/k2i86ImmVHctavGFcrUd6UWc+myh7plQZT+ESnjt6pBkJ8yw90neKxjP/DFePwTzTn8193Z8EfM21uyY4H6lkCU+zAZH0INiiOVZnTEiclw7S80X/8jOMwx2mOFBPBJpULktyRJWd/TKVQMiZej7yEWXHbKcMB6/a1KmPLQSz8Nbg9sRsNTIKvBYwM6bo9T2zMPWUkbhmGjw91/mMVmbxps7+CvqFoH+6Z4lZDir98+xu2VQDccx9cLKvAmZklCxIuXDSTrxwiNn8Z5jDFONE5a59GnYn/nY0PPwz9TcnFxnM/Isu1XQZP0k5HI5GjpwthZOaTrlrdAJaegGoFkalz/1vCpLHNjo1xGA1ya7PKFl6y5hI8847Ext49awJEfZjaRXPuY0LW0wYdke3JqaPt/k40eOtnV5Vf7vWZlJx+Gu8cNe/wwzE1cKJ6turU/cu56gh3f/3CBE2MKXm340SJzqACJHSpUZB/q0BQ0LIsBn28cMMQR0CNdyoYQPa+s/nUU/HB+1feoIgYK6e2nsyi7lXeu6yqxu7xTPnsMxdXVeEKnZiIQFHzL5m+tvphUi/ubs5fxfw7UC3/A7NNbiVPE5bZWrjQLh2h0r7Mfjmv//iztmYHBakz/oJCDkjgTCpET0yohz4/4QwA6iWkKOA1pi5OyXtvT4z4BTctFHlmgNOBaokXp4W2cubP/ECvR8B3rZu1MqX4Ax0gud/n6dczMgaHgo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmJGM093K0gzRjdOSTZXUFovYjRSRVNLSDZJWVo4S3RrOWpXeHFlblJsN2NC?=
 =?utf-8?B?b1IzSjAwc3ZMR2tBNjhYMm1JelprOFo5SFgybU1EbDZoYmh4YU52MDZ1OXdt?=
 =?utf-8?B?RktoM1k4YldFV3NlY3VMRnBlQUFkZkQ3czBWRGNBOGdsK3R4djNwTHdVUTBC?=
 =?utf-8?B?T3ZDRmZSekZrT0VYRFVOY1FMbVNsMTdXUmZOVmZrc2lmclErSzduVFgxSHFT?=
 =?utf-8?B?TnRQTkV2dzd4cXN5OHJGbGRqcWRsVXFEbjRyVDJRUHo1ZHlOWElmVmJrVjYv?=
 =?utf-8?B?dHFmN2U0NDZ6WFdkVHU4MVc0RTdwUVdYR2RKQ0RMRVA5ZWdVa3BjQzNnWXAz?=
 =?utf-8?B?K0xYNXNtL1Z1RlVWeGVkN1AyWGNha253YUt2T0g0SFVFL2lGSENDMWdZNE1B?=
 =?utf-8?B?dkRIV0x3ZkZFSE5ST081elB2Qm1JNisvbmN3RGovZGVGYjcwbFNWaUxJVnFQ?=
 =?utf-8?B?aDlRZ1JveTM5SldBY3VUckpTMW1HWjRWQkdyQStjbjJOVllnY1BMOXJwamhz?=
 =?utf-8?B?TU9UQzl5UHZqOWNHdGNpWkt5N1YweWJRa3owR24zSXd5cndoR2hDWUdVNGFt?=
 =?utf-8?B?cGRsRDBJQmxoSElqRlRZVnRnalVYMFBGTG84UjhOZ210L1JsSk42TVU1VjNu?=
 =?utf-8?B?V0F2WG9XczJrZTBZVk9PYklBMFZxbiswYUtodmNSa2F6T0s4ci8wYVBGUmZZ?=
 =?utf-8?B?eHAxWjBDRysxNExlTVo0ckpwMGxud01Fb0J0cmhycVFrUEFkbTg5RFVRcEtV?=
 =?utf-8?B?bFpWQ0N1RVVjK25PNVR1d0I0YzhKODFxU25CQndxS0diUExFOEJONFhCaU5x?=
 =?utf-8?B?ZkhpOFlJQlM2OHJBdVIwb1FlUmlrY05CRDZLNHRRTkwzNGFLQlpySnNxR1lk?=
 =?utf-8?B?M3RIbzhGUWdtL1ZOdGU4WXdMU0tNRW11QzdpUzBxTjFkczFua2Q3QWpzOUlj?=
 =?utf-8?B?N29sd3lVNC9PWFh5empuZFFSK0V4TGxOQzVFRWxMK1JXZ0s2MloyL2crNEhL?=
 =?utf-8?B?akJRS1NUZnRrQ1RSU1h5a0piakRVMTJyR2Fab0V3dWYvbjV2UHZaSjZPUWRQ?=
 =?utf-8?B?NlNvaUtJL2ZEYUFrS1dqai8xZDBqNmkrb3A3U1VXVS8wNFA1M0dDRmZUSkxR?=
 =?utf-8?B?b1pKUUU5MXZvS1JjUFdValNZWHVQQ1A2azdOMlpEOTcrSjMxZTlPRWRFTzEy?=
 =?utf-8?B?UEZTYzBmbjdJZVdCaXZxTVFVMEtyQmw2Nmw1YytBSWdqRGlFV3NCaksxSmxB?=
 =?utf-8?B?ekdsblJhWE5uMkQyci9UbERoTzZjTzBoMXI0a0V5L3F5MmdVQ0M3NndlanFu?=
 =?utf-8?B?cWVNd0lQNGFkM0ZrNnk3NHZiZnE5dy9mZGhwdU5xY0dFMzlyU2doZGNSUkpp?=
 =?utf-8?B?bjRhMUx3VjZFY0ZYU2pZaUYybjdWamVGUmxOeDZ2b0xtTFNVV0xwWUxUREJR?=
 =?utf-8?B?bkNlc3o1TkdtMjY4b0tVbGlyMEVLOGdJSXhPMmJOS3IreElqQUFSS1g5Ukd5?=
 =?utf-8?B?UjZCTmZQSkpjK1VYUUttZ3haTDZWeUJJN0xoTEp0N0o3Si91TWVrL1U2MXhQ?=
 =?utf-8?B?bVg0Q3JNcE5odldoMkdmZGxGTFRnTE1NRFMvS2dnZWdzSHVLYTdDaGpMb0tR?=
 =?utf-8?B?V1BLSGFGVXJXUzJQaGJUWWt3Y0wvNUo1L01MWmxxTC9uMXZ6eHQzM1FUc1ZZ?=
 =?utf-8?B?aWlVY2s1eUNJOG5ycDdhc29Pa0tTWTE5QlVZdVYxa2loMnRGcmtmREZST1Ft?=
 =?utf-8?Q?SHOGbaGgjn33+hqTF8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb8c18-f3c0-4eaf-0a34-08dce3833a8b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:13:14.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:13:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16628

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
  lib/bb/data_smart.py | 15 ++++++++-------
  1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4e15a43c2..bd2716b2b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -35,6 +35,7 @@ __expand_var_regexp__ = re.compile(r"\${[a-zA-Z0-9\-_+./~:]+?}")
  __expand_python_regexp__ = re.compile(r"\${@(?:{.*?}|.)+?}")
  __whitespace_split__ = re.compile(r'(\s)')
  __override_regexp__ = re.compile(r'[a-z0-9]+')
+__old_override_detailed_regexp__ = re.compile(r"(_append|_prepend|_remove)(_|$)")
  
  bitbake_renamed_vars = {
      "BB_ENV_WHITELIST": "BB_ENV_PASSTHROUGH",
@@ -539,14 +540,14 @@ class DataSmart(MutableMapping):
          return var in self.overridedata
  
      def setVar(self, var, value, **loginfo):
-
          if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
-            info = "%s" % var
-            if "file" in loginfo:
-                info += " file: %s" % loginfo["file"]
-            if "line" in loginfo:
-                info += " line: %s" % loginfo["line"]
-            bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
+            if re.search(__old_override_detailed_regexp__, var) is not None:
+                info = "%s" % var
+                if "file" in loginfo:
+                    info += " file: %s" % loginfo["file"]
+                if "line" in loginfo:
+                    info += " line: %s" % loginfo["line"]
+                bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
  
          shortvar = var.split(":", 1)[0]
          if shortvar in self._var_renames:
-- 
2.34.1

