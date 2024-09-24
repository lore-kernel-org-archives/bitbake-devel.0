Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979E4CF9C6B
	for <webhook@archiver.kernel.org>; Tue, 24 Sep 2024 09:10:02 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.92.59.102])
 by mx.groups.io with SMTP id smtpd.web10.9387.1727169000720366397
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Sep 2024 02:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=Mz7mmEUh;
 spf=pass (domain: outlook.com, ip: 40.92.59.102, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmGdw6GNmJcc2XCK6cdPihHh3fmmjXzq8RXJ4m/joaiIiujrnxSo3guWHMs0Olw0CbnWbQ0IVPoWY+OwHvbEXVJ7SRxCsBrR65o28uIRHAlvKo1g6gtW42QahOLav9efByIfb4yQvMRTE9CvkDWtD6y2VVUBuWMKsq3cA0DymU5Dl/6x6Ox6W5q9zPz6KegP5kOxKCg9AGQcQkFfNqQE0xh89TTC3D80piQgnU4tRT2cHae6hhS2PO1+TBvwDyZseN6b3GqIo1oGFb57RA7SsFj+n8GheTHJMTvdzpAt7B6UtWgUBqXoKsYUxWJbyVFJAE4PCSENMTSlDpdzshBMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSCg7ai/FQdGVmXzu0+XcqPXVZPjN6LUutnTT6Z2HBY=;
 b=Le9RDcp7zTmuYU+CDmdp2rxna5xfWGt93rL+6b+n1511Zbc7JnGlfaBuwhECkH9ZMUKeMG56YxdyL7mzlavi8ZG9GIvSgwLQannoUyYRHasNmqmmb/mBGQePqSyC/DIlAb8ifU35nGvZ1eTTO2AWBvO5eZ8nQKvuu12Cb0D9Tj/DQ40qMVYx8Hp9TC/fIh0s0plcFvoFzYvFDTtr0Zsve/6zEI8TOJsmispoqY4JFOrGfPx0bNUtEs2aXh1BjGXEQvdmpxW+gU8KLKhxWNjU8vKFXhmcxE83hmzMCSwKjriICicSmKy6YgqwktgaKGIrotmuvtdiJVL4nOmIAZVe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSCg7ai/FQdGVmXzu0+XcqPXVZPjN6LUutnTT6Z2HBY=;
 b=Mz7mmEUhUg31yF7inbgy7SotRkSlrBkbD78Fi+una9ljx4omhslhN0ihDbjNm+bToabEd9EkO0ftb1ZXedrJnmeYhRBENxBn9w78l8L6/GQorDY/5pTYJRKReo7jyFBGopRyIB+DR0djKb9ooIBVaTS0VIgqtMHsW4oFA07ddBDQixbyWeyzvh1EFU0A6nqG2BBHVMFIiRSU2vl+DqtABFPfieDlsHn1DbdaJe8xN6PQIbYGzfD18pSKALePC4LfLgScyeVYeYOw9y/fEDnl6hVbwpdungNOnZpj2XTez2do1UgO9jgvzObi2/jWnD3WfOGqRzvDBkC220LyAxp6Bg==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS2PR07MB9491.eurprd07.prod.outlook.com (2603:10a6:20b:642::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:09:57 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:09:57 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH 2/3 v3] bb/data_smart: fix override syntax warning
Date: Tue, 24 Sep 2024 09:09:05 +0000
Message-ID: <GV1PR07MB91207A4634F67CB1F1F972D4A8682@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240924090905.4097-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS2PR07MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3c1620-94ad-456b-b32e-08dcdc78a945
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|7092599003|15080799006|5072599009|461199028|19110799003|8060799006|5062599005|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: 
	5BF7mT9W7KUC2nS7NjAp6FUFtJpqS9rP2jtC00DmPv800QF/cYpe+8cExgMfaJbJEuc7k/jvJdV+RV2MQfyiUswI/eeJt70//mL6bfoJAMJZA6n9MK303RnLzNUwpQcKQYfrjNIZqrGOh5if/v34SicVFIDJRY5u3Ac8RmB09ivjtaCeWZ94/291QslRXVgIgvqvfvWub6uhyPrahzwJxkKSa+YPsJGoszxghyPy5fNUxci2wcMhAjFpWckryYYAOipmHXDH41CBfmRr5Qhb8OZT9bdRXW7j1vHcRO+NeVQ7/QjChSmjROAsNNlssF+RQ2t7sR1FmRn30e4oYncenSuo3aK/Ro8qu+sb2mthE04ep5+DEtquVy398+jyPbKSv1sqZEZRO7c/04cTKme6HiDmaRnS/e3Qudr0ibNxJq9RliqRz585wTKrS5sI7TCNnV5MRQQk8hZ1TepOSk+LAdO/uQZ+/rOWROjp9V7XYGGiBrtuxlb8RXV66cSColvsG/NFLc6CAA45Rl+bfjn2VvmGLVpctXamos4MEsWME9S+uNr+AMQw5JOXsJsUCg4eyojZVaWtRN/rsx9JOyPJHLsRPN5q/vI9WoJEVULwdpnITKpJyDbLcb87t2zN1OQHEL7HpgEHSPodFFT5y+D570SF0Nk6e75HUHcOlnN4ejJqk0u9tqwOl8EEP6f0IOTHTpzJHkcYNWTeRtgvuhL7B9bBiYBmIsIWJfTKzw+Ib4P5w7BIikogeVdBMuMQiqeaYIzde12XXONa66v8ODpLfUFqSb7Z9bOaCkYZCwRHFBE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YDHjGgI/UqTfIXCSUUmtOG0j+fp+5Iw8KoMXGkL/n8wcgtnmBMc5dsZyyHY3?=
 =?us-ascii?Q?mI56kT6W3dOhdTEsRTYwrKrep4NZN/eKxT381uYL9Iq2TOQP7sbBu2YmtFd7?=
 =?us-ascii?Q?0CPdLFpeT/WAYEJ1PSjiAAOCFE7p/O8GS8neWY4YD89VfH4A8cevb+DXxPGe?=
 =?us-ascii?Q?8bZhKk+oXo8DUwk/ppTO9oDZKyxCjy8otq6AXWkwYYm7uPTR46ggp6GAffDH?=
 =?us-ascii?Q?nhtLerNFYi1uiWla1rScsJQ7iKw5jrOhFjmhIBu1Ds9AcipTmkGNOZsooAjG?=
 =?us-ascii?Q?kZjjCxSB84/BXqp3CPntxLuP/74aPGhl1mTlJgqUQijX9W0PuwNHjSeOBlzd?=
 =?us-ascii?Q?4ku3sJxzrYiE1tLcBikTj2MBQgOaaLuQ6/feOSZyi54ddhKXPIFzKv0ig97K?=
 =?us-ascii?Q?5LPVZqu/Pse0DWz21VBfapRhjqPYnogFSSju1huX8WBp4Uxi1ZkVFg+kQTpU?=
 =?us-ascii?Q?AYj4uF05VtGhz2DMYkdGvF1WiOlbyKpOq7Cl9iFr6xVC8d4yrkYp2dZxdkBi?=
 =?us-ascii?Q?mV0s0VdX4NnTpZFd4I6UHNWr0RSBpZEZmLapUJdp/GfrJJW7egH/geXHKDaq?=
 =?us-ascii?Q?WTWXe3m2mua1oHgCkT/jQyZ4QRiqb1/nkOLSIMrtgGgJkem8pnmihiDQI/LS?=
 =?us-ascii?Q?dxdRl/hhOBpbO3j9AZ4lLrEHGhFzoOx+LXElfJyy5CR0lWHMkP9Yda6s7Wnv?=
 =?us-ascii?Q?/H5S81dcADPYsTtprYQHCSiupaxDlFXOseEWjzmXiT7c2jnVo/jxF+2gT+Pl?=
 =?us-ascii?Q?FPJfR8I/tFs6UMIgOuvoBzIJqSrUAeSIsou3rLP/TfDYQIspp8GkPlDY16oN?=
 =?us-ascii?Q?LEw9PdSxv56pvufmu71EcGo2VmJ23X/D8Y2LFHWafWjdjw6aPdITvKuTipTW?=
 =?us-ascii?Q?5vx9vzrSSw16Y/lJGKcVAdy2aMldJaUxMV7wLJSpowoDxm+03NsepQVwKwr9?=
 =?us-ascii?Q?8KjIAEe/gV2qtALN9giXfF+NDBJRBjZHoBskCNz1cEj2WKK5+kPQJppp3mFx?=
 =?us-ascii?Q?lr5stbSqgm/AbmNs6dtXzXjDmlAAtIeYdShuDxE1JSndeqGQLZ4iXySSAxBb?=
 =?us-ascii?Q?qHtRXjo96dzQVuRU+1Emy5aDQBcmLrmd5tvuV7+gEeVSapU71VoaXP5LbnGA?=
 =?us-ascii?Q?mHQX47zFBavie7c9WvNKat1+o4cCTeFnhhTnrNv0fkoJw8PNmd2FXRxV0AZ4?=
 =?us-ascii?Q?b04A+xgfByk77yUh3ise2PVn4esaqnmDIkSIoahOQWDzQalXOVHTGw+Qy1IJ?=
 =?us-ascii?Q?GDX3KkrQgWy7aF0hCF6620XFBR+/eYXcfZhzFM/4PehD9jT82BRftPkb8iZR?=
 =?us-ascii?Q?aOU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3c1620-94ad-456b-b32e-08dcdc78a945
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:09:57.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9491
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Sep 2024 09:10:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16597

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
=20
     def setVar(self, var, value, **loginfo):
-
         if not var.startswith("__anon_") and ("_append" in var or "_prepen=
d" in var or "_remove" in var):
-            info =3D "%s" % var
-            if "file" in loginfo:
-                info +=3D " file: %s" % loginfo["file"]
-            if "line" in loginfo:
-                info +=3D " line: %s" % loginfo["line"]
-            bb.fatal("Variable %s contains an operation using the old over=
ride syntax. Please convert this layer/metadata before attempting to use wi=
th a newer bitbake." % info)
+            if re.search(r"(_append|_prepend|_remove)(_|$)", var) is not N=
one:
+                info =3D "%s" % var
+                if "file" in loginfo:
+                    info +=3D " file: %s" % loginfo["file"]
+                if "line" in loginfo:
+                    info +=3D " line: %s" % loginfo["line"]
+                bb.fatal("Variable %s contains an operation using the old =
override syntax. Please convert this layer/metadata before attempting to us=
e with a newer bitbake." % info)
=20
         shortvar =3D var.split(":", 1)[0]
         if shortvar in self._var_renames:
--=20
2.34.1


