Return-Path: <BLEVINSK@xilinx.com>
X-Greylist: delayed 12403 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 15 Jun 2018 01:40:44 UTC
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-sn1nam01on0071.outbound.protection.outlook.com [104.47.32.71])
	by mail.openembedded.org (Postfix) with ESMTP id 1B32D751C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jun 2018 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=e1RWtRHYN3LRG+4Vusv9nQ0oKNoZ0ZGREnrq42ntFT0=;
	b=d5vWoh8YexfuyQqIbRWUUy0hWXNifIWzoWjNQe4yJnkHVFFQQO5aLdboi+BRCQMv0XpaGAs3kA95I9kkcPj+dZNUQA6ZP6xmYvf/ch7Jebe7NlyuzwTy8lHNBPoxGbwOCdIO8pjYMY3RFL3SOuTcwgUUuvL66mwAUsgobm26KQg=
Received: from BN6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:405:60::34)
	by MWHPR02MB2813.namprd02.prod.outlook.com (2603:10b6:300:108::11)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.19;
	Thu, 14 Jun 2018 22:14:01 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e44::200) by BN6PR02CA0093.outlook.office365.com
	(2603:10b6:405:60::34) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via
	Frontend Transport; Thu, 14 Jun 2018 22:14:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
	smtp.mailfrom=xilinx.com; lists.openembedded.org; dkim=none (message not
	signed) header.d=none; lists.openembedded.org;
	dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.841.10
	via Frontend Transport; Thu, 14 Jun 2018 22:13:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44359
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <ben.levinsky@xilinx.com>) id 1fTaVD-0001Kb-JC
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2018 15:13:59 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <ben.levinsky@xilinx.com>) id 1fTaV8-00071n-Fa
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2018 15:13:54 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	w5EMDrfA009154 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2018 15:13:53 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <ben.levinsky@xilinx.com>) id 1fTaV7-00071i-Mh
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2018 15:13:53 -0700
From: Ben Levinsky <ben.levinsky@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2018 15:13:53 -0700
Message-ID: <1529014433-30364-1-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(39380400002)(376002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(186003)(356003)(7696005)(51416003)(63266004)(336012)(16586007)(50226002)(2351001)(26005)(77096007)(72206003)(305945005)(8676002)(478600001)(2906002)(8936002)(476003)(486006)(2616005)(106002)(126002)(44832011)(81156014)(81166006)(316002)(426003)(6916009)(9786002)(5660300001)(50466002)(36756003)(48376002)(106466001)(1857600001)(47776003)(107986001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR02MB2813; H:xsj-pvapsmtpgw02;
	FPR:; SPF:Pass; LANG:en;
	PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; SN1NAM02FT041;
	1:CbWRLFrK4v5UHNvSGcEs+G4mBnCGGGzJdCWXfz/9QO9kFNP1bbqmLgZ8OyV7xJeWtMEe0/l2c3UcBhHaef+CpPFGFMnUbxfYJ1QbXt0LaoD6wPmA96KuhYzClxbjqzwM
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d7143e-73da-4840-09cf-08d5d244213c
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);
	SRVR:MWHPR02MB2813; 
X-Microsoft-Exchange-Diagnostics: 1; MWHPR02MB2813;
	3:euPhZYpZtzVnbToBcegsQvN3hpl8mTdQXVXHOUgN7SevM/4qJ5mIjqCTXHX0fpHGEKG/Fp213JGVEbBGWYN/CXglw56r2UnyZQc1Urf5ymyd33S3eyDjkwlNHn9wfRZeoYjqSTXjVY9t5wa2VG1Id0bq8v4vxdv77v7xLhSDNt7su74dZUVvNZ1UkOX5y100khRLOkEWBAM/FAywxi6y08q1ztJ/h5V+edHEnCK2+WZg0AALhVTAJZvfzMnZZLA6oIgA5O3pQVUrygGKBVVGtmMvuNgXDg011CAQSYkt4Gk53Z+6wRO4qvuOCoP+ea55T2XMjV3Lyawj59/znnAr+J3dCnwmofS2g6JiGBOI/pg=;
	25:Jibr07Hj+xX8reifZ/Kz5G3MElk77KAsdmUjqPGhaUm/i1Z4AVbmFICtnfx76fA5bsPtpQn9EIVlrxgr55zjARxgRJiTKtmz6TZIicOJaPGYZs6n5Fwak7XzK4MFV25R4u8waXosd4Ol4YnpeDJRsysCvYg7DG0akZoy8gPEiCci7duRccyflxoDE7IGMa0rc3m7Ujp9Grm6a/RVEmIbHDUulMb50gkAVxvcia7dXXmQ3JLdZc54PfdQ1mFUn/unXjcEZozu6xgvpX+qcq3VFewfyaLlP+bKVODkOS6L3Zj6q8dKMh7G8bur3/hgVHPhU3tfFpc6wLhCj5OQ3zJbcg==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2813:|MWHPR02MB2813:
X-Microsoft-Exchange-Diagnostics: 1; MWHPR02MB2813;
	31:XAxII88uTLPox4rusZEAPu2ifck1gm7gJTiJkuGNuu2Cr/2x0gpgrB1wWS0yS/mnLIU5UPLIOMjnalxfte5UYw/4vfguG6712jLyYDSqto1/yhQ4p/EEx8ZN1LQZd6NuIDMqB+C4ckwcFo7rGM1EOrC8ztFUYT6bSkA6JXTMKDid9hbegNA/0usKsF85t1lufJa5kNOX4R0AUhBz23UrWLTAlNwSSgaGZkEto17KpA0=;
	20:0yMesy1vy3tLaGLKe+iBRGS1EZqZRqOTheQB5oEN4HTnVHN2OPUkk+eHqK6sTyuhC7xq1pPZaDvhIvK5fqF3V6mPZ2og9fin752iaKX5d3U9OMXIbDOk5dGDi1td30xEAj5tRlXGU87hpjM7emBgXJsk5+HGYstq09x2adeEPF9ySKeHD8ByzdyZKZFBBk6smdSPFgoVlb3jnGgeo/A0Ieg4Fq1N9aoZuEKmTTbts5iwv1zlJRq9XINR1HyI1nee00Zge0Rvwf950lyLAP2qx+uDi4B3F1P5mcBglu39E6YPbFuTBo0wATNo61mgHaYbIxIfLLhRZN7xc4TtJ5Eyzlik1rG9KM1XSwBRhVh3FRkORj8+JIeDChFD7gDDFOH79QJ2Zjp6xewSAZyOTNUK7zFtWxHsQAUrwKfeH8ELfpZmLVAsEWwtNerH2yeNn89hwUpqqtbMA8WfSWTL2XLjxHoiv6aBM0n1sy1wmXXzjET8EuSJQyF8U4ymts8wEy1x
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2813D4EFD261698446075A44B57D0@MWHPR02MB2813.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);
	SRVR:MWHPR02MB2813; BCL:0; PCL:0; RULEID:; SRVR:MWHPR02MB2813; 
X-Microsoft-Exchange-Diagnostics: 1; MWHPR02MB2813;
	4:nFGC24HG3TpTfcacJH7PJvflEbmGMP8qDMz57uya11yI7291zs0G24VztJ8cWGahcJZtgrXXIiHbZtcm5JzobZRITVA1x/U7uhoosBOV3N9qTO6P5vJReHAIdPSsRC8nqFC0SPP2yPNtAcxDPCc1aYs13fb9bWw03wrBuPZpupAYe+BBT4EhibcsB5Klx4BLmVzHqfw0Lvr3llrkOopwBoih6C+AxyYErP0MiQEo15Osl2eHF61h2MLD5/4p3xRcmUsoP3jsvXt5BUs6omIZKtNRNzm8wLdkobIzo2vAwUEIJfyTilvTa97iAfP5rIxT
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; MWHPR02MB2813;
	23:z+pC3+U2Z/P6ZExb1kHfmfzys3Slkp8q4mFxYaBku?=
	=?us-ascii?Q?t7XMHI1QapQc4OPBC9R9umTBjAZZQFj2wqyFfRsZ83tdEtu0Hc+Dj+tH/6NP?=
	=?us-ascii?Q?JfQNEJ+GUp42uf3R3eEA4QpqPXSKbfP+c/YwIWsfdgkoq8dxLuWF5lbkshXh?=
	=?us-ascii?Q?N92kuixXLKxPp88S1yGJRKr2bEXqHdXVBwV3prsj3JXMKTsnRr+Vd8ImqwwT?=
	=?us-ascii?Q?Tjr0CwHxNdKpGSqiNsLjqu91DDpkEQSbrbNAdW35WGZfOvkmBxb4B/2ej1eT?=
	=?us-ascii?Q?AOQ3FE0/Cqo8faUKpWeAVjomNFXJOpP31E6rgtzWsX2Nc0rIu+UnOQBEE/j3?=
	=?us-ascii?Q?eysH/+FjvR9nlJw7yV4r1D0aSfMIm+gq9rQm7RltRoaLhBEeewy/psIFnRif?=
	=?us-ascii?Q?Z7TVBLAYC/u1AxRwR2e+CEdP0tmIXs+FHbRn0wgnpv0k96RDRsxR/XMcWvy3?=
	=?us-ascii?Q?KexZMG7k4BflQCjY37wVPCqmn6gAyXJEPUc9db37Zh8S1GLNtR1x2bPgyJzw?=
	=?us-ascii?Q?QjiD+hZMCo5Cq7A+zgnkt/FYgtBX7hzNpUtB+Vv3XW2mJgKE8gOrPP60AYCA?=
	=?us-ascii?Q?e+6wsaYNcDQ7/3jYcoj/O66yqMlLzIoWLi6ylzTjjXkNvwKKlbAIUv8JHn+v?=
	=?us-ascii?Q?OiThdIwFh8vtkIIAWVJpGcDqS7Fat0CP5Io/wEFe57iqLF8l9URyaD8nn17R?=
	=?us-ascii?Q?itV7arWbE9aQ4v1733xgno9cUZTe8c4zLrMXdv09VMmvrhxg9JAMF9O0l66I?=
	=?us-ascii?Q?OPnS9G0JWPZKt8G7GqNGQ2Zfy+xcNHSXQbxok7eX+dvZPHSiiqhJlbXq8eoX?=
	=?us-ascii?Q?QVNFZ+om/KWKUcZfqGbRf+0PjVZrtN4rerYFPlR1/Wwu8NYIGsuzXdnHtI7Z?=
	=?us-ascii?Q?U8cxJpkcBm9nYrzPZ6nyJL7ubAvuckKVMP8HC1G4MX3zPyQoQELWumiCw3SO?=
	=?us-ascii?Q?UOWgXX1SpvUkHkfgLqHhcsf9Es4sL5w+2vPbVQseffHfQ/H7piSKlKmIxaBc?=
	=?us-ascii?Q?6ZASKOVHrO5dD3HEzg2xRTPs48WEP6y1Opg9dfScSfXpZ2RYd7zKyzRMy5+B?=
	=?us-ascii?Q?Nvxxz3MlsVpun6O5UknaMRd3yp4?=
X-Microsoft-Antispam-Message-Info: 5wuG/Bv2TZuuFWhJiSFaCWvBX8lt8VPcvSO4Qvhy8GmbdOcGpdbuRaVQo3sIq1XTiljvFUnyVvfOOnLjEWBO7yIRYkSbG2sBk45GKvxgrwBi4VnsHzXbUXFzt0nbBwSdWCujTgj5n+7i7zUCLQPgg465JhuRAD9esxJBDT5PdLnjhy+CR636tvbRZ5S1MfrA
X-Microsoft-Exchange-Diagnostics: 1; MWHPR02MB2813;
	6:N4nq9FDosxkfggN2za1nxwHbTV/64xOH5McDWs+300EKSc2B7acwcNL+lliNXu66W4QEVsUHrW5v8B/2WWtuLsYKl2/rzQYpHCZ/TVZm5HdkV7qc5qkR+x6d4KDFR+QFtEZUyCETG4M1oBlJneamD8NZOYD2kSlDOiw6sJGC/CYzNLoveHajtKbK/T5jfnzY6xDn7B+NUQVCqGGm999ILj9B+hkp6WxecGWk2WinqPjWFbebIHFmOOStftuFaFyghjBsPcOJSX7kg6CuzpJGu8F3XI4HTXuennrI7b2ZEhf7gdYwQbAik5+iNcsKINhagaNFwmFtm1bt6ArTrSfA56sXQ47bppFea1nnA5wMb6LcPNG9fp06fFrM5h3vRXSxB7Aq0P/z9szdgVuKcKkmrFW67trGWPVDteBbj8ST861/LZflNty5+PGgZLAQ2HxGRm/rBJyhbomJE4ZZtNv0bQ==;
	5:i5SQWPUO0nAOzArUCYQ2F1lP9w/SUiR0VlfDsJukXR3QdNkZerm2q22pfbVOt6vjc+G1IWQVNBh9uA9+tABkFifGUwdrj1ACBHWDjBgOGJhNo5BjUom2VFz/SeudM6Z8Efa/BA85fidJQdTgw3nHF9kUswTZBiomGfxFfs1GgnA=;
	24:W70sWpFQyq24rLaQ+xR+8U3XyMgX5nYbhWyRr+qFxAHnqTFzQxE8MlMTmezg1BUyaPPDhje7egun43Ii6Duov8B5ua+Xu5j11gHsUDevFZM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; MWHPR02MB2813;
	7:Tqhf4e0I2HVtCzkRV0gbJiqhDBa31uoUKGltRt/aZAdVlRYlVA5wbrPtF0Iyd6pZLu/NgpF32JRGc0WhlWRjra/OFaCJFJOCPftr2NfYYhy0DOFijDPWGIQIvQcbyaTl0jLMLLA7wnQjnuckBwhHW5tZ0PkPT/oeoBGOpW388ILMVc18VVddB0UCYIl+fsl14f+eTsAmYEjQ3pMVzIliJ2ePIjKJnLuPsd04MD2EOsd+OINrWqlKknC2rERZq3F9;
	23:NbWPvNwhoaStHFDhfquz9jb126u1PgYhVpJ2QrDoadvr852ylDSqtCAYYxU3GrrCXryeI++VG1dBOdBFjJapxctMOPRN/+BC4QpfC51VK2p3zpKLdOQHosuI7+tCcZtL4h8KQkd4OBD89Knlxki7aA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 22:13:59.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d7143e-73da-4840-09cf-08d5d244213c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2813
X-OriginatorOrg: xilinx.com
Subject: [PATCH] runqemu: Allow the user to specity DTB
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
X-List-Received-Date: Fri, 15 Jun 2018 01:40:45 -0000
Content-Type: text/plain

In some cirsumstances the user doesn't want to supply a kernel, rootFS
to QEMU, but only a DTB.

Allow users to specify dtb for supply via the QB_DTB option
to QEMU.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 scripts/runqemu | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/runqemu b/scripts/runqemu
index 0b6daf2..075b3b9 100755
--- a/scripts/runqemu
+++ b/scripts/runqemu
@@ -604,7 +604,9 @@ class BaseConfig(object):
         if not os.path.exists(self.kernel):
             raise RunQemuError("KERNEL %s not found" % self.kernel)
 
+    def check_dtb(self):
         dtb = self.get('QB_DTB')
+        deploy_dir_image = self.get('DEPLOY_DIR_IMAGE')
         if dtb:
             cmd_match = "%s/%s" % (deploy_dir_image, dtb)
             cmd_startswith = "%s/%s*" % (deploy_dir_image, dtb)
@@ -674,6 +676,7 @@ class BaseConfig(object):
         self.check_rootfs()
         self.check_ovmf()
         self.check_kernel()
+        self.check_dtb()
         self.check_biosdir()
         self.check_mem()
         self.check_tcpserial()
-- 
2.7.4


