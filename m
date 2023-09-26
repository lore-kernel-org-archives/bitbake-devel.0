Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA4E7D27A
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 10:15:01 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15691.1695723297523871929
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 03:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sYyEny8O;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7633c6df23=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q9eHaB008475
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 03:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=UzsOyiiGCimv/VOGHp2t+EWi/2rarxdUgxVi6kfrmeI=; b=
	sYyEny8Oe4fe88h9TUjNjimrdkrAdNUq41xbvPJoPD7VkFnyhkobbbWQIjIj5TRF
	FdCabi42gYKY8m1+SnXInxyAeVuVxiKJbBaKjdH83tGC12TahByKRs/ELkQV+pSq
	FqsAkolylVcDb8VfgerToNqa6Kl6u6gZZC6FeNpR1S1P1bLbJiOg31jLY7iTv85O
	6O4yCCPwPKwxchh5vL9s96DZNyAjensY+onfglHlySG7058XDFn14+SjNSQhwB89
	fFLG9ZVZo9WBmgWjnAZAeNpMx4qjFhkD9oFZ+Pm4ipl7fR1GquYxvC43J5d3C9pk
	rQmPb/UI1svw9zizEeLntQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9ua0jf2r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 03:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9qVXcvDCYJ2TjMxY/uZH3ix+Wurcv3dAZ2yn6avkxIg4yDxZi+1tUXZSJ4YvjqkEr66fmhUjzOV/TXLcnauvzix8oRw7LtZBwBb3jUncqEMur/8fzoKZ8kwN/v1eYrh+hMsikwK3WaIknNLAum0thWTBex9VkTmMLOqytxOydzojnQ1dYloCzmffPtySCcgJIY8iU3eU8OISZh64wt0K9N/DSc+E8LH8L73BRuUGIVIIJlCgbp9T2j35yZDuYMs+PVCQ39UVhVns9x8FuEKg00JMvSEoBEpfMlriWprNRRdPpN1cCXPY1HD+5mQwIgAnq6ygmlCNN1dCc/srnJ42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzsOyiiGCimv/VOGHp2t+EWi/2rarxdUgxVi6kfrmeI=;
 b=oem7yL/NM0Y2n645hDeeJELR7A08wuFDw0C87JCvQzbOau5Y/CgdcqV0jH/hUXMdQaSWgMXj/DR/QW8wFYBL/X1ULa/ausxR7derfe1K5CuxxS99aAdYd0xl7I6kyGeaOGQBax8xzDpSmxTRB9aOv2+kflHfZ/cX9EXiQ6PqHqpbtur0E9ixMyn5EIyKiFWn3LPLjdYHc+MTq6MrfZbYQIJldtDMx1GZv+2Ml/iJ8JHrRu/MDO7uZ+dgohKonh8NR67JpchUkOJTTtkXEaAouuaeim/aOwfujPfdpqiSqkLbuLDXYMSVa8FyGwMS5xaJAizWDcJqusp6reELeDjEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:14:54 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 10:14:54 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 2/2] tinfoil.py: avoid undefined variable error
Date: Tue, 26 Sep 2023 03:14:40 -0700
Message-Id: <20230926101440.3610057-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230926101440.3610057-1-Qi.Chen@windriver.com>
References: <20230926101440.3610057-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: f43b58e4-39ec-40da-5ce8-08dbbe796d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mIM4IRqv6qiGUesu7CXHePEhTrgKnnHFU0vjPeIo4QsExIgBcvdc7H2rkVNYZPc2yXQY3hQQBGvq+U8wmKMHqEXMebPBL4s5ahpKnyrbo1IScozVsKBtVFfECBX4OXMIB3cJZPjRDCqG1z5WVLp+7/W4rj4WHUMPTRToaFGcNa3Jd2694AG87P06kX86vBeVDWKprvex4WE2h5oCOrxYYX6ponrMnIANkqwvaFRltuYYMbt4YjjWZbcqIMhrZRK/t2PSSGpswwSzCAcZZgAbtJYzLpv+WkIjrXKBGT255PQ96LT4TKGhKtvNwEKt5yqZCyOrIMRsSaLOdeA6tKPDmtArsq8UBHLZjXxLcN9wyLEC4dz7k8qcxOQL5QyHrRvn9+gy8/HyEOlpgCOtZ7JqW/CuwqxjNVXBY9WGZrLtT2QOiWv7EkGWNEfq6Lp43me11/aC8XhPa/M41xcYJYSL6v8+kqI1NE7QDX7WBfsuJdvnEr29vYZ1BGhxpAF8zCoIKsw0O4EmqJvtGZCLQBRmiB6UD/gDJqf4MQvwFX5+2+Ce0EGn8CBjWQSmu2rlHm+jUin7OidLAjhM/d/E53paCdzpYx/jLlGGxrO0SmjGxG4EprnpSG36ISiqZcqhvrCI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(86362001)(36756003)(41300700001)(66946007)(66556008)(6916009)(5660300002)(316002)(2616005)(8936002)(8676002)(66476007)(6666004)(9686003)(52116002)(6512007)(6506007)(6486002)(478600001)(38100700002)(38350700002)(1076003)(2906002)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sNbzI+sDfACvQFjGS5U45Ovjer0A4ijgnNmPl4FrcHhwXlA9L55px8daQRFL?=
 =?us-ascii?Q?dNwTApbdPkf0KsVVhRu5Npo5VPaaQ8lSEHfM1r1+aL1LkUefJc+D/wF3PHd3?=
 =?us-ascii?Q?YvmN7J1e+4kfp9DpQZxlKIzyuccEzORE459nDtLMqNIbGvcAloSBC1F82c/9?=
 =?us-ascii?Q?TRawGPDDunjjobaiqaR2e9S1dyrsDZqxLQSeXal+A3ENfalQmOUo0V/Lkl07?=
 =?us-ascii?Q?WI3xO81XY1UI2bK/hTMecU3yo0pgHLCahrGQBRyVtqB3yX3NBYfbhUfn3hX9?=
 =?us-ascii?Q?Z9+5E/xsyzuDxq3U21NgG7pKOD9fvBjti0KBB6xxKjEyoOX+p00bJaOcdAql?=
 =?us-ascii?Q?ZikCKWJiZryEKhYOZ0YIJuYPdrcDK2GJrRk8KCTVKq1f8QeOyNDWt6szGV7z?=
 =?us-ascii?Q?TgGpcePAkbh0MXqnHcDYcxrmAiq1uZFiAE98pLKxQD++SriGPulqOEoiD0P0?=
 =?us-ascii?Q?CNnsYZ2kKDbMSUZePDW7HKYM1CWrerTqBNPI4wf6Z2wtmRrVSfuYGLhgzlsN?=
 =?us-ascii?Q?a5Talh4Y4NXq0CrSkE7Ra23+ZEZzxzkcZb+AH66SJ0LLZ0czRKUeykqMvebd?=
 =?us-ascii?Q?Rgdml7LU/9IHso2HWTnnmic5VLQ/4kfGtZ00vwwKwwB9/wxFKXyEncGWcEVl?=
 =?us-ascii?Q?nrk0EygyUS2HC74GrP0/70IeRkIIPhY4PVhoZ+YMGR/wq/Xq1u+x+YG4dwU3?=
 =?us-ascii?Q?4+FtoZ4hacfH6LBRuONKPPBlA+pkJEDRXneXRl5PM8XDOf+Qb4kyFQV72S5D?=
 =?us-ascii?Q?4QiZjYqwZDHH7uGeNPEkKEDF84CAbUaB5wwQeGkRAyufoeGlTaNjLshBaSo5?=
 =?us-ascii?Q?6TSGn4Lfakp5SH5ucoh1xEzSawH3kuJfeHlRERoqv4GdPWCqB3KS4z5gVAdK?=
 =?us-ascii?Q?JTw92/8trMtIlXrUpjjZOzkWrmddsfEsvLUuT3//clxwMqn9NepAbRPDWzUA?=
 =?us-ascii?Q?6yposVxQrlAV35inHKhyK4Hb2MExOS+vPCAr3yNvuO/pLZGrHdCU2jYbeSMb?=
 =?us-ascii?Q?1AmhexmlFtOzEVLW8Lzv+goax/F/eic7XXtiGNmqLlbELoJNfEG0VSMPs0K2?=
 =?us-ascii?Q?OqyuNS/rzwNlTgzyOjKetA9VSflZ6ZbK0rZ29u7GflwMJ+ZcpXKStXB4HzUb?=
 =?us-ascii?Q?cdnU8ByZgnVespIymgZfacJ3daS8BIQn4h1+tIuKkiVMwh29tbAttLaYOfTC?=
 =?us-ascii?Q?BnFiSqUfdQ1S8x0pY30gONQe1tIjhsiH/KLr45kheS3D4hrI1COSteXC35py?=
 =?us-ascii?Q?o5KsOxeLehmQzwjvbmTM3rqi6+gdKLQZy3wHbMsQiiFxNbWMeZaYNBj29SfA?=
 =?us-ascii?Q?3bDrhvmwYdJf2P7LNynAFO37rblReEra8TRiCUE7MSj5q7GPxxWBhFux3SJ8?=
 =?us-ascii?Q?byC3vRThK/2WZKJn641KJqKIpG3ZeP6YnBcWxVrd7yr5BF2pHGMYTKuR+uV+?=
 =?us-ascii?Q?3rL/azEeJRI1+2bO+QwPBuohcPhWiHtu6OM5zsGcwMy8XNU9EnmEOF3VPCAt?=
 =?us-ascii?Q?RBVCg2yZXJMlYTfI/VrTubU/EFHCaVWbMHj+QvTatCW9E4FYxDU+9Tb84L3q?=
 =?us-ascii?Q?gaEf96vVgMLOCC6PkHb/RrHttDTU+F3MUjFxSCRBaTNBTTbS9tF+k9//2j7W?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43b58e4-39ec-40da-5ce8-08dbbe796d40
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:14:53.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRCCNTbrrBv/pSCHni8vw5lgRkzjKJ0KqS6fEgunVTG8ttXbqfWeKZ7pK5GGq2vJNbJL1fa/xDpwwEMb/7CkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-Proofpoint-GUID: fDlS5wsrmgBkI1R-3dZs0P_ijLriP3NB
X-Proofpoint-ORIG-GUID: fDlS5wsrmgBkI1R-3dZs0P_ijLriP3NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=736 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309260089
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 10:15:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15128

From: Chen Qi <Qi.Chen@windriver.com>

When setup_logging is False, self.localhandlers is not defined
yet will be possibly used in prepare.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 91fbf1b13..8fed21dca 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -325,11 +325,11 @@ class Tinfoil:
         self.recipes_parsed = False
         self.quiet = 0
         self.oldhandlers = self.logger.handlers[:]
+        self.localhandlers = []
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
             bb.msg.logger_create('BitBake', output)
-            self.localhandlers = []
             for handler in self.logger.handlers:
                 if handler not in self.oldhandlers:
                     self.localhandlers.append(handler)
-- 
2.40.0


