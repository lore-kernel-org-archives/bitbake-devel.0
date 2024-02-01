Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B5AC4828C
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 03:31:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7744.1706758276556223050
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Jan 2024 19:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=BUTxkb20;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=276184b32d=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41125UGN025555
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=69MjcHK5rPQ2K+WqgCjwY5X7q5Az4qcRhj5To9dOoxA=; b=
	BUTxkb20bsIDUXDhH4pJbPC2VmIOrwtzGvvLuAqD1YD8WRhORXJ4+zMfgqGrAGCG
	hAwjmSRtXz8FH0VGFLyU4E/JhhRcWe+3TR3h5ziZujuBajSqWRiLwObpQ2RnNPZQ
	qfVASd4PDv27bp84xstLMuCVhOao3lWtZzOtutqIJ2pGpMh2G785OvdF79q6MS5M
	kO4StOw7NuRd+ocNnxWng6WEauAUqk7l2u3GEZwWch42gjkgPeEa+ObJog2axd3c
	eVYgSVgEDnlH75a2HkO/eHBNSv2wSp66dDryPY6cC6acChgReAAmsu9HJjjEs+dF
	sKd8iAPU0c8r60jTlZv+Yg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0276g1q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQYz1+UkF3zjIC7yNV1wl4dq7I5255uhloh8ADpRVnKHi67dc21cqTH2bKTId9NtVgjDB1HgeDh7AjTtM9mzNr1c6XwvSVamD9QcnXYkMpJ6HoXxvJFYavAryOsKjFPcnblpH9+fsm90hjerEbvpAxSIQhLP+0rhZZvU4MvXvFKQOgjj7FhnrVRlG4TdzuqR3Uflapbz7GQ1j8s4pHnyHaFk56GtqbqvsA+skB8FtIT/V6mqYoKoXgbI3Xe3CWGWue9sXLHeUtCZIKK4r7Ty9T5mQk6umjeoTiZ7ueBbyMuVljJZqpHiazX7VO13oFMrdWXB7kzhID6AFs5TFEZ/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69MjcHK5rPQ2K+WqgCjwY5X7q5Az4qcRhj5To9dOoxA=;
 b=h+XCOe2QjWjSMh/xweof5UwzxVzTUxgq5PplyDHvO3sSHaZSYVveC5WwL/o/jj5lefdaKgbU7NwmiAlDWUv+ECvOBIvNT8IKczgOj3wWLSIgwwNdsZRMnSdHz2Ns+ib4fUego4+GLmKAOHtkf7I9h5zwUBtGdyMxrPufYVqR8T+UuKrkvponyKNuu2sEp7f1R44RO5F3HLU5CIquM6wTJfL8SsnGikZ20dr5WKoR9WujOA4fbErDSC7Q/Xz3B58oBdCG07msMPKk8xX/y1BHiwdal970paCTAsYvnJBbHK+CkkvpAxLNqFPU/OJ68m1zhYXX7Ld4kmy4QkBC4mjlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 03:31:13 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 03:31:13 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 2/3] tests/fetch.py: add test case for using premirror in restricted network
Date: Wed, 31 Jan 2024 19:30:59 -0800
Message-ID: <20240201033100.3617421-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240201033100.3617421-1-Qi.Chen@windriver.com>
References: <20240201033100.3617421-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf955fd-2214-488c-ed72-08dc22d63dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	m8jPlPzmz9kh9varcQjH95AcDbvGN+eXcJx/rSOYLE7VoOo9XCb9uCX5WGq7AAUIsOPXPXRGD8AzSbpsvFzQwz6QzZ68M7Kx1RduB4XcJ/ZIecj+vkx4CXLaPBAHllrCItLg64myg9n/WDQ5mePth7NuezQDFYUQHS0QRVOC9dg/0I6MLzkexxDBuIzLOrVrH5NvLSjG458RLdk0YdXqm5JLxIWjstPz7VIPM6A0/qaYuqvnpQNDTjqeJODJtjqT0s2kBEr2lZTcFdeEZBZ5xjlYGccZeMCX7iV5srYMOnwGOIN/5TvPL3iTfixwjdYBIbojcEFsfQz8LjTG7HKPjb+siG8f7y0/IRJjzJT1eclXIbzYoa317PKSjr09vKRFNTWM5872D/+Yi4bp6OoMRrIwkfF8RRjCVUa5kqo2LZwDIkw5qUj+lOgQxeswA3xaKZXW26kpsH+trhltMmcEdGLA+orjEH0jTGHCZHu2JNF9T2r4mIdQ28u05WBl5gl0J/aEeTMNzI9/9i7a5pxEaxpsqjDpkWLTzA08OK6jPc8wNbDAtTIObm06D5UlCgx2UozCldodUEFMK++4c73L8qkbO9bLd+agOUPujfWlvB2f6GcVoiLPSeGJZa/EvmvYn9Qrl0qZ3c4+qlvoy3rsNZQXIbUl4GRAZk6WpbxjDNA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(366004)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38350700005)(26005)(6486002)(66946007)(478600001)(5660300002)(2906002)(83380400001)(9686003)(6666004)(66476007)(6506007)(8676002)(52116002)(6916009)(8936002)(316002)(2616005)(6512007)(1076003)(66556008)(38100700002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M6cS24Et11dkDrTH8MfMA8xLpWepELw6jgJodNWfA+MT0DfM/i3r7JNTqwxz?=
 =?us-ascii?Q?XSnidiw1EXRamk4fHUECunGv5+lasW0asESJVN1xiRP2F7sB1aGbM0EA+NTr?=
 =?us-ascii?Q?gVOTKtqTxMDRCwJ5FPlGb5TKQbyZ+lBLy96zxWSfhEOATuj8wo7EZr56hu+T?=
 =?us-ascii?Q?BdWsCvAUr3lQc3iNwGCJpVqQddZ0mWHlg16LgB9Nr438upDen1TiXW/zFD5Y?=
 =?us-ascii?Q?9N6Pw0k1KdkUoXDuh7Pyxh4gsZyAVh7rkrD3zmItd1O+yH17bYXdFYkv+M1O?=
 =?us-ascii?Q?pSPSTYnoXSqS5r7kV4LCRZHUaWGlvzgsQabxZDawRkHUC+irwhyKuLTnRiDR?=
 =?us-ascii?Q?NA5wh4ETL11eefk/ezefDfDhUFUASPRTsn0Wn6Ek4V7CiJ+a/Wjiiw+TrmJf?=
 =?us-ascii?Q?yUpIycMg3F1+XvRxb92L/yQBpdGK4li5XC9duV5samMDVG7Yriy/t9dkPJqc?=
 =?us-ascii?Q?R1Ce+VpvChHDyETw4u1fUEEO5vkx9McbboDGtOKRjRbVNwJSQWqKV/U3oX63?=
 =?us-ascii?Q?sdHg6OVBiiZVH8h29RKUF68NaF0BBBRyzH5D5g9LCpnc6iGYilxYd78z2p41?=
 =?us-ascii?Q?kQaiEAX7ALczou3RNa3I+GLLIN8b2UjW4FwpAADRAFcIVvlQvz7LlKx4MO2I?=
 =?us-ascii?Q?5TwU95HjF3hpxuzM0Zhq6EKKq/XISKIEYfxHKNCN6z6H7Lofy0OHo9N+Ma0o?=
 =?us-ascii?Q?vTlBymL7xvvn0Dh7LNhHeR/4HV+jLJONpyOIn7nFYLE5i2YvQ2jEMwC3/Rcp?=
 =?us-ascii?Q?NI4SmSfLutO1cMsiHs0OMXX5mB/sBylMwfCein5LnUf5HurO2dcwRM0MsLZj?=
 =?us-ascii?Q?WyXZknZnRoHvAzqfhP6yMeDKic/2Pbn01fFMQH30C4Z0DACAzN2FbBl5o804?=
 =?us-ascii?Q?7w3vywgKVbYmx250Cj7VK5CJ9RlaPPS3G6Js+cIxgIucDx44pJ5vOA/Ob9Nn?=
 =?us-ascii?Q?/gFFNgmCceJc1c7zxi+RGhBUNzr1uYZtBqKj+majddyqtXKoTujIr0cOMs3N?=
 =?us-ascii?Q?1sOb17K4RckohHf0OvuAAIzKdmwRasDFgpkpesuC+MemUKMU1yjc6YKOdPCA?=
 =?us-ascii?Q?qLdWDrd4wdJMX1AhGj8s8A2Lg3yiKrX9FFacnsMVBWWFMa4aOM2XNKXhIqsi?=
 =?us-ascii?Q?kWJKhC1IKnILQvKYo8ayH8VN75QuDedq4TifQdD7mE7BxciWJmmZFUw+HuNh?=
 =?us-ascii?Q?whm7XEyRSR9AJX2tez1SyvwSopEOy/sYMpJIHkFK/M+uYV35eBD9Z4aAG1vo?=
 =?us-ascii?Q?iDTn2q9B5J4q8SADG2dB/ELaaWlj1d9ez3Yb1QEiSMt/Bo+QszZfQW2UwnWW?=
 =?us-ascii?Q?Q0NrZEDiDPsQCM58D/Iy8nqs2jn2NeVjScfNDnHAiseWuxsTCOThrIY9t2KK?=
 =?us-ascii?Q?r96d7K+6JEVXRa5tqaY/Nvzu2Ckb4dQxlwU9RnQC3UvleKqCyyRK1TajqFp6?=
 =?us-ascii?Q?/nMwMhe4Wfi0qoEQkwLhYcx4C9Sbo7eUuqXhfUF+0suPvkEK88GAcCVPzK69?=
 =?us-ascii?Q?RcVXTjj3NzsMuys2NBVmxCTZy5I1wIE9q9KF6d9jKHCzXXG96R7UExqMLNWp?=
 =?us-ascii?Q?Y0efV1lf1jaE92IF4gSibTRoTasOggUd71aImww2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf955fd-2214-488c-ed72-08dc22d63dd1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 03:31:13.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3G3/ts8S+gZT6rXP9w/li0tCymFHZ34+yOdCAsXTDWrjzx0/+LcmWC1VMFvW4mvbZcsHDs277CWn0aUG3zWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-Proofpoint-GUID: iYVOddFlgTxeHQqRs_1gx7AdZUTYOw2C
X-Proofpoint-ORIG-GUID: iYVOddFlgTxeHQqRs_1gx7AdZUTYOw2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=486 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010026
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Feb 2024 03:31:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15816

From: Chen Qi <Qi.Chen@windriver.com>

We had issue when BB_ALLOWED_NETWORKS is set and `bitbake grpc-native -c fetch'
failed even with all contents available in PREMIRRORS.

Add a test case to ensure no regression in the future.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/tests/fetch.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index c7a23407c1..179511232d 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1107,6 +1107,25 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+    @skipIfNoNetwork()
+    def test_git_submodule_restricted_network_premirrors(self):
+        # this test is to ensure that premirrors will be tried in restricted network
+        # that is, BB_ALLOWED_NETWORKS does not contain the domain the url uses
+        url = "gitsm://github.com/grpc/grpc.git;protocol=https;name=grpc;branch=v1.60.x;rev=0ef13a7555dbaadd4633399242524129eef5e231"
+        # create a download directory to be used as premirror later
+        tempdir = tempfile.mkdtemp(prefix="bitbake-fetch-")
+        dl_premirror = os.path.join(tempdir, "download-premirror")
+        os.mkdir(dl_premirror)
+        self.d.setVar("DL_DIR", dl_premirror)
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # now use the premirror in restricted network
+        self.d.setVar("DL_DIR", self.dldir)
+        self.d.setVar("PREMIRRORS", "gitsm://.*/.* gitsm://%s/git2/MIRRORNAME;protocol=file" % dl_premirror)
+        self.d.setVar("BB_ALLOWED_NETWORKS", "*.some.domain")
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+
     @skipIfNoNetwork()
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
-- 
2.42.0


