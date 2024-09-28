Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1FCF6493
	for <webhook@archiver.kernel.org>; Sat, 28 Sep 2024 07:00:22 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.92.49.39])
 by mx.groups.io with SMTP id smtpd.web10.9219.1727506814732853398
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Sep 2024 00:00:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=AnoJioLz;
 spf=pass (domain: outlook.com, ip: 40.92.49.39, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+sxNLiOEQsoVgGsenvg0tAW89GXzHRFJFwXalv36i+gGFlVO1g0oBXmZIATf4Qc9ZKaGbPXHBB4U++HPJVwPU2fAdQplWAnpA5l6iEy1WVPPvKExhf1rkGQxc4X4Nu1Wtuee1JSFuXnZltwTH+fPWBWmdYf/xpoFESXv69FQRb0Y0j6AFzwmqa89xD8bXvAaKdAWA+wB2/lPT54ki1yfzoIL8yCMP6INItCB/WdCUfT1cV5BbPRWC2gGaLe1GU87DULoAKA90qGYiOYteD0NPmYqpuif7JFqVSyGQt//7rNWRW2a8qpJY2PM37C3vKfRek76E4ODvbLOYf7Fi6Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/vC4KthfmfUmLGogUPiBxzDrY1ZtNI93LmCSBCGjCk=;
 b=VtkH7VoNQXeymhhLs0KGKOxrfTiEWNlmjFRKemmKDPCVI7z+hPkPxrnD05yat4h6BCfFoNahzPwUWmQPMaBrwYh1cRAvSxdcnDPutaEQjSk5PpXvoW2p8z0iYYjXPP9cX7M+9O7lMm+K67BrBldbwvNzT2Pm4o2JmWgoo/QAYqPTTQpNq/TogLCznwveZlXGgWQ45TWdEjEKnb09A8KhDIzMieMFjUpOqQAQaeiSuGybRRZsyOU51XYk8413wPC0GwDhxQASwOJm0EYE08F1SWCkXVqVfiYdwxL5rI/vScwI9cpUmQ6YjO36xTwRi4Aaqy2gtHMWvVx3TQ3Bh0Dryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/vC4KthfmfUmLGogUPiBxzDrY1ZtNI93LmCSBCGjCk=;
 b=AnoJioLzvjqy0IMtircu6aZ1K3Jam5+8CNw38sm0If4/2XXcj9eJxcrsIZQt40OjnsDXl99DyarCPnETB9LzALZl16oKaXVuoD3FSsWwQhV+6t0he1yKijn7sqaqqKZLAPBSirOfKnh7Xz3s+rTu7+LBl9NVot+CyZXZTjsxJDLsQM3AQCpuZEmXZG07fpHfUB01ceEFylWq58zCF6G2xGQrWIA7xlF8fggQ0k1Kl5NY1WQplJqzxObsXY/eDo0TipNwRPwXozIF08YrNNLGfJk+JyobAJ6aiXQGPt6+q3F3ClP8KMTCE0xITxZb/GvwTJdZzPBTODcQ3C1mmlLwiQ==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 07:00:12 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8005.020; Sat, 28 Sep 2024
 07:00:12 +0000
Message-ID: 
 <GV1PR07MB9120F25EE86DFDB0CF63AD9FA8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Sat, 28 Sep 2024 09:00:11 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 1/3] bb/data_smart: remove dead code
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <804e0805-6469-4f39-9571-31b98aa36041@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|DB9PR07MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6f866a-b56b-4d2a-6300-08dcdf8b32d6
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|6090799003|19110799003|461199028|5062599005|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	mAiXoFvulz3wC2dE148XnPxmL/YWt42Ut9XLB/ZM+FtB8k3wUFCasQfRc/grkSjaQJsWn1788clgU4/sTDk/ywADh/8Znr9San+x3Whsg1WHG2F/z3Sf0KJ/HtyXTjyQGb6dHOQgvOpuAfwwUmtZ+74kVasoXH8HpKiil91IPK/XGpA7GX0oqbRR8H8TCbnBOnoedWPDsWVB+ZmonywD0lzYJKN7ccr3yFmH6cj+H0taQerT0FwvC27t1h6YoaTD5YusVHXWg9RECP+DiAOmfCETl5Hny2i+HAI7etLVwPQBmJTOwfxJoHTPwcgMv2ToPsTVgSO+TZA22vPA132TBaTA//3rf13W/c44u/4/wv+fsn7h3s0PM1tjuiCVqnRaTjbzYYNjjYN+1wQkLuCJMdNA6mO+ay6qPux6+XYCxJ2h0Yb8BJu041lfy3lnY/6CrXuejKSCprvAZj73VCeV4Cp5JRPsl8WcgCwi8EowMnNddlzGyfiueXCITpcon/Qp6f5fA6jCQdW0vd97eUqxtSR1wWFJXWtzdHnVuebW9Btgf6ph9aVQPi65LxxUbWcqVvtqAjzL++UkSUMDt1n3eVqm3oAz2VASW05rz+kmvqIhxoCCqHUZSK7/oCbWjSfYwShD+FBI/boS+JNtnW6Q/TtiAuYPm75+enM2GKJ8i63xiXd2hZfCLEg5xyI52WYAJeDGxcF048dXM0af1HeF9dj8233kyGs5hPmj45wQA3H9KMGaeVRHyh+khTK+UsU1QN7r3LA4HyjRRq3b16o8X0Gx9anjG/eYJ82ENxT2zPY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WStCV3NsZ2pIZzlFbkMwQU1tUkpTOURkVHdrT2xIWXVwSTZrY2l2TWRuNFJo?=
 =?utf-8?B?WTFZZ044V0hLZ0NiUUMvWWJMZWpVTjk2MHp4NGVjMEM2TXNybjB5SWVEQ1FK?=
 =?utf-8?B?SWlvSkpCRTN3Wit6eHY1N3I5RWRkcm5Qb3VZQUNmQmQxVHhLMHl2TEZEbzVW?=
 =?utf-8?B?eXJJLzZtY0JLNEhrMG90NTZTUGNmYnFGVFlBd0M5Q29Ha29XNFRxdTB1WE1G?=
 =?utf-8?B?dDRycEk4UFpmMkRreXczQ2tGYmtxdWxxdVJwSFArYjgrWmM0TnhwNVRuSlFN?=
 =?utf-8?B?Z09DSGg5SDIyQnRscERGeFF6ZksvYWVpSHh1cEdkdkY1M2x1WEkvVFphdTdq?=
 =?utf-8?B?Y2c0OHlRcmhyYnhKWXpUOGdqN0YzUW1FK2NsWGN3LzUvRFZLY2tmRlU4QkJ4?=
 =?utf-8?B?T1FVRXViY0xDb2IwRVpOY1I1OTdvZkYvRFVYdVZoTExBU3JTdC9LRCtWYzc0?=
 =?utf-8?B?VFBYdXZGNGEzYW12WFE2cFNyaGh1anJybHhXRkNmNndOMzB1akgrM2pJRisx?=
 =?utf-8?B?aFNBaVhPMTU1OG5JVmFOV1hmRUdzeU5pK0lObmNkYTBUZGlxWDhlejhOWDY0?=
 =?utf-8?B?VkpiVUhERXByTnRXbHRrY0hvVU9WUmE3OFYrNXkva00vbTRZQzQyVnRiQXNQ?=
 =?utf-8?B?TDFDaXlJcVkySXJyY2FpQ3pJSXFRcjBld2xUTlJpeU1MeEY0TjNiQ1BZSWwv?=
 =?utf-8?B?TXRBZ3hLNVB3blE2bnU0dnlwRFNrUE5LWmlEWmkxcGR3ak0rbXhDcHdFTHh3?=
 =?utf-8?B?R3FJNGM4cXpjYnJ1KzZ4TXFEQ1gwWHNXREh4M0xvSTFzY1BHVERkb0k2MjV1?=
 =?utf-8?B?bTZoMUgxaDhPekZ6eVBjWVpVRVhaekxacHRGUldVMFY1V2F5TC9UTlc4NzJK?=
 =?utf-8?B?T05VZUNhc1ZUZEIrbXVLNDMvTVZtWVhBRmRPeFFjZXU5YktLcTY4bzlqaUNM?=
 =?utf-8?B?VGNHcllnV0FNdUl6T0pidXc3Si80Z3YvRksyT21LL3ZoaVZ6ZVZ3eVIzVVJY?=
 =?utf-8?B?VHpYS1pXYjZuZDdneGdvaEtWTXViVWVHV3YzTmtWbjczMTlhVko3ZXNwMzRK?=
 =?utf-8?B?MVV0RUk2bitsb3E5R1FOaFBLNW9vMjFVb1BFLzRsRmNKakdjK1lNRldkSlVC?=
 =?utf-8?B?VGdkMGtuSUt6NE55c1k0VW1jN1M4MStENzhJU3hwdzZjU1FXbmxNbDNNeDA1?=
 =?utf-8?B?TkU0Rjc0dG5OZC9tRUFPYlU3UFJlYktEdDhORHNNYlNKS0h6ekR3dWEyckVL?=
 =?utf-8?B?eUMyS2hwc1pxMWRpZG9JMnNZNEs2eHp0WXlQOXI2UGZYSUZBZytVLzlqd3Y0?=
 =?utf-8?B?WlFGelpJNVMzSkxFUmNoRk5lQmw4M1hYb1BUQ3ZhdTE3Q21qcng5ZHFiUUdH?=
 =?utf-8?B?d0RWTDdTZWZuL1NiN1JlNVNXWUpKdXg0QzJFZHVyeFBHbUJJSFdlNm1ZY28w?=
 =?utf-8?B?NVNSL05WUWt1UDYzRTBQUFRYZnk5WkxhdnVGQlpPRlV0d3F5cHN3WlgvKzRu?=
 =?utf-8?B?OGFSK09qY3hLZE01UFNCS2thdm1QQmowMEJDclcveDA4eG12NVQ4TTAwWWcy?=
 =?utf-8?B?ZEwvb051L2ZIeXA2UGhXNXAyNFhiNUpkck8yL3JvTFpwWXQvcDZGUXVyc1dq?=
 =?utf-8?B?NFU1elJVVG55bld3WlNlK2s2QURUNzhTZXZnYVFiYnJnL3ErK05oakRpZzJ6?=
 =?utf-8?B?SmFVSE5Vd1lLcm94clI0RUEySGlnZUpCd2dxN1J2Q1pYbWFsMDl3dFJHUTJU?=
 =?utf-8?Q?V69gFkQIVQY41x5R4cdZnxpzmCwhHydxg/4njEB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6f866a-b56b-4d2a-6300-08dcdf8b32d6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 07:00:12.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 28 Sep 2024 07:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16612

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
                  o.write("#\n# $%s [%d operations]\n" % (var, 
len(history)))
              for event in history:
-                # o.write("# %s\n" % str(event))
                  if 'func' in event:
                      # If we have a function listed, this is internal
                      # code, not an operation in a config file, and the
@@ -540,7 +539,6 @@ class DataSmart(MutableMapping):
          return var in self.overridedata
       def setVar(self, var, value, **loginfo):
-        #print("var=" + str(var) + "  val=" + str(value))
           if not var.startswith("__anon_") and ("_append" in var or 
"_prepend" in var or "_remove" in var):
              info = "%s" % var
-- 
2.34.1

