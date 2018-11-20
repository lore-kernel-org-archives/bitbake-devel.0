Return-Path: <alejandr@xilinx.com>
X-Greylist: delayed 53882 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 21 Nov 2018 18:54:29 UTC
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr710078.outbound.protection.outlook.com [40.107.71.78])
	by mail.openembedded.org (Postfix) with ESMTP id 2C5746C4A2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2018 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Lvcmg5sGwbVxYhZgeCvDIcromPBJvLUX8DF68JYrfJ8=;
	b=KI6f1nwl1HaLOPJu9KyzcBBpUBLaSjUjs1eO6o9YqqmXu3zdrW82Bww1wxadPKdFRwS731w+Wby/IPJTZnFy5xMyd73dSEZE0Gm1jxsqRyUpW2lEkZck85vPSEFULKb92uCpt6E5cLSkFmbcAArJvl3uhb6LZd0xkQyGZWQqkFM=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
	(2603:10b6:803:20::32) by DM5PR0201MB3510.namprd02.prod.outlook.com
	(2603:10b6:4:77::10) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.26;
	Tue, 20 Nov 2018 18:23:02 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
	(2a01:111:f400:7e46::206) by SN4PR0201CA0070.outlook.office365.com
	(2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.23 via
	Frontend Transport; Tue, 20 Nov 2018 18:23:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
	149.199.60.100 as permitted sender) receiver=protection.outlook.com;
	client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
	BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with
	Microsoft SMTP Server (version=TLS1_0,
	cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
	via Frontend Transport; Tue, 20 Nov 2018 18:23:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58557
	helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gPAft-00037Q-1v for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2018 10:23:01 -0800
Received: from [127.0.0.1] (helo=localhost)
	by xsj-pvapsmtp01 with smtp (Exim 4.63)
	(envelope-from <alejandro.enedino.hernandez-samaniego@xilinx.com>)
	id 1gPAfn-0006lC-Ti for bitbake-devel@lists.openembedded.org;
	Tue, 20 Nov 2018 10:22:55 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id
	wAKIMqiU024801; Tue, 20 Nov 2018 10:22:52 -0800
Received: from [172.19.2.8] (helo=xsjalejandr50.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <alejandr@xilinx.com>)
	id 1gPAfk-0006kX-FT; Tue, 20 Nov 2018 10:22:52 -0800
From: Alejandro Enedino Hernandez Samaniego
	<alejandro.enedino.hernandez-samaniego@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Nov 2018 10:22:51 -0800
Message-ID: <1542738171-19791-1-git-send-email-alejandr@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(77096007)(106466001)(186003)(2351001)(36756003)(6916009)(63266004)(9786002)(1857600001)(81156014)(6346003)(81166006)(36386004)(8676002)(8936002)(50226002)(478600001)(48376002)(5660300001)(51416003)(26005)(7696005)(50466002)(107886003)(47776003)(476003)(4326008)(575784001)(356004)(106002)(316002)(426003)(336012)(305945005)(486006)(16586007)(126002)(2906002)(2616005)(107986001)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR0201MB3510;
	H:xsj-pvapsmtpgw02; FPR:; SPF:Pass; LANG:en;
	PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; MX:1; A:1; 
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT046;
	1:q5ai5ZX/FcgjNHZZLvrQZsWBzFoDU+f/vUUUpqFzGfmb4KPoScU0XNwHKbxvpmzqTXeeRIKnJm7Nl80aLRwQo9n7Ag3PyLwmhK0GoaSxq2ZUOY1Yr0I9xzLLPcwfoOWp
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87348413-1251-48f0-6443-08d64f1534c8
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
	SRVR:DM5PR0201MB3510; 
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3510;
	3:UTCDlkrpGEg00B5BR65m8hh3PwpuhZMZ3CyS3SBRlfL2CyTJBCA5LwjjB4ysRr0zRBr67ozHeNw/ghrmNtAmp22QzjQScfIQ0MSuFf2/AnpmbmX6k/2yOZvaCwgmuAInRFMNVvwhJGNgKkjgX52Fe/yJhMCPZFZvUBE7JDPCYdk9lgr3PX/IHCiKEUOAbmS5oY3jT0h6cpY+Zowu26ZjTiSmPeCn025Ox2mLbgtbu8eB3Ljl1aKfKv/+4NrMOqv5VZQDkH+YULQ3ACH3G3Zuhus2HAPI4C7wwVwuCgm1zQeel34gQlYmKhL++viJY4eze6/GMXrl5DyAvwpC3Wu1F/383/PUtkrFZBt8iK4skQs=;
	25:tk7fus8FB+ufma3NZy3GtITkQktFge7IeeJn4aNDudsvOH5p6gp3qnmsPmypMXkDl6F3O9pzHOG9lKFVlZ2qFSRFkHj/QlhJt8MYWVCzox6Zhqo6n+/sEGK+/J6duVWl0RIlE8jgmTTmTIf+wmayWnAhrHDjFNSox3xmJYtJNyd0QtfUd3qj76gLPU0v2xJ+gxn5J6rMc8iJFow+BtOgWZr4xJKFWdePprPKHg7SisgDFhDLjFir1BXWBEhZY93QehWM5DyQkbQvK9ernmUBa4sS6qEOLpd9rU4ce1E8ihYc126Pz8rjdxZAIg1IU1AzZRYzP79FhKc3FVVsry+Sug==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3510;
	31:OK80jbFlcgCDiAO0tLrZHc18hmXYSgP+1y3S6UH2YsYub/tOLR1dPrDzF/W0eXIi/apHBaYCH0IxOK9qJI7pCH2ifvZG5IyN6rwX6xgGEPkV5tmmWxdsuCGTrIQ3spjbnP8KSJRbIfOl8q55DyvlwM7mtZ49W7oJUCJQtH/t1qpO5AM0XF2bqSw04L+hCSLtzR0VjUNwMIQRCwULM6ZuDb8EnACTL+smr5UKQvS3deY=;
	20:128UVI4crYBymMHc8T34S8DIFc9MqsNUMUGkdtHSY1wsd2Bt43XNZQymSA6fP8rRPW8z/IFFY8vGhA8akdJUGAJ4F/WynKQlMRt8wexrJwt/7YS3iR2zIrWOLQORTkHisx2bekDYtZjKHIoq0Z+ynU7dyc4ARb5CqA1TVP4LmT103BtN98UbDIVBVS+6cfayG02gdvDuc1AxaGfiVAimKtIWEZ+PhWqTVqtlO0s+8v9qMy7dwtFpTZPGlVQuXPdCJgo4jtEQu9TOFtfkHtelu2VRvFek5R4p+3iYoHTrCbqIANAsCbNZKwk3DmrMAVz2saQDmZ8DxEtY/rKBMQeylNy7jIRzMhQBLykGFsEqRVX1pvgdmnbr2eAPM+OywD6cebaP+T09ObF1usKeHjhvnARxDfo+L4GXyE9ylAMebMl9bV7exwLbtoGrxoYqPWdTsAfPjZmoN+H3Y0BMe3JKf3bh1tTyWVgA5Nih0eQ1f9s80d6pU1n+axPlceK90qoV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510FF83B3ADC52F741952C0ACD90@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
	SRVR:DM5PR0201MB3510; BCL:0; PCL:0; RULEID:;
	SRVR:DM5PR0201MB3510; 
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3510;
	4:6tIVKxu4ATfCv8GTL8og97FGmK7vq5eAfHyxdnl3FzGKWdsVMwg4B+++IyJYrUHuZhlma5z3DPRYSNZAFW5HIeDIjubYe0y59hmj3CtRJ2ygS38KdLXRXQSgTeeOzvfI+205IWEKKhWDKAJYZg5DM7TFYpBh96fMUjf0wD0Rqye4RE8DYhgPdiS8+ZdwZ52/28N0RPdbE97KuGssKjhvxCCcQ2NmOX4LdDc/Wsx2mRe6jSkG8QNG4tYO2+AIIF7UVYjTHNOFrTQV2wR3/XR9WQ==
X-Forefront-PRVS: 08626BE3A5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM5PR0201MB3510;
	23:ilPrZvoL5Ocj7XrRcnlMlOHrr93g9DfGnLTAEWs?=
	=?us-ascii?Q?Brp0VX7vShEGrbW9rnNinae0P8G8SVmb7TrelBZejUnq4qdrHXeaGB16I+qi?=
	=?us-ascii?Q?b6s8wwYKOjTKchPjO3j9D4bOc867RIG/CuFf9vsqGA73HDiV2VgZKu3Gbbcd?=
	=?us-ascii?Q?BzA40I7GMtTeM+92W2z/rzzAnKCbN9HNEhV17yJ9wjPicC/LXg7Pnc/HkXWM?=
	=?us-ascii?Q?tF91u1bb63WANp7EhL49Ba9XhsXqgCtemM10nV8b8lzHD3McTa5pkx0dE7GF?=
	=?us-ascii?Q?xk8qSmKKTp7uUvOuUUajCP2fojGhwX9tj1isQWfie963aWuChrJeHCbXw+BY?=
	=?us-ascii?Q?o0hqua2MipcNAa07H+0D5T8Vi9m4GmP8jN/h3FElZn9sh9Ia6tWEKL1wmNNw?=
	=?us-ascii?Q?wF3Gt6WR9FxKbUOhIRQmN0yKHPFEr0BK9dgKy1MfwOKg8+5yIqfsKXw8Ifdj?=
	=?us-ascii?Q?4lvKs/FZgpOFBrA7MEDxD6az4oi5KqAqlj/4RLOvNP7tTzB7Y0OvSc1exFeG?=
	=?us-ascii?Q?dDRfnke+/3MkYfCzDqIa9PDRdMFXdhJNmtGRy8KYE3Fje6aFT2OaW5M0JQgo?=
	=?us-ascii?Q?4P4+GKdW5TjFgZMXah/xEIVphfYhS3Hbty9/B1LPtPrFTUDVHv95tKZeTTXB?=
	=?us-ascii?Q?buqrb5I+lKSoBwxAFbk+DzgzvwwzzFOKYx+JXT5qAKeOoJpdEhrSIpeM49B+?=
	=?us-ascii?Q?9DPQE/RnekfIy806SNqDASS8omYMlwY4ARLGW6zAGh3MkPqpovDLKyQekkM8?=
	=?us-ascii?Q?xTZpX2crKI33hD3SuVfFLhfSQ6iT9BprFECIgUvQh/S0+3oQpF2u93wNhGXy?=
	=?us-ascii?Q?rwx7wSeCD4cWlkd3Q2iwVxaWfosp9JlD+P2bSF0YWfTbjQOW5gGR7OWRm5qG?=
	=?us-ascii?Q?Mn6hewuA/65e9z4q0ifIyG46+QRUhoiFiNcm6a9F/6oFHicBGd5P0X4aVk1x?=
	=?us-ascii?Q?++KtRyTDjafUIObdStjZ+PmEZb7HnD/srcu3pjxMzxNzLsPtFfXWkoZSnHGU?=
	=?us-ascii?Q?MpkRTQjEkwcojmzQDPOnuc4Ev4RCvWjakViMgqg3WAHWl+li8+EOGWSdobiz?=
	=?us-ascii?Q?jS+skjK+f3367No3wkxamv3qNDz8gfUJI7LEYhXRWCMSyDODXX3v2j6eYFAX?=
	=?us-ascii?Q?h8hSCvTVergc=3D?=
X-Microsoft-Antispam-Message-Info: 4j4qlUK8i1xlwif2qpfHfFJ/cLt/VxPdkfbChIbMPjOzsHxWoiCQHi8KUtAHP47hbIUsj89wlb4nZkJ+76+gbXKlZyRqS/9Tvpq9O8ZEiViDnB4C0GyEFy7pnpau5JLaBgzJ7WTRtBxtEupgFB++6JMWUWcwg5DfztYTa2rfanSUlAOgNrOev5+LZRjIeOiBtYuwxn/DQCRpPXSIhGqM30/jATI+w8YJBIzkwLFHirgkKjAurXnoPpgzX+bgdjt/aaVCknsRlmRf54Ta1Vpy6K3zgtoHYxc+Y467foXJm+c0J7kjmroxwHqVXmCRddgXQe739O3yDhdTdDod3HYfN0/6zXQBIJX6fjLhPnQWf8k=
X-Microsoft-Exchange-Diagnostics: 1; DM5PR0201MB3510;
	6:6W2bofUTP+CJ9lLtvwDnoCk3f029DVKE3q6juEYLcD8wKkDfkVzqi+ua1UZYDBkg5vyh7OfzC9QEAu0euPsO4GI5Ol0GwIGVZ6OXYYKb1uMwGji78l5ZvbtNsQCw9kyfiqxK9hf1iLaJJAAVjiyooqF+3ldjUGYIUeG8T62HcBJumNhKfh/QJsjk9VbjjcfIJ5ibeJeWXB/lET7Nbzr1+ceKU7Pp8khxZYBUqs91tWxHRDsXFq5c/WB/QGzwZCLRNunj24q1IlyTdHGuRTxXNsaargX/OBxTDw5hFwORCTQoltJjOu/TOs/P5aKlg0CfY6mHP7FQd9/K5reLUL4wQQ1C67+YHyiF89VBHQUvplo+SAKK26zjTu/BaXDP+RywqR8l3KDWDf1trB01LUpq7xygP3kPhDBYC50okaKJW4uE1jmrNzJGEqEijYi3lNpXXVm9Y5Ij4NHoQ0z2OnAMaw==;
	5:rfZsqU9IEYMlDR0nsXPX6gahfuV6zPsrV4Bl8vI1BC4xvU8MJmBFY3YLpt67IAaUwDWK/Zn6Qxz9wt+YUZ0URmuQdaDs5Uy16BtMGJ5mNhHWhJNWs/24xwxmXtaOrHTAaLOfsUaDxTciZ/lYSZihpxq8ZPB0vzYL7gT16VeqQoU=;
	7:4aENEoDrK/iht0uT1D5WL9h0LQC9zHNOdQ5TNOj+FLsMUsy9yhp+fnly7tAee7sioeqfw0heUUdgtycmRJT2eLAhVHh/KSo489+fahCv6hTFKbSpiJ7VG+vkld63nbVU3gsPdyGj/kmbnQA9bBr1lg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2018 18:23:01.6084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87348413-1251-48f0-6443-08d64f1534c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;
	Ip=[149.199.60.100]; Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Subject: [PATCH] cooker: Fix multiconfig dependencies
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
X-List-Received-Date: Wed, 21 Nov 2018 18:54:30 -0000
Content-Type: text/plain

When multiconfig is enabled the cooker adds providers
for all the targets to be built on all the multiconfig
variables that were set, regardless if there is a dependency
to it or not.

This causes an issue when a certain target is incompatible
with one or more of the multiconfigs, e.g. the target is not
in COMPATIBLE_MACHINE for one of the MACHINEs being built,
causing the cooker to error out since no providers can be
found for that certain target on that multiconfig.

This patch modifies the behavior to only look for PROVIDERS
for a target on the multiconfig that was selected to be built,
PROVIDERS are then looked for in other multiconfigs only when
there is a defined dependency to them.

[YOCTO #12985]

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandr@xilinx.com>
---
 lib/bb/cooker.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 71a0eba..16681ba 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -609,14 +609,7 @@ class BBCooker:
                 k2 = k.split(":do_")
                 k = k2[0]
                 ktask = k2[1]
-            if mc:
-                # Provider might be from another mc
-                for mcavailable in self.multiconfigs:
-                    # The first element is empty
-                    if mcavailable:
-                        taskdata[mcavailable].add_provider(localdata[mcavailable], self.recipecaches[mcavailable], k)
-            else:
-                taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
+            taskdata[mc].add_provider(localdata[mc], self.recipecaches[mc], k)
             current += 1
             if not ktask.startswith("do_"):
                 ktask = "do_%s" % ktask
-- 
2.7.4


