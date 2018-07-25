Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 3608 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 25 Jul 2018 19:35:19 UTC
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-sn1nam01on0042.outbound.protection.outlook.com [104.47.32.42])
	by mail.openembedded.org (Postfix) with ESMTP id 524A56025F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JgP3y3gz6XzG53GF1uUYZ5ZstEDJ18B+nSE22MmdQPE=;
	b=5Aacy4OQhPX932ZAbL6aPwrqtoi8vOajhdWRaiDeUgAr0HfvdMJa1ck7zvTIbFj22ZyYCKF6AKkPVXEb6Gm8dMAAbUkFBBsvsF8+OYtFXpAep1HdQv+Ff4pxg5Q/eUoFUx5ybY9bKTSDJOtss9IxJImYG8e411UEuvQGBhJAdsM=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
	by CY1PR0201MB1914.namprd02.prod.outlook.com
	(2a01:111:e400:527e::24) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21;
	Wed, 25 Jul 2018 16:01:21 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e45::203) by BYAPR02CA0039.outlook.office365.com
	(2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via
	Frontend Transport; Wed, 25 Jul 2018 16:01:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
	smtp.mailfrom=xilinx.com; linuxfoundation.org;
	dkim=none (message not signed)
	header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
	header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
	via Frontend Transport; Wed, 25 Jul 2018 16:01:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45127
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1fiME3-00074s-VE; Wed, 25 Jul 2018 09:01:19 -0700
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1fiMDy-0001YS-Pb; Wed, 25 Jul 2018 09:01:14 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	w6PG1AWk013318; Wed, 25 Jul 2018 09:01:10 -0700
Received: from [172.19.2.8] (helo=xsjalejandr50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandr@xilinx.com>)
	id 1fiMDu-0001WE-Gc; Wed, 25 Jul 2018 09:01:10 -0700
From: Alejandro Enedino Hernandez Samaniego
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2018 09:01:01 -0700
Message-ID: <1532534461-4321-1-git-send-email-alejandr@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(979002)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(51234002)(106466001)(426003)(336012)(7696005)(14444005)(2351001)(47776003)(478600001)(51416003)(1857600001)(77096007)(186003)(486006)(126002)(476003)(4326008)(107886003)(2616005)(26005)(50226002)(356003)(9786002)(81166006)(6666003)(305945005)(36386004)(81156014)(8936002)(8676002)(6916009)(50466002)(36756003)(575784001)(54906003)(48376002)(316002)(106002)(16586007)(2906002)(63266004)(5660300001)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY1PR0201MB1914;
	H:xsj-pvapsmtpgw02; FPR:; SPF:Pass; LANG:en;
	PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT029;
	1:Yzr5jOdDsZ285DVNhcbLRnS5HFJ2CY/0IED08ZHq+EoKztUvW521fWRF3rIp77ThkPQbgrI4m2wqyaYd7X504xG266I8bSR2GazR9daQ+rkDv+Py0cebAorA1zeUBspG
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc5617a-2d27-4cfd-840b-08d5f247dcfe
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);
	SRVR:CY1PR0201MB1914; 
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1914;
	3:9MMTXcJraxniQBdyD0CDWqFJvLFSJR0xv3n1u+mW5nKPyVKDyOpFvVFPceUn3/lAU2dTK67k/BOWs06ZfrOkjvbncUUxE8LVCKe9EVW37urVjZo2UADY2M0jfAVd8bqx0TISV+fL4UtcKibXWLqOzr5aeLG6zFeXwqXY7pFvj+TYBaMxGq+Shxna7vCx3hj/kz8KPo+/2pvZdo7lxlwJSMdt0pJRhhr78JdvNyb6XpnXDshQ3vYfxGTcBeyA8B+IoLu5WgBtQLUS+hNNQzNf5aWVVooz/5sRncNSxEWEv07G8WClJMd3m5q41+Z+LNNa3+e7gnuj7MewIxxKVaVyuJGHmWc7bIX8KxNjAWnVYM8=;
	25:pft9f7xLY6aT4EzIiG/yIU3Wz8F+1G0LR/3sWURjj73pzcP5DsAV3QPN1HEdKJF79otCY5p/n83QrevBRI6fQIINTYBNh81Ml90vjZnzG65GpUD4jjgtJsnZslysHyVJetIkMmiWeJOGn6KGfV3w0CPnDAqeLc+hljYbUgYymwmRUce+pviccwgH8T2LSN+AHL+KgfAvlKtRzQGaQQfrDrOwYNocUk69lRFveb2QbWzQEn1kSgmsRyx7wlelM7qpMUk1dW+Z1wqiHvOkjAgEfrJ803/1dtAKWqZ/Mwl92LeAgWW3XfmjJDOLefHldisGH0uwMPpox9Q+TcQq9jlgpA==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1914:
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1914;
	31:qgydDcHPUBasaolLCJUSWoDnBcJ0MEw4NOP1kSd6TMbbVqxorAfZsGLYavEd+ZEaLLs1WDWirGEdTCV/VRHc8cNYHB5Ilud0ZyimCm76XhwwBWQyTT4zKmHskdH70ay5P1yzyR7asluNND9QPh6Smph5rbcj8oBiApC1kLLbmsrdmhdCnT0oJBt45WXt+hTH1eZ7lEd15G41KoAqyvubwus+doRh+535l4I8Rpr50F4=;
	20:clFRO+DTAGoe29pA2sYJALy00zZy+5E2JfR6F3jI05141u12TFgqCht5O2gnT5X48Qjk62Pv/87IpjxeBFR+AJmrq/k3IPGfWvtpeZAp+fga7rDR5IhygqplU/9mQEGnEUPgBGOa0WXhCddXq/y3se7gpsKoGYD9br0+OG/xbaO60b7l3EnVjkT4/RyTVbRj1EG5iVY7mVTOpv+YeXi0SrKU1PVJtZRPeTidz5j0aH7U+6ACbiL2edpEOkHo/pxTDiJvMy7FPJtG+4y10+dIPxfCtkmF/MOinuwCYXvb7zjvb1NS3hcBbeJp6MKoQxGx1WpsDJhz6Pufhzxs5IaU5nErC+FjQe2LWYYKOIugQJbXf+x8KwM/kppW0/LbcUY1NdofhvuTsamjF0Tn2dCij2Uz9fpPWuFGMtEDhtc+Pwvx3RZYAkQfApyJQbKyENulcJ6tWWQHUeAS2cs5NSb0ZZ9QTPBKxWZY0LU2l8iGx1zpTW0lgLIjIJpfLc9Ib84z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB19145778AC7CC2745CE73F96AC540@CY1PR0201MB1914.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);
	SRVR:CY1PR0201MB1914; BCL:0; PCL:0; RULEID:;
	SRVR:CY1PR0201MB1914; 
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1914;
	4:npiyv5KWShBsjje3ISCQYfG72VlA91sZ3b0y29TLbH+9CHAnnDxq1FSxXEc3M6V18vx2tXN7zV961s/0ng6lvC/S61dS1t6256tIZbH5NVJzOvALkfVFLfUNFxs3C4wycDgOq0aN37lvNJSO8S7FIYygwk6qqa004amBbAVhmFIY21ZRma7Qb1sVDWu95dN5aRB/SuwRv7y8CUU1HTj79mIB69zlWWCCC/EWtYH74cgnQ1jgK6ltEvqdCcyaeZLvcVvAPcf75fVafwl3/varZlzWu0yjNKGYgAvsG7ZVYTebXf6R4DHl00V09HXYvFhF
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; CY1PR0201MB1914;
	23:vy4RSPQd4t5fb+DGuxpDIAGDzflR9si8prCGVDg?=
	=?us-ascii?Q?pOJVe26fefazCi3fTSO10yukYZLDTHb7YnJnbp2lT0T5+Xf+xMTU5aI4gR1L?=
	=?us-ascii?Q?O9MEeyOu+DEQNH7o/hcF9U7jZn62hyxvnAuY7jm4XFLDTPiin+O17eDajSZG?=
	=?us-ascii?Q?lfMZsuBMchxnRziKG0aniz8XIIMVUEOuGZl9S3y0yJmtu8H5xRzSinIxX6+p?=
	=?us-ascii?Q?OhAj8gxHkOz7DeL/FnkoRLinVR8c98/iCNg3Fnx986NvVobE//4E6lJAQCUS?=
	=?us-ascii?Q?LcMlpRsqaeWXE+YJoVl557w9Lql5o0AyY88pHp5Q+wI94q5U9f0kQ1san+JY?=
	=?us-ascii?Q?ROriKTNF4qGeDWDDs+TTWJ0AQBq2cNzEvbaQQ8DQxeFaeGfg804hQmpehblx?=
	=?us-ascii?Q?CqjNfFJKXlr7v1rP5LJNyuC1MXH84IiDwuX0ecZp2IMRXT8gUWe6Qez3KUWy?=
	=?us-ascii?Q?3W6MTu03LfQehYI5cp5U3/xhrOz3HaoX6xx4NaoKBCih3g7PKJTZqk2aMzfX?=
	=?us-ascii?Q?T92R5kW5lt1Pyo0qN5+aro518YkofKG7dF+35+tsL8wrMD/UWVG9+h5X+/20?=
	=?us-ascii?Q?6OazLNC9Gw8qr9s7VyihjzMNw8VdfayQniBFzaL19h8sFIu9l3d0unajSRa5?=
	=?us-ascii?Q?YDhUCEBKYA4wIzQU4Al4RO1bIZYG/ZyrK0IrrEZ833gQwa5VPUo1M0ufV5TJ?=
	=?us-ascii?Q?gt7c7oD9zQxS1IcJtJhryPg+NPQns6Rxqhdyp/Wrc2wEu3cFj+hjvQVlm13b?=
	=?us-ascii?Q?OZOMmN8pIUlLOB69EZaMHe2e+Jg/XH8q14BU5jTTZazYmGyE/8KkalyRyJi2?=
	=?us-ascii?Q?jU3ueKEI6AYkB0yFAVIgtZeW3EstCSc1xzLXKJLXA5+TfB/xpvxl+Era/j18?=
	=?us-ascii?Q?9l4ebBrUJ3naeqqApwoSuN46o3N4uuqWGfJHyqa2s6YTyG9eFX6oGSjSl6xP?=
	=?us-ascii?Q?MfiykiY9PMOZ8uWaVkv0MZ1Aw9DTCfHa2u3p9/zrFGhPUjLRo0f3+8yRaeP6?=
	=?us-ascii?Q?xbQrDFmVet+CIOdMgYXoH/L+FJr0BsCZyMKwUN1h01cCkuXfPoCyZW6mwyLP?=
	=?us-ascii?Q?ADl3Fxh7mdq9/dbZpsvTWo1+m1O6h8kGFkBYyIvsMcU5I+iCPB9w1bNNUzVS?=
	=?us-ascii?Q?B2IwGWtCOWZUTwFWv6ZdUrUrpoVDZXaOdY9OX8YFETq1VN+HFNITcILgrrVN?=
	=?us-ascii?Q?gWqvtW1KR1yAhfClgCD7hbPkzdoxVQ941BiqI60O1ub2LMl86S50gpGNxjW+?=
	=?us-ascii?Q?eCJW+07K9J8oYjQu3Bw1Hl1xzhItuHwf1uZjKgOPLSm7lKOmIRh5agCUzjpD?=
	=?us-ascii?Q?98Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: AICNbZKS/MM/lyREKdxZj3sxkLyNEviCDl1fQPjwcrwUgpe9GzRW2EIWnI8BnotwSddTfF6WQ5ONW4/c0ghY6K5jWxT2Aq2wGr2olOWAN7l1X5rcIfwNkchma4iAZPIS31oyBp2Eg3AcMDZ+fKzWz4tdOTg4lQiX76bFP7OwIHIme0zegcyWsi7X/50YjH3Xh/t8f2oRhAhJaBj+iMbir/eAqLnA08xzSM0BeP3TXy9DXQ/xQRnuOvkOCjl3ot5PhP16PUoKNv+xZOUExdmIdHnAEs+HRbXy2+BNwGXrWdn5oa/SGFvBxtf1S6it48Ru2koLTFfU4vbo5n4tinmsZGwA/roqXXFLFWFkoX/piaw=
X-Microsoft-Exchange-Diagnostics: 1; CY1PR0201MB1914;
	6:+9jBXjUg0fhjxMdpwrpgc1yqzac3/rMK85JaYYEJvn3lHkwlBMcCVA6etwEZXekLNFd/ARg83ZVBuxgeO6IndmeCN6JnzSy9VXnt1YM1qq6Or30qwIEpCp/wozil/Hvl+aTFZ92ChJxn6pgnsOTpuucXTVxCnT05xmBy/RL3Q1/mFy4ZRzjKIWbY8vh4hSFneJvXPbi9k1XGz93QO5Pb9B9qzevw55lqD52ZUMuJTnd/qRROU7NYMpCsBQ0Xovdu6eyEa4OJEKyF+djKmL4AfmBg3Sq+uudMyVI86LHbGI1+WQnkY7j2JJTDuZBrQXB77T0WoZV8vfUUxvcCIAhXJjsMkkgaquJpfbrVyJj7ihAQ70dB58zvZQQkiL1Fjx4HiSd7+NxzhuqKKkzUAbn6bHzO+jWb28ZFhXfiyS3SikwpLcMnEqR8Cp1Yk0q4hMvTy44WWXjoTM3qeKiEmel64A==;
	5:GlRMhA4/gJYzYHGSM9iivqyy2GX1CXMNmICzoXoSNHxeH5P+zytEvYC0cCxKnecJl8hymUreczqvvwT9veIuYfOdAYOe/PjrK4mvt+17UJgYW1NyLi4Zwq5RocNpXEEPZzB95agheFURNL+E2wbN+m0+dM8sTO/kcugcqP5SpUo=;
	7:DCc89vr1r4+esaCVOvrHS4reod7gA2tMP2E/dBjVnIr+0wOFObBNroQqGdUqnN3SrYO3emNyN+b7GiyEv691hA3enG2C5JSpQpmW/6pkJxoXFlIxVr6lW2+yJ9i2wO4iOfJi4MsbgrfpSwOdMNroXrk1eYJbSmv6yXr3OLRtg1H0nv08lX8jZw7i1Mx4cIe7vtaTatqT6VokHANj3Z1ehgot36Nehx52iAE/h9bMMZglXNAke789/HHi3dlCtopd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 16:01:20.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc5617a-2d27-4cfd-840b-08d5f247dcfe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1914
Subject: [PATCH] bitbake: Add support for multiconfig dependencies
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 25 Jul 2018 19:35:19 -0000
Content-Type: text/plain

This patch adds the capability for tasks from different
multiconfigs to depend on one another.

These dependencies can be enabled using the following format:

task[mcdepends] = "multiconfig:FROM-MC:TO-MC:PN:task-to-depend-on"

For the sake of simplicity consider the following example:

Assuming we have set up multiconfig builds, one for qemux86 and one for
qemuarm, named x86 and arm respectively.

Adding the following line to an image recipe (core-image-sato):
do_image[mcdepends] = "multiconfig:x86:arm:core-image-minimal:do_rootfs"

Would state that core-image-sato:do_image from x86 will depend on
core-image-minimal:do_rootfs from arm so it can be executed.

This patch makes modifications to:
- cooker: To glue both multiconfigs in one place and make sure
  the dependencies can be provided.
- taskdata: To parse and add a new kind of dependency (mcdepends) to
  the taskdata object.
- runqueue: To differentiate tasks from different multiconfigs,
  add the specified dependencies to the corresponding tasks, and
  create a working runqueue that contains tasks from both multiconfigs.
- siggen: To avoid looking for tasks from different multiconfigs on
  objects where they dont belong.

The taskdata objects are still not aware of the concept of multiconfig,
so each object doesnt know which multiconfig its building, hence why
the mcdepends are added to all taskdata objects equally (we really
dont expect many of these), but the actual dependencies are added only
to the required tasks by the runqueue.

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandr@xilinx.com>
---
 lib/bb/build.py    |  1 +
 lib/bb/cooker.py   | 34 +++++++++++++++++++++++++++++++---
 lib/bb/runqueue.py | 21 +++++++++++++++++++--
 lib/bb/siggen.py   | 13 +++++++++++--
 lib/bb/taskdata.py | 18 +++++++++++++++++-
 5 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 4631abd..c79354b 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -803,6 +803,7 @@ def add_tasks(tasklist, d):
             if name in flags:
                 deptask = d.expand(flags[name])
                 task_deps[name][task] = deptask
+        getTask('mcdepends')
         getTask('depends')
         getTask('rdepends')
         getTask('deptask')
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1fda40d..946ba9c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -609,7 +609,14 @@ class BBCooker:
                 k2 = k.split(":do_")
                 k = k2[0]
                 ktask = k2[1]
-            taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
+            if mc:
+                # Provider might be from another mc
+                for mcavailable in self.multiconfigs:
+                    # The first element is empty
+                    if mcavailable:
+                        taskdata[mcavailable].add_provider(localdata[mcavailable], self.recipecaches[mcavailable], k)
+            else:
+                taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
             current += 1
             if not ktask.startswith("do_"):
                 ktask = "do_%s" % ktask
@@ -620,6 +627,27 @@ class BBCooker:
             runlist.append([mc, k, ktask, fn])
             bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
 
+        mcdeps = taskdata[mc].get_mcdepends()
+        # No need to do check providers if there are no mcdeps or not an mc build
+        if mcdeps and mc:
+            # Make sure we can provide the multiconfig dependency
+            seen = set()
+            new = True
+            while new:
+                new = False
+                for mc in self.multiconfigs:
+                    for k in mcdeps:
+                        if k in seen:
+                            continue
+                        l = k.split(':')
+                        depmc = l[2]
+                        if depmc not in self.multiconfigs:
+                            bb.fatal("Multiconfig dependency %s depends on nonexistent mc configuration %s" % (k,depmc))
+                        else:
+                            logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
+                            taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
+                            seen.add(k)
+                            new = True
         for mc in self.multiconfigs:
             taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
 
@@ -706,8 +734,8 @@ class BBCooker:
             if not dotname in depend_tree["tdepends"]:
                 depend_tree["tdepends"][dotname] = []
             for dep in rq.rqdata.runtaskentries[tid].depends:
-                (depmc, depfn, deptaskname, deptaskfn) = bb.runqueue.split_tid_mcfn(dep)
-                deppn = self.recipecaches[mc].pkg_fn[deptaskfn]
+                (depmc, depfn, _, deptaskfn) = bb.runqueue.split_tid_mcfn(dep)
+                deppn = self.recipecaches[depmc].pkg_fn[deptaskfn]
                 depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
             if taskfn not in seen_fns:
                 seen_fns.append(taskfn)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ba9bebe..a43c998 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -602,6 +602,19 @@ class RunQueueData:
                     if t in taskData[mc].taskentries:
                         depends.add(t)
 
+        def add_mc_dependencies(mc, tid):
+            mcdeps = taskData[mc].get_mcdepends()
+            for dep in mcdeps:
+                mcdependency = dep.split(':')
+                pn = mcdependency[3]
+                frommc = mcdependency[1]
+                mcdep = mcdependency[2]
+                deptask = mcdependency[4]
+                if mc == frommc:
+                    fn = taskData[mcdep].build_targets[pn][0]
+                    newdep = '%s:%s' % (fn,deptask)
+                    taskData[mc].taskentries[tid].tdepends.append(newdep)
+
         for mc in taskData:
             for tid in taskData[mc].taskentries:
 
@@ -618,12 +631,16 @@ class RunQueueData:
                 if fn in taskData[mc].failed_fns:
                     continue
 
+                # We add multiconfig dependencies before processing internal task deps (tdepends)
+                if 'mcdepends' in task_deps and taskname in task_deps['mcdepends']:
+                    add_mc_dependencies(mc, tid)
+
                 # Resolve task internal dependencies
                 #
                 # e.g. addtask before X after Y
                 for t in taskData[mc].taskentries[tid].tdepends:
-                    (_, depfn, deptaskname, _) = split_tid_mcfn(t)
-                    depends.add(build_tid(mc, depfn, deptaskname))
+                    (depmc, depfn, deptaskname, _) = split_tid_mcfn(t)
+                    depends.add(build_tid(depmc, depfn, deptaskname))
 
                 # Resolve 'deptask' dependencies
                 #
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ab228e4..e9bb51d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -193,15 +193,24 @@ class SignatureGeneratorBasic(SignatureGenerator):
         return taint
 
     def get_taskhash(self, fn, task, deps, dataCache):
+
+        mc = ''
+        if fn.startswith('multiconfig:'):
+            mc = fn.split(':')[1]
         k = fn + "." + task
+
         data = dataCache.basetaskhash[k]
         self.basehash[k] = data
         self.runtaskdeps[k] = []
         self.file_checksum_values[k] = []
         recipename = dataCache.pkg_fn[fn]
-
         for dep in sorted(deps, key=clean_basepath):
-            depname = dataCache.pkg_fn[self.pkgnameextract.search(dep).group('fn')]
+            pkgname = self.pkgnameextract.search(dep).group('fn')
+            if mc:
+                depmc = pkgname.split(':')[1]
+                if mc != depmc:
+                    continue
+            depname = dataCache.pkg_fn[pkgname]
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
                 continue
             if dep not in self.taskhash:
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 0ea6c0b..94e822c 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -70,6 +70,8 @@ class TaskData:
 
         self.skiplist = skiplist
 
+        self.mcdepends = []
+
     def add_tasks(self, fn, dataCache):
         """
         Add tasks for a given fn to the database
@@ -88,6 +90,13 @@ class TaskData:
 
         self.add_extra_deps(fn, dataCache)
 
+        def add_mcdepends(task):
+            for dep in task_deps['mcdepends'][task].split():
+                if len(dep.split(':')) != 5:
+                    bb.msg.fatal("TaskData", "Error for %s:%s[%s], multiconfig dependency %s does not contain exactly four  ':' characters.\n Task '%s' should be specified in the form 'multiconfig:fromMC:toMC:packagename:task'" % (fn, task, 'mcdepends', dep, 'mcdepends'))
+                if dep not in self.mcdepends:
+                    self.mcdepends.append(dep)
+
         # Common code for dep_name/depends = 'depends'/idepends and 'rdepends'/irdepends
         def handle_deps(task, dep_name, depends, seen):
             if dep_name in task_deps and task in task_deps[dep_name]:
@@ -110,16 +119,20 @@ class TaskData:
             parentids = []
             for dep in task_deps['parents'][task]:
                 if dep not in task_deps['tasks']:
-                    bb.debug(2, "Not adding dependeny of %s on %s since %s does not exist" % (task, dep, dep))
+                    bb.debug(2, "Not adding dependency of %s on %s since %s does not exist" % (task, dep, dep))
                     continue
                 parentid = "%s:%s" % (fn, dep)
                 parentids.append(parentid)
             self.taskentries[tid].tdepends.extend(parentids)
 
+
             # Touch all intertask dependencies
             handle_deps(task, 'depends', self.taskentries[tid].idepends, self.seen_build_target)
             handle_deps(task, 'rdepends', self.taskentries[tid].irdepends, self.seen_run_target)
 
+            if 'mcdepends' in task_deps and task in task_deps['mcdepends']:
+                add_mcdepends(task)
+
         # Work out build dependencies
         if not fn in self.depids:
             dependids = set()
@@ -537,6 +550,9 @@ class TaskData:
                     provmap[name] = provider[0]
         return provmap
 
+    def get_mcdepends(self):
+        return self.mcdepends
+
     def dump_data(self):
         """
         Dump some debug information on the internal data structures
-- 
2.7.4


