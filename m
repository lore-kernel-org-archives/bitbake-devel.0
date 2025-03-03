Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728FC3DA4A
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:49:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.60])
 by mx.groups.io with SMTP id smtpd.web10.53492.1741009761896938486
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TmU8auUW;
 spf=pass (domain: siemens.com, ip: 52.101.67.60, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ11zBm1fU22ni0dHxQEoYQe8VVSF7B5mVZmI5K8BJ/aM1pbLX8M3pax63kcr2nF075uXV6M7MQ/SvSV/X1Xr/utT6NsrJG0DLGg/J/bmu74ueZg46YXDRTUkNUs1LtZ8N4df4wExR1vQ/O+vkenLyj6klEPYq/rjghgrYdzP/rPLFE3pkMVR6LoZfE67kfxW6BT9JJecfDgu+8qxq5usEk3wcO0F5i17iJfwT0l4vmiWMNI8gIeMoNhOU2u3PmXCXfdFXMli30wFRsElupL/rAsjFU5yrsq1v3b+EagCDNgLZj6uFmpR/6wZozSswM3yDaG3o/ME2DgTqFOCu3owA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw2M6g8OJV+P//g6oWmEfSnUlcSTel354RpQHn6B5oA=;
 b=aE6CfnV3Bl873ZrO5p6LbiNyhLEOVZwxOGX0QIee2un6R5w/jGBMkwYgVDbWt+TJh48KhTeGVJfQDJmNZ5pvJuO0xQHJxp1/T3SBCy/ldopZA/4omxc/2B2/k9UCZC1TBg1id0by/Q8iNujMiJh8iyWet6xiWKK7KIv+T7nmiTtTcRh339jIdgScTrnYFJfypJZ+FVoIJC56EEMWzzLzd2qNUSi1UUIOeSuSAVWcWsyODsCwr/wF89dqNvp3AYqCItVCS7x11uF/JAcuhY1mKTrauoTeQ+vy9Hr0hSeXJiWfQWUqInlpKWd2Oxxk9JhGAPh7RcboyWlFKUHH3rJx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw2M6g8OJV+P//g6oWmEfSnUlcSTel354RpQHn6B5oA=;
 b=TmU8auUWAeIXYnRkma7TEeialkp0OURle5y/jlGLxI5+g1z35iYc9L3LWAaqtGA2y6UNyin3Qi97lP5qICq46v85IWppsbmZN1nK0Uli1hVaTiqQn2tu279K8l/vBAKnIEMRAPcqwjU5MifVQbgh1JXy1czmQxOfnmoPB1qEIHc1ydf4l45+0TDRHOR5tHkXQSnQcb+SfUwGtqA6qOWMudWcduXbnUKi80uvlawtBr6JZe3dC93+QmskKgjEZATxKE06feS2krHSC4ff7rcbwY5s7rVqwh6YxJ1bAk6lVJBxK8PX3uP8TcJOLtmzyHiyRVmiWwwwO9UJsjbziBST/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GV1PR10MB6121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:49:18 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 13:49:18 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com,
	alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	quentin.schulz@cherry.de,
	mathieu.dubois-briand@bootlin.com,
	Ross.Burton@arm.com
Subject: [PATCH v5 5/5] tests/fetch: Add an additional test case to check whether the fast fetch is shallow
Date: Mon,  3 Mar 2025 14:49:13 +0100
Message-ID: <20250303134913.356778-5-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303134913.356778-1-stefan-koch@siemens.com>
References: <20250303134913.356778-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GV1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: e87132e4-53bf-4894-606c-08dd5a5a31dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jNdr0y64fQanuKV0H41xrzEH0LdpyMgUK9d1nm/6v0K0D7/PEYiJSohDMIqS?=
 =?us-ascii?Q?1U/9GUnkxOEROGMDgNvOJBLeG4ZWOBXBlv6YVWvMLFBwdoxwjYvHRMYKLglK?=
 =?us-ascii?Q?k1fyWe5FHhna1emn7yZhRKVCTdEdKpbBJNQeL9Z+g+7XWMLn69J9/YFOYaj5?=
 =?us-ascii?Q?EHVh/ZRDpYO1hbKELk+CKmgqNyZUfYrkfU1r0+ZBXT1kRclFXGSXfT3HZTNc?=
 =?us-ascii?Q?jyGB4iwgY1cGCl+9SKDHxvP/CyBmieV7fRgApISXgpzMt71wiBEAzgOIpQxB?=
 =?us-ascii?Q?cNP675xq1AR3j2O/UKk6bNHdmZIL8AzYTG8sVKIFbM3pDjMROu1rc8oH+c25?=
 =?us-ascii?Q?01N24rNtlDAWlhcS1YB4EwP4KRFOwpfAhtLyyraGKP3JVjZpe2s8Y2ybCht6?=
 =?us-ascii?Q?KIHjDJKLT2Z/FTgW9iMyaKbKLK7xSYZN57PUC6AxrfJhE4LF5ij6ykW1n9Sw?=
 =?us-ascii?Q?Rv5gXsOH4Wr0wGcpPeaPUz86rJJ/AtU7MxFnn0maZ5UVuS3q9KzSZ/W/y3Eq?=
 =?us-ascii?Q?PQ3QYgII8krpmiU7l3ilYwG9WxyEgx1+IKC/FoebblROQlav28sk+QkQm/y/?=
 =?us-ascii?Q?E5F2S++7cBRX+AW1XEA+7N4+EdYEI7AVtbuT910a6iq4aeskv09BuHfrF8Ux?=
 =?us-ascii?Q?m+6+JiMagmYbN2hanpYiy/3vDGechBey0oiFjNBDOWk9poh031XIZPymOybH?=
 =?us-ascii?Q?Oz3pnK9wSbpk+nEwsnRzJOsOIVbH/yqmP4V1r976j0mxSmpTAamOKgFfkv8F?=
 =?us-ascii?Q?ugHbKXfEG5Fdd0ZPiAaqyEJ2Y2MxnK04WYRS/3BTHxIaw+cf8tDHJEod+41H?=
 =?us-ascii?Q?gx+19g9/HgWxFnSAzDPbx0uTt87tQz+nDmGzTXHet6Ts3KEPLa0o+NoQg7h3?=
 =?us-ascii?Q?t4F5L2qxMQPMywC9wVUukDz35HQNuzXrJ6Ih120jAQJokujPslxrqeJLBipF?=
 =?us-ascii?Q?yaQv/ZYKzEzDjQEFIGJp49k0snndTYtRhNDLrKKyMcLLQGtkp6FrK4L0MfEX?=
 =?us-ascii?Q?mLity4Gt0rb7/JKaDB9yyaC050tJTHavBiNEO9BrrfgyB2hIsz5zypxXymfp?=
 =?us-ascii?Q?j+yiprnrzdCnULYXkhsCc3FFOkEkjS66WLKWJMz63dPUDUbtGZTuIzFqqVd6?=
 =?us-ascii?Q?lJUIwBjPEiuYUYfDoR0S+SqB++vz75FkNDgCR9/MgpLDwzODu7k4Uvqi2nle?=
 =?us-ascii?Q?R2Lo6YCfVAgJwQWDpf0olb/rtOlJQv4YnNBncfVIU5WUgHBenXUk8Ox7ESuT?=
 =?us-ascii?Q?p/sY88G9qTep8QlXAI55m49tQnAnVBPQTSfilEjBH86MT7/bEFYd28gzNgvf?=
 =?us-ascii?Q?CnHJ9rbbmmXlzLaIz3iOfnJa+kO7GFeFUTuf+eZ4KLx0N3N+lG6u40yQSMCx?=
 =?us-ascii?Q?ZCFwBneiaEGrpi7pSG37mrjBfTuN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qljkU6ScInCsSYPYZEEOeNRpCMFslwcwykOHpx7KygrpR+ZS7sG3lGAqRay2?=
 =?us-ascii?Q?pH2EAxVEI+a570qERsoATpRowk4UJPtXxLoFCyZOuyd/sQgRUfUU5LJ51le2?=
 =?us-ascii?Q?Bb8tznPv6LpxZ1OjH7rEb+bOTm415qoJr76sThB8UBenGMnazIhvtbit86Ol?=
 =?us-ascii?Q?e5+h4pHfZQnPAAs3z5ZK9MNXNwe8zV6fF+NRbOTF9TLh8mLYeVx3p4qebIuT?=
 =?us-ascii?Q?HZqdMmJgF6bCqOwuJH/G7z6v9/NtqUmLMHoottqbgCcVFw48wImsTpd2iLLc?=
 =?us-ascii?Q?zQ9ZaA+6EQQG2KZldM4YONWvXqkNym65x0oyyaSphZEBCv9HzgGZ6CJvotUa?=
 =?us-ascii?Q?trboaAuVhVDMAs+OjzV8QzEVzTmGLpmzBIFZCB5M0gBmW5RJ+3jVoqp5Zsq0?=
 =?us-ascii?Q?kqSo4WgiNqkAdpOhtNwKMkuZsHY/K26fHDS4w+8iMkHBH+hgeS4RLMHX9JOc?=
 =?us-ascii?Q?YbZKoECeij0amWozF75upVx1Z9nlli5XL6jyY9Oydp8QXuFqkTeYQd1PEocV?=
 =?us-ascii?Q?ZJdRcqT8B/nmYmzJg16OhCYZOmVS+pktZQLhY1aTWQPX6twhUCjeTTn4VV0E?=
 =?us-ascii?Q?aDzEp55L8RYkaQ6Gz7RcfAcyKZeZO3S/uiXPkP7uwBe6s1xj3eLxAAKsHtSR?=
 =?us-ascii?Q?aHVBPZZ/1NI6JpOTNTKxegDGmksoAUwlu9HT7OvWS+LwKU8RC4YocmG11obN?=
 =?us-ascii?Q?tX7iP12QK97UfhB/P+xxXOHEGpdxOgtDs9SfSFKuj6pIbHsbLdkh0uJwumiq?=
 =?us-ascii?Q?1clLcFSYB1j3t3RnxecyvCpsBehmMHoFU6EiqGMVul+CCfgGKj0+i/FipwAd?=
 =?us-ascii?Q?0rusxSF+WpvKAfcOCs+gF3kWCWErkTqQvL+v/deCwljtD5nTmTW1XxSc1N5Y?=
 =?us-ascii?Q?T1KQWa3lIUSz4/jldiRP60TabvqGxjisxrRxeAfeDK8YM7tWU0JK8sOicujs?=
 =?us-ascii?Q?cO/RWXbHpAIThnlZO41Efmx7CWZUsDLpdrfpMVNk6jiCEcHxpf9X8GR6e/EG?=
 =?us-ascii?Q?VXdQOZ/ZP24PISb3oSJS/1UgKRdeDaftHifh1uSWxmK5ouHWAjYRvzc0wdKy?=
 =?us-ascii?Q?HNtiSidRLdOry4NZEBupMuigL19T/nPR34e0KoduKLqYo95K3udDe8hYoYsF?=
 =?us-ascii?Q?ITEtVAodd0CYiFXGuoNAuz07wG9c6ZCfPzwv/NAc1n6umDAcr3d7NJEXuHQs?=
 =?us-ascii?Q?Evs5ctPupE5SojFddQhdx66lURtZfB4Psq9lDExnZf7j3cJa1wBpyc1fjeq8?=
 =?us-ascii?Q?vvQkimZ4InDbE4JeTyNk8O5EVe6CORa6f0uXMKngCwB8m9lM6/nSPCq7TMxO?=
 =?us-ascii?Q?oAJqseHauRvi8fhi27DXtQ/qTohEWw872grB4i1jyLEfVQrrs/ez7A2Lv6al?=
 =?us-ascii?Q?MuGSFdW88daGr10NI/gdNf3oPwPuBHzqFn08oWU2fUtLYSW4VqQaZipoDWHd?=
 =?us-ascii?Q?6/U4tqw9Z4GMZO4yrGZCZqz91W1GQPsBFMser2iqFMMPbB4oHI1zYw9MYBV1?=
 =?us-ascii?Q?LB730p53DuS/LBNnb9dNP3LFjzAi9EEG7DMhZiZyi28R90oaBVGaVP9Q5nOB?=
 =?us-ascii?Q?o3lkXVBmqszc5WXXLwFbuBYh9vhKuTMOy2C5ifprSkEmFz08UjfzSoqrVVQx?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87132e4-53bf-4894-606c-08dd5a5a31dd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:49:18.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6199MfRC2h0PDYuqPJiNVDmMgXh+Z/7IwPcI+mqkc1NpJ/ZrMVcjvSl8SQClbgEjxu7wj30WqyUaTkXzSRKNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6121
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17379

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4a5af7106..c19180aaf 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2302,6 +2302,18 @@ class GitShallowTest(FetcherTest):
         self.assertIn("No up to date source found", context.exception.msg)
         self.assertIn("clone directory not available or not up to date", c=
ontext.exception.msg)
=20
+    def test_shallow_check_is_shallow(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        # Fetch and unpack without the clonedir and *only* shallow tarball=
 available
+        bb.utils.remove(self.gitdir, recurse=3DTrue)
+        fetcher, ud =3D self.fetch_and_unpack()
+
+        # The unpacked tree *should* be shallow
+        self.assertRevCount(1)
+        assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow')=
)
+
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
         import shutil
--=20
2.39.5


