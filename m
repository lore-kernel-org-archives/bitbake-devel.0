Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A54CF6493
	for <webhook@archiver.kernel.org>; Sat, 28 Sep 2024 07:00:32 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.92.49.98])
 by mx.groups.io with SMTP id smtpd.web11.9180.1727506826095922038
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Sep 2024 00:00:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=OmmdZRVJ;
 spf=pass (domain: outlook.com, ip: 40.92.49.98, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJA/3sWtzSuiQ0R9DNTPNKScGH30rDy9g8PsYHs2bb+7X4jZObkobETQp8cxCG+DK933B998GRzv7TJF3XEa/FuwIgpeWi64FVg4prJhqqGaGS9dVUty+BZmIlL4/SundQzUmAEMOz8Wz6FGgtObPyl67hHDzHULH/WdxgCDDDjuxYagHLr52Myean0F6zv0Q3GryE5RxUcj0zWWIAu8o9B5vhaQ4yTmLTDPvji+MFe4QkUgAjfQxKma4Gqe85vombPWmLkaVuYRMJKyyvd5owqXJ8/dPJcoDDGUDJVjCbraxTAkeOnVZ9BN6bHxjW+hEDfb3rRqRoe6MCsNMRodNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4mMVEDXxYkgbmatEC3Jact7khixa+nQdVZO19Zh3dU=;
 b=Finz8uEDH/Zjt9arG3Pn+iVRbsw/WOAitRPguzSM6Cib/+/zv1kdZN4v7osrMAoH21g4KavdXR+zSbjlrcUbjEwxFV+NVNsXC/R6vh/AnStv8q3KHSQjpZJrlLgEz0hkO7p1ukGoHTohHselcQ2jtl+xf3w3bn23RbWi4GIrE83Hagg9RlOMYHRw5ivfDMplRj4e+cSPAGcwDzgsEVkr/j4aYqzOF6SeyKE/97kyHxGOJvVC9al0OIO7ZVkQYM0xq4o/UYpK8ZVhdvpHA92gLE9J76an1HoVjGR5RQT0LrsvOYdAzim9unKF8cXf0kIHqvVkz0BeRRbrPfNCEOSuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4mMVEDXxYkgbmatEC3Jact7khixa+nQdVZO19Zh3dU=;
 b=OmmdZRVJ/UZFr41m09bRu79CZ2ZcVmY1O32B4YMBbQi/8eEe7wRSp1Mjhrdr7Kl9jrninHP2rpmjmRADhdXAYmml/C2ADdTU1d40PDGqcoTVOoNuUv/k2jeHcXvaVg52iuEpbXcgBN8UCGsc60S2rcbzjYP6s2Jff5bJ+QgM4iQIhMqKy6lMIo3Gu2XkSwHLw96jf9sbD27AUvBT7FbKSc3CpbNBVL00MEt3g0wp1gVvtRP/wJv9g2tvgJnjMXbtVOvJ92caIXCZrJC0q07nH045r6b1yD5LujfIRCP7DPQVqwxVxTWffO9zyc0Py6iqA4SpUbnQJl+niXICTPjI1A==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 07:00:24 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8005.020; Sat, 28 Sep 2024
 07:00:24 +0000
Message-ID: 
 <GV1PR07MB91208B4ECFB120D35707021DA8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Sat, 28 Sep 2024 09:00:23 +0200
User-Agent: Mozilla Thunderbird
From: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 3/3] tests/parse: add coverage for old override syntax
To: bitbake-devel@lists.openembedded.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: 
 <0228e795-3175-4fa3-9ea8-af2c3490f686@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|DB9PR07MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6e4ab2-7236-4067-ea2a-08dcdf8b3959
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|6090799003|19110799003|461199028|5062599005|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	uygXrfqlL8HLE1/av906B0b48kgf0Ek6wJRMn99ksFbhizVaUg1ucnkP/4i9a9ZaTTuB4ndMqjhBoavVin7H4kgmX5Xya7NUAwB+JppFPnwM4M/8/NewBvwx7hLm0/1gCfyVjU+t8aNtdtHa4y9+B6OIT9lYx7IhhoutxZa93Jj1XF7a3W7S7VPVTNupmxem8mB6zPDDZ8wHQVYZJgnYdWIm3qI4V3+ZI67G/PiZn3/e6Qpr/x11cMwj3IEOfvERARlQEEO/rWOony8iLBFdn5l5FmUo9ixJ4lxOBS90VMFp8hhsNTZ8zu8nqCfK/yBSELNt0DkAwr5/7P2JLHOu14LxOs+oc91BbrgU8H6TIfJApLqXVota0TGAl63XBzcaUsbCVtTv3RwHQEFDkskgQHOId+DSSsT5Z1lGXCy4rS7pgR97ZbRHVXVutJBYy2HjOGUaAE9nGX27aH/eDsi8vinnP+t2GCTcggcz9+q9BDJ0CEvEukDVtn9bPRQRJO/85l8TgCguEz51+14yLnFqsAqdkrDW+vib1Im98FgBOklT9KP5LAT38JwzAY8LsM3rNsFi484Wym7sMBO7ieEy+kVlYKlSZtOoXOu72pSA20XmIWzUVCjBhyGr+E1DtYHc1DVnU+37ceAP1J1udeUPWAqUPBvkHybFTSPFEdk6N9+rTzSQp2Y6W9+ECO+GSAX/oE3aDnMZzc2dD8lsI/qsUE4vU/9A2WX+zD6A9C8yljeq/nIVvbCXvWYyTiBT+njNbCh2pwu+YB1Qe+YelpdbqJrlPADZEDEb8i1YBkkrPRI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkZjeDVGcEhxbkhuRkRNbXdDdkpScHorcVFZRlhDSmVrWTBmRHBYK2NmTmx5?=
 =?utf-8?B?NXZ1aFRJbWtrWDA2OG02bXNqRjFiY2VqRTZoQkhrWmZtNm1UZzcwcDFqWG85?=
 =?utf-8?B?UVNpcWVpY1RZSjZwY29jRG10UGpuNHB4ZnNPWTVpYVppTFJYaHFWbGZPQ1ZU?=
 =?utf-8?B?TEtlVW56YXlvSDRHcnc5KzdoYXU0OGhpMlZJQWJvWjJWWWVmc0RzcXVuRUxx?=
 =?utf-8?B?UU82a1hHUXRWTDdrNVlTdG8rVGFKdWk5Nk14a3AweFBOUzBHbWZ0aXEwMDQy?=
 =?utf-8?B?d1ZDK1FIVkRwbkRqdi9kZk5JVWh1L2xRcUVPZC8xeVJMOFdGZ0xHN3hkNDdC?=
 =?utf-8?B?TnN3aFozNXF3QkxVYXZOTWlLcFlyc3MyRVlURDkxK0xQT0wyaFpjME5YNlVS?=
 =?utf-8?B?blloa1NJWUVrdGZrSXNnQXIzYldoaCtHaVNkdkdKV3l0Nzg2Q0dzYTJYTkxB?=
 =?utf-8?B?WFJlcFpEN0FVSTQ5SS9PUXNtQVl0b0RpWHg2d2F0aE1kNlNwVHdtTTNBL0d6?=
 =?utf-8?B?ZlIyRzNNOEZCYXIzVzg2OXdKZXk5VkZrTGdvaHczSUNsNDU1NS9SdVhlWVR3?=
 =?utf-8?B?NHhCVnlla3o1d2g1WGFybGFZcGl3Q0YwZjI4V01oNFMwRGRoeTk3d1phcU51?=
 =?utf-8?B?TGRPVmdPZ2ZqTHBhd2lteUpsaEZENW1MdDhZWHNGWEVjK3JHaldSaWdjT0Jw?=
 =?utf-8?B?cFo5aWUxcUxMZ29mVjd4Q3FXZkdaUUpFZzBRUDJjbVBEdGxGRmJuNzFOME9U?=
 =?utf-8?B?b09HQlNHSTVUVHhHblhHREwzWU0xNTZFNm9zZGhLdU42Y2hUcDBJL2t5VjRM?=
 =?utf-8?B?MEdteU96am5xOGZCNmNaZDlvMUhkTFU2SzA2ZWlSd3FkajMvSzhQYVQ1NWF2?=
 =?utf-8?B?ZUw3VkREYTFnMUxzZHRUWThuZGdPdmRLdndoeE0rRDZZUWFCRTRNZzdreWM1?=
 =?utf-8?B?MTNYdXVaRThQbFNYUGZlQXJOcGd0dXUwbndvWHNud1RlK0ZPcUh6cGpFRFJa?=
 =?utf-8?B?MTV5OWY5VHBUQmI0ZEJHdld6VG9FMjVEY1BicEwyZTZIdXNXQUh2eWhmb00y?=
 =?utf-8?B?R05IeVhjME1lWDNMQTRiRmg2WnFDM2lFM2ZFZkFMYVh0eFNQMDA3Zy9GUW5U?=
 =?utf-8?B?cmpKNTdhSkR6dVUvcVFRTEc5SloxSVJWR3RqSFBxODY5L3E3azN3ckdDb1pZ?=
 =?utf-8?B?WllpeW4xbTJkOXlaWlRBS3BHRE5adlpxVDBvMkdtOHYzZVdWYlZDd3J0RDJE?=
 =?utf-8?B?WDZmS3JER0hwU1NXR08rNytkbUdmVmY1Vk9FTk5yZFczdzM5WUNmMzVXMW04?=
 =?utf-8?B?S21aQTNCRVRUbktRTDB4dGc4azFUb3dXN1lUQWc0WitnVG1QRGZBVXBrMFNG?=
 =?utf-8?B?emhTekpEaDVsS0YyNGJpTnlSN2hsakJaeXN2di9lbC9xYk1Pc3Bob09pRTVz?=
 =?utf-8?B?SFNmV3JaMUJQS2NyYUNPOW9tVVhyYXNsMzNEaWlQVkU2K0tTaUlHdE5FRE1P?=
 =?utf-8?B?QlU0RjlHZDFtY3ZjT0h5M3ltenM4bGx0eFBhbHUrMDVyM2hlZkVwM0J6MXd6?=
 =?utf-8?B?dVZHcjB0VTBvRG1USjVYMnd4bXhyeGhkYlRHTW1ISVhwUElJWUtmYkNzOG8v?=
 =?utf-8?B?UkVYblkzNTlNU050cWxHUk1hN1kyVzVVOFZGNlE4L1F1K1A3cXBWeEpKWk1U?=
 =?utf-8?B?bitOSDNZVEFYZVo1UDByQzZWck8vYUxWdG12Z3N0cHlMSzJhSlBwWG90NE9s?=
 =?utf-8?Q?FaZx/+wfds5jNHNmzvNH3NP9ztXHXdHTlizSKd8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6e4ab2-7236-4067-ea2a-08dcdf8b3959
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 07:00:23.6441
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16614

including previously unconvered tests for true failure cases of
_prepend/_append/_remove.
In addition add tests for not valid cases

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
  lib/bb/tests/parse.py | 69 +++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 69 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 410679d5a..2da3a2a22 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -132,6 +132,75 @@ DESCRIPTION:${PN}-dev = "${DESCRIPTION} B"
  PN = "bc"
  """
  +    override_old_append = """
+EXTRA_OECONF_append = " c"
+"""
+
+    def test_parse_old_override_syntax_append(self):
+        f = self.parsehelper(self.override_old_append)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_prepend = """
+EXTRA_OECONF_prepend = " c"
+"""
+
+    def test_parse_old_override_syntax_prepend(self):
+        f = self.parsehelper(self.override_old_prepend)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_remove = """
+EXTRA_OECONF_remove = " c"
+"""
+
+    def test_parse_old_override_syntax_remove(self):
+        f = self.parsehelper(self.override_old_remove)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_valid_append = """
+do_appendsomething () {
+   :
+}
+addtask do_appendsomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_append(self):
+        f = self.parsehelper(self.override_old_valid_append)
+        bb.parse.handle(f.name, self.d)['']
+
+    override_old_valid_prepend = """
+do_prependsomething () {
+   :
+}
+addtask do_prependsomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_prepend(self):
+        f = self.parsehelper(self.override_old_valid_prepend)
+        bb.parse.handle(f.name, self.d)['']
+
+    override_old_valid_remove = """
+do_removesomething () {
+   :
+}
+addtask do_removesomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_remove(self):
+        f = self.parsehelper(self.override_old_valid_remove)
+        bb.parse.handle(f.name, self.d)['']
+
      def test_parse_combinations(self):
          f = self.parsehelper(self.overridetest3)
          d = bb.parse.handle(f.name, self.d)['']
-- 
2.34.1

