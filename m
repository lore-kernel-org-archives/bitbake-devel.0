Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B776C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 06:49:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.2807.1740466161736528842
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 22:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41510c6688=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P651Wc019708
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y5j8b81e-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/iHWJ4kZ2xVpCmXqImNaSwgaRTne0G6LzMQP6Q9QKgDE5YKZk+poYGZaVWmG45ztxxZ6eFGdFFRevGUx/B+qTRl5+0Lk9Gpw8McXW7BkQq6atzAC0WTbN2mP4irL4U4be8fuA6xkhWEhwNqta5FBmB2FXwj7W/5P6g0r0xNI/xhP+7hKfwoOkzsDp9A6RhZeCfvqhfpnJO2xiFYYOOBRlcLo9uwOUx9zK/e0sdryBD/DQms9VXde0QHA5WXQ4QiIPiax9MfBUeMZ/vtOpXsYe5cVcOpPXtPuA3MdLrYE0PBkBWbNFe0A30sI3qq09KeRLYolnAK4FaMZjhT7mrqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO7j2NXlV9DxarkzMuKt/fpwGsAnkjNr69cvJF9H4zo=;
 b=zHhMjwndJVrGMTnWigB2fpbPYs81cUOR8+BLryTScUPznra1wKnb8Uy02B+pyoS5MooYjJ3A73DtNcXuapI/4wHNNHeO2H/aukx0y0QJPDQyTuZaVDEZBkacIHQiFLsGG6rf40JSkbQLjPPwVpJds/9JWCryGSZvlutpK6gQpeceKs/tl/CqsRP98I2uobBdsK4y2G4Dx3Xpmh3624hu2ZOqcJBr86xO0CfqkPpdTJO00T5qrVBadETBs6r9tUuFEGa93ck6e/NO/wP1EKtK5+aDhnht3fi+5KiDoHL3/UAdP6ZJwbgsURP96PYnC7oC2jxhrerRzhcv1VrepN08tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:49:11 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 06:49:11 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 4/4] data_smart.py: clear expand_cache in _setvar_update_overridevars
Date: Mon, 24 Feb 2025 22:48:53 -0800
Message-Id: <20250225064853.2406575-4-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064853.2406575-1-Qi.Chen@windriver.com>
References: <20250225064853.2406575-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ0PR11MB5613.namprd11.prod.outlook.com
 (2603:10b6:a03:3ab::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: e190fc94-4bcb-4feb-70e0-08dd55688100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t5wPTWz9RqMK7kTrJNl25Fme3puPq09wc3WTpIdf8gbShAH/8/7L+9+4HDHu?=
 =?us-ascii?Q?NsyPDWvpizDCYgSqXePNyzH5kIJSl41dzLJC/4+bcInWtuPp7RUStBTZd00s?=
 =?us-ascii?Q?yg8IGucl/XTUpNFMSD4kYQMUS3LcBG65+yHBq/uP5TZxDGv8wRfvxkATxk1m?=
 =?us-ascii?Q?A6GxcOxo3PUWzeBGcfbqRBUejIFkHN+ThSeTVI9g5duY95fh+EWLpVYqYe+g?=
 =?us-ascii?Q?mdtKI8TuWEyydQNcnX0vZXLi+fopXumfIYGsCXdU51xc28KXlBMlVvBrgi0v?=
 =?us-ascii?Q?6VIfQXW56zqdrSF4Eaczi+jTyiFVwxRNvuyOlo+vqbyszphmyLNyLorkAlbt?=
 =?us-ascii?Q?IZMUsw5Ky/tsoDIc8uXllY5KRgD4ANLVKO1BM5ejtPup+QeECT5VThDu8jcz?=
 =?us-ascii?Q?qHczbK8wWMak1jBjLNwVRhx7D8+0//IcDiPlwY0pSvQRia7523s9I91mITvu?=
 =?us-ascii?Q?c3NMb21tedfF9NokN9xLM6kEQNjf37/GxkmrN7p/JvpCA7ztt7KC2TOYKm1m?=
 =?us-ascii?Q?ly0mHY7ClrNtXyLFJKhqbUpw4WDAHP9r4w32OJArVydPt3SpPmw0wO/JwPMr?=
 =?us-ascii?Q?y6r+R3QC8lwqB+7XmBDeAYUUSqIQlNb+8jRFHkecKLnM2IapkChYRuGQcKBo?=
 =?us-ascii?Q?MWBeApWOH+M3HfHj7aurk/ckxeQeE00VNvWgVLwhIq87lty0s4adKdl3ADEl?=
 =?us-ascii?Q?xhlXeyPjqiFBnMwRFcPk2xzuR0jugNguDOtv+N6a+Kc7v+2vDjauNMhNTETd?=
 =?us-ascii?Q?NX0J5LytNpxhQbZUbIutPcvrlaNzcFuX1M6iFiP0Tojr/K5jAHAq9TTA1Sna?=
 =?us-ascii?Q?wqJE1VulkAxh6LWPUAPk5KRF+T8fE6p+NiGZ8mKqOgryCwoDH/inhp7hedw+?=
 =?us-ascii?Q?escKFO9vRbUcyIVVvZz27RCTtJpvJXQhXlFjIJEAytthti8XTEQpWeMY0tLh?=
 =?us-ascii?Q?NtrqbxbCYn+e0C3zG5tI7z9fwaNGT2sHRRr+aBVPyQ6ymMDGAZ/n9yIox5+m?=
 =?us-ascii?Q?oE9o8vzEHPIGSdGlAJCrH763DCYayiNjqCdoi78nyHFJaXiKuC7dV1gq+Szu?=
 =?us-ascii?Q?t9+E0+8e2ejt37BZ1r3U2ohIXABFaUmUitF40vYqDWNGN3j0HKOecv+/UdTJ?=
 =?us-ascii?Q?/Zn2CDgf4fDZLmSXa26DkKSi+BIsu5TDh9mKK3TJzuPxl+kXAuHXBQeQddKD?=
 =?us-ascii?Q?EedG3I+WVL18BQeqzieyKCpEfa7BlAICdDmm15KJ3x7zayNIDrPubu8njRbH?=
 =?us-ascii?Q?ta1X64nGcgNJJkbgFe+wYehC6Kps+j9jpxUlSDmA4prGqVOc0B1C23XHE23J?=
 =?us-ascii?Q?TiI+ZIIkTF53O7zmePVRmirGnEqdTw6Vcb9wtnnNTqof74qofg6mDGK+o0Nr?=
 =?us-ascii?Q?UtqzsQNBu/1+998t3H9aGnjN0TXM35BMx05+5WjjJhYPyOyJjU/RBiiD2xAE?=
 =?us-ascii?Q?XB387M2RYfu6mLhlPPhkh0aQtlC5B0A2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UJ7AGFfqJtJutOe3D/llQ0U04KlQNZJBeKJ7pRrwce9D/1McM/8FePhR/Bv3?=
 =?us-ascii?Q?RzpKMcF8lEviqkhd7FUmPC3tpt0n1ty788a4V/5QHwnEuYgx09FrEysQyOsg?=
 =?us-ascii?Q?Zp0oCe5FxnsojEwyHqPlaQe7kM4pN4u7qEywkmlNwjhQc8r16UFE6I8/qZTK?=
 =?us-ascii?Q?GemVO0g8ZCWdlwA/xnVKq0OZNlXJP9q0hVscnRtkK4hO58C/XXnPcZMsd1w+?=
 =?us-ascii?Q?0gMfZgZk2SW1RxMPLN2OkBBnJlhkgsMJTrMlqN4naXHRSr0YGdkMfoIoVWPZ?=
 =?us-ascii?Q?/8upsUUXRzxxp5q5Jg6d+wrNqjnNQWh4I+ixIidICh4Gr755cpSKw3AqoPIv?=
 =?us-ascii?Q?EUIvkyMWFGdwXqMYZt+CbwpbwHss9A52Uko4zYskLtDBmo2KA1e1P13Orz4y?=
 =?us-ascii?Q?5fRh7X6yY/v3qnE+svVseDmckBn1Mo4QOC5zKj6EbRVV4ejM6kY1Ko0rRODw?=
 =?us-ascii?Q?oORqFW0atvSvmiVS6GuGtLF9jnijNjdoL1COnnkD+KWPVajE8O6FOaHo+WRN?=
 =?us-ascii?Q?fwcw5rMfGTEEUq6WGfbK6J5dO6X8E6fnmGkW45AaO9TTALk65XmfJHdkHYae?=
 =?us-ascii?Q?xzyAVYFNtwOb0B7rV3IctMPl8boHMBTaxATlTZ1CJPPhE3Yxovb5U7GuC8bH?=
 =?us-ascii?Q?+iJb6Z+s+drGK4bqLr3MQkEsvZxp2GzrCnCcdFgsleN+M94LihMdSLqSXhVh?=
 =?us-ascii?Q?zYqUPhWWiWxiS6XpPxllj+dsuke/y4jJMKLn4K8/JkZMnV6xl6Hmwhq7lJln?=
 =?us-ascii?Q?NnRmy1D7MtbHdNwJB1jF45+oHxsHWKCHCJgacZFxBxROvK61Ngd5uk3M+19W?=
 =?us-ascii?Q?413cEzfhX451cx22TaiCGGM5ve2d4D4jVR1D6zsuVKxZvksw3b/EBQHTIvS2?=
 =?us-ascii?Q?OrmHFiveLWsBPXE8V/aJ6AN02noNX+EQmsiVQddhjyEuuid3jxQSRFwP1zDU?=
 =?us-ascii?Q?KkF4O4SbLeNvOIFJlfENOxnpjnplRZMIHRRmyDqnj2XHGjvBzJIfAcNoHjoi?=
 =?us-ascii?Q?EEyTbd3DWZA4+TLcuVy6NtD2L/5jzrIx/x8Gy6Ml1droQBAUW4eMpxXR7Osc?=
 =?us-ascii?Q?UVd8KjaFj/BAhCxKwZu+p8tTtTaIN9s5s8hKBRBzJvU4zLJJcVPAE7v2NAOF?=
 =?us-ascii?Q?aNbj1g+o0z4k2zEUf9nzKrxwTOrDQNoiFoIWgM2Cid2kcHqkxOKKzJ8x4JJs?=
 =?us-ascii?Q?ktDjzQZlY4oYEbBI7o2xs/u6lnsC57ea8L28/hd2ra3L1h5gfRrW9WcVdsqj?=
 =?us-ascii?Q?gVjNAPczpdXSpGV8x2UskPzC8XcW23N/Ca5MZMoBcLQyOjLdPPsX+iJTFEMG?=
 =?us-ascii?Q?rWkn5sMWZ/IArL+7YOgxizqwQn23RmqhqVO0MW91zDSnxZhqwPDkEvSvXfzx?=
 =?us-ascii?Q?k8uiw+Jiqfl1+lrpKfyrcnD9T6buVq4TdeTJcHvb1tuI+TqOx9IsCPvukoLR?=
 =?us-ascii?Q?+mtLC59HrE9mZYg5TuwhlCniQBaJRbj3MM6IpVax+ySU6BDFD9wbcS6HDIhU?=
 =?us-ascii?Q?Eu8ZOoufGW4vTdxcWUgOkaCRUOkSzWywMPbDlPJKP4pW711/sFn/xMIsf+GD?=
 =?us-ascii?Q?szytHQFVLTeaSPIv4NdRC7bKfLysVe7Z8/W2O0/PHvjs7V0f5xUz/AtPCxwe?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e190fc94-4bcb-4feb-70e0-08dd55688100
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:49:08.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxlUukjDnATcUuShJLhlrxXLNPv75JPBkEeuAka72S3Ht5OyMEhywDZd5DIg4CclBclXM/0COwQl2cT9BhA3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-Proofpoint-ORIG-GUID: BcUFtUPJRsTBWxkT6jT2BSqQFzhOFwSs
X-Proofpoint-GUID: BcUFtUPJRsTBWxkT6jT2BSqQFzhOFwSs
X-Authority-Analysis: v=2.4 cv=U+ZoDfru c=1 sm=1 tr=0 ts=67bd67f0 cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=t7CeM3EgAAAA:8 a=JXAwwj8Sm7eIh-r5mEAA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502250043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17301

From: Chen Qi <Qi.Chen@windriver.com>

At the end of this function, self.overrides is cleared, which means we'll
construct a new self.overrides after this call. And a new self.overrides
will give out different expand_cache, so the old expand_cache should also
be cleared to avoid any wrong value.

Currently, there's a problem revealed by recent recipe specific virtual
provider patch. If we enable multilib and set "OVERRIDES:prepend" in local.conf,
things don't work.

Here's the error message:

  ERROR: Nothing PROVIDES 'lib32-gcc-cross-x86_64'

Below are reproduce steps:
1. Add in local.conf the following lines:
   MACHINE ?= "qemux86-64"
   require conf/multilib.conf
   MULTILIBS ?= "multilib:lib32"
   DEFAULTTUNE:virtclass-multilib-lib32 ?= "core2-32"
   OVERRIDES:prepend = "some-override:"
   (Note that using :append and :remove also reproduces the issue.)
2. bitbake -n lib32-sysstat
   (bitbake -n core-image-minimal also reproduces the issue)

The expandWithRefs calls getVar, which fills expand_cache. So when setting
OVERRIDES:prepend, this will fill the expand_cache. When overridevars are updated,
if we don't clear expand_cache, we'll retrieve wrong values.

Previously, things happened to work because there's a call to expand
PREFERRED_PROVIDER_virtual/${TARGET_PREFIX}gcc, which in turn expands
TARGET_VENDOR. Now what we expand is PREFERRED_PROVIDER_ virtual/cross-cc,
so the problem is revealed.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index caef93ff4f..1c867653f3 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -635,6 +635,7 @@ class DataSmart(MutableMapping):
                 nextnew.update(vardata.contains.keys())
             new = nextnew
         self.overrides = None
+        self.expand_cache = {}
 
     def _setvar_update_overrides(self, var, **loginfo):
         # aka pay the cookie monster
-- 
2.25.1


